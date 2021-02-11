Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5490A3195F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 23:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhBKWlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 17:41:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:43760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229907AbhBKWlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 17:41:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5035764E57;
        Thu, 11 Feb 2021 22:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613083232;
        bh=8IaBx6200CR5VJbEUK0yZ2/gA5Be2yye2+JFWZpaRN4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YjH153+T24737wK5scfdcPYfh5XydxNmbAzAYG8DhvjXaxuvt6c1S6l9emEu0iLzn
         i4SiuNarDaGCwSLYWgb8Xtj6hf8kJjZ1eK+CeSaVvNA9epzvN2U5aOIiUOiZ4rK13C
         Xt4RU/okHVOYY/k7zZtLafvuv7Pyt8WQMtal8REthmytdRXfKr4Aj+L9u52H1IUcuW
         nuu1Pxqs3wgg+2GP+pXN/J4V5+8YNGippxXNSelWvdIERUwR921udXA0/zovhfZ/BH
         sGoFfZZO7d8kJ2HVV7krDqwrtMrDWYbIUHmZZQ5MolsAmxDAXktYroplx1mBvG0fw3
         WxGV5MRClhwMA==
Received: by mail-ej1-f42.google.com with SMTP id p20so12559041ejb.6;
        Thu, 11 Feb 2021 14:40:32 -0800 (PST)
X-Gm-Message-State: AOAM533BXZdCFp7asMtMyVYc8YvADhpxOUepoI8E+SWShZ4toGUQcb0i
        nxoBIqnu9CdTsyyPIfgPs/C1sZlestT3r3Qu+g==
X-Google-Smtp-Source: ABdhPJy/tXsuWi2sVSL420n1VWn35elaOLSkUJLWGUKyIVhfyygASwyoBm7zsKZoDDuVuAb0cWG3qFM10Tkh4q5KN/w=
X-Received: by 2002:a17:906:f85:: with SMTP id q5mr10524066ejj.108.1613083230827;
 Thu, 11 Feb 2021 14:40:30 -0800 (PST)
MIME-Version: 1.0
References: <20210210171040.684659-1-mka@chromium.org> <20210210091015.v5.3.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
 <20210210210645.xapaua7djdsvr3ca@kozik-lap> <YCRcIuCxB8nYi7/e@google.com> <161307087919.1254594.11784819060723374369@swboyd.mtv.corp.google.com>
In-Reply-To: <161307087919.1254594.11784819060723374369@swboyd.mtv.corp.google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 11 Feb 2021 16:40:19 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+A5YpF9ySzmL+G1g=ca4926vpPOpA71hB37p+FZ-=tWQ@mail.gmail.com>
Message-ID: <CAL_Jsq+A5YpF9ySzmL+G1g=ca4926vpPOpA71hB37p+FZ-=tWQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] usb: host: xhci-plat: Create platform device for
 onboard hubs in probe()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 1:14 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Matthias Kaehlcke (2021-02-10 14:20:18)
> >
> > On Wed, Feb 10, 2021 at 10:06:45PM +0100, Krzysztof Kozlowski wrote:
> > >
> > > This looks hackish... what if later we have something else than hub?
> > > Another if()?
> > >
> > > What if hub could be connected to something else than XHCI controller?
> >
> > In earlier versions this was standalone driver, which was more flexible and
> > didn't require cooperation from the XHCI driver:
> >
> > https://lore.kernel.org/patchwork/patch/1313001/
> >
> > Rob Herring raised objections about the DT bindings, since the USB hub would be
> > represented twice in the DT, once in the USB hierachry (with an explicit node or
> > implicitly) plus a node for the platform device for the new driver:
> >
> > https://lore.kernel.org/patchwork/patch/1305395/
> > https://lore.kernel.org/patchwork/patch/1313000/
> >
> > Alan Stern suggested to create the platform device in the XHCI platform driver:
> >
> > https://lore.kernel.org/patchwork/patch/1313000/#1510227
> >
> > I wasn't super happy about involving xhci-plat, but at least the code is minimal
> > and all the device specific stuff is handled by the onboard_usb_hub driver.
> >
> > If you have better suggestions that might satisfy all parties please let us
> > know :)
> >
>
> Is it possible to use the graph binding to connect the USB controller on
> the SoC to the port on the hub? Then the hub would be a standalone node
> at the root of DT connected to the USB controller (or phy) and xhci code
> could probe the firmware to see if there's a graph connection downstream
> that is a powered hub like this. I didn't see this idea mentioned in the
> previous discussions, but maybe I missed it.

An orphan at the root node is exactly what I don't want to see here.
I'm happy with the binding now from a skim of it. The kernel support
does seem kind of hacky though.

Rob
