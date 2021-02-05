Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5EE3111F2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhBES0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhBESZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 13:25:48 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB95EC06174A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 12:07:28 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id s11so2124838qtq.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 12:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqehshu3MUzrBle/QPxMj3NcYrs2O2w0CHnNjXFfUqU=;
        b=CaGJibvMjhSDKdOj6Tx5gGCiGEeZxTrLjUqGXdVJUt474AZwL5JTnIy7a82+nOThvI
         /Kd5dqOlXza4DW9UgKcG5PpQepH32TaAH/xBcQT2CaMhBpsbwgOaSrffKlzFWHYfsnq+
         pYN1Udbb+TjAT6mCvZ4jOh7XNqxBIa3GTKoM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqehshu3MUzrBle/QPxMj3NcYrs2O2w0CHnNjXFfUqU=;
        b=losuWWg9YIxCuTNIWdAZzKR6kuEO0uWAfZGPutIstRlBK2VEUeTrytrxRvm9gfU3kx
         MZvmK/5xjjbZiteGpagplPUs8QCWy7ej6yNb6JWnjxtHPa5UF2HjlzPyn42NH5aIEa2k
         12D3j0nlksZ9S7Z2HPbYsWWqxb9PUAefL/9MKs8SnuARnOQEthqaQI1LO5O33zD6BVd1
         xw4PliwowKICIAMos8mGjNg5NhQ3udZciXPTzWqsVKC+DNEb9r78L2HiFi4ByqK6vtEW
         Wt6a0lGUvEg2y5XPXCThT0/jIk6NeigGbfe/lxPpMtAPh9gEDTSnAWFSjEGuxDNNPT9+
         KBRw==
X-Gm-Message-State: AOAM530urVMOlCeiPRBS2A7X7+3Bjh/5j+7vSzA1LnS/q2cp9L6oI7F5
        Rn4rDCGJNn4tW2QUppym3U+gJZUQ7u4KWxA5xyuysQ==
X-Google-Smtp-Source: ABdhPJy+gFh8lAckUDFUvPvLh47rABL095luYOJcWMkV8WMeHxa2hYhoDFsGxakL9ix/Lp3h3FRFT7dzPvlX38QG6r8=
X-Received: by 2002:a05:622a:4ce:: with SMTP id q14mr6007256qtx.132.1612555648087;
 Fri, 05 Feb 2021 12:07:28 -0800 (PST)
MIME-Version: 1.0
References: <20210205195113.20277-1-rajmohan.mani@intel.com> <20210205195113.20277-2-rajmohan.mani@intel.com>
In-Reply-To: <20210205195113.20277-2-rajmohan.mani@intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 5 Feb 2021 12:07:16 -0800
Message-ID: <CACeCKadzdTGi3y_WbihX_p_rfL8wcTFVwbUGPU=de53fA9dVog@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_typec: Skip port partner
 check in configure_mux()
To:     Rajmohan Mani <rajmohan.mani@intel.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raj,

On Fri, Feb 5, 2021 at 11:52 AM Rajmohan Mani <rajmohan.mani@intel.com> wrote:
>
> For certain needs like updating the USB4 retimer firmware when no
> device are connected, the Type-C ports require mux configuration,
> to be able to communicate with the retimer. So removed the above
> check to allow for mux configuration of Type-C ports, to enable
> retimer communication.
>
> Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
Reviewed-by: Prashant Malani <pmalani@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index e724a5eaef1c..3d8ff3f8a514 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -536,9 +536,6 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>         enum typec_orientation orientation;
>         int ret;
>
> -       if (!port->partner)
> -               return 0;
> -
>         if (mux_flags & USB_PD_MUX_POLARITY_INVERTED)
>                 orientation = TYPEC_ORIENTATION_REVERSE;
>         else
> --
> 2.30.0
>
