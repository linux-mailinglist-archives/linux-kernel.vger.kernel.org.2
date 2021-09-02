Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6413FF24B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346585AbhIBR31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346507AbhIBR30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:29:26 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B98EC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 10:28:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso1958390pjh.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 10:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nN3k3dUPK3S2b7Nats+T83sdUWEKp5nCRR4lWMJTudE=;
        b=nWNOAEMUfKKG10J5yFzKaL+d1LPZ/vaJ16maYdNimJPFb3bjF18zpQ6wc9etzDEy/d
         9xQc4gI4VrrMkBORoD6/t3glawBRoqo69QvPVI651WrYAkLWyoR15rtRe/tHd5HDoLYI
         OSjDefyQyWTDekFHdpDQkbZlFEI6sIdvQEBMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nN3k3dUPK3S2b7Nats+T83sdUWEKp5nCRR4lWMJTudE=;
        b=gdXlsfhhv4c1+ZioFAtFOL9qyDpdupmcLYKBhan+iGsugzdRsnYLQuf6N2t1R89anE
         +MApqkoB0oRD6OjIGNstHyseP7SJ9ayyPf/kuJ4w4hpbsG3pKfg3omeM9fq4/bgetPb+
         f2JeE7+zhOTMJWYnx0UnUBm7eKo2lghpHYCRmwuw9qS/S376+ZywqpWAOnvniJVSdftb
         VNNIzFJKRV70uwdOnC36TTTzXmw5NTAoqPRGhR4hSaulU80nFVQ3NwvEm6WifaNrk9xd
         5vdahjDjBQHldYUrcyIhtS9NDgT4wCZjNSD+BrTjFF8cJGjbG2Kw+8EyNbO7zsBFwWh7
         3DIA==
X-Gm-Message-State: AOAM532Fp3wrRRILKvONfJrfR6Kffd1c3p25Y4D16iBxc4TDbXGPZsEs
        8+kQUxQMqp59TWZ9VBSwH7AQ2A==
X-Google-Smtp-Source: ABdhPJwutjaCOHy2rhBSD4BacQLshzTVMU7A2qtTEc4S35wECtIDWPXF89OF/GlW+jFL6IjLlmpuBQ==
X-Received: by 2002:a17:902:8c90:b0:12f:699b:27 with SMTP id t16-20020a1709028c9000b0012f699b0027mr3900196plo.28.1630603706621;
        Thu, 02 Sep 2021 10:28:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:76ac:d178:a633:4fb5])
        by smtp.gmail.com with UTF8SMTPSA id k8sm3108494pjg.23.2021.09.02.10.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 10:28:26 -0700 (PDT)
Date:   Thu, 2 Sep 2021 10:28:24 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 2/4] misc: hisi_hikey_usb: change the DT schema
Message-ID: <YTEJuK50e5PBBJfO@google.com>
References: <cover.1630581434.git.mchehab+huawei@kernel.org>
 <d990e75f28c443c0c5a5fc857b87acc4be3f9464.1630581434.git.mchehab+huawei@kernel.org>
 <YTC4LPDem9uKXyMd@kroah.com>
 <20210902151053.7ddfbe3a@coco.lan>
 <20210902153820.5624b57f@coco.lan>
 <YTDYFCH/DbK1SFVv@kroah.com>
 <20210902163529.734b8e0e@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210902163529.734b8e0e@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 04:35:29PM +0200, Mauro Carvalho Chehab wrote:
> Em Thu, 2 Sep 2021 15:56:36 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> 
> > On Thu, Sep 02, 2021 at 03:38:20PM +0200, Mauro Carvalho Chehab wrote:
> > > Em Thu, 2 Sep 2021 15:10:53 +0200
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> > >   
> > > > Em Thu, 2 Sep 2021 13:40:28 +0200
> > > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> > > >   
> > > > > On Thu, Sep 02, 2021 at 01:28:35PM +0200, Mauro Carvalho Chehab wrote:    
> > > > > > As there's no upstream DT bindings for this driver, let's
> > > > > > update its DT schema, while it is not too late.      
> > > > > 
> > > > > So this is for 5.15-final?    
> > > > 
> > > > It can either be for 5.15 or 5.16, as there aren't any compatible
> > > > under arch/ which uses the DT schema there. All patches adding
> > > > such compatible are on this series. So, whatever version this
> > > > is applied should be OK.  
> > > 
> > > On a separate note, despite having "hisi_" on this driver's name, there's
> > > nothing there that is really HiSilicon specific. What this driver does is
> > > to control an USB HUB integrated inside a DT-based board, doing those 
> > > functions:
> > > 
> > > 	- Power on/off the chip;
> > > 	- reset the HUB;
> > > 	- control its OTG switch;
> > > 	- control power on/off for an USB type-C connector;
> > > 	- set USB role as host or device.
> > > 
> > > This is used on both HiKey 960 and HiKey 970 with the following
> > > topology:
> > > 
> > >   +-----+      +--------+       +---------+
> > >   | SoC | ---> | USB PHY|  ---> | USB HUB | ---> USB 3.0
> > >   +-----+      +--------+       +---------+      and type-C ports 
> > > 
> > > Both Kirin 960 and 970 SoCs have a Synapsys IP (DWC 3). 
> > > 
> > > Both HiKey 960 and 970 cards use Richtek RT1711H Type-C Chip Driver
> > > as part of the USB PHY logic, but they use different USB HUBs:
> > > 
> > > 	- HiKey 960 use a Microchip USB5734 HUB
> > > 	- HiKey 970 use a TI TUSB8041 HUB
> > > 
> > > While I'm not sure how generic this driver can be, I'm thinking that
> > > maybe a future patch could rename it to 'generic-usb-hub' or 
> > > something similar - finding a good name is always the hardest 
> > > part :-)  
> > 
> > Try looking at:
> > 	https://lore.kernel.org/r/20210813195228.2003500-1-mka@chromium.org
> > for another example of this.
> 
> (C/C Matthias here).
> 
> Interesting to know that someone else is also needing to add support
> for USB chips.

Yeah, there were several attempts over the years, but so far none of
them landed upstream ...

> Yet, the approach took there won't work with HiKey 960/970, as
> it needs to control not only the regulator, but it should also
> work as as usb-role-switch. 
> 
> So, besides controlling the regulator, which seems to be basically what
> the onboard_usb_hub_driver does, but it should also be able to:
> 
>  	- (optionally) reset the HUB;
> 	- control its OTG switch;
>  	- control power on/off for an USB type-C connector;
>  	- set USB role as host or device.

> Perhaps it would be possible to merge both approaches by modifying
> hisi_hikey_usb in order to add the extra bits required by the boards that
> Matthias is currently working, and requiring the GPIOs for OTG and
> type-C connectors only if DT contains usb-role-switch.

I'm not convinced that a hub driver should be in charge of role switching.
I wonder if the hub part could remain separate, and the role switching be
done by a dedicated driver that interacts with the hub driver through
some interface. From the above list the hub driver could still be in charge
of:

- (optionally) reset the HUB;
- control power on/off for an USB type-C connector;

Maybe the hub driver could implement a reset controller to allow the role
switching driver to switch it on and off (including type-C power).

The role switch driver (a leaner version of hisi_hikey_usb) could model
the mux and switch the hub on and off, without being concerned about all
the details.

I fear if we go the route of completely merging the two drivers it might
end up in a hodgepodge of vaguely related things, and it would probably
re-open the can of worms of the DT binding, which took a long time to
settle, even with a more limited functionality.
