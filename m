Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9E431103C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbhBERCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:02:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:47880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233693AbhBERAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 12:00:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74E7464F19;
        Fri,  5 Feb 2021 18:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612550521;
        bh=Och95jZSPmS5JZOu3rWCNdzFapqEaxA4bX7uCQJwQso=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IX2kVxDXqUuV7iowgJJWwlByQAXihwSnK8hf2TkQT1LjJOn+hvItadXV2bJyoRau7
         HOKkWGUOj+U72dTLpf3ngoAqJxxjr7HVVQLOZ3JeSerI0czD9EOtEjff0dN5pwjAzL
         lHXtfzrHcLi0OEG13gFG+8vkS1XZn7EwSFmEV6Q4u24sKbaLeKU3RydjLgcxSyVqH9
         o8/POigpER9rYtSUxohfdtok+MTincfAKZNBVtrzVs0qURvp6KhO+I3fVBFRCsQ/aP
         QPOOkbBMHxXEPzJyBa4FDHBlm1WDl8DvdHUM+I5p77ZkVSZ+QkDIpX6sWoKuZFbqjt
         APStkyUYfhrCw==
Received: by mail-ed1-f43.google.com with SMTP id l12so10002193edt.3;
        Fri, 05 Feb 2021 10:42:01 -0800 (PST)
X-Gm-Message-State: AOAM530innO9ERQUQ/am41MEWx4Qu/qorp7E0r2caH9R81WGpvfQEKWP
        sUFaZeUzEZeJ6a1MuJHoNZCVWgMDku+W4FuPKg==
X-Google-Smtp-Source: ABdhPJwnoYzJJaU11tmANzpBNOiB4Jrz6Z0M34lW0MRbvQXE//h7k1Ng7TT1yLPvbcgMbS512EbgqHcxVP6l+HwWAJM=
X-Received: by 2002:aa7:c895:: with SMTP id p21mr4907518eds.165.1612550519893;
 Fri, 05 Feb 2021 10:41:59 -0800 (PST)
MIME-Version: 1.0
References: <20210205114011.10381-1-jbx6244@gmail.com> <20210205114011.10381-6-jbx6244@gmail.com>
In-Reply-To: <20210205114011.10381-6-jbx6244@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 5 Feb 2021 12:41:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJwNdUfoYM8SZmOgMG9iAyZkJ4-kzjjiDDm_mdmghTEOA@mail.gmail.com>
Message-ID: <CAL_JsqJwNdUfoYM8SZmOgMG9iAyZkJ4-kzjjiDDm_mdmghTEOA@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] usb: dwc3: of-simple: add compatible for rk3328
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     "heiko@sntech.de" <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 5:40 AM Johan Jonker <jbx6244@gmail.com> wrote:
>
> From: Cameron Nemo <cnemo@tutanota.com>
>
> Add a compatible to be hooked into by the Rockchip rk3328 device tree.
>
> The rk3399 compatible cannot be reused because the rk3328 SoCs may
> require a specialized driver in the future and old device trees must
> remain compatible with newer kernels.

Yes that's important, but...

> Signed-off-by: Cameron Nemo <cnemo@tutanota.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  drivers/usb/dwc3/dwc3-of-simple.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
> index e62ecd22b..93bc34328 100644
> --- a/drivers/usb/dwc3/dwc3-of-simple.c
> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> @@ -171,6 +171,7 @@ static const struct dev_pm_ops dwc3_of_simple_dev_pm_ops = {
>  };
>
>  static const struct of_device_id of_dwc3_simple_match[] = {
> +       { .compatible = "rockchip,rk3328-dwc3" },

Why does this driver need it? In fact, you don't want this driver to
bind to the dwc3 node as we're binding to the 'snps,dwc3' driver.

>         { .compatible = "rockchip,rk3399-dwc3" },

Given the above, you might think we should remove this, but we can't
since there are old dtb's with the dwc3 child node.

Presumably you are getting lucky here (with link order). The kernel
has no logic to decide which driver to bind to if there are 2 matching
drivers. If we did, it would probably be the opposite of what you want
here as we'd pick the most specific match. This driver should probably
bail probe if no dwc3 child node.

Rob
