Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D6433ECDA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhCQJSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhCQJSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:18:17 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BC5C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:18:17 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id o16so7433684pgu.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/RAuP6d3EHqVzmwtPPFGX8X8kp9JullC1xe70psycjM=;
        b=eUG+fAxmq/wH6hTcKCecXREl4EFwzDxKSQ2OSHfLvmOznzLTytowCM4UEoY1/QNhdU
         Vj3/nYfS8jv/K6AyOgXq7AbCriGLNtOGB7cwtkcK9abw4gtURuiDOUHPawLkcrnJrHzE
         YnCC7Orw8n5T+mjRWEFf9b+5rbojz+Vz6n82Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/RAuP6d3EHqVzmwtPPFGX8X8kp9JullC1xe70psycjM=;
        b=dikiHjDyraD71ua0fdK57A0BvLxcYCWejq2ZeWUSpVL+WyGuIySmBMzSFsRmKfxioC
         Uzz0jvQv7/+WZeS/hTK6iq027VbbZf8xY+tW8fQR/szFHh/teDc+p4saYH8c2GI6gMn6
         zjImdKqM1wrbKpmndCudnljbF43/2VctjsH9/c17TZjUTNx9xN83S9bkZ844BvQQ/Ve4
         H6hBGmixqZVzgIrDzAy4C16bBzjPiPBgZZHO196WcaTLIB/HETE1mJRvdSc05DvZHEZy
         P3qSm07cQmRF4scIwxV0rUlCA7of8lyo2CglD6fsnnsi0Ysrepr8RaJpWY+cMIAjSrzG
         Ym4g==
X-Gm-Message-State: AOAM532gxemuI0iU0EAALnzZdXfa3PZ5o2URb6h9PR5pBC8Q3LqKKn09
        Km4/1cy0AjQEvqUEyuBWJPiXc03Wezb0jw==
X-Google-Smtp-Source: ABdhPJxzEMAdvRlTnBIxyhFx2/AHYGkuQMMQyw5lQaOxKc3HfIjesRaNndy/n+mXkGntrZvMg5Ip/w==
X-Received: by 2002:aa7:95b5:0:b029:1ef:272f:920c with SMTP id a21-20020aa795b50000b02901ef272f920cmr3426660pfk.21.1615972697160;
        Wed, 17 Mar 2021 02:18:17 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:b48f:f050:bdc5:eb89])
        by smtp.gmail.com with ESMTPSA id mz11sm2046409pjb.6.2021.03.17.02.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:18:16 -0700 (PDT)
Date:   Wed, 17 Mar 2021 18:18:11 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv2 2/3] media: uvcvideo: add ROI auto controls
Message-ID: <YFHJUyNA53J72bVA@google.com>
References: <20210208051749.1785246-1-sergey.senozhatsky@gmail.com>
 <20210208051749.1785246-3-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208051749.1785246-3-sergey.senozhatsky@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/02/08 14:17), Sergey Senozhatsky wrote:
> This patch adds support for Region of Interest bmAutoControls.
> 
> ROI control is a compound data type:
>   Control Selector     CT_REGION_OF_INTEREST_CONTROL
>   Mandatory Requests   SET_CUR, GET_CUR, GET_MIN, GET_MAX, GET_DEF
>   wLength 10
>   Offset   Field            Size
>   0        wROI_Top         2
>   2        wROI_Left        2
>   4        wROI_Bottom      2
>   6        wROI_Right       2
>   8        bmAutoControls   2       (Bitmap)
> 
> uvc_control_mapping, however, can handle only s32 data type at the
> moment: ->get() returns s32 value, ->set() accepts s32 value; while
> v4l2_ctrl maximum/minimum/default_value can hold only s64 values.
> 
> Hence ROI control handling is split into two patches:
> a) bmAutoControls is handled via uvc_control_mapping as V4L2_CTRL_TYPE_MENU
> b) ROI rectangle (SET_CUR, GET_CUR, GET_DEF) handling is implemented
>    separately, by the means of selection API.

This approach is "no go".

I just figured out (am still debugging tho) that this patch set works on
some devices and doesn't work on other. The root cause seems to be the
fact that some firmwares error out all ROI requests when sizeof() of the
ROI data is not 5 * __u16.

So those devices are not happy if we set/get ROI rectangle 4 * __u16
and auto-controls __u16 separately; they want to set/get rect and
rectanles in one shot.

This fixes ROI on those devices.

---

+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -1190,6 +1190,7 @@ struct uvc_roi_rect {
        __u16                   left;
        __u16                   bottom;
        __u16                   right;
+       __u16                   auto_controls;
 };

---

Back to base 1.
