Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E813FD470
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242605AbhIAHdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242536AbhIAHdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:33:31 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E694C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 00:32:35 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f3000ff66408ba4c79392.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:3000:ff66:408b:a4c7:9392])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 486081EC051E;
        Wed,  1 Sep 2021 09:32:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630481548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Nfx7osNSCSWsuprh9JcmDnOdHspNz8TiIpJSkCXCK6U=;
        b=HCvf70KyLdcFsXPWQoba889Qb+VICM63hbggFR9iCZBjNmMmHWIOC/YIZA7OKITJdHNwpo
        Ibz+aALzrNSBdEvPc3Rlv1/5lRhXZg/xZ9t4westld+0gDVJz5ufmBYAAqFi3MyXO64EgT
        kTOPSpuMYnKQtnj9+19OEDxXxwsNVj8=
Date:   Wed, 1 Sep 2021 09:33:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     torvalds@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: make setup.c build again
Message-ID: <YS8stOCBCdfZ+J0Y@zn.tnic>
References: <20210901071232.1258388-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210901071232.1258388-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 09:12:32AM +0200, Christoph Hellwig wrote:
> Add a <linux/acpi.h> include to setup.c to ensure it compiles without
> any config-dependent implicit includes of that header.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/kernel/setup.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 63b20536c8d23..6edec9a28293e 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -22,6 +22,7 @@
>  #include <linux/usb/xhci-dbgp.h>
>  #include <linux/static_call.h>
>  #include <linux/swiotlb.h>
> +#include <linux/acpi.h>
>  
>  #include <uapi/linux/mount.h>
>  
> -- 

There's an identical fix

https://lkml.kernel.org/r/20210901021510.1561219-1-nathan@kernel.org

which explains why it happens but I'm fine with whichever one Linus
picks up.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
