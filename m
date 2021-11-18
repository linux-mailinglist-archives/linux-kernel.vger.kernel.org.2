Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84FB455185
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 01:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241828AbhKRAO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 19:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241818AbhKRAOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 19:14:48 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743B0C061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 16:11:49 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id k22so5587378iol.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 16:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQmfsxDLxgEs9nX9rSOSZBMe+yfw/Mx6HQKSmuKCC3g=;
        b=Kb4PcktbaPyqHZ2UQU1v+/ez0LRcLtjC2X24LD92/dndf9/61zXTJbtySx8bxMrfOr
         QEfS1D+TV8oOQvh1TYtPrsaYsZ9KleEl/UOfci3IoO4IBwoi9jbigV8L2Q6iVKRsuxZk
         7DXPA61QQTPLY2JG9ESVsQRExfu9E6FZac4VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQmfsxDLxgEs9nX9rSOSZBMe+yfw/Mx6HQKSmuKCC3g=;
        b=ulrFYxbjmzQDVBWXfpmh+vBsXiE8KsflN2oOfeuk3gCzDgkH4+CLMPVuWhUd1Jng4o
         8kqBaNbtWkjeV4niutlSHUiC3h25KUwUkifjF+QG2tLtXcvfSGULOkP5GKaTt0QCJe0h
         6oAas+/ZEgAch7QZH15BjHdDOAjxWuLCv+/wQqwi1O7e8T7biyOhq/ZuxB1eUJ2zDCE8
         ON3+T/j7yZMh1/tOLeKyEtTkk24mf9eHjNWSIUj7PZeI0ZmgF4H+r3QQ8Ms8RIi8/oqV
         WX0KodUyD09ZQwi+EA90hPj7AD7ggCTzDjos8ViJIt2vou/g/SP0L4/WpcGhSEINR4Qa
         TAVg==
X-Gm-Message-State: AOAM532A07JNCDP4JjVhz0W8JCR8EzmW5DFeaETJmkuFQLBPD99tBtv3
        OCFoLkXrsBT1PRp+tSZ+/QtVlTPrir4ucw==
X-Google-Smtp-Source: ABdhPJwU/2ezhnHC7ocCdjdM2n4ec1lR84ob7fHJ0ophH2jXp40v8af6qPmg5ZIuBDZ9Xk149IQDVA==
X-Received: by 2002:a05:6602:13c9:: with SMTP id o9mr11701226iov.40.1637194308653;
        Wed, 17 Nov 2021 16:11:48 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id y7sm845380iov.22.2021.11.17.16.11.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 16:11:47 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id w22so5694341ioa.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 16:11:47 -0800 (PST)
X-Received: by 2002:a6b:440f:: with SMTP id r15mr14131151ioa.128.1637194307041;
 Wed, 17 Nov 2021 16:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20211116200739.924401-1-mka@chromium.org> <20211116120642.v17.1.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
In-Reply-To: <20211116120642.v17.1.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 Nov 2021 16:11:34 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VnRQzvgjVzTNgx5kaC6VDvFGvTx2njtdTo27LW1zxWJA@mail.gmail.com>
Message-ID: <CAD=FV=VnRQzvgjVzTNgx5kaC6VDvFGvTx2njtdTo27LW1zxWJA@mail.gmail.com>
Subject: Re: [PATCH v17 1/7] usb: misc: Add onboard_usb_hub driver
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 16, 2021 at 12:07 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -284,3 +284,20 @@ config BRCM_USB_PINMAP
>           This option enables support for remapping some USB external
>           signals, which are typically on dedicated pins on the chip,
>           to any gpio.
> +
> +config USB_ONBOARD_HUB
> +       tristate "Onboard USB hub support"

Aren't you back to shenanigans now that you're being called straight
from the USB core? What if you're a module and the USB core is
builtin? It can't call you, right? ...or what if you're builtin but
the USB core is a module (yeah, I know that sounds insane but I don't
think anything technically prevents it)?

Can you just add a dependency here such that if the USB core is a
module that you're a module and if the USB core is builtin that you're
builtin?


> +void onboard_hub_create_pdevs(struct usb_device *parent_hub, struct list_head *pdev_list)
> +{
> +       int i;
> +       struct device_node *np, *npc;
> +       struct platform_device *pdev;
> +       struct pdev_list_entry *pdle;
> +
> +       INIT_LIST_HEAD(pdev_list);
> +
> +       for (i = 1; i <= parent_hub->maxchild; i++) {
> +               np = usb_of_get_device_node(parent_hub, i);
> +               if (!np)
> +                       continue;
> +
> +               if (!of_is_onboard_usb_hub(np))
> +                       goto node_put;
> +
> +               npc = of_parse_phandle(np, "companion-hub", 0);
> +               if (!npc)
> +                       goto create_pdev;
> +
> +               pdev = of_find_device_by_node(npc);
> +               of_node_put(npc);
> +
> +               if (pdev) {
> +                       /* the companion hub already has a platform device, nothing to do here */
> +                       put_device(&pdev->dev);
> +                       goto node_put;
> +               }
> +
> +create_pdev:

I don't really like this "goto". I'd rather just use an "if" test for
the few lines even if the indentation gets to be a bit much.

-Doug
