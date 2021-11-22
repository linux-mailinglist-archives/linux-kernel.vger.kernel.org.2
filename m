Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A00458880
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 04:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbhKVEAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 23:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238673AbhKVEAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 23:00:22 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A13CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 19:57:16 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f18so74499107lfv.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 19:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YPH+0EiaxzoumZ5BogpFk3ypvqyIvp8gCd3yQ5SMSQs=;
        b=je7U59HM902HnyDDvdrsniCHFenLkHrcZN6VCMpNpziBhBG/b8cf/91XvGLb4dL/Cy
         OjsK4ODk9USfQZBOTBtFBB0qWELL7iRtFYk33udnOjVSx/v9y6hLu6hGL4T2XwF+NOYz
         zA6wqKts1sYYjrtrmTruWJFcxKMtZJWGZW0Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YPH+0EiaxzoumZ5BogpFk3ypvqyIvp8gCd3yQ5SMSQs=;
        b=uV/LoWHpDHCgDIx17lZZxacBf/cFrbmcTBGRhHl49cUrQQ9RxxnT8apQDRqCKgvEKk
         i3C+cM8b8N3DoHqL8/d092CWqM9H5vD91I9p2TnbnYprr4nkr6ktOFCO4x4Z4Q8eugUv
         SNn324oKbBMNKL1/U2TveeNpdVTgkybNfU1fZElWgJxLfpncR6CgG3QtQQO7pIJpLWLA
         rzOx+m1gxaEiHZhzYcGOlt5IR5IXl7FjJTFCEvq02bA+ync4lhPhiWWpXKxoE6vZQDvM
         Q2a+2FrFSSkDH0f9rVJxcUIfqcIKChBeE1Ai2x7t1dmkx5qLcusJaYTXY6s0TJmz3JpK
         jyQw==
X-Gm-Message-State: AOAM532FctRYJ3a3agES4RrxbjXosNF0hX8acjemh2DM+f0WJxGjxNmR
        3F8iDW2dpkT+LyEfL8+Hw55wgmikZgyeIZU9oAT/YQ==
X-Google-Smtp-Source: ABdhPJzjZY+DcDHCyM4+GAs+uYCYy7Sv0RCNUU5ODlpGRz9jfKtWgMv8J2hf23GvVJ7rYzAPGd6ocKQULp3zp0K7pHk=
X-Received: by 2002:a05:6512:32c9:: with SMTP id f9mr51649260lfg.308.1637553434248;
 Sun, 21 Nov 2021 19:57:14 -0800 (PST)
MIME-Version: 1.0
References: <20211119074654.470729-1-wenst@chromium.org> <5d23258a954eb0076cacf89d6c88b5e6ef13695f.camel@ndufresne.ca>
In-Reply-To: <5d23258a954eb0076cacf89d6c88b5e6ef13695f.camel@ndufresne.ca>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 22 Nov 2021 11:57:03 +0800
Message-ID: <CAGXv+5Gf-gsB7JXnLiZF_R=0RdxXS7CDZaFftyZ+aESXLXy1Ew@mail.gmail.com>
Subject: Re: [PATCH] media: hantro: Hook up RK3399 JPEG encoder output
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2021 at 12:00 AM Nicolas Dufresne <nicolas@ndufresne.ca> wr=
ote:
>
> Le vendredi 19 novembre 2021 =C3=A0 15:46 +0800, Chen-Yu Tsai a =C3=A9cri=
t :
> > The JPEG encoder found in the Hantro H1 encoder block only produces a
> > raw entropy-encoded scan. The driver is responsible for building a JPEG
> > compliant bitstream and placing the entropy-encoded scan in it. Right
> > now the driver uses a bounce buffer for the hardware to output the raw
> > scan to.
> >
> > In commit e765dba11ec2 ("hantro: Move hantro_enc_buf_finish to JPEG
> > codec_ops.done"), the code that copies the raw scan from the bounce
> > buffer to the capture buffer was moved, but was only hooked up for the
> > Hantro H1 (then RK3288) variant. The RK3399 variant was broken,
> > producing a JPEG bitstream without the scan, and the capture buffer's
> > .bytesused field unset.
> >
> > Fix this by duplicating the code that is executed when the JPEG encoder
> > finishes encoding a frame. As the encoded length is read back from
> > hardware, and the variants having different register layouts, the
> > code is duplicated rather than shared.
> >
> > Fixes: e765dba11ec2 ("hantro: Move hantro_enc_buf_finish to JPEG codec_=
ops.done")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > This was developed on the downstream ChromeOS 5.10 kernel (with a hack
> > for .data_offset) and tested with ChromeOS's jpeg_encode_accelerator_un=
ittest
> > patched to accept non-JFIF JPEG streams (https://crrev.com/c/3291480).
> >
> > This was then forward-ported to mainline (name and filename changes) an=
d
> > compile tested only.
>
> Tested with GStreamer on top of 5.16-rc1 from media_stage.git. Not perfec=
t but
> at least the the output it valid. Test command was:
>
>   gst-launch-1.0 videotestsrc num-buffers=3D2 ! v4l2jpegenc ! filesink
> location=3Dtest.jpg
>
> Notice that I encode two frames, it seems like the draining flow is broke=
n in
> this driver. GStreamer will queue the frame and issue CMD_START immediate=
ly, the
> driver will skip the encode, leaving me with an empty file.

The hantro driver doesn't implement ENC_CMD, which IIRC is used for the
draining flow. I guess that's something to fix, since the mem2mem stateful
encoder spec seems to require it. Or does that spec not apply to the JPEG
encoders?

> Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Thanks!

ChenYu
