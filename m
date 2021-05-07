Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBBB3762CC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbhEGJ17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 05:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbhEGJ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 05:27:58 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF9CC061345
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 02:18:58 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id v6so10696680ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 02:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gse-cs-msu-ru.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1o9fOfYSfdOLRiAvqZDl7HSV8PVlBtz8PalnoaqHKxE=;
        b=vwnM0CoCg7R1i/1jp1MZvWTP69djgR9Zc5n/8XqqmjmAq0U35kL1RKCMM2kB13+byt
         OJkErkQuCbfUqm4ME0Oi0poVqXn6xP6BiVhJOQ8wHFIVqjXmBK8We8BNtrBtrzMN/NRm
         O4ZJ+cpfsQFEAhYoRY76G8UWrNZ4AJ625uSJWXV/HSkbFGEMTfThQ87ox0cj7xeECT/E
         hnE3OjME6bryymqwRr4aQHtTwbPhzbfv9c9Srbi8vRy+dPxEnPj9vTQ/LqkENWwQCB8R
         6jag1InkvRfVl6GfVNzgiRltg8cXOd1ijfH2CJq5BHA1Q6KEJvl2QfSDEinbLjSclnAm
         Zynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1o9fOfYSfdOLRiAvqZDl7HSV8PVlBtz8PalnoaqHKxE=;
        b=gSuHM/88IFHOTb6J4hvPdHNnvMz/W9Mkjfvask8RMZS8LHLJ2V4yhEuHgNmEwtFSza
         ZZ5R/BROlWWxAsb5iK6TRfD94+yBcrRzaaVhl0tFP67fDAzFPvUZXFPxexRulG5FuieV
         2rWT1+lMllB1F2rO5SQ3whgLEnVkwyklFUDKOc5VhXIlX8fjnczV9ztVJCppXeFnTuKu
         JCH62p0Tn8CWs3TfgtcPDihrh0CV3tAxuXhOSCxV45NT94tT37RLxqWBWkbl2wmhOXzN
         daQ3fX+vZHZTs61ir0zzoadQzSKoEvrulPXS9GSFyWXAfqkjc5cNr8Be6SKc+75hyb2S
         DmRw==
X-Gm-Message-State: AOAM530uvirQ9PHU7JAtYZLNqtyVFPaZCJS3j6Wglyvh4qhdtTNhRsT6
        +lCodYSUzGrjOJtYqNvAJynVqGt+axF5h1jiNZ0lJg==
X-Google-Smtp-Source: ABdhPJwgfmUbDL1BY5nAx3kKI2XkygqI2MpgbmkeaOlAUMed3/6Vw5NvTFgEgoTiLB8Ubiz0H8mQotlxm/7/RrxCMMA=
X-Received: by 2002:a2e:1516:: with SMTP id s22mr7040859ljd.109.1620379137191;
 Fri, 07 May 2021 02:18:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:7e06:0:0:0:0:0 with HTTP; Fri, 7 May 2021 02:18:56 -0700 (PDT)
From:   =?UTF-8?B?0J/QvtC00LPQvtGA0L3Ri9C5INCQ0LvQtdC60YHQtdC5INCe0LvQtdCz0L7QstC40Yc=?= 
        <s02190176@gse.cs.msu.ru>
Date:   Fri, 7 May 2021 12:18:56 +0300
Message-ID: <CAA5EkfcVXC4MwMj=2GsfyLDjPsnT1nxgNk5XhdE346MuLFwMVQ@mail.gmail.com>
Subject: [BUG] ALSA: korg1212: Potential NULL pointer dereference in snd_korg1212_interrupt()
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Leon Romanovsky <leon@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_korg1212_create() makes the following steps during initialization
of the card:
1) registers an interrupt handler (lines 2230-2232)
2) allocates and initializes korg1212->sharedBufferPtr (lines 2280-2287)
3) reboots the card via snd_korg1212_Send1212Command() (line 2358)

2145    static int snd_korg1212_create(struct snd_card *card, struct
                                 pci_dev *pci, struct snd_korg1212 **rchip)
2147    {
                ...
2230            err = request_irq(pci->irq, snd_korg1212_interrupt,
2231                                        IRQF_SHARED,
2232                                        KBUILD_MODNAME, korg1212);
                ...
2280            if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, &pci->dev,
2281            sizeof(struct KorgSharedBuffer), &korg1212->dma_shared) < 0){

2282                         snd_printk(KERN_ERR "korg1212: can not
                                 allocate shared buffer memory (%zdbytes)\n",
                                 sizeof(struct KorgSharedBuffer));

2283                         snd_korg1212_free(korg1212);
2284                         return -ENOMEM;
2285            }
2286            korg1212->sharedBufferPtr =
                        (struct KorgSharedBuffer*)korg1212->dma_shared.area;
2287            korg1212->sharedBufferPhy = korg1212->dma_shared.addr;
                ...
2358            rc = snd_korg1212_Send1212Command(korg1212,
                        K1212_DB_RebootCard, 0, 0, 0, 0);
                ...
2412    }

But if interrupt happens when snd_korg1212_create() is still within
lines 2233-2286,
snd_korg1212_interrupt() may dereference korg1212->sharedBufferPtr before
it was initialized without any checks (line 1149):

1098    static irqreturn_t snd_korg1212_interrupt(int irq, void *dev_id)
1099    {
                ...
1116            switch (doorbellValue) {
                ...
1145                        case K1212_DB_CARDSTOPPED:
1146                            K1212_DEBUG_PRINTK_VERBOSE("K1212_DEBUG: IRQ
                                        CSTP count - %ld, %x, [%s].\n",
1147                                korg1212->irqcount, doorbellValue,
1148                                stateName[korg1212->cardState]);
1149                        korg1212->sharedBufferPtr->cardCommand = 0;
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
1150                        break;
                ...
1185    }

Should we be sure that such interrupt cannot happen or
should we move the registration of the interrupt handler after
korg1212->sharedBufferPtr is initialized?

Found by Linux Driver Verification project (linuxtesting.org).
