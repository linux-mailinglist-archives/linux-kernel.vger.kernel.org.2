Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7323543D0A3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 20:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243526AbhJ0SZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 14:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243524AbhJ0SZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 14:25:19 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6405C061348
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:22:53 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id d15so3307322qkj.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9N5C8SGb7U5wdMZ58rdvN1GPz0ZxsaF/5pC41Q62sE=;
        b=FQVRt63dmGzxcOIe6TYyIX4Vu9tje2LGd9fxy8cyXIUBWKQwtlTDLHo7hmIBdrrDgI
         ETEQ2EZ34R5jo6WeXHhUcp0qigiPu3E8JkuaemsjFQyLD/RQS4u7bHF4Gwj+g3v2PuhP
         cFjBpa+zovyyDe1er6eRmuezXlUrm3uFS55+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9N5C8SGb7U5wdMZ58rdvN1GPz0ZxsaF/5pC41Q62sE=;
        b=L8pR8IGKXXbTjV8QRGNDtyx3UAhjqrhZoSYhtBGdKUcvSUBTDw4kHBpaQwwGb+OPq5
         BDxOUp+4QbT666bF4FoeoJwyi4id05IFwJYh6+JewBaBnwEXVusjbs0Z3TCSvCRLPdfE
         feTFLkSKBR8GFd1M19F6CUhrPioSRAF8X5AawZf5gJY/07u+cKONFetC3GYp0jN3z0Av
         9mY2ngERz66RVXNElqj10Vla0q0TaJW7IUb+aDWDXTKvWz5kY1mo8Gtc1exdTvlY1Fev
         HcVKxCXxFMoQ5MXAj43Eocb0hA+Y7P2glvJ8szL8oeiXU8x1g+bCJcTit93Fjf7hpG49
         vmdA==
X-Gm-Message-State: AOAM533YeXHT2JUwXtoeIGudiKlyE4akai/veHNeNYejsg4zbnzGZ2p0
        rbCcQaLtrZFtucU9xLS3DVG+nqtVksCHHA==
X-Google-Smtp-Source: ABdhPJyh1aWR1QRFwBGWIBl3xXcUFCCJnIt3/qh6Do2vewOVEBJ3srVFFaj6FGCcUM8zCJ0a22jU7g==
X-Received: by 2002:a37:9c0c:: with SMTP id f12mr3971188qke.347.1635358972574;
        Wed, 27 Oct 2021 11:22:52 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id m66sm428320qkb.87.2021.10.27.11.22.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 11:22:51 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id m63so8563444ybf.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:22:50 -0700 (PDT)
X-Received: by 2002:a25:c344:: with SMTP id t65mr35272097ybf.409.1635358970358;
 Wed, 27 Oct 2021 11:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211027080819.6675-1-johan@kernel.org> <20211027080819.6675-4-johan@kernel.org>
In-Reply-To: <20211027080819.6675-4-johan@kernel.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 27 Oct 2021 11:22:39 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMYbP3jQPeOpDDktHgp4X81AH41cgiLFgz-YHVPyZO1sw@mail.gmail.com>
Message-ID: <CA+ASDXMYbP3jQPeOpDDktHgp4X81AH41cgiLFgz-YHVPyZO1sw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mwifiex: fix division by zero in fw download path
To:     Johan Hovold <johan@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Amitkumar Karwar <akarwar@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 1:12 AM Johan Hovold <johan@kernel.org> wrote:
> --- a/drivers/net/wireless/marvell/mwifiex/usb.c
> +++ b/drivers/net/wireless/marvell/mwifiex/usb.c
> @@ -505,6 +505,22 @@ static int mwifiex_usb_probe(struct usb_interface *intf,
>                 }
>         }
>
> +       switch (card->usb_boot_state) {
> +       case USB8XXX_FW_DNLD:
> +               /* Reject broken descriptors. */
> +               if (!card->rx_cmd_ep || !card->tx_cmd_ep)
> +                       return -ENODEV;

^^ These two conditions are applicable to USB8XXX_FW_READY too, right?

> +               if (card->bulk_out_maxpktsize == 0)
> +                       return -ENODEV;
> +               break;
> +       case USB8XXX_FW_READY:
> +               /* Assume the driver can handle missing endpoints for now. */
> +               break;
> +       default:
> +               WARN_ON(1);
> +               return -ENODEV;
> +       }
> +

Anyway, looks pretty good, thanks:

Reviewed-by: Brian Norris <briannorris@chromium.org>
