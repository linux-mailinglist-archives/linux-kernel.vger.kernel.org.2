Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1566435496
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 22:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhJTU36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 16:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhJTU34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 16:29:56 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4712AC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 13:27:42 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t11so16941381plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 13:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7MkU8qwyEkJbn1j/FIRW/1axu09eSaDPhCxUWJs7Xag=;
        b=ciE7a7WangZ6fjX+SQ+qQvaQsbxewBTE/wyy0BbU9QMyhMs7ST6ntYWq4kQG2y5kEn
         D473iaqcbfVQgwGikbqQZGdPcgylhhowl1o+oW+693DDQHGKPtCth01zB2BZ1tU/IdJY
         NSjJBGZWqRqKyj6tSCs4I6f+Vc3kYci0wabT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7MkU8qwyEkJbn1j/FIRW/1axu09eSaDPhCxUWJs7Xag=;
        b=6IXkbC59RmmsSYWUuS4TzmnD7fw2V4B7I+LMckavSuvbxUWn2s01Hf0khr2AI2qZjh
         zaMohnsAcZadaYk9o5hTVUZn3Qx62xxoGbe8dUjD5vqFNOUsL+lAdyvl+Ic3x2R7ERDz
         MePfg7uCUMT/FvF7B4yRc1IAu1efes0kSl+TS+J30sRSk3SE6O/6s3atDCbUZ6rFbGSG
         3ooMDKfOArjuDHDx0r++i3QQCX0gPiTgvl4UPlLSbB5xWDhlme8itBLowKI5W0dXQJnT
         l59HRD2s8DfdNPAY5gap29KZGJqpgICTLwXnGLE2nRW1U18nSDGbohZ0E1uDoUKLpJDk
         cLIw==
X-Gm-Message-State: AOAM532FiwoXpJpAOS0s0P8Yh3rivhU9MkLWmNiHVXJXmc7JcI78wTui
        mzH+KOmDLHFhzIIRCHZvQQaxKvwmzR56eQ==
X-Google-Smtp-Source: ABdhPJw6gfKcbqM+tY+90U1CK/uu2LsahHLxttJUjL8ZmyqqKLDjo5TIxo28aeH3NR6WmU2kfy7dOw==
X-Received: by 2002:a17:90a:1950:: with SMTP id 16mr1233777pjh.126.1634761661806;
        Wed, 20 Oct 2021 13:27:41 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d5fe:85e9:caf2:ec4e])
        by smtp.gmail.com with UTF8SMTPSA id q8sm3806814pfu.167.2021.10.20.13.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 13:27:41 -0700 (PDT)
Date:   Wed, 20 Oct 2021 13:27:40 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Douglas Anderson <dianders@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v16 6/7] usb: host: xhci-plat: Create platform device for
 onboard hubs in probe()
Message-ID: <YXB7vIP6ifQS3T4o@google.com>
References: <20210813195228.2003500-1-mka@chromium.org>
 <20210813125146.v16.6.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
 <dfac0025-b693-2431-04c8-1dba7ef32141@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dfac0025-b693-2431-04c8-1dba7ef32141@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On Wed, Oct 20, 2021 at 04:05:37PM +0300, Mathias Nyman wrote:
> Hi
> 
> On 13.8.2021 22.52, Matthias Kaehlcke wrote:
> > Call onboard_hub_create/destroy_pdevs() from  _probe()/_remove()
> > to create/destroy platform devices for onboard USB hubs that may
> > be connected to the root hub of the controller. These functions
> > are a NOP unless CONFIG_USB_ONBOARD_HUB=y/m.
> > 
> > Also add a field to struct xhci_hcd to keep track of the onboard hub
> > platform devices that are owned by the xHCI.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> 
> Haven't really looked at this series until now.
> 
> Is there any reason why the xhci platform driver was selected as
> the best place to create/remove these onboard hub devices?

IIRC Alan suggested to use the xhci platform driver for creating/removing
the onboard hub devices when we were trying to get rid of a separate DT
node on the 'platform bus', which was suitable the board for my use case.

> This ties the onboard hubs to xhci, and won't work in case we have onboard
> hubs connected to a ehci controllers.

Right, the driver itself isn't limited to xhci. The initial idea was that
support for other types of USB controllers could be added as needed (I only
have a config with xhci for testing).

> If separate devices for controlling onboard hub power is the right solution then
> how about creating the onboard hub device in usb_add_hcd() (hcd.c), and
> store it in struct usb_hcd.
> 
> A bit like how the roothub device is created, or PHYs are tuned.

Sure, that sounds feasible, even better if it's handled in a single place
and different types of controllers don't have to add support separately.
