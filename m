Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA3F4550A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 23:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241329AbhKQWlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 17:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241260AbhKQWlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 17:41:05 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D762AC061766
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 14:38:06 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id w15so4449150ill.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 14:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUpr14WULbylEmtF7t956SPZXS+VuuZpnqfZu1X3c5o=;
        b=XovnTv5J+ql5NGvS2VHagQDr5MzDYW2wzrdNHzt+pM0O1uc9Y7m66mLBrS6Eb8XdFh
         ctOxYw0O6dU8eAZ2n3iXfnBjSLYy0SvSjcm7Iw61g4xawTQtMYZKquHcllOB8QPoeBgK
         Ax7TGJln9rVvc7kOqw9IsuP1KFBhKatULyfVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUpr14WULbylEmtF7t956SPZXS+VuuZpnqfZu1X3c5o=;
        b=xVeD4+ChO6Wh0Si0dC2ugYtG8uuWQy/0z/4RrvZXQu+LhVooP+vyC137biphXFEQ8/
         9k7Ih89v+E+mwuqxLvmZA6N2Pdyrktm7KDWjkBRdaB7fhC3+DOfBaedQ2tNj1FwaS0ol
         6yfOcEgYf1IpmSrc0MsHpsWGRqTrIQXJHXcf2RCo4qXuBix06NlOvTJJhv0RK/O61HZW
         vX67fnu4XbOlTH0r8mDKFSc5W1R92v7kDB3sLm5OcXexpAk33tQfAf1nGoRJRxXmMtGt
         8WvEoldEmvQQNndRNnsH4U90Von1GZHvYdsl7MbwTHws32WKQ4n1vuj+x1k32QhOoifk
         pUMQ==
X-Gm-Message-State: AOAM532fDRoVna+yahzsjsYrjBEzliok9DuWUWTjEqmdZv8nmwgQlHOc
        08y/zFUpvE8SDymPAK9WpQPMun4LQXKOGQ==
X-Google-Smtp-Source: ABdhPJwjPLgriD+JqnSHec4MFuI4jJOmbwQWb2A5gdPyCe/2sT83HQ8lVPfyQo5+w6+0ZFd5zUHtig==
X-Received: by 2002:a05:6e02:1886:: with SMTP id o6mr12924868ilu.13.1637188685827;
        Wed, 17 Nov 2021 14:38:05 -0800 (PST)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id d4sm687197ilq.76.2021.11.17.14.38.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 14:38:05 -0800 (PST)
Received: by mail-io1-f52.google.com with SMTP id m9so5484870iop.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 14:38:05 -0800 (PST)
X-Received: by 2002:a05:6602:8ce:: with SMTP id h14mr13375797ioz.177.1637188684807;
 Wed, 17 Nov 2021 14:38:04 -0800 (PST)
MIME-Version: 1.0
References: <20211117133110.2682631-1-vkoul@kernel.org> <20211117133110.2682631-3-vkoul@kernel.org>
In-Reply-To: <20211117133110.2682631-3-vkoul@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 Nov 2021 14:37:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U8Ac0MY9yG7qdqunX4C592_Zrc_Lh-tf-OAVKDi0YOKw@mail.gmail.com>
Message-ID: <CAD=FV=U8Ac0MY9yG7qdqunX4C592_Zrc_Lh-tf-OAVKDi0YOKw@mail.gmail.com>
Subject: Re: [PATCH 3/3] spi: qcom: geni: handle timeout for gpi mode
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 17, 2021 at 5:31 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> We missed adding handle_err for gpi mode, so add a new function
> spi_geni_handle_err() which would call handle_fifo_timeout() or newly
> added handle_gpi_timeout() based on mode
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)

Fixes: b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
Reported-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>


> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index b9769de1f5f0..5b6e9a6643d8 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -164,6 +164,30 @@ static void handle_fifo_timeout(struct spi_master *spi,
>         }
>  }
>
> +static void handle_gpi_timeout(struct spi_master *spi, struct spi_message *msg)
> +{
> +       struct spi_geni_master *mas = spi_master_get_devdata(spi);
> +
> +       dmaengine_terminate_sync(mas->tx);
> +       dmaengine_terminate_sync(mas->rx);
> +}
> +
> +static void spi_geni_handle_err(struct spi_master *spi, struct spi_message *msg)
> +{
> +       struct spi_geni_master *mas = spi_master_get_devdata(spi);
> +
> +       switch (mas->cur_xfer_mode) {
> +       case GENI_SE_FIFO:
> +               handle_fifo_timeout(spi, msg);
> +               break;
> +       case GENI_GPI_DMA:
> +               handle_gpi_timeout(spi, msg);

Slight nit that maybe you should call it handle_gpi_err() instead of
handle_gpi_timeout(). As I understand it this function will get called
for _all_ errors, including errors reported by
spi_gsi_callback_result(). So basically if you have residue then
you'll immediately finalize the transfer with -EIO in the status and
then spi_geni_handle_err() will get called. It seems a little strange
that it then goes and calls a function whose name makes it sound as if
it's only called for "timeout". (For the FIFO case we actually only
hit this for timeouts since we don't currently terminate transfers
early for errors, so the FIFO name is actually OK).

-Doug
