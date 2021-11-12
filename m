Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2CB44E45D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 11:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbhKLKMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 05:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbhKLKMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:12:18 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7DAC061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 02:09:28 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so5164452otj.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 02:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1UIviT/iEpg02tsl0vodgO77AUWUF+iHJhNcWDAIxyc=;
        b=Nnb+RTc6JF+hYggAcUVzXhgUOACSv0jPxNKXJmP7yUn7da86rIHZDkX5C1ujcB3/QJ
         ydDQmIpPnQ6DZM6m72F3fDxxHqnCyruXtRazYSHUvbO2hQUTUo4c3qE5H5l3WQuRmPK0
         G+TvzsCIBIiNoKOksP2Pway8YErnfPCpaaLVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1UIviT/iEpg02tsl0vodgO77AUWUF+iHJhNcWDAIxyc=;
        b=Z0tZ3YtQ9ams6hb6OcL3HEGSeBl3Z2cCp+Hgev3RU31/xwtiQXk67VHQslC6R2WqL1
         GBkO+IBoBHhgMxHPhEn5b2RpBNZSnPaJzLSXLj8/Ksm+59o5kxCe9Q6AYaIXmEe3YVuk
         7BplPhBfC2eMNsdeKKOy7fYd1WedL/IQY4PbIxX++ZOmSI9fqB2zgz5x9w0c3mJeMOQ3
         6fctL1GK7DBqO61LiV+wn7MkHcTqNiSUhP1W3hUle8FDhUulvUtsrDBdSsw68lMiwxER
         nrOniw2mQ8wPnvFnT5tYIPueXs7euBw302OP7H5rrwMwAei7LHdMZQAsoYz+k0tQhF57
         qbKQ==
X-Gm-Message-State: AOAM531QgTDg3djo/fmejbbij+OVZKo7Gxo1UOeixwioOwVgQE/7/QuY
        Wv8MwwaPlzSCQH7MjHXWNT4LwSsnWpuiuw==
X-Google-Smtp-Source: ABdhPJxeHXVENtsCM1mnSmR3bNUpyXFpDbXbr8jdivjAFBJep0Uq501e2sfQNR5FxVwC7KBWi1SCnw==
X-Received: by 2002:a9d:7459:: with SMTP id p25mr11325374otk.247.1636711767451;
        Fri, 12 Nov 2021 02:09:27 -0800 (PST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id m3sm1148348otp.6.2021.11.12.02.09.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 02:09:26 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id t19so17072026oij.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 02:09:25 -0800 (PST)
X-Received: by 2002:aca:be54:: with SMTP id o81mr25029359oif.64.1636711765360;
 Fri, 12 Nov 2021 02:09:25 -0800 (PST)
MIME-Version: 1.0
References: <20210909150046.57615-1-ribalda@chromium.org> <CADvTj4rB5ZThAh2oPkx2=mqUir4Bc_uFFaL6DV_YyOYNSDrXEQ@mail.gmail.com>
 <CANiDSCvpRezQMEBbmv4z9ttPt9sThHXR2xmnizzacYuMDri-KQ@mail.gmail.com>
 <CADvTj4pAxGYeuQEN_ktHko41z=bCWWb1UtbdngezMoUUsvsj6Q@mail.gmail.com>
 <CANiDSCvkcr8hbdo4Ea2p3BdMPiPE2RC_HcHHmUdm9uy1XN2E4Q@mail.gmail.com> <CADvTj4r_SzChXj04Ddn6PPUDN7QnKczm6MJXeES-uUUQx3ds+Q@mail.gmail.com>
In-Reply-To: <CADvTj4r_SzChXj04Ddn6PPUDN7QnKczm6MJXeES-uUUQx3ds+Q@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 12 Nov 2021 11:09:14 +0100
X-Gmail-Original-Message-ID: <CANiDSCsDWz5rS881NXXcuxJYb5RP=HLEmdQaYiKrjqyvhO223A@mail.gmail.com>
Message-ID: <CANiDSCsDWz5rS881NXXcuxJYb5RP=HLEmdQaYiKrjqyvhO223A@mail.gmail.com>
Subject: Re: [PATCH 0/4] Follow-up patches for uvc v4l2-compliance
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tfiga@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James


>Pixel Format      : 'MJPG' (Motion-JPEG)
>Field             : None
>Bytes per Line    : 0
>Size Image        : 614400
>Colorspace        : Default

>ioctl(3, VIDIOC_G_FMT, {type=0 /* V4L2_BUF_TYPE_??? */}) = -1 EINVAL
>(Invalid argument)
>ioctl(3, VIDIOC_G_FMT, {type=V4L2_BUF_TYPE_VIDEO_CAPTURE,
>fmt.pix={width=640, height=480, pixelformat=v4l2_fourcc('M', 'J', 'P',
>'G') /* V4L2_PIX_FMT_MJPEG */, field=V4L2_FIELD_NONE, bytesperline=0,
>sizeimage=614400, colorspace=V4L2_COLORSPACE_DEFAULT}}) = 0
>write(1, "\t\t\33[1;31mfail\33[0m: v4l2-test-for"..., 59 fail:
>v4l2-test-formats.cpp(358): !colorspace
>) = 59

Thanks for testing it out. In this case I believe that it is a camera
bug. The error is due to the fact that the colorspace is does not have
a valid value. That value is provided by the camera:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/usb/uvc/uvc_driver.c#n766

You might have to send a patch with a quirk for your device.
