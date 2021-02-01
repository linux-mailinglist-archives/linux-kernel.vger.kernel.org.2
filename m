Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9755309FFC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 02:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhBAB13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 20:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhBAB1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 20:27:25 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359BFC061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 17:26:45 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id 43so5358219uag.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 17:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5c2tURYavXYb2cHWVqhvkd3VGt9RfM76mrzI5iA7YY=;
        b=jQrle0h17kSq8qRcsj70o6mRcY9EIJWuruFlHiCB2rvsdCPZ2oNhbmUWBGP0I9R6Qs
         EJqlq3LglsZXzKwjO92FZ4UGAGJ4HoTFiuotk0XZVTOU2okugZ7JqEMep2RPBU/G8I7L
         Qtw85zjwSQklNVFNvjMa3AVYL4792PWUdwRJtm+AJqZC7KVtUY9SUB0ltn3AUUH3by9D
         wLqYq3z3SIM+TDaRfvfDUbz3D70/koA89mO9r3kRv/90ins8HW32q6Qhj1A1FZJq+syh
         X4HQQL9bVdCNTB4Wk0wapZlx8rACijt1njlRf+/TSvq4MLJMUxo4SZCMaRtQt7k70TlL
         g06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5c2tURYavXYb2cHWVqhvkd3VGt9RfM76mrzI5iA7YY=;
        b=Pr1SFkahi/R4pmCQnwSj9QTqQ6hBf3B6/mTR+Kcats2umkUke6suynGBfnFYHMiybs
         UU5RzYN1RfMRqZe1FUX8empqxwfjKTP5Wpld/i/U84gIYHEVkVJ9WE6+EP0YGI4LtlCy
         P5tfdKpuk/2bZoSri1zNc93Sw2Mih2glmS7rh4DNGcOF1RbpXnVZRYi8a8WM8SplHOfB
         2A5Yrj9Dno9NCa2mrkeaX1kZeJhhZtU52FhYespNpcU9Hyve99KtBQLr70NWsbDOH2IW
         fwfq1sgCaYZy/4TXK7e6BbgjyP3vuofwm1OQIb25goDH5937+r5+O2X7oJk4a2aF+PyN
         9sTQ==
X-Gm-Message-State: AOAM5310DOQovjUhvUtJTolMn4jhZraU9RpsJh7i3rf+R1ztrbwT/pDz
        NVhs67ALwHdVt9gGvhzaWCQHlRj2CYW1QhR+sVY=
X-Google-Smtp-Source: ABdhPJxjYd0W813Ldzx5zfamsAbHV5huHv2FJQ4XrABVFbh8am3NUiXBIp4QMO1f38p5QjyIO3sTw3A4h/f/1FLXlME=
X-Received: by 2002:ab0:61c2:: with SMTP id m2mr8314070uan.45.1612142804294;
 Sun, 31 Jan 2021 17:26:44 -0800 (PST)
MIME-Version: 1.0
References: <20210131205654.3379661-1-saravanak@google.com>
In-Reply-To: <20210131205654.3379661-1-saravanak@google.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 31 Jan 2021 22:26:33 -0300
Message-ID: <CAOMZO5AZgk0N8sN9=bGcWTcnju75TPVxQX3FbLpF=n-=JA-7-w@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: imx: avic: Convert to using IRQCHIP_DECLARE
To:     Saravana Kannan <saravanak@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Kaiser <martin@kaiser.cx>, kernel-team@android.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Sun, Jan 31, 2021 at 5:56 PM Saravana Kannan <saravanak@google.com> wrote:

> +static int __init imx_avic_init(struct device_node *node,
> +                              struct device_node *parent)
> +{
> +       void __iomem *avic_base;
> +
> +       avic_base = of_iomap(node, 0);
> +       BUG_ON(!avic_base);
> +       mxc_init_irq(avic_base);
> +       return 0;
> +}
> +
> +IRQCHIP_DECLARE(imx_avic, "fsl,imx31-avic", imx_avic_init);

Shouldn't the compatible be "fsl,avic" instead?
