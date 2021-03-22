Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98305343FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCVLZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhCVLYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:24:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 971096191F;
        Mon, 22 Mar 2021 11:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616412295;
        bh=ZLi6Bd3+v6SEZ7BojqeGDRUBPIM44t1xQ82RsA0FR9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1/XGgKUEwjQp5cnpZHom0FOv2Wv5aaJYB7D+9Rw0EKC2/dvDBwEJcrxiYyR97pDU
         eYn/PT/+WCDlABZbe8MpPobHdtfpAF8TYkAGpcCR8OJweh0kThjbcjPdgqZ6+yp8C6
         bafuJ8IHT1lZ6KsjCHAipLHctHG91NWEMOK8h3E/xmoUC2T8/t23/Ft5yM0t7K6xqQ
         w5HhDuSR+/J9+l+Cn/QyRCrEd5qWcl181B1HdL4IPUQExefVoxRsXpztnn9/sAgvRB
         c624LvFnWaco433jFHovHRbtT6LhTK8h7dp+zoHh6jnJnEt3YrnzRqMTAE+uTqgHJM
         2/yrTOk8JW+ZQ==
Date:   Mon, 22 Mar 2021 11:24:49 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com
Subject: Re: [PATCH v6 13/38] KVM: arm64: Enable access to sanitized CPU
 features at EL2
Message-ID: <20210322112448.GA10318@willie-the-truck>
References: <20210319100146.1149909-1-qperret@google.com>
 <20210319100146.1149909-14-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319100146.1149909-14-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 10:01:21AM +0000, Quentin Perret wrote:
> Introduce the infrastructure in KVM enabling to copy CPU feature
> registers into EL2-owned data-structures, to allow reading sanitised
> values directly at EL2 in nVHE.
> 
> Given that only a subset of these features are being read by the
> hypervisor, the ones that need to be copied are to be listed under
> <asm/kvm_cpufeature.h> together with the name of the nVHE variable that
> will hold the copy. This introduces only the infrastructure enabling
> this copy. The first users will follow shortly.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/cpufeature.h     |  1 +
>  arch/arm64/include/asm/kvm_cpufeature.h | 22 ++++++++++++++++++++++
>  arch/arm64/include/asm/kvm_host.h       |  4 ++++
>  arch/arm64/kernel/cpufeature.c          | 13 +++++++++++++
>  arch/arm64/kvm/sys_regs.c               | 19 +++++++++++++++++++
>  5 files changed, 59 insertions(+)
>  create mode 100644 arch/arm64/include/asm/kvm_cpufeature.h

Acked-by: Will Deacon <will@kernel.org>

Will
