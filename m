Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBECB33ECF8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhCQJ1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhCQJ1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:27:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BD8C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:27:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so1013771pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CHoHa8ANgbUXhNI8gJ7HiZ459ad1ZF2Tra1CY7Xtr2k=;
        b=iBN5cmPvI99uUHowxUBR84ahtRgUy1dF0922MmGTKqRM4EAfBefHsZ4C32iYA4SFGy
         5560oY/08KJ5iO2nHMSWhKpz20dAZOTTLfpnr3JFQCeKL1MXbGLKyBPjirQpEnHWBZyL
         Dew+9Afn7HG3pdramVwghslrevE4fHzVS8ZHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CHoHa8ANgbUXhNI8gJ7HiZ459ad1ZF2Tra1CY7Xtr2k=;
        b=QoTlyVxNrpJHAAnYc77H4/+8gro8K8G0BOuPSGyGLqzgnIzhFSOpn93GqEXbGt5H1b
         2XSaQ7qGKHGHxbDd+lcnPeEhQK0nGPMj9MEwsRRKRm2dUDH9gRLSvYF1KJZ94ntSeZ7D
         1qAlcU0nOt60HBs2UUJ1ptrRNxUSuaISYzHOJPuOHuGc+ICWxfPBiO84A0MQi245Cfl5
         UUWvDbFT6otKFNnHX+3RRorwtfqdMKfqwRcy6zuZA+998QetpNRsBLmCSZ2PHzCcPKDC
         DjuXtDcusdB1WvIwMVCfIaIgUlVLMl27etKbCb33mk05hD+0ttTJjb/2FFXsWPdNf/ZO
         cxZw==
X-Gm-Message-State: AOAM5311bPhnnMMVGBUSHWI49x2fbn2kCfPuxXLsD6Pan1e9zU2AbwEP
        z0cH7ll265VI+Hi5j/nl7lbIjTdmlMT/dA==
X-Google-Smtp-Source: ABdhPJzJQVUIs0RqXskkTI1Q/7L2H9DqOAZ+jdbctj5Bt7NA2+xTzYnz33OISX1tDsJKlaauzu3AEQ==
X-Received: by 2002:a17:90b:244:: with SMTP id fz4mr3560032pjb.137.1615973233884;
        Wed, 17 Mar 2021 02:27:13 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:b48f:f050:bdc5:eb89])
        by smtp.gmail.com with ESMTPSA id m5sm19071280pfd.96.2021.03.17.02.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:27:13 -0700 (PDT)
Date:   Wed, 17 Mar 2021 18:27:09 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv2 2/3] media: uvcvideo: add ROI auto controls
Message-ID: <YFHLbWwsF+lvhQb9@google.com>
References: <20210208051749.1785246-1-sergey.senozhatsky@gmail.com>
 <20210208051749.1785246-3-sergey.senozhatsky@gmail.com>
 <YFHJUyNA53J72bVA@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFHJUyNA53J72bVA@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/03/17 18:18), Sergey Senozhatsky wrote:
> On (21/02/08 14:17), Sergey Senozhatsky wrote:
> > This patch adds support for Region of Interest bmAutoControls.
> > 
> > ROI control is a compound data type:
> >   Control Selector     CT_REGION_OF_INTEREST_CONTROL
> >   Mandatory Requests   SET_CUR, GET_CUR, GET_MIN, GET_MAX, GET_DEF
> >   wLength 10
> >   Offset   Field            Size
> >   0        wROI_Top         2
> >   2        wROI_Left        2
> >   4        wROI_Bottom      2
> >   6        wROI_Right       2
> >   8        bmAutoControls   2       (Bitmap)
> > 
> > uvc_control_mapping, however, can handle only s32 data type at the
> > moment: ->get() returns s32 value, ->set() accepts s32 value; while
> > v4l2_ctrl maximum/minimum/default_value can hold only s64 values.
> > 
> > Hence ROI control handling is split into two patches:
> > a) bmAutoControls is handled via uvc_control_mapping as V4L2_CTRL_TYPE_MENU
> > b) ROI rectangle (SET_CUR, GET_CUR, GET_DEF) handling is implemented
> >    separately, by the means of selection API.
> 
> This approach is "no go".
> 
> I just figured out (am still debugging tho) that this patch set works on
> some devices and doesn't work on other. The root cause seems to be the
> fact that some firmwares error out all ROI requests when sizeof() of the
> ROI data is not 5 * __u16.
> 
> So those devices are not happy if we set/get ROI rectangle 4 * __u16
> and auto-controls __u16 separately; they want to set/get rect and
> rectanles in one shot.
> 
> This fixes ROI on those devices.
> 
> ---
> 
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -1190,6 +1190,7 @@ struct uvc_roi_rect {
>         __u16                   left;
>         __u16                   bottom;
>         __u16                   right;
> +       __u16                   auto_controls;
>  };

Maybe I can drop the separate auto-control and just use v4l2_selection::flags
to set the roi auto-controls value.
