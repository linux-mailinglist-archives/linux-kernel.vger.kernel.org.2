Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74423E2902
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245242AbhHFLBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhHFLA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:00:57 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799F4C061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 04:00:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cl16-20020a17090af690b02901782c35c4ccso13331637pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 04:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqezZ2/HwBTxC4hfR4A8RkBTbm8B6r0iUtltdIvH/WQ=;
        b=wPfCjiqa1MALuiJUaKW5iy1FtNfG6I7bAdM+tcLUlHzl2neknstN3PG01WGezIG4Wn
         AX67+2Wo1cV03hBdnAJyve/wr3U++Sv2+IO4fFRMwBMjg3MlY4LMXxnv9cUYr0J/w8ME
         l0Btb8iRsW/UikCqCHgTYoJAbfIOOSYrxH6UeL81fCtnPOMXF1pOCqAmkKk5chBEiw6Z
         yaTEYJbWUNoVt4HmP/4ut1Oa6QtRxGJUZVSJkrVVIiTdIOwLidoVSJUVDDptJehoEaTE
         KjoaWncKZEYbCPNeDiBQIxq744EGlx7PnATR24qZV2yaDdvpXGHuLHdVuLaLwuvlgthS
         ag0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqezZ2/HwBTxC4hfR4A8RkBTbm8B6r0iUtltdIvH/WQ=;
        b=alCO9MJMLhLrFiGrHUXN4rhWlRtCsYIgyI04jqX1L5RftLti1TewGmJMBl3A+PeyBA
         31WGUfYFM54wzAqzBNhrKFZlgFUWDNNhlL20SVGA2GL6jjG1FSDOnsk0M4K/H5NopFCe
         7kh9U8jkQB7thU5d7qqoEcmlKdQmnHJi69brpoGedroqvQzXBtvQtFmYp/ZVbngyV0/j
         LHS9bnZHvFwC+PuFVBiJdWLHX/rXG9sMZVLa0Q99dJH6bgrQGg8gDfMi80kY1OZbztcY
         bE49pyi+PeJsGxRkcfLCxQRO+/bhQbVFU3JmKuMIOQMOMUFwfo41cf/KNrz45D/CDfwb
         eDeA==
X-Gm-Message-State: AOAM53134IavF5+xENRWchDWJKC39LoppH5+oeHQONEa/VidC3mTMbFZ
        eGnf4hafvEM7fiWe/mzfTSF9PD5iwdmx+WdXFmtA1w==
X-Google-Smtp-Source: ABdhPJx2mx/FDsh5/262RxdOPkT6ydnEP3Uh2S21vtAYPtUS+Wn/DcQtgQAbZX/mXgpJQMdt+fMf5UfYoS3PcG5G/uw=
X-Received: by 2002:a63:494f:: with SMTP id y15mr876560pgk.185.1628247641017;
 Fri, 06 Aug 2021 04:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210806104407.2208538-1-xji@analogixsemi.com>
In-Reply-To: <20210806104407.2208538-1-xji@analogixsemi.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 6 Aug 2021 13:00:30 +0200
Message-ID: <CAG3jFyuB-PJc5S+jPiBH8_shyWR_05JTBiO802+tg+8RvBQUcg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: anx7625: Tune K value for IVO panel
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Nicolas Boichat <drinkcat@google.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, Torsten Duwe <duwe@lst.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bernie Liang <bliang@analogixsemi.com>,
        Qilin Wen <qwen@analogixsemi.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next
