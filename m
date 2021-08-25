Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC473F7EE7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 01:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhHYXMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 19:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhHYXMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 19:12:15 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4123C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 16:11:28 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w6so505210plg.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 16:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=auQsiU026YRcUJDBrDCigbKQFMyBdgrRl4yQyRusVVE=;
        b=KsYDraaCmX1B7uNInfhFu+xYYZW0V2Gz972uL5UYRPpWaK5WAawbOGfWtd42arLjEY
         JpjHKQMIyUD72LoPfBoxBSL5ZwOG4UAebUC7GIlLE+GJbw9Nn17615fqWok1AV8s+UKa
         WyyEcIlgtbE1M0DSpXT7BY7BWrBqMg6HwcqlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=auQsiU026YRcUJDBrDCigbKQFMyBdgrRl4yQyRusVVE=;
        b=awacF7TXY4SF3z/bqPc0pQIhRLQfsOttDS8W9ywGBGYZmR0HBbZkNhVXg0r/swyHAW
         I8YyLHhgPknnapZuCkFvZCNNU0DIB7fCLIb0TKr6zHr8s86a5KLQbSIKOQr+49N6XHje
         925Vt77Ih+BOsRGMgyG4b3j6G74WYaEku4p+nbjIGesHntfO3aIwJXzYtzRJV6dxc58S
         wJUqRi76M3jNl2iawBrwseaMT26cGxhz+fMFGd6rD62pc7ykWTKhDkIzYeLmndVvjB4S
         G0m43zdu4Czqrakivk7zQKj+kPFLIg+dmGnD+5ZZ2B8Fy60my6gwLKERCG0EJq2fEis+
         uTRg==
X-Gm-Message-State: AOAM531v7PNlxqQDQUrl6YCA7ozq0ffAsd4Iwbzlb4GfGJbAV0tNkukv
        N9w5WWp0NJWU4mwiqZ8gN7CMFJIJ1ssOA46qzfugMQ==
X-Google-Smtp-Source: ABdhPJzNUEKVFIv6N8mYQAYQ3A0+DYTB+NOni0Zp//TmiXJA3uI7jGbvj5rAJzumaKzWnPD9VN5+tmK5NYMi16924hc=
X-Received: by 2002:a17:90a:8801:: with SMTP id s1mr755065pjn.166.1629933088041;
 Wed, 25 Aug 2021 16:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210825084434.32309-1-mansur@codeaurora.org>
In-Reply-To: <20210825084434.32309-1-mansur@codeaurora.org>
From:   Nathan Hebert <nhebert@chromium.org>
Date:   Wed, 25 Aug 2021 16:11:17 -0700
Message-ID: <CANHAJhE4h+WPL+uRCqZ=CdaqWr9SVuLtK9SXnP3PTkk-A0rZZQ@mail.gmail.com>
Subject: Re: [PATCH] venus: vdec: update output buffer size during vdec_s_fmt()
To:     Mansur Alisha Shaik <mansur@codeaurora.org>
Cc:     linux-media@vger.kernel.org, stanimir.varbanov@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, dikshita@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mansur,

I tested the patch on kernel 5.4 on an Acer Chromebook Spin 513 based
on the Qualcomm Snapdragon 7c platform.

VP8 test vectors [0] were able to be decoded and decoded picture MD5's
matched the vpxdec reference decoder. Prior to this patch, three files
failed to decode. I didn't see any regressions with VP9 Profile 0
(8-bit) test vectors [1] using the same decode and checksum test
methods.

[0] https://chromium.googlesource.com/webm/vp8-test-vectors
[1] https://www.webmproject.org/vp9/levels/#test-bitstreams

Tested-by: Nathan Hebert <nhebert@chromium.org>

Best regards,
Nathan Hebert

On Wed, Aug 25, 2021 at 1:44 AM Mansur Alisha Shaik
<mansur@codeaurora.org> wrote:
>
> Video driver maintains an internal context for the output buffer size.
> During S_fmt() on capture plane, the output buffer size is not updated
> in driver context. As a result, during buf_prepare(), the size of the
> vb2_plane and internal size of the buffer, as maintained by the driver,
> does not match. This leads to buf_prepare() failure.
> Update the instance context for the output buffer size during s_fmt().
>
> Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/vdec.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 198e47eb63f4..c129b061a325 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -332,8 +332,11 @@ static int vdec_s_fmt(struct file *file, void *fh, struct v4l2_format *f)
>
>         if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
>                 inst->fmt_out = fmt;
> -       else if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> +       else if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
>                 inst->fmt_cap = fmt;
> +               inst->output2_buf_size =
> +                       venus_helper_get_framesz(pixfmt_cap, orig_pixmp.width, orig_pixmp.height);
> +       }
>
>         return 0;
>  }
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
