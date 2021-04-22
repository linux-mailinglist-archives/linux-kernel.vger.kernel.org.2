Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E85367746
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 04:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhDVCOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 22:14:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231958AbhDVCOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 22:14:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82406613A9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 02:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619057622;
        bh=Yw7K9IjVKeA1ve5XeFqKI9e8FmeRsydmEaXBh4ITgOE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MdqXnfphixpyQ3qeRIwYn7HO4Mf4dPu26iLeck6sChFNz9Bw/LrvnJMUfbkt0+y1f
         TC9AiGYqq3zhyMT+os6NEe+NH8ZKwXHaSimWqJQZKc4YwKWO8z7BU7zX1JoogJzupl
         s9qSpOOmxMGuBIU1S3mwadUjVjvyEbouvowgrD3r1NrHTOvPJvCOtuz3qEOjeJkFCw
         KIuLpH9aRd4zq34p3dB2OWy5siVK8q2mHHvSWCMnG8nAGQ5ygezEwP02a8bA6/FVEv
         55+8aZYSIPb2DMqTmELscSMO+S5a1TZIt2jzgHwNQ2L78TlL94J1gBjZx+Xb8v9zK6
         CRg2xNnrQAn9Q==
Received: by mail-ed1-f46.google.com with SMTP id bx20so50441967edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:13:42 -0700 (PDT)
X-Gm-Message-State: AOAM532mzKKuFpA5llTJbsg7ukGcWr4H1FQWHECfD3aqpKazut5K9TGg
        akxnw5/OUYy9Cdes1uFsRwL0TQR9R3Kl+HzDow==
X-Google-Smtp-Source: ABdhPJzwI8F/F+Wc8pu5UrW5JX71y3qdUywFKV19rtT5/YxTMHIQDMYNWVbo6u510fJD5+wLnQ/xCbC/EXZDdbLFnvI=
X-Received: by 2002:a05:6402:34c8:: with SMTP id w8mr1030755edc.194.1619057620994;
 Wed, 21 Apr 2021 19:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org> <20210421130105.1226686-98-gregkh@linuxfoundation.org>
In-Reply-To: <20210421130105.1226686-98-gregkh@linuxfoundation.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 21 Apr 2021 21:13:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKoqh=-8UHk9JkCgK1fC7bVjVLNehHUM=R_g6fDan3dHg@mail.gmail.com>
Message-ID: <CAL_JsqKoqh=-8UHk9JkCgK1fC7bVjVLNehHUM=R_g6fDan3dHg@mail.gmail.com>
Subject: Re: [PATCH 097/190] Revert "video: imsttfb: fix potential NULL
 pointer dereferences"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kangjie Lu <kjlu@umn.edu>, Aditya Pakki <pakki001@umn.edu>,
        Finn Thain <fthain@telegraphics.com.au>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 8:05 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This reverts commit 1d84353d205a953e2381044953b7fa31c8c9702d.
>
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
>
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
>
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Finn Thain <fthain@telegraphics.com.au>
> Cc: Rob Herring <robh@kernel.org>

Sigh, get_maintainers.pl likes to punish people for treewide clean-ups...

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/video/fbdev/imsttfb.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
> index 3ac053b88495..e04411701ec8 100644
> --- a/drivers/video/fbdev/imsttfb.c
> +++ b/drivers/video/fbdev/imsttfb.c
> @@ -1512,11 +1512,6 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>         info->fix.smem_start = addr;
>         info->screen_base = (__u8 *)ioremap(addr, par->ramdac == IBM ?
>                                             0x400000 : 0x800000);
> -       if (!info->screen_base) {
> -               release_mem_region(addr, size);
> -               framebuffer_release(info);
> -               return -ENOMEM;
> -       }

The original change appears to be valid, but incomplete...

>         info->fix.mmio_start = addr + 0x800000;
>         par->dc_regs = ioremap(addr + 0x800000, 0x1000);

...because what about cleanup when this ioremap fails.

>         par->cmap_regs_phys = addr + 0x840000;

Then again, if anyone really cared about this driver and h/w (a
PowerMac era PCI display card), it would not still be using fbdev and
would use devm_* apis.

Rob
