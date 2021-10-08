Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5E9426E12
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243179AbhJHPul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243094AbhJHPuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:50:39 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D571C061755
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 08:48:44 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id w14so9863842qkf.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 08:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=l3PEMMPfXxjXjuD/So1WBTTo0/C4bwAxd2b6X1tJZs8=;
        b=hz44myI2e9hT99CcaOMwcPVlnQnJbFO3h/0o8xHijXj70TxjuCcD0tZhUCfCk+yqXz
         XwpMs5vk04TCBD7HIVSnK8kf3Oq8Lmo//xOzsYbLjIV3YvvJwK0a5EYvw7JnNvIsemUF
         yDUx2KPPhAHJ3l79xy2cohXDh3ykEIB4//OacdN6yUQgHVibPtocf3xiesR7r9zVkIpC
         G0DrmWqg+8xfpT8bFTI4MAurT4OTdlvhgjgmEwBmiDJ+Mw3vj7pkV0gHORF2lySeWuzp
         qSQmEAdEjCrR4XwB8MBDrKlKJz1OPqYArGJX4gtPSMnz/lzMutKV583HPAYyaYvlbRi6
         VSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=l3PEMMPfXxjXjuD/So1WBTTo0/C4bwAxd2b6X1tJZs8=;
        b=qpToCKKKaEzEt0vLzvNSwjPezg1kAUIcZDSadKC4mAcRw7UNUiSeC3vuaEjKpoPGmE
         2WNk+bJVSMzHjz38hgdjgCXQ224bWY+jcIGMT3s6e6fjo3ZsFONbxzzxCuktU00k4lx+
         hylpF6rsyCERqZGmH+KipXgxhZi3xKaOLVl1jHFpeXnBUgYpFjvnqb6oe31t58uOkaPW
         tf/J+8NWdfwKxHL+RxyKxZOIzcAJTw+kKqX5+68xxJ00qf+MdDfuD9zVXIxSYEedYhss
         RBjFm//jMe0qk9MBCiVdjBy3zXXVE6QFq62rd2nffamJcLO0ObEUzrIUiYgwN/xhyp9o
         3DLg==
X-Gm-Message-State: AOAM531CqUQ4WsQOu1RtpKAOOW63TA/qKhwsD3bMi9QisLoT1C/4Yb1V
        ZrKYEXNWY5obR3XPOWikImbiMA==
X-Google-Smtp-Source: ABdhPJzY04tEl4nAarIutljMkJuT3pDnLioval4mb3+ZBoihi3Uh3E7RjIRdP27pTSBVzuYrLOLRfA==
X-Received: by 2002:a05:620a:4548:: with SMTP id u8mr3616083qkp.253.1633708123733;
        Fri, 08 Oct 2021 08:48:43 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id y6sm2312972qkj.26.2021.10.08.08.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 08:48:43 -0700 (PDT)
Message-ID: <44b1a16754d9b44f98da5a02ae1b06bd7adcdcd3.camel@ndufresne.ca>
Subject: Re: [PATCH 1/2] media: rkvdec: Do not override sizeimage for output
 format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        stable@vger.kernel.org
Date:   Fri, 08 Oct 2021 11:48:42 -0400
In-Reply-To: <20211008100423.739462-2-wenst@chromium.org>
References: <20211008100423.739462-1-wenst@chromium.org>
         <20211008100423.739462-2-wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 08 octobre 2021 à 18:04 +0800, Chen-Yu Tsai a écrit :
> The rkvdec H.264 decoder currently overrides sizeimage for the output
> format. This causes issues when userspace requires and requests a larger
> buffer, but ends up with one of insufficient size.
> 
> Instead, only provide a default size if none was requested. This fixes
> the video_decode_accelerator_tests from Chromium failing on the first
> frame due to insufficient buffer space. It also aligns the behavior
> of the rkvdec driver with the Hantro and Cedrus drivers.
> 
> Fixes: cd33c830448b ("media: rkvdec: Add the rkvdec driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/staging/media/rkvdec/rkvdec-h264.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
> index 76e97cbe2512..951e19231da2 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> @@ -1015,8 +1015,9 @@ static int rkvdec_h264_adjust_fmt(struct rkvdec_ctx *ctx,
>  	struct v4l2_pix_format_mplane *fmt = &f->fmt.pix_mp;
>  
>  	fmt->num_planes = 1;
> -	fmt->plane_fmt[0].sizeimage = fmt->width * fmt->height *
> -				      RKVDEC_H264_MAX_DEPTH_IN_BYTES;
> +	if (!fmt->plane_fmt[0].sizeimage)
> +		fmt->plane_fmt[0].sizeimage = fmt->width * fmt->height *
> +					      RKVDEC_H264_MAX_DEPTH_IN_BYTES;

Note that the test is more strict then the spec, since this behaviour is within
spec. But in general, the application may have more information about the
incoming stream, the maximum encoded frame size would even be encoded in the
container (which is parsed in userspace). So I agree it will be more flexible to
accept userspace desired size. If that size is too small, userspace will fail at
filling it in the first place, and decoding won't be possible, that's all.

Perhaps we could make a recommendation in that sense in the spec ?

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

>  	return 0;
>  }
>  


