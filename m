Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327F43FCD97
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 21:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbhHaTMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 15:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240212AbhHaTMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 15:12:39 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D5BC061764
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 12:11:44 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id r13so120561pff.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 12:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZeXlIpviTzn5ex9dkffQ1j3818rQ1ctd2HbBkClIb6k=;
        b=q2errspj+rUwbMG3M4gEBlmMaQ4UI6DwAr4wXRkbNHSXUbDaLDNp85bw2JUGTw73JN
         bZu2zPml28k1pFsdzFv9ZpLc3QQqc7b8/QjKOmbann965/3inH12U0UprgAdmHLYakxk
         0u5uwnTobJpRh9mslGMW7169VY3XwbESfIhh+DjOLhWC+uCX+jkW+fT5aBuYwXbuMlcU
         YDf64UcaOmr5jzQwdtSsYtyhwh5etMWVM/fvQc8rzAmlNnW6Bqtq6gemNaJEIa0mrvc4
         kCCoT+/Uakm0v4R2vxil07KlXvLFjRMfJw0kxHcW5HJl2yYZI3ybSGemYo6WHe7S6mzk
         Mn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZeXlIpviTzn5ex9dkffQ1j3818rQ1ctd2HbBkClIb6k=;
        b=IwsVhNNHKmRhducTJKaAfTT6MwNIFmpRhx0fgmipUBBfOaPO97y+UsRJteTa11yHV4
         1OguIRrS6GLgoVlfAz9PFgYpBa0U1byA7E85Fw9Ez7n0xgvsf2bJ77F+vDKlFfhYPm8i
         40p0TVv7fGt/3bjnfrNyANujyJ80VTKaQcwHesmh+o5Ej1/piOWchf2EO1k34A00zSn0
         OF5By4JG0VxUqVi/dVio1OPhx6nDJzWQ2OBYUATWOMn/X02bR2GQ+H83hHnMR1GYp4iO
         Etda0pEZudLygB0CE7+WFZ0ovwjafduAReTdiHonckUZetrgLMg2HG9RGHIljGzVO607
         oo6w==
X-Gm-Message-State: AOAM530WVxTNvO03jrr263TDl0prS7efz48ALd0kQQTd3f5MCjinE8Ki
        kLUC9l3S77wVPUC8QLmlmRAY547SxvCxqJYs8b42yw==
X-Google-Smtp-Source: ABdhPJx42wOD1ke2NsPZdxHBJWqBaSeUsMlqEovH1j3bO/yBfYt79Ud7ZMMJ2OUK+3gXgh78iKg1PRcE9fm4pgcmT9U=
X-Received: by 2002:a62:8287:0:b0:3ec:f6dc:9672 with SMTP id
 w129-20020a628287000000b003ecf6dc9672mr29649670pfd.65.1630437103517; Tue, 31
 Aug 2021 12:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210818194105.1400766-1-trix@redhat.com>
In-Reply-To: <20210818194105.1400766-1-trix@redhat.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 31 Aug 2021 21:11:32 +0200
Message-ID: <CAG3jFyu9QoXAsAxXx-YWhBCxk_jHOWKc10rL7o051Ehav+e4Kg@mail.gmail.com>
Subject: Re: [PATCH] media: camss: vfe: simplify vfe_get_wm_sizes()
To:     trix@redhat.com
Cc:     Todor Tomov <todor.too@gmail.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Tom,

Thanks for the patch!

On Wed, 18 Aug 2021 at 21:41, <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Static analysis reports this representative problem
> camss-vfe-4-1.c:333: The result of the left shift is undefined because
>   the left operand is negative
>   reg |= (height - 1) << 4;
> ~~~~~~~~~ ^
>
> The is a false positive.  height is set in vfe_get_wm_sizes() which
> has a switch statement without a default.
>
> Reviewing the switch, the cases contain redundant assignments.
> So simplify to assignments.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  .../media/platform/qcom/camss/camss-vfe-4-1.c | 20 ++++++-------------
>  .../media/platform/qcom/camss/camss-vfe-4-7.c | 10 +++-------
>  .../media/platform/qcom/camss/camss-vfe-4-8.c |  9 +++------
>  3 files changed, 12 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
> index 7b7c9a0aaab282..42047b11ba529e 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
> @@ -290,22 +290,14 @@ static void vfe_wm_frame_based(struct vfe_device *vfe, u8 wm, u8 enable)
>  static void vfe_get_wm_sizes(struct v4l2_pix_format_mplane *pix, u8 plane,
>                              u16 *width, u16 *height, u16 *bytesperline)
>  {
> -       switch (pix->pixelformat) {
> -       case V4L2_PIX_FMT_NV12:
> -       case V4L2_PIX_FMT_NV21:
> -               *width = pix->width;
> -               *height = pix->height;
> -               *bytesperline = pix->plane_fmt[0].bytesperline;
> +       *width = pix->width;
> +       *height = pix->height;
> +       *bytesperline = pix->plane_fmt[0].bytesperline;
> +
> +       if (pix->pixelformat == V4L2_PIX_FMT_NV12 ||
> +           pix->pixelformat == V4L2_PIX_FMT_NV21)
>                 if (plane == 1)
>                         *height /= 2;
> -               break;
> -       case V4L2_PIX_FMT_NV16:
> -       case V4L2_PIX_FMT_NV61:
> -               *width = pix->width;
> -               *height = pix->height;
> -               *bytesperline = pix->plane_fmt[0].bytesperline;
> -               break;
> -       }
>  }
>
>  static void vfe_wm_line_based(struct vfe_device *vfe, u32 wm,
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
> index 2836b12ec98915..ab2d57bdf5e71c 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
> @@ -370,30 +370,26 @@ static int vfe_word_per_line_by_bytes(u32 bytes_per_line)
>  static void vfe_get_wm_sizes(struct v4l2_pix_format_mplane *pix, u8 plane,
>                              u16 *width, u16 *height, u16 *bytesperline)
>  {
> +       *width = pix->width;
> +       *height = pix->height;
> +
>         switch (pix->pixelformat) {
>         case V4L2_PIX_FMT_NV12:
>         case V4L2_PIX_FMT_NV21:
> -               *width = pix->width;
> -               *height = pix->height;
>                 *bytesperline = pix->plane_fmt[0].bytesperline;
>                 if (plane == 1)
>                         *height /= 2;
>                 break;
>         case V4L2_PIX_FMT_NV16:
>         case V4L2_PIX_FMT_NV61:
> -               *width = pix->width;
> -               *height = pix->height;
>                 *bytesperline = pix->plane_fmt[0].bytesperline;
>                 break;
>         case V4L2_PIX_FMT_YUYV:
>         case V4L2_PIX_FMT_YVYU:
>         case V4L2_PIX_FMT_VYUY:
>         case V4L2_PIX_FMT_UYVY:
> -               *width = pix->width;
> -               *height = pix->height;
>                 *bytesperline = pix->plane_fmt[plane].bytesperline;
>                 break;
> -
>         }
>  }
>
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
> index 19519234f727c1..7e6b62c930ac8a 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe-4-8.c
> @@ -343,27 +343,24 @@ static int vfe_word_per_line_by_bytes(u32 bytes_per_line)
>  static void vfe_get_wm_sizes(struct v4l2_pix_format_mplane *pix, u8 plane,
>                              u16 *width, u16 *height, u16 *bytesperline)
>  {
> +       *width = pix->width;
> +       *height = pix->height;
> +
>         switch (pix->pixelformat) {
>         case V4L2_PIX_FMT_NV12:
>         case V4L2_PIX_FMT_NV21:
> -               *width = pix->width;
> -               *height = pix->height;
>                 *bytesperline = pix->plane_fmt[0].bytesperline;
>                 if (plane == 1)
>                         *height /= 2;
>                 break;
>         case V4L2_PIX_FMT_NV16:
>         case V4L2_PIX_FMT_NV61:
> -               *width = pix->width;
> -               *height = pix->height;
>                 *bytesperline = pix->plane_fmt[0].bytesperline;
>                 break;
>         case V4L2_PIX_FMT_YUYV:
>         case V4L2_PIX_FMT_YVYU:
>         case V4L2_PIX_FMT_VYUY:
>         case V4L2_PIX_FMT_UYVY:
> -               *width = pix->width;
> -               *height = pix->height;
>                 *bytesperline = pix->plane_fmt[plane].bytesperline;
>                 break;
>         }

Reviewed-by: Robert Foss <robert.foss@linaro.org>
