Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE4B3B2F09
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhFXMfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:35:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37282 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhFXMfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:35:09 -0400
Received: from zn.tnic (p200300ec2f0c1e00373e146aff8faaa8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1e00:373e:146a:ff8f:aaa8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6F6FA1EC046E;
        Thu, 24 Jun 2021 14:32:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1624537969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=w3Imzx+Dttr4Se/KutyUyF0VY+n/AzDUQ7OUjfDHAgM=;
        b=c0DP3acQFntZSlcpq9n/Uf/3sV2iLEpv8qxPfZ5ca4KWx2A85kYx1S5tkEh2TSacFsWBLA
        Ckh5YxtV5n2aHqKOmwJ4uTI+jT3QcukGhjTIvzwpaeVEA3hNLJQ4rlhkdt21ZPuGnwnHbb
        FQsK+lNO5tG5+jj7PjRgC0CVGM37u/Q=
Date:   Thu, 24 Jun 2021 14:32:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] x86/tools/relocs: add __printf attribute to die()
Message-ID: <YNR7aw+C+7AJnBIG@zn.tnic>
References: <YNRzSy3NuwBDYWwr@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNRzSy3NuwBDYWwr@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 01:58:03PM +0200, Greg Kroah-Hartman wrote:
> There are a number of printf "mismatches" in the use of die() in
> x86/tools/relocs.c.  Fix them up and add the printf attribute to the
> reloc.h header file to prevent them from ever coming back.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/x86/tools/relocs.c | 21 +++++++++++----------
>  arch/x86/tools/relocs.h |  1 +
>  2 files changed, 12 insertions(+), 10 deletions(-)
> 
> Originally sent back in Feb, but it seems to have been missed:
> 	https://lore.kernel.org/r/20210227095356.603513-1-gregkh@linuxfoundation.org
> 
> 
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index ce7188cbdae5..c3105a8c6cde 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -389,7 +389,8 @@ static void read_ehdr(FILE *fp)
>  		Elf_Shdr shdr;
>  
>  		if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0)
> -			die("Seek to %d failed: %s\n", ehdr.e_shoff, strerror(errno));
> +			die("Seek to %d failed: %s\n",
> +			    (int)ehdr.e_shoff, strerror(errno));

Instead of casting all those, I think you should use %zu as, apparently,
we're using unsigned types for Elf{32,64}_Off and Elf{32,64}_Xword, etc.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
