Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3061F34F89D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 08:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhCaGUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 02:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhCaGTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 02:19:31 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC002C061574;
        Tue, 30 Mar 2021 23:19:30 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id g15so18350231qkl.4;
        Tue, 30 Mar 2021 23:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPdGHSIIR00sAQIYSjMd9oGwW07NfsHMGXGmByQwlRc=;
        b=Txxvq0eBKd/H8YcrQndy9HA0UYExIhy7stpzgsx2OR1DU9qzBRteahNQ6iB8WFDuO9
         61A7Pkcx7uxMi2lkQ/geULAAjdBwSVtXhqUygskJUlAQBzyONk8yTa4CxJRcsIe8/yIO
         cNAKlsNEwMIWQLTHfVcuqOAPqqeod1JEb+pO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPdGHSIIR00sAQIYSjMd9oGwW07NfsHMGXGmByQwlRc=;
        b=iWf7cDnoEKL8KG4V3k9sOet5JQAPGjlBq8fjsGDb/c6RGRHRjul0zsIfPXsVoS7ljg
         lFWdw5iceJuSSYtge5WX4Fs5Z2xhjj2NVKkx51xUH3gNPatpR65ijAu9zfF3vgMsOSC3
         dVhTeo10Pv/mOVcpKOW21uD3qpxFUv6PzunmsOd64UzZ8GBQrRhLwbC+fH6q4lYQGe1Q
         t9tf9UBwTIeceUfmwREkECpwcnOqkqy7qra9mRi+K9OFmeNJKRZUo/15J5Qq3J9u6Kav
         4xSbo+E2wiOzX7pGgibqs8eD6WTJXmvGu09bz0XvGI6Xf4GpuTlMO58Kjs6sMMRYaVIb
         adRw==
X-Gm-Message-State: AOAM5335fR8qwg7qQ4eM/WB81uauCCBPl0dBDtYGnC33LpSCQeSVu0cM
        iFmaXc0a5TGc8KRWdeNG/Nu2+wzF8Uanw4T120A=
X-Google-Smtp-Source: ABdhPJxTiz+BKd7Wa3J6NU0WsFjpgzR2F7xmXCD+R0O9qnYbgAxLwDKhEJJRSGfkjpBgQZkMqkTSQjLXyEFkS5Hs9+M=
X-Received: by 2002:a05:620a:c11:: with SMTP id l17mr1705538qki.487.1617171569936;
 Tue, 30 Mar 2021 23:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210331045831.28700-1-rentao.bupt@gmail.com>
In-Reply-To: <20210331045831.28700-1-rentao.bupt@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 31 Mar 2021 06:19:17 +0000
Message-ID: <CACPK8XdfgMg=n9gBaMe+8z3aV4ifAJ3rZP7oL6ME1wem70FQTQ@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: aspeed: fix dma map failure
To:     Tao Ren <rentao.bupt@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-usb@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 at 05:02, <rentao.bupt@gmail.com> wrote:
>
> From: Tao Ren <rentao.bupt@gmail.com>
>
> Currently the virtual port_dev device is passed to DMA API, and this is
> wrong because the device passed to DMA API calls must be the actual
> hardware device performing the DMA.
>
> The patch replaces usb_gadget_map_request/usb_gadget_unmap_request APIs
> with usb_gadget_map_request_by_dev/usb_gadget_unmap_request_by_dev APIs
> so the DMA capable platform device can be passed to the DMA APIs.
>
> The patch fixes below backtrace detected on Facebook AST2500 OpenBMC
> platforms:
>
> [<80106550>] show_stack+0x20/0x24
> [<80106868>] dump_stack+0x28/0x30
> [<80823540>] __warn+0xfc/0x110
> [<8011ac30>] warn_slowpath_fmt+0xb0/0xc0
> [<8011ad44>] dma_map_page_attrs+0x24c/0x314
> [<8016a27c>] usb_gadget_map_request_by_dev+0x100/0x1e4
> [<805cedd8>] usb_gadget_map_request+0x1c/0x20
> [<805cefbc>] ast_vhub_epn_queue+0xa0/0x1d8
> [<7f02f710>] usb_ep_queue+0x48/0xc4
> [<805cd3e8>] ecm_do_notify+0xf8/0x248
> [<7f145920>] ecm_set_alt+0xc8/0x1d0
> [<7f145c34>] composite_setup+0x680/0x1d30
> [<7f00deb8>] ast_vhub_ep0_handle_setup+0xa4/0x1bc
> [<7f02ee94>] ast_vhub_dev_irq+0x58/0x84
> [<7f0309e0>] ast_vhub_irq+0xb0/0x1c8
> [<7f02e118>] __handle_irq_event_percpu+0x50/0x19c
> [<8015e5bc>] handle_irq_event_percpu+0x38/0x8c
> [<8015e758>] handle_irq_event+0x38/0x4c
>
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>

Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")
Reviewed-by: Joel Stanley <joel@jms.id.au>

Thanks Tao!

> ---
>  drivers/usb/gadget/udc/aspeed-vhub/core.c | 3 ++-
>  drivers/usb/gadget/udc/aspeed-vhub/epn.c  | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> index be7bb64e3594..d11d3d14313f 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> @@ -36,6 +36,7 @@ void ast_vhub_done(struct ast_vhub_ep *ep, struct ast_vhub_req *req,
>                    int status)
>  {
>         bool internal = req->internal;
> +       struct ast_vhub *vhub = ep->vhub;
>
>         EPVDBG(ep, "completing request @%p, status %d\n", req, status);
>
> @@ -46,7 +47,7 @@ void ast_vhub_done(struct ast_vhub_ep *ep, struct ast_vhub_req *req,
>
>         if (req->req.dma) {
>                 if (!WARN_ON(!ep->dev))
> -                       usb_gadget_unmap_request(&ep->dev->gadget,
> +                       usb_gadget_unmap_request_by_dev(&vhub->pdev->dev,
>                                                  &req->req, ep->epn.is_in);
>                 req->req.dma = 0;
>         }
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> index 02d8bfae58fb..cb164c615e6f 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> @@ -376,7 +376,7 @@ static int ast_vhub_epn_queue(struct usb_ep* u_ep, struct usb_request *u_req,
>         if (ep->epn.desc_mode ||
>             ((((unsigned long)u_req->buf & 7) == 0) &&
>              (ep->epn.is_in || !(u_req->length & (u_ep->maxpacket - 1))))) {
> -               rc = usb_gadget_map_request(&ep->dev->gadget, u_req,
> +               rc = usb_gadget_map_request_by_dev(&vhub->pdev->dev, u_req,
>                                             ep->epn.is_in);
>                 if (rc) {
>                         dev_warn(&vhub->pdev->dev,
> --
> 2.17.1
>
