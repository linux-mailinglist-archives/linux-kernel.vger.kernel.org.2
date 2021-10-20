Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953DA43554F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 23:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhJTVfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 17:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhJTVft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 17:35:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C308C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:33:34 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0db300cc2d979de0b8ef18.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:b300:cc2d:979d:e0b8:ef18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 961E01EC054F;
        Wed, 20 Oct 2021 23:33:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634765612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dsjfBWI6wKKWwWro01yEyWHbVjpFfLoM/YqzmDMVLXo=;
        b=GVu7YxHWHXehAJvsssAkqATQcr5k1Wq5DXKhPD2tjWzQiEpcD8RTUMhsoY/izqIxQ1JtXA
        U40pb+oGu+2pBrGPvviuZF9A9v6pI+xh6da3aZGLv0J0p0xkIV+amQvFEBhrVW+3rAtJOL
        c7b5Yto+8FOb6kN+IUQeiU3KBU0XP8I=
Date:   Wed, 20 Oct 2021 23:33:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: MAINTAINERS: Add Dave Hansen to the x86 maintainer team
Message-ID: <YXCLKozoJ/gtbWxi@zn.tnic>
References: <87zgr3flq7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zgr3flq7.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 11:08:16PM +0200, Thomas Gleixner wrote:
> Dave is already listed as x86/mm maintainer, has a profund knowledge of
> the x86 architecture in general and a good taste in terms of kernel
> programming in general.
> 
> Add him as a full x86 maintainer with all rights and duties.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  MAINTAINERS |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20336,6 +20336,7 @@ X86 ARCHITECTURE (32-BIT AND 64-BIT)
>  M:	Thomas Gleixner <tglx@linutronix.de>
>  M:	Ingo Molnar <mingo@redhat.com>
>  M:	Borislav Petkov <bp@alien8.de>
> +M:	Dave Hansen <dave.hansen@linux.intel.com>
>  M:	x86@kernel.org
>  R:	"H. Peter Anvin" <hpa@zytor.com>
>  L:	linux-kernel@vger.kernel.org

Absolutely!

Dave, welcome to the team!

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
