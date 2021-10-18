Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD9443165D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhJRKqP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Oct 2021 06:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhJRKqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:46:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8611C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:44:03 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mcQ7X-0002lf-Pv; Mon, 18 Oct 2021 12:43:55 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mcQ7X-0006Dj-Cx; Mon, 18 Oct 2021 12:43:55 +0200
Message-ID: <46235d88ea5d3621eb8ab6fe150e9fcb3f9ebe1f.camel@pengutronix.de>
Subject: Re: [PATCH v4 2/2] reset: mchp: sparx5: Extend support for lan966x
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>, robh+dt@kernel.org,
        lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Andrew Lunn <andrew@lunn.ch>
Date:   Mon, 18 Oct 2021 12:43:55 +0200
In-Reply-To: <20211018091522.1113510-3-horatiu.vultur@microchip.com>
References: <20211018091522.1113510-1-horatiu.vultur@microchip.com>
         <20211018091522.1113510-3-horatiu.vultur@microchip.com>
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

On Mon, 2021-10-18 at 11:15 +0200, Horatiu Vultur wrote:
> This patch extends sparx5 driver to support also the lan966x. The
> process to reset the switch is the same only it has different offsets.
> Therefore make the driver more generic and add support for lan966x.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
