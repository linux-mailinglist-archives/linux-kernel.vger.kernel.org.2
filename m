Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BB03252F3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 17:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbhBYQCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 11:02:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhBYQCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 11:02:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E5D964EDB;
        Thu, 25 Feb 2021 16:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614268882;
        bh=nyR5e5Sw00AV8E+QvgPhcwRlboPNI2VFPrdUASzSmnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j1QM7b31tj393PX+O5gCyJlNEYUHRI1Ykhhb8q2HNwX/cZjai6sf2DqRaXIQKf/Tu
         4MBH7KrC5XDOrF5Xp8KZrcFw3nIquE4Te8hpS9R3fQmaZrzEID29IC0yRCi/dQ36/X
         MhOgnudGLTMk2PGqQug2VOrymjUcEIBEPwFVvKPFNrnoY4/Z9ljR05YWe7mjZPAmjw
         c4oup5HE5gHZtcxWRgpLr0AVWH1Jm0/TqwILYOcCkBXV5VjwN5WyJIIb2ay0gbRnr7
         0Cl6+TAJ9CJWpscANbXy2GQKIElWtYTI30ACEq+vBqk+n6wyhxvKbWVzceh130bu1i
         Su/uLFQQ621CQ==
Date:   Thu, 25 Feb 2021 16:01:17 +0000
From:   Will Deacon <will@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Li Huafei <lihuafei1@huawei.com>, gregory.herrero@oracle.com,
        catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, zhangjinhao2@huawei.com,
        yangjihong1@huawei.com, xukuohai@huawei.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] recordmcount: Fix the wrong use of w* in
 arm64_is_fake_mcount()
Message-ID: <20210225160116.GA13604@willie-the-truck>
References: <20210225140747.10818-1-lihuafei1@huawei.com>
 <20210225094426.7729b9cc@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225094426.7729b9cc@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 09:44:26AM -0500, Steven Rostedt wrote:
> This requires an acked-by from one of the ARM64 maintainers.
> 
> -- Steve
> 
> 
> On Thu, 25 Feb 2021 22:07:47 +0800
> Li Huafei <lihuafei1@huawei.com> wrote:
> 
> > When cross-compiling the kernel, the endian of the target machine and
> > the local machine may not match, at this time the recordmcount tool
> > needs byte reversal when processing elf's variables to get the correct
> > value. w* callback function is used to solve this problem, w is used for
> > 4-byte variable processing, while w8 is used for 8-byte.
> > 
> > arm64_is_fake_mcount() is used to filter '_mcount' relocations that are
> > not used by ftrace. In arm64_is_fake_mcount(), rp->info is 8 bytes in
> > size, but w is used. This causes arm64_is_fake_mcount() to get the wrong
> > type of relocation when we cross-compile the arm64_be kernel image on an
> > x86_le machine, and all valid '_mcount' is filtered out. The
> > recordmcount tool does not collect any mcount function call locations.
> > At kernel startup, the following ftrace log is seen:
> > 
> > 	ftrace: No functions to be traced?
> > 
> > and thus ftrace cannot be used.
> > 
> > Using w8 to get the value of rp->r_info will fix the problem.
> > 
> > Fixes: ea0eada45632 ("recordmcount: only record relocation of type
> > R_AARCH64_CALL26 on arm64")
> > Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> > ---
> >  scripts/recordmcount.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
> > index b9c2ee7ab43f..cce12e1971d8 100644
> > --- a/scripts/recordmcount.c
> > +++ b/scripts/recordmcount.c
> > @@ -438,7 +438,7 @@ static int arm_is_fake_mcount(Elf32_Rel const *rp)
> >  
> >  static int arm64_is_fake_mcount(Elf64_Rel const *rp)
> >  {
> > -	return ELF64_R_TYPE(w(rp->r_info)) != R_AARCH64_CALL26;
> > +	return ELF64_R_TYPE(w8(rp->r_info)) != R_AARCH64_CALL26;

Acked-by: Will Deacon <will@kernel.org>

But you know you could avoid these sorts of problems by moving to little
endian along with everybody else? ;)

Will
