Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2263161D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhBJJI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:08:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229940AbhBJJA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:00:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A07664E2F;
        Wed, 10 Feb 2021 09:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612947618;
        bh=6DKov5lEdYKhCGKIaGnnaTsGU64eVZQrn5xUICHQO5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AFsdPOTUnOAxrPPE/sCYoKo0E3No0FLZH9BzhWbJ+lxLVxujwcWRJtViH5FmK9Z3m
         sLGmP7IKlRxIE53iXpYQePAB5jJSWay7TFLNDmVqvkSGSF9ARqijsTr4DTg3Tjl8b9
         zWO1Z7v30T9SmIh6ipJVgvzvFQbOPhUNkVpegmpg=
Date:   Wed, 10 Feb 2021 10:00:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ludovic Desroches <Ludovic.Desroches@microchip.com>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        mirq-linux@rere.qmqm.pl,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        a.fatoum@pengutronix.de, Krzysztof Kozlowski <krzk@kernel.org>,
        Codrin.Ciubotariu@microchip.com,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: at91: Fix the declaration of the clocks
Message-ID: <YCOgnm2VkSinTYIk@kroah.com>
References: <20210203154332.470587-1-tudor.ambarus@microchip.com>
 <5bc4f5b7-5370-bdd5-143e-429c83447ce1@microchip.com>
 <161291845517.418021.17378265940034341908@swboyd.mtv.corp.google.com>
 <CAGETcx9fjRhNmEMF2QoerrzGctC6MMTy+_znVTgPEm1w-+ehqA@mail.gmail.com>
 <CAMuHMdWBZq8n6-8e-GYEEs0V9ZW--CSDCs=+u_bkr=aRW4y=ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWBZq8n6-8e-GYEEs0V9ZW--CSDCs=+u_bkr=aRW4y=ZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 09:51:14AM +0100, Geert Uytterhoeven wrote:
> Hi Saravana,
> 
> On Wed, Feb 10, 2021 at 1:57 AM Saravana Kannan <saravanak@google.com> wrote:
> > On Tue, Feb 9, 2021 at 4:54 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > Quoting Tudor.Ambarus@microchip.com (2021-02-08 01:49:45)
> > > > Do you plan to take this patch for v5.12?
> > > > If fw_devlink will remain set to ON for v5.12, some of our boards will
> > > > no longer boot without this patch.
> > >
> > > Is fw_devlink defaulted to on for v5.12?
> >
> > Yes.
> 
> Have all issues been identified and understood?
> Have all issues been fixed, reviewed, and committed?
> Have all fixes entered linux-next?
> Have all fixes been migrated from submaintainers to maintainers?
> 
> We're already at v5.11-rc7.
> Yes, we can get fixes into v5.12-rc7. Or v5.12-rc9...

Yeah, I'm leaning toward not making it the default for 5.12-rc1 because
not everything seems to be working, let's see how the rest of the week
goes...

thanks,

greg k-h
