Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E853CBB15
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 19:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhGPRZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 13:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhGPRZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 13:25:27 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BB6C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 10:22:32 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id hd33so16221400ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3c+sIMooxtvDJVn8odY5JLFWl/IcyMyFIVxI67a4xSE=;
        b=C/KEm8SY1qRUq8mfvLz7OVdGBiu3jZv76CDgZzY2pjAN2b4Wx2YLbSoRxo4KrQ5Ing
         oZLQNbWqO67GD4pM9c8sevTAv4rCOm8nYLVIMxZNr5pXR0ma9pIFlzYXMaXh6Drv4FG5
         H5a2NqUUia2w9A2+QMZ/tduTd4VTxtqYjqr66pTRe4Mxy26VP86vCKTDcbyt142T9DJ5
         RCoMmd7r1+su12GBNvh6fUs2U0H38lW+rzaVVRq/yrqNQ4Yx3cTygD8KvO1iiPhc655M
         7eD+aBBT3gaDqt/N0TCshI6/k3C3WIE4uRjhQtYg0liO5sY/sUFXER+PDXhBpsbBVSTq
         o4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3c+sIMooxtvDJVn8odY5JLFWl/IcyMyFIVxI67a4xSE=;
        b=SkFg6ErLQNkQ3yJ5Wzf/rKvmW3Lw8OxZpV/TMpQLj5w0Gd9UdRf8D9xLWeKsbco1Jz
         wykjmZDO9bjErsxlWHIT1v91Sqspbva0tdkwg0GEZmdYF+ae2IF9GobFZu0XKWMszWy6
         9vklIUolbcaCUvVmuBZOGFD3SgBfdMu/QSGX9UWHCOLT/SBPDQ0O2EzHuMEfE2mJwFwB
         QkbkDUjRmiNHBMlN9rL1F2hccLwtb1plrNYLB9TySEYqPmp2wR6GQQ06Y15ImMhp8THq
         HmxtKaD+LUucJVtMGcr44sp3NNzE9xnhuttYPf8QSo4UzoM2k7NaagRL7Pxd5pix2UcY
         Cp/Q==
X-Gm-Message-State: AOAM530F4TNExN1RkxTZhfhtB9XgJ4jzCGF1+F7naWI5L1pZijvKCEKu
        vDQSUvjjluHmwrX4hDsn0JC8/qxik5cJCioAIBwWxZIlrUM7qA==
X-Google-Smtp-Source: ABdhPJyLuAxVHnqK+wx3ejq+Fn8StY+eDIP0EU5IEIZdhxkZCMlzyXAdlFLhmjA8wtQaIy15/WQq4RqPdOpMXdZWDIU=
X-Received: by 2002:a17:906:3699:: with SMTP id a25mr12875173ejc.452.1626456150821;
 Fri, 16 Jul 2021 10:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210716101602.1891-1-laurentiu.tudor@nxp.com> <YPF40t5bhgTFM2wK@smile.fi.intel.com>
In-Reply-To: <YPF40t5bhgTFM2wK@smile.fi.intel.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Fri, 16 Jul 2021 19:21:53 +0200
Message-ID: <CABdtJHuKyybhJazpAc8KT54ELtZ319rdb6CbSH6zB5x3NhgtAw@mail.gmail.com>
Subject: Re: [PATCH] software node: balance refcount for managed sw nodes
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 2:17 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jul 16, 2021 at 01:16:02PM +0300, laurentiu.tudor@nxp.com wrote:
> > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >
> > software_node_notify(), on KOBJ_REMOVE drops the refcount twice on managed
> > software nodes, thus leading to underflow errors. Balance the refcount by
> > bumping it in the device_create_managed_software_node() function.
> >
> > The error [1] was encountered after adding a .shutdown() op to our
> > fsl-mc-bus driver.
>
> Looking into the history of adding ->shutdown() to dwc3 driver (it got reverted
> later on), I can tell that probably something is wrong in the ->shutdown()
> method itself.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Isn't the other alternative to just remove the second kobject_put from
KOBJ_REMOVE ?

@@ -1149,7 +1147,6 @@ int software_node_notify(struct device *dev,
unsigned long action)

                if (swnode->managed) {
                        set_secondary_fwnode(dev, NULL);
-                       kobject_put(&swnode->kobj);
                }
                break;
        default:

If we aren't being incremented in device_create_managed_software_node() then
should we be decremented here?

-Jon
