Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF25316B15
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhBJQX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:23:27 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:38930 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhBJQXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:23:09 -0500
Received: by mail-oi1-f169.google.com with SMTP id l19so2617880oih.6;
        Wed, 10 Feb 2021 08:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vth8XAW3OyURtmhNnatsP5/LHcdSP/3zZ/uHnRpXRKc=;
        b=N1ih5ssccjZOrnw1UX0F8wx3gDGtho+L/26PE+dcF0ItVf7ihxR9VkrXcZegkhnWiW
         4PIWStQ6HLZP9a84pbtFhgbBQMljBQZd4eVRQeY10kQ7YAoPvQXhYdywBhLVklq4AP3h
         E6zYexHHFFpZAxtCnJPnyOGe5fbdpJsw+wg9NQ0uzjchJ9E5kxQ+98Rxpu9nvPRvhOh9
         +RnC4XogLT5F+fp1Apn4PANeE7IQb0IUvFwLVaIc8mK9ygAtITpeMG3HKqGrYhyPSHxn
         PezeG9ctofwhOgPZ+dOLvetK5BF8PcaIKBMK1phzubDtAx8wJDUfYhBeKvvKaFGbMWUY
         04dQ==
X-Gm-Message-State: AOAM533b0TF2kldped3rj3ZubMv5WqFve2Bt+33zgGsFYval0mk9llbl
        XeyVSCup9EcvBaCLbW/ITA==
X-Google-Smtp-Source: ABdhPJzfxK7JznCTG1mpjgRDFFLjV0SKpKj+NHymT0VWGOpHsKTkHtAJz+FjiiuPdSHMH+x9xBnSjg==
X-Received: by 2002:aca:3746:: with SMTP id e67mr2563353oia.68.1612974148441;
        Wed, 10 Feb 2021 08:22:28 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w2sm469998otq.9.2021.02.10.08.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 08:22:27 -0800 (PST)
Received: (nullmailer pid 2263747 invoked by uid 1000);
        Wed, 10 Feb 2021 16:22:26 -0000
Date:   Wed, 10 Feb 2021 10:22:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        a.fatoum@pengutronix.de, Saravana Kannan <saravanak@google.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, mirq-linux@rere.qmqm.pl,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Codrin.Ciubotariu@microchip.com,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] clk: at91: Fix the declaration of the clocks
Message-ID: <20210210162226.GA2246688@robh.at.kernel.org>
References: <20210203154332.470587-1-tudor.ambarus@microchip.com>
 <5bc4f5b7-5370-bdd5-143e-429c83447ce1@microchip.com>
 <161291845517.418021.17378265940034341908@swboyd.mtv.corp.google.com>
 <CAGETcx9fjRhNmEMF2QoerrzGctC6MMTy+_znVTgPEm1w-+ehqA@mail.gmail.com>
 <CAMuHMdWBZq8n6-8e-GYEEs0V9ZW--CSDCs=+u_bkr=aRW4y=ZA@mail.gmail.com>
 <YCOgnm2VkSinTYIk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCOgnm2VkSinTYIk@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 10:00:14AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 10, 2021 at 09:51:14AM +0100, Geert Uytterhoeven wrote:
> > Hi Saravana,
> > 
> > On Wed, Feb 10, 2021 at 1:57 AM Saravana Kannan <saravanak@google.com> wrote:
> > > On Tue, Feb 9, 2021 at 4:54 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > Quoting Tudor.Ambarus@microchip.com (2021-02-08 01:49:45)
> > > > > Do you plan to take this patch for v5.12?
> > > > > If fw_devlink will remain set to ON for v5.12, some of our boards will
> > > > > no longer boot without this patch.
> > > >
> > > > Is fw_devlink defaulted to on for v5.12?
> > >
> > > Yes.
> > 
> > Have all issues been identified and understood?
> > Have all issues been fixed, reviewed, and committed?
> > Have all fixes entered linux-next?
> > Have all fixes been migrated from submaintainers to maintainers?

This can never be true for these types of per platform issues. There are 
folks that test linux-next Then there are ones that test rc1. And 
(unfortunately) so-on ending at testing only LTS releases.

> > We're already at v5.11-rc7.
> > Yes, we can get fixes into v5.12-rc7. Or v5.12-rc9...
> 
> Yeah, I'm leaning toward not making it the default for 5.12-rc1 because
> not everything seems to be working, let's see how the rest of the week
> goes...

I think there's some value waiting until after rc1 to turn off if just 
to find a few more issues.

Rob
