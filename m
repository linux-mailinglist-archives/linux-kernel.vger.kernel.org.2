Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CC044443A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 16:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhKCPGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 11:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhKCPGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 11:06:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CBBC061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 08:04:13 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id m14so2608573pfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iRvWtzwg/X+s+PVSCDVSgb8j+VJEj6TNe4P8gzkbf1E=;
        b=bHso6gi1DV1CF5WZ9TAs3H1Xlxf1WMMoI+tP6FGXAHPjJeiGAN+EnsdUBTiNl8eDZU
         kuKR39LqXDa8RpGyzqZjIzz/U1fQX5ZpAsjl7SbJTLnVE2m9pnhAiQrWmjrv3TWj1PiY
         GJdYf3hDaE134sx2ZFosOX2o30t5fh09v1GgMUXPS7JTxiGIHWaQ3VrvpSu114plf20a
         a4TtC6+WV825bmrzQOq3/5y+sRmHEnWzg2DaUPq5gGprf1Hdonvz4lAYa0Qr0x/JlaJR
         cxWG+R7Qy8CAw9XI/4goKMajav8EfIWyaTx1WVQapGyn/zEs2Rhj4Hpr5vzr0AogThnc
         xaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRvWtzwg/X+s+PVSCDVSgb8j+VJEj6TNe4P8gzkbf1E=;
        b=uQ1a2gkd2c1r61sme5KzC4D1mILCnsbc60aZ86aBJMY3kQj9yoRaefEaj5jeURkIt7
         nOgGWVIHhP+fMfZm32PW3h9S38wyLljQ2sVDhfiQ/vypSp7aa5wuH9nswUnGeW1l/hEI
         4mehVjrzQVG8EGf2Gf9wLn6s30IZeNtRnXChcimACqCiSIzmFy/k+4r/mp+RfLiwA8NU
         1p7wHNKSTCw90TnDjKzdPnU8s9reFZh2Sdm07RPood7FVfLdlpTpFDvbw+jf2vzy6SST
         dAVl+9j/FOtQIIjthp2NV/x38SsubDoBmPt/H27ES5ZLCNfWg26fcWG7ar3Z1gH6pzVt
         2ylA==
X-Gm-Message-State: AOAM531Bsg8MX6od4uymStw9VmcOmVBMPcM331qp52ZYX2XtCCc0cDOz
        oHoVX/BlXw2NOh19G05fqvib85m17RvJpU3sYfR+PQ==
X-Google-Smtp-Source: ABdhPJy38kv5yu9QkI0Sc1dz3CnMHn3IkSiqnB7JWHoxSzZxmxMosM6+HZrXEOIfa5D3aPYkHr/k2LSt1kVITbbIoRM=
X-Received: by 2002:aa7:88c4:0:b0:481:22c7:3d57 with SMTP id
 k4-20020aa788c4000000b0048122c73d57mr13744491pff.1.1635951852566; Wed, 03 Nov
 2021 08:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <7dc405471da4771641d2942960d364a588bb4395.1628161369.git.xji@analogixsemi.com>
 <20211018030529.2055255-1-xji@analogixsemi.com> <20211103142003.GW2794@kadam>
In-Reply-To: <20211103142003.GW2794@kadam>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 3 Nov 2021 16:04:00 +0100
Message-ID: <CAG3jFysp-Gs_Zk2PooTpqig1ns5pi+FKASMy=FW1V7oecdNGig@mail.gmail.com>
Subject: Re: [PATCH v11 4/4] drm/bridge: anx7625: add HDMI audio function
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Xin Ji <xji@analogixsemi.com>, devel@driverdev.osuosl.org,
        drinkcat@google.com, span@analogixsemi.com, sam@ravnborg.org,
        jonas@kwiboo.se, airlied@linux.ie, narmstrong@baylibre.com,
        zhenli@analogixsemi.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, anarsoul@gmail.com,
        a.hajda@samsung.com, boris.brezillon@collabora.com, duwe@lst.de,
        laurent.pinchart@ideasonboard.com, daniel@ffwll.ch,
        hsinyi@chromium.org, bliang@analogixsemi.com,
        m.szyprowski@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Xin,

This series does not apply on drm-misc-next. Please fix this and
resend. Make sure that checkpatch --strict passes as well.

On Wed, 3 Nov 2021 at 15:20, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> This is a super awkward way to resend a patch series.  Next time, just
> start a new thread and put [PATCH RESEND] in the subject.
>
> I am sorry that no one responded to your thread.  :/
>
> regards,
> dan carpenter
