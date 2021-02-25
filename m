Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B153251B8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 15:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhBYOpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 09:45:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:59646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232473AbhBYOpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 09:45:09 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0C5564EC3;
        Thu, 25 Feb 2021 14:44:27 +0000 (UTC)
Date:   Thu, 25 Feb 2021 09:44:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     <gregory.herrero@oracle.com>, <catalin.marinas@arm.com>,
        <christophe.leroy@csgroup.eu>, <linux-kernel@vger.kernel.org>,
        <zhangjinhao2@huawei.com>, <yangjihong1@huawei.com>,
        <xukuohai@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] recordmcount: Fix the wrong use of w* in
 arm64_is_fake_mcount()
Message-ID: <20210225094426.7729b9cc@gandalf.local.home>
In-Reply-To: <20210225140747.10818-1-lihuafei1@huawei.com>
References: <20210225140747.10818-1-lihuafei1@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This requires an acked-by from one of the ARM64 maintainers.

-- Steve


On Thu, 25 Feb 2021 22:07:47 +0800
Li Huafei <lihuafei1@huawei.com> wrote:

> When cross-compiling the kernel, the endian of the target machine and
> the local machine may not match, at this time the recordmcount tool
> needs byte reversal when processing elf's variables to get the correct
> value. w* callback function is used to solve this problem, w is used for
> 4-byte variable processing, while w8 is used for 8-byte.
> 
> arm64_is_fake_mcount() is used to filter '_mcount' relocations that are
> not used by ftrace. In arm64_is_fake_mcount(), rp->info is 8 bytes in
> size, but w is used. This causes arm64_is_fake_mcount() to get the wrong
> type of relocation when we cross-compile the arm64_be kernel image on an
> x86_le machine, and all valid '_mcount' is filtered out. The
> recordmcount tool does not collect any mcount function call locations.
> At kernel startup, the following ftrace log is seen:
> 
> 	ftrace: No functions to be traced?
> 
> and thus ftrace cannot be used.
> 
> Using w8 to get the value of rp->r_info will fix the problem.
> 
> Fixes: ea0eada45632 ("recordmcount: only record relocation of type
> R_AARCH64_CALL26 on arm64")
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  scripts/recordmcount.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
> index b9c2ee7ab43f..cce12e1971d8 100644
> --- a/scripts/recordmcount.c
> +++ b/scripts/recordmcount.c
> @@ -438,7 +438,7 @@ static int arm_is_fake_mcount(Elf32_Rel const *rp)
>  
>  static int arm64_is_fake_mcount(Elf64_Rel const *rp)
>  {
> -	return ELF64_R_TYPE(w(rp->r_info)) != R_AARCH64_CALL26;
> +	return ELF64_R_TYPE(w8(rp->r_info)) != R_AARCH64_CALL26;
>  }
>  
>  /* 64-bit EM_MIPS has weird ELF64_Rela.r_info.

