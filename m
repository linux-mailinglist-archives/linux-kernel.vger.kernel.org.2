Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AB334F634
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhCaBZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhCaBZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:25:00 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD10C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 18:25:00 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id h3so13359540pfr.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 18:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0k9lXRJTS1Wy+xaZrJOGXgNw1l0SEWX+Tl4Aywnp+T4=;
        b=jPaKtFx3zVY3hunovhRFR7mAKTjxioFYYJz8ouQey1m/QZHIbE8r0UmNMsV/8iGYfc
         0/FuXL7+dB1kML92yA39BODXyPt2DfhzshN2EOrBODRpeCa/eaeaOA1MjIEK+DxkDfVZ
         1xPMp0c9VTla0hrve04OkC0s7rFbkWfQ8AUeh3L1QfJg2EcG7xMs1/8ctsxoWJDQg46A
         217zPVR2nZ3z3Hqn/iUWe4RELzzTuWBl/KK/wSrZNEddi+Gt+oGtLW/dPrbC/SuClDXn
         dGPq+SwFU4SArs4y/+YB1eeFHMqFjTa51Hc/gOnQ82W6L8Lqn5900PJjV969wvSfmJDE
         tqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0k9lXRJTS1Wy+xaZrJOGXgNw1l0SEWX+Tl4Aywnp+T4=;
        b=AhIgfVzbptkCK4L9Ou6LKbPXoqiuM8lZ7krzm6WmTi3Ih8j8xnGEfceti6RbDBQSAQ
         PK7EPSJOwU/D6lP7cGiIdRJ5bjGeKtYnMXx8ucimXSU66jiWcrQzKRVX3o81cILim87O
         L1u9CHBYEH6Gs3Ee/QPajSm5Tkn7o8cPiBgRMTH9C6WBFBKsKLVN2vo6MqSd8Fxuyy8f
         S+awImsVStTX8Cgx2UTfB5ErmVrX0gC5Cyf6GKyhOXZOQUhC92jjfjQe+Bwks+09eyi4
         MJX/N8mMB8r9jTVNB1zOZ+vQ6yKfvp1RFkCsH4kSaan8Wxpw/YDqG6UqShyzOd+Upd5F
         yRuQ==
X-Gm-Message-State: AOAM532zZua/3i6kEz7QULot7+L0CEre8/dwuTRKl2Eji2s+d73VJmrP
        AIJGfWR4ostL37rAaJ5QGdo=
X-Google-Smtp-Source: ABdhPJzJpXSDBGi7T4t0K1MYRPr9nB4Lvl1izl8/SJM3atEN25F66hzr5wrgQrrWu330B2dCQ9DbaQ==
X-Received: by 2002:a63:175c:: with SMTP id 28mr826053pgx.376.1617153900123;
        Tue, 30 Mar 2021 18:25:00 -0700 (PDT)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id 11sm236828pfn.146.2021.03.30.18.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 18:24:59 -0700 (PDT)
Date:   Tue, 30 Mar 2021 16:18:29 +0800
From:   carlis <zhangxuezhi3@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, zhangxuezhi1@yulong.com,
        sam@ravnborg.org, kraxel@redhat.com, tzimmermann@suse.de,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/1] drm/tiny: add support for Waveshare 2inch LCD
 module
Message-ID: <20210330161829.00002263@gmail.com>
In-Reply-To: <ee78a788-3a69-164d-95da-6482e05f8603@lechnology.com>
References: <20210330080846.116223-1-zhangxuezhi3@gmail.com>
        <ee78a788-3a69-164d-95da-6482e05f8603@lechnology.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 09:17:19 -0500
David Lechner <david@lechnology.com> wrote:

> On 3/30/21 3:08 AM, Carlis wrote:
> > From: Xuezhi Zhang <zhangxuezhi1@yulong.com>
> > 
> > This adds a new module for the ST7789V controller with parameters
> > for the Waveshare 2inch LCD module.
> > 
> > Signed-off-by: Xuezhi Zhang <zhangxuezhi1@yulong.com>
> > ---
> > v2:change compatible value.
> > v3:change author name.
> > ---
> >   MAINTAINERS                    |   8 +
> >   drivers/gpu/drm/tiny/Kconfig   |  14 ++
> >   drivers/gpu/drm/tiny/Makefile  |   1 +
> >   drivers/gpu/drm/tiny/st7789v.c | 269
> > +++++++++++++++++++++++++++++++++ 4 files changed, 292 insertions(+)
> >   create mode 100644 drivers/gpu/drm/tiny/st7789v.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d92f85ca831d..df25e8e0deb1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5769,6 +5769,14 @@ T:	git
> > git://anongit.freedesktop.org/drm/drm-misc F:
> > Documentation/devicetree/bindings/display/sitronix,st7735r.yaml
> > F:	drivers/gpu/drm/tiny/st7735r.c 
> > +DRM DRIVER FOR SITRONIX ST7789V PANELS
> > +M:	David Lechner <david@lechnology.com>  
> 
OK, i will remove this in the next patch.
> I should not be added here. I don't have one of these displays.
> 
> > +M:	Xuezhi Zhang <zhangxuezhi1@yulong.com>
> > +S:	Maintained
> > +T:	git git://anongit.freedesktop.org/drm/drm-misc
> > +F:
> > Documentation/devicetree/bindings/display/sitronix,st7789v-dbi.yaml
> > +F:	drivers/gpu/drm/tiny/st7789v.c +
> >   DRM DRIVER FOR SONY ACX424AKP PANELS
> >   M:	Linus Walleij <linus.walleij@linaro.org>
> >   S:	Maintained  
thanks,
Xuezhi Zhang

