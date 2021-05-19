Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921F938999A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhESXIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhESXIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:08:42 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE990C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:07:20 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id i5so10556183pgm.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bNc/PWg94RceQRhCF+NWBGbuB6YRbrHAKURevypSwFM=;
        b=mSWFOwADaHEDlE4bh10NpqgWa6CTP9+Sm9dHQ6eoBbWGJHDdMViCN7coGdcVCtEMQE
         yC0L+DJ9wfdsZp5NBL8n/C7xdGyAf9raRZrWSyAhMMvnFfyjbmbsnQvaQpVuFKuZ7NiH
         oOIkeQEx0OPk7XKv9FAunwxgRWKkZ8fdnXAEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bNc/PWg94RceQRhCF+NWBGbuB6YRbrHAKURevypSwFM=;
        b=NmX6coE/N5268W5fx+vug9/KL0rBVhyTQjBhRSm7yF+xF19jwBEQ6d5A3MMvA3rZhW
         4gSmL4Yolofy7DlQq0WtQH1YZ39TQMNwEoKbNpoHiT3Yv2J1tgWDd/ddSm1MFEzUiTki
         D766WIYLYbpbPMoTnJIjkC159t15u1zV2XkQ8UW6oBlFDLU6uPCt3v4aNTWTMsUtBOMN
         jHy4g7zHxQNrl/hOsbcoLQG6ifSdbmF4ylm5Xh82XnTLNtQgndpVMQqzTUmu4z6vryNx
         MlUhZaIjUKiv3q5jXz/41FmLJMK+EySTX79msDKNsD8NBHWNOx3YIOHi/5L2gDc02N+h
         kE0Q==
X-Gm-Message-State: AOAM533odRyaGOtpKtCnVB3pcD2aIk9TNhWpMy46SlUuoOjFWNMffW7A
        Maa3R3MkM8H4Z+epR0Sy5l10Kw==
X-Google-Smtp-Source: ABdhPJzBEoDJyD7xAJElngJnr/KuQQSRJrUCEpy57acaWEpNQlcSaojYP4getzfGJYiB1eHj7IPsKg==
X-Received: by 2002:a63:4b18:: with SMTP id y24mr1493340pga.438.1621465640249;
        Wed, 19 May 2021 16:07:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:3d5d:d560:9fb4:d9d1])
        by smtp.gmail.com with UTF8SMTPSA id l15sm422658pjj.23.2021.05.19.16.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 16:07:19 -0700 (PDT)
Date:   Wed, 19 May 2021 16:07:17 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v10 2/5] USB: misc: Add onboard_usb_hub driver
Message-ID: <YKWaJdrpj1ixx9+v@google.com>
References: <20210511225223.550762-1-mka@chromium.org>
 <20210511155152.v10.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <YKPz7a68duMyXU5x@google.com>
 <20210518194511.GA1137841@rowland.harvard.edu>
 <YKQ0XxhIWaN37HMr@google.com>
 <20210519144356.GB1165692@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210519144356.GB1165692@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 10:43:56AM -0400, Alan Stern wrote:
> On Tue, May 18, 2021 at 02:40:47PM -0700, Matthias Kaehlcke wrote:
> > 
> > Could you also have a look at "[4/5] usb: host: xhci-plat:
> > Create platform device for onboard hubs in probe()"
> > (https://lore.kernel.org/patchwork/patch/1425453/)? It's a
> > relatively short patch that creates the platform device for
> > the driver from xhci-plat as you suggested in the v4
> > discussion.
> 
> I'm not the maintainer for xhci-related drivers.
> 
> However, there is at least one thing about this patch which looks 
> suspicious: Adding the onboard_hub_dev pointer to struct usb_hcd instead 
> of to struct xhci_plat_priv, where it would make a lot more sense.

I can move it to struct usb_hcd if that's preferred

> It's also worth mentioning that this approach won't work at all when the 
> onboard hub is not at the top level (its parent isn't the root hub),

Yes, this limitation is mentioned in the commit message of '[2/5] USB:
misc: Add onboard_usb_hub driver'. It shouldn't be hard to add support
for nested hubs, however I currently have no such configuration for
testing, so I prefer to defer it until the need actually arises and
it can be tested.

> or when more than one onboard hubs are connected to the same root hub.

Right, currently that isn't supported. xhci-plat could iterate over the
ports and have a list of the platform devices it owns. It would also
require some logic to make sure only one platform device is created per
hub. Much of this code could probably live in the onboard_hub driver
and would also be used if support for non-root hubs is added.
