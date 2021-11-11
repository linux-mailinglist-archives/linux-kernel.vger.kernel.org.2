Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AB744DB80
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 19:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhKKSVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 13:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbhKKSVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 13:21:21 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0DCC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 10:18:32 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z21so27540047edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 10:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vnmxwn/tZeM/AHymk+3atT3H8KaElmrCo0Jws8wvOvA=;
        b=ExqD7I0dtPteyE+rPa5NxBrJ7mWXCX+6K1XnVBIyiRxmjTpjy34M1yZ+ZD7k7I4cX+
         3Kv4LeG1cljOnPaqMNOchb3VsUdPhPadvZlrLJGHAVa8957yvCXygvk5luW7ripmeG0w
         saAdMc0h1DFLV2cBJ8i/Fl5fk4kpkkHxCTZR1OKOw8g4WCD5qMzTPch2VzJpAGzFr59R
         qrK/I5pmFTyRZj7a6hJOqUUE9f6lKnLzx2Bd4fltBrKni+AHa1GQ2KJUJIEc0mVhPxP/
         hXcyFM7WSLBj+CNM73dVat6eZZy+SKKKNGCPfHMIn6EzLvj6PziP2kjslddOiS4hVcvD
         n5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnmxwn/tZeM/AHymk+3atT3H8KaElmrCo0Jws8wvOvA=;
        b=hc4peSgilouNFbuMSCfvVZfPZPrteSxJlXp/7CPZvCpRqS2tFEx4FA3CjYk19Y1dtj
         AO1x4u8fvEwuwxKA2Mwa9bLvEYkI46EqR5M/KY5+c6RXm+t5v1+B9i16XnEcxrbCMdgm
         aZWtF2aiyEPOFBiMVOTAkBvrLhb6huneAbwIkNThLBPcXnW3L3oZRBRmv6YtrPPUACYJ
         cE3De9+5I4di5IghsAEVYXD26iXosyWcmbRaOZc+Ie0ziGN9xD/H0/nob61tGwWrTnaN
         W0SLm6U0MtJ8E/+nELw4p3pPsGtXeDXnRWlM5kUCb34uur18WGT5ME/JGkFNCYW+8uWh
         t4/A==
X-Gm-Message-State: AOAM533LuogoVEvaygIyZyya1O/+sdQBewbTMNE7F2Z+2kur8pZy9qER
        rzd0duGVSqfcB9ljLAFfMeAdAcZCPBMvg4YAXelgKg==
X-Google-Smtp-Source: ABdhPJzba7bVic9RyDyOSTksjvjV62o5u0z5w36iz4HU98btIq1dlbOxkB93U98vp5KpeLHVHkfLQgWCDJugvMeQGGU=
X-Received: by 2002:a17:906:4d4a:: with SMTP id b10mr12055937ejv.89.1636654710614;
 Thu, 11 Nov 2021 10:18:30 -0800 (PST)
MIME-Version: 1.0
References: <20211102141535.28372-1-mark-pk.tsai@mediatek.com>
In-Reply-To: <20211102141535.28372-1-mark-pk.tsai@mediatek.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 11 Nov 2021 11:18:18 -0700
Message-ID: <CANLsYkyLgvMDx-CMLZPEdJ8rUuGX-=QgB++5fz_h_ordm_q1aA@mail.gmail.com>
Subject: Re: [PATCH v2] remoteproc: use %pe format string to print return
 error code
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        matthias.bgg@gmail.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, 2 Nov 2021 at 08:15, Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
>
> Use %pe format string to print return error code which
> make the error message easier to understand.
>
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 502b6604b757..2242da320368 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -575,8 +575,8 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
>                                            dma_get_mask(rproc->dev.parent));
>         if (ret) {
>                 dev_warn(dev,
> -                        "Failed to set DMA mask %llx. Trying to continue... %x\n",
> -                        dma_get_mask(rproc->dev.parent), ret);
> +                        "Failed to set DMA mask %llx. Trying to continue... (%pe)\n",
> +                        dma_get_mask(rproc->dev.parent), ERR_PTR(ret));

Macro ERR_PTR() is used to convert error codes to pointer type when
returning from a function - I fail to see how doing so in a dev_warn()
context can make the message easier to understand.  Can you provide an
example?

Thanks,
Mathieu

>         }
>
>         /* parse the vrings */
> --
> 2.18.0
>
