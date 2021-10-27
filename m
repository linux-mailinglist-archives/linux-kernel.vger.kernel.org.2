Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2FD43CF9A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbhJ0RYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbhJ0RYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:24:07 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AF3C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 10:21:42 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id f9so4520148ioo.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 10:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QZE204EdFXCqqeplQIQZFn93510I/ipYoAbmbJM+aPk=;
        b=qQR/yLJkXvFfrSdto2VPUZG+SB2UoWOgA4fQfhs1YUHlTbFHe+YFpsD/kXYkku3Obf
         +ZSY4SGwXRRtZRCnPyjGToLgEkDTFiUnnJxLnke4N+v4CsWBRVH30r063vrl+DPuL4Yj
         jLwiIQpQFOwtFjUXfT5u03rWT/DuEiM0+rxvpQ2DLYmxy+T/qrA/rvKsM/0PxvdzP4AX
         XAaE2iVTGw1TFxGbdMD2oO9tqAGRV6eoT6zKjNIUtnHdfTa19fo2vMUdiAm6XZQ/4WSS
         WThoj2vkh1yIH4sJ9BzBmiJCDzoPlaJK01pThZwOyO2n1eK9dZCyvnKcxmB213+zu+Po
         1Iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZE204EdFXCqqeplQIQZFn93510I/ipYoAbmbJM+aPk=;
        b=hPzav+nPuD/PqQ78XZw9V6v/lhEfvpphAh7B55wG9EfstLIvsV1q9KwkokhS2gaEpQ
         8N2T1w/8aNUrvA7VIriXyUvVcyWgF4hr07gdHguF8JasK7+70Dz3kY4Pv5uQZauLiRp8
         Z2uhQTuJepj/pPJ5ovIF6dsQSvigu+dMcuNmD6L8TffgkPY++C/cs5pp/0Jq7DJ1V10L
         t0L5dokTPoxOkEPmhp5MTtAVegeFoStTagLa32uqzfCcJ4DeTstAoxZS3g4Dx8Vp5XU4
         h/P190S6HstaQvRQAbA9HAfUfu8QS6qlvLsegQFmeW+sFpFHufvTxEKl+xtDpHSdda8h
         kkWQ==
X-Gm-Message-State: AOAM531ARznQ+/ESt+rwoPjITkpO/BY4DRti5C2/dvrO7j/OOWb30rvX
        2fTeSP1D+0iEwyks14/JW79HoJqCaM1vkvM5ukNsaEOaygY=
X-Google-Smtp-Source: ABdhPJyn7hzvRV4nB13mGIYQHEFKL8xWPzUMMcn2u++F3EJBTnAm/MsnY9+1CGKKRVUw+IJfBSlVduDOHACuui/nqIg=
X-Received: by 2002:a05:6602:168f:: with SMTP id s15mr21499612iow.178.1635355301612;
 Wed, 27 Oct 2021 10:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAD2CkAWjS8=kKwEEN4cgVNjyFORUibzEiCUA-X+SMtbo0JoMmA@mail.gmail.com>
 <d8434a1a-b813-958f-69d7-34007faa49b7@deltatee.com>
In-Reply-To: <d8434a1a-b813-958f-69d7-34007faa49b7@deltatee.com>
From:   Marshall Midden <marshallmidden@gmail.com>
Date:   Wed, 27 Oct 2021 12:21:30 -0500
Message-ID: <CAD2CkAV8fWVPdtoxzf5w-q_411Zw_Rwm1QGuz3-Li7eFXehktw@mail.gmail.com>
Subject: Re: v5.15-rc7 AMD no kernel dump, spews "scsi_dma_map failed: request
 for 36 bytes!"
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     joro@8bytes.org, will@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, the spewing of messages stopped. Kernel crash dump taking is now
occurring.  Patch applied to v5.15-rc7.
Reworded: THANKS!  Patch works!

Dunno why the dmesg isn't right, but at least there is a core image!
[I updated makedumpfs for v5.15-rc4 -- applying a bunch of cifs/smb,
qlogic, etc. patches and was getting ready for new kernel release in a
few weeks -- couldn't debug a cifs crash. :) Down the rabbit hole...
;) ]
Intel machine booted, etc. and it has a dmesg correct. *sigh*  I don't
think "I" need to worry about that. Someone else can report it.

/media/parsecdata/crash/127.0.0.1-2021-10-27-12:06:53:
total 5283408
-rw------- 1 root root 5410206160 Oct 27 12:06 vmcore
-rw-r--r-- 1 root root          0 Oct 27 12:06 vmcore-dmesg-incomplete.txt

On Wed, Oct 27, 2021 at 11:41 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> Hi,
>
> On 2021-10-27 10:08 a.m., Marshall Midden wrote:
> > v5.15-rc7 AMD no kernel dump, spews "scsi_dma_map failed: request for 36 bytes!"
> >
> > With v5.15-rc (1 through 7), AMD processor kernel crash dumps do not occur,
> > instead spews:
> >         "scsci_dma_map failed: request for 36 bytes!"
> > Works on Intel machines, and in v5.14.0 (and v5.14.14) - as well as previous
> > kernels (down to v5.3.x.)
> > git bisect torvalds repository shows: dabb16f67215918c48cf3ff1fc4bc36ca421da2b
> > Reverse patch to tag v5.15-rc7 allows kernel crash dumps to occur/happen.
> >
>
> On careful review I think I see what might be causing this. Can you
> please try the following patch?
>
> Thanks,
>
> Logan
>
> --
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index cd0f1a593997..3bfb5da87802 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1028,7 +1028,8 @@ static int iommu_dma_map_sg(struct device *dev,
> struct sc>
>
>         if (static_branch_unlikely(&iommu_deferred_attach_enabled)) {
>                 ret = iommu_deferred_attach(dev, domain);
> -               goto out;
> +               if (ret)
> +                       goto out;
>         }
>
>         if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
