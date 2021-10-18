Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C5F431652
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhJRKnK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Oct 2021 06:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhJRKnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:43:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E48C061768
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:40:55 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mcQ4U-0002SF-9S; Mon, 18 Oct 2021 12:40:46 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mcQ4T-0006AV-MT; Mon, 18 Oct 2021 12:40:45 +0200
Message-ID: <26612614156b53a3c1798f86177a69f613f210b7.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/2] dt-bindings: reset: Add lan966x support
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     robh+dt@kernel.org, andrew@lunn.ch, lars.povlsen@microchip.com,
        Steen.Hegelund@microchip.com, UNGLinuxDriver@microchip.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 18 Oct 2021 12:40:45 +0200
In-Reply-To: <20211015141404.5eiylskcfy2fxi42@soft-dev3-1.localhost>
References: <20211013073807.2282230-1-horatiu.vultur@microchip.com>
         <20211013073807.2282230-2-horatiu.vultur@microchip.com>
         <838af7b574968fc55d517a3becede5fa106ed896.camel@pengutronix.de>
         <20211014152016.wuwaesswc5iiil42@soft-dev3-1.localhost>
         <20211015141404.5eiylskcfy2fxi42@soft-dev3-1.localhost>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-10-15 at 16:14 +0200, Horatiu Vultur wrote:
[...]
> Were you thinking to have just another reset driver('phy-reset') and then
> the switch to refer to both of them?
> I like this idea because then is more clear what is doing each driver.

Yes, especially if there is no requirement to handle switch and PHY
resets at the same time: this would allow the sgpio driver to trigger
the required switch reset without already releasing the PHYs from reset.

regards
Philipp
