Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B881390803
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhEYRoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhEYRn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:43:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0B1C06138A
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:42:28 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso12980910pjq.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1LMzOQ6+6ac4DFrNM4H4DzBnGvXNX1b50v8NC4P1lBs=;
        b=BE/GG9Z/NXu7m9YM5e6u1l7oetX08lvY69gn3S4WObyiIprElhwMJFxRb/3w0rS0WP
         ILi/Q17Zws9RuwTT7b3Z0Pye+MhCu+QGrJKLlET2u9W0dHp4Fl4UgJFZ/nfsDdJe7CGm
         uL/MdbkeZpsHmyfXOAjFMK4Q5ci07WgjKGGXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1LMzOQ6+6ac4DFrNM4H4DzBnGvXNX1b50v8NC4P1lBs=;
        b=FCNOhLFTdYCkVpOiegAmxfRTPYOBXdyzV4YrSaHE7YzEN14zsmNF69N6+9StwIY/L+
         Rcp77IOzCLLALDASMHRlXIa1Rk4P6MUIfRx8gOXL/wD78hRH9nSkZyvGxoy3p9O3ea0B
         LQ/o/IGxWgVHk9pxwmn2lhn0klk5SxJnvzt22WBNSnpy3YdN3mTb0mV2G0w91Ssa4ASe
         YrrQUH1CrXXCrhu6Z0K6CjMjE+krtfW9msw5lFC60pfgvz2Xy69A2Q76KB2ImwDYhQqh
         eQATJwoIxGAnSyCyjgKXnpfH/kYg701dtJ4CC/9KFzAXUMo/8t5+yD/jg8sSA9B3c9WJ
         uuAw==
X-Gm-Message-State: AOAM533gAs0qSAcOezOtVBWBG58T8XTAmlxVxl9cCA5AiE+1OyUsQERQ
        ICjgYJXrQuoN361291mxEfwpdQ==
X-Google-Smtp-Source: ABdhPJyA1ui0ylTVhiYxdLOqLS28ZsWlyNXkebBUTtc2C+tO7Ah8y7HTYwy8rOi4Wsvea8p/lSZoGw==
X-Received: by 2002:a17:903:22cd:b029:f4:d923:89a9 with SMTP id y13-20020a17090322cdb02900f4d92389a9mr31750260plg.52.1621964548172;
        Tue, 25 May 2021 10:42:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:ab0:bbc9:a71:2916])
        by smtp.gmail.com with UTF8SMTPSA id s6sm2488105pjr.29.2021.05.25.10.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 10:42:27 -0700 (PDT)
Date:   Tue, 25 May 2021 10:42:25 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-usb@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Al Cooper <alcooperx@gmail.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v10 0/5] USB: misc: Add onboard_usb_hub driver
Message-ID: <YK03AVRfbRJUGd0X@google.com>
References: <20210511225223.550762-1-mka@chromium.org>
 <YKen70owPqdjy5+a@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YKen70owPqdjy5+a@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 02:30:39PM +0200, Greg Kroah-Hartman wrote:
> On Tue, May 11, 2021 at 03:52:18PM -0700, Matthias Kaehlcke wrote:
> > This series adds:
> > - the onboard_usb_hub_driver
> > - glue in the xhci-plat driver to create the onboard_usb_hub
> >   platform device if needed
> > - a device tree binding for the Realtek RTS5411 USB hub controller
> > - device tree changes that add RTS5411 entries for the QCA SC7180
> >   based boards trogdor and lazor
> > - a couple of stubs for platform device functions to avoid
> >   unresolved symbols with certain kernel configs
> > 
> > The main issue the driver addresses is that a USB hub needs to be
> > powered before it can be discovered. For discrete onboard hubs (an
> > example for such a hub is the Realtek RTS5411) this is often solved
> > by supplying the hub with an 'always-on' regulator, which is kind
> > of a hack. Some onboard hubs may require further initialization
> > steps, like changing the state of a GPIO or enabling a clock, which
> > requires even more hacks. This driver creates a platform device
> > representing the hub which performs the necessary initialization.
> > Currently it only supports switching on a single regulator, support
> > for multiple regulators or other actions can be added as needed.
> > Different initialization sequences can be supported based on the
> > compatible string.
> > 
> > Besides performing the initialization the driver can be configured
> > to power the hub off during system suspend. This can help to extend
> > battery life on battery powered devices which have no requirements
> > to keep the hub powered during suspend. The driver can also be
> > configured to leave the hub powered when a wakeup capable USB device
> > is connected when suspending, and power it off otherwise.
> 
> I get a build error when I apply this series to my tree:
> 
> drivers/usb/misc/onboard_usb_hub.c:273:6: error: redefinition of ‘of_is_onboard_usb_hub’
>   273 | bool of_is_onboard_usb_hub(const struct device_node *np)
>       |      ^~~~~~~~~~~~~~~~~~~~~
> In file included from drivers/usb/misc/onboard_usb_hub.c:21:
> ./include/linux/usb/onboard_hub.h:9:20: note: previous definition of ‘of_is_onboard_usb_hub’ with type ‘bool(const struct device_node *)’ {aka ‘_Bool(const struct device_node *)’}
>     9 | static inline bool of_is_onboard_usb_hub(const struct device_node *np)
>       |                    ^~~~~~~~~~~~~~~~~~~~~
> 
> Any thoughts?

That function keeps haunting me in different ways ...

I suspect this was a build with CONFIG_COMPILE_TEST=y. The driver is
compiled for such a config and has the actual implementation, however
the header defines the static inline unless CONFIG_USB_ONBOARD_HUB=y/m.

I realized earlier that the driver doesn't really need to include the
header, and planned to remove it in the next version, which might be
the most practical solution.
