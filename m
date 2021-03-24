Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35859346F69
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhCXCWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhCXCWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:22:25 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBD8C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:22:25 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id g15so16250707pfq.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=24qmeKyq+RHas/0nWkzkV/yI24iW9xTstvjT8SYVV4E=;
        b=Z/cYUHiAg1doJjTTL9i5pzxTGBcMOwSFHfvXzdWI360hIUuuL+l/4Itd0NqBwrVq3m
         JpNg1TbeLRgZx7/VHCob/VRq2QxVsDTWRa7GlmDMKrGrYSzi+hdtqb10NhgvShPeSiWS
         HOQyDu00aY3ueYqPJ6vocPlj9PM+p5LpE4gjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=24qmeKyq+RHas/0nWkzkV/yI24iW9xTstvjT8SYVV4E=;
        b=Q05U26tbjAxazCKXJi3KvONF94kSqEaPewtIJpmfSZam1yRiR7enTpKszcm+yanpYU
         x2X2jz/1U3soQvhl2hbo8DB11abPLTpvZSseYs4ZH/U3/j1CPwCUWK85sJozkV7RKHVY
         D8o4yOtrrhXZU5RWBYYdBazR2G6C99a2dG4AYMqawkM69v8mXc51jU/+pvIibx5C8YSF
         0qLq5V+NAXetJ3AjlNTf1I5mgt74G/NGlCKpvOYMgvY/b4aKgrN+0FEa9DE5yV3ZaN8n
         QPyBGphbHD736beWNNVcYxSDQUxhW5SLPzr4nRFcq5qIDYP7TGNkeaXcIX+7ciah/5zr
         wVWA==
X-Gm-Message-State: AOAM5328TYQ/YHoOA/4GzhqC7qDOuQ7/TDO+3vqPvQyP0+w4ruT1vQKC
        rHpTU+MN+wqqk/TtkCTxH4Z1Wg==
X-Google-Smtp-Source: ABdhPJxnk/W0wD4yXUfVCUeih3TUIWGMrPaANeh6c9Cpau3Dqf9YRsDnOkp2GPsr2Rbg8zwwigZIQg==
X-Received: by 2002:a63:43c2:: with SMTP id q185mr993479pga.41.1616552544705;
        Tue, 23 Mar 2021 19:22:24 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:bcf2:e05a:a993:9494])
        by smtp.gmail.com with ESMTPSA id j3sm439947pfi.74.2021.03.23.19.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:22:23 -0700 (PDT)
Date:   Wed, 24 Mar 2021 11:22:18 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 3/6] media: v4l UAPI: add ROI auto-controls flags
Message-ID: <YFqiWixqSuPMTwXz@google.com>
References: <20210319055342.127308-1-senozhatsky@chromium.org>
 <20210319055342.127308-4-senozhatsky@chromium.org>
 <CANiDSCseJdKuPSZFDvc8VGp=PDqGEN42ZsLVGgkwhAz5hhVCQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiDSCseJdKuPSZFDvc8VGp=PDqGEN42ZsLVGgkwhAz5hhVCQQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/03/23 17:04), Ricardo Ribalda wrote:
> On Fri, Mar 19, 2021 at 6:53 AM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > UVC 1.5 defines the following Region Of Interest auto controls:
> >
> > D0: Auto Exposure
> > D1: Auto Iris
> > D2: Auto White Balance
> > D3: Auto Focus
> > D4: Auto Face Detect
> > D5: Auto Detect and Track
> > D6: Image Stabilization
> > D7: Higher Quality
> > D8 – D15: Reserved, set to zero
> >
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > ---
> >  include/uapi/linux/v4l2-common.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/include/uapi/linux/v4l2-common.h b/include/uapi/linux/v4l2-common.h
> > index 3651ebb8cb23..34f1c262d6aa 100644
> > --- a/include/uapi/linux/v4l2-common.h
> > +++ b/include/uapi/linux/v4l2-common.h
> > @@ -92,6 +92,16 @@
> >  #define V4L2_SEL_FLAG_LE               (1 << 1)
> >  #define V4L2_SEL_FLAG_KEEP_CONFIG      (1 << 2)
> >
> 
> Are you sure that you do not want to start with 1<<3, there might be
> some hardware that support LE/SE

How the hardware's going to support this? There is simply no way to
pass these flags to the firmware, the values already overlap with
auto-controls. So I guess these flags are for the driver (C code).
uvcvideo driver is not doing any "lesser or equal rectangle" magic
for ROI. No such thing is defined by UVC spec.

I can move these flags to entirely different value range and do
remapping to uvc auto-controls values in uvcvideo.
