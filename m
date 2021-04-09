Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A905359560
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 08:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbhDIGXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 02:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbhDIGXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 02:23:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14890C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 23:23:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id g17so4074144ejp.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 23:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0WMp8MwKJ/u3qX7Dv8XtiWzb8xXHglsszw5dF/53Js=;
        b=RSzU/8fTXW2zL+EO/inJbfSmLIUvORZ+0ncpCjsA5xwox5jMW+/13995cQ1BG3+drn
         IZLu1plLrnt4tTK9456EABz/OGQNBErWwlNrkad+Xu2ynqUdG049uL1nGgvDOpkN5YQF
         Z5VxJ8a24qmf8sTw08PZCOYyjRLbLc3aSYuEVLbcrzIzisS19Y+MvrZRe4EsB/OXp7Zc
         Nduhl29srfd0adZ5Np0cthNChuCC60bAfT50gGRfWDz28GU052SKiHM22kDt34JNpaSP
         j+zO42c44T9gPxiY1sPbQ8GzIO4UTE4AKDK4iq42bImf4aZVY+wH3fXj/mbLqLnaRAzL
         UY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0WMp8MwKJ/u3qX7Dv8XtiWzb8xXHglsszw5dF/53Js=;
        b=TiBKeO2En8P3XHegTMoXYbaBddE84Sb+uPUmmPU4w5o4BsiDu2Q5vUJQV/lC+Oso/f
         Uea8Mk33l25/GL1NeL6XWmmTZtFjcqPArrGOmX+ot4Urfbanmee5cSMWg7sIagbb2mHs
         L5sXMBU2azWV3U6JeapGs+z8H/gHrF598Reuc2oJPvH6+FRg8O8sjHX+23MrNLP21Z3I
         a0soUS4zNZJu5VyP0DrwTF3o0lCOUT9k+haqUrbLjvUSVPRKHzg3someGmdzj8n/2KcU
         e2RyNsnELVNWz3o8fSRt2qv87YvC8FmckEWJSsbMaQmP5SfKj/9VP73/iXH7txJVNkBG
         pLlw==
X-Gm-Message-State: AOAM533Um95676lMj91CrSF0PV+QjjXsOc4+MsLhSvjdLH/PCInCo6Ay
        4o2k7C8GAXZDuhx7YZFPNYbxewuzb+/mFAqMke1PYw==
X-Google-Smtp-Source: ABdhPJyNW8FA7KCEbD2ruFaUWyLqipptmdm8sQ3TknahXLmC9cmxEHhJE+UDIIR9xnnqW2/0yG2B0wUwPtpsfi7AkfM=
X-Received: by 2002:a17:907:7785:: with SMTP id ky5mr14338784ejc.133.1617949418711;
 Thu, 08 Apr 2021 23:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtNAEwCk1WkA_25FVUrR0QJ2vt2Dh_w+m-QOSjb8f5TBQ@mail.gmail.com>
 <BYAPR04MB4965A95A5131664085CDD8B786739@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4965A95A5131664085CDD8B786739@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 9 Apr 2021 11:53:27 +0530
Message-ID: <CA+G9fYt30EZOv2mUOf+xGh3R3A0SMJhvVtHFwZuKyBgB75UTTw@mail.gmail.com>
Subject: Re: [next] drivers/cdrom/gdrom.c:586:61: error: 'rq' undeclared
 (first use in this function)
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chaitanya,

On Fri, 9 Apr 2021 at 11:01, Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 4/8/21 22:21, Naresh Kamboju wrote:
> > Linux next tag 20210408 architecture sh builds failed due to these errors.
> >
> > # to reproduce this build locally:
> >
> > make --silent --keep-going --jobs=8
> > O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=sh
> > CROSS_COMPILE=sh4-linux-gnu- 'CC=sccache sh4-linux-gnu-gcc'
> > 'HOSTCC=sccache gcc'
> >
> >
> > In file included from /builds/linux/include/linux/scatterlist.h:9,
> >                  from /builds/linux/include/linux/dma-mapping.h:10,
> >                  from /builds/linux/drivers/cdrom/gdrom.c:16:
> > /builds/linux/drivers/cdrom/gdrom.c: In function 'gdrom_readdisk_dma':
> > /builds/linux/drivers/cdrom/gdrom.c:586:61: error: 'rq' undeclared
> > (first use in this function)
> >   586 |  __raw_writel(page_to_phys(bio_page(req->bio)) + bio_offset(rq->bio),
> >       |                                                             ^~
> >
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> >
> > Regressions found on sh:
> >   - build/gcc-9-dreamcast_defconfig
> >   - build/gcc-10-dreamcast_defconfig
> >   - build/gcc-8-dreamcast_defconfig
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org
> >
>
> This can be fixed by following :-
>
> diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
> index e7717d090868..742b4a0932e3 100644
> --- a/drivers/cdrom/gdrom.c
> +++ b/drivers/cdrom/gdrom.c
> @@ -583,7 +583,7 @@ static blk_status_t gdrom_readdisk_dma(struct
> request *req)
>         read_command->cmd[1] = 0x20;
>         block = blk_rq_pos(req)/GD_TO_BLK + GD_SESSION_OFFSET;
>         block_cnt = blk_rq_sectors(req)/GD_TO_BLK;
> -       __raw_writel(page_to_phys(bio_page(req->bio)) + bio_offset(rq->bio),
> +       __raw_writel(page_to_phys(bio_page(req->bio)) +
> bio_offset(req->bio),
>                         GDROM_DMA_STARTADDR_REG);
>         __raw_writel(block_cnt * GDROM_HARD_SECTOR, GDROM_DMA_LENGTH_REG);
>         __raw_writel(1, GDROM_DMA_DIRECTION_REG);

Thanks for your patch.
After applying this typo fix, the build pass now.

- Naresh
