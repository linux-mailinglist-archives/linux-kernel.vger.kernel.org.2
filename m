Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5C73568E8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346619AbhDGKFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:05:49 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:32826 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350558AbhDGKEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:04:46 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4FFg3l69FFz1qtPt
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 12:04:35 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4FFg3l654mz1r1Mm
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 12:04:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id wUIKBREbtGJf for <linux-kernel@vger.kernel.org>;
        Wed,  7 Apr 2021 12:04:35 +0200 (CEST)
X-Auth-Info: TN9Y4pFqAHH5cSF9g0fhxINmFoDBbngbyb5ew7t34aA=
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 12:04:35 +0200 (CEST)
Received: from deneb.denx.de (deneb [10.0.20.1])
        by mail-internal.denx.de (Postfix) with ESMTP id 5998D182B1A;
        Wed,  7 Apr 2021 12:04:16 +0200 (CEST)
Received: by deneb.denx.de (Postfix, from userid 569)
        id 259F524068D; Wed,  7 Apr 2021 12:04:15 +0200 (CEST)
Date:   Wed, 7 Apr 2021 12:04:15 +0200
From:   ch@denx.de
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Marek Vasut <marex@denx.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v3 1/2] dt-bindings: display: bridge: Add bindings for
 SN65DSI83/84/85
Message-ID: <YG2Dn3RkYOhYmYUa@deneb.denx.de>
References: <20210214174453.104616-1-jagan@amarulasolutions.com>
 <d7f9b241-3cfc-836a-2519-3b6621899108@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7f9b241-3cfc-836a-2519-3b6621899108@denx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

On Wed, Mar 24, 2021 at 02:56:37PM +0100, Claudius Heine wrote:
> Hi Jagan,
> 
> On 2021-02-14 18:44, Jagan Teki wrote:
> > SN65DSI83/84/85 devices are MIPI DSI to LVDS based bridge
> > controller IC's from Texas Instruments.
> > 
> > SN65DSI83 - Single Channel DSI to Single-link LVDS bridge
> > SN65DSI84 - Single Channel DSI to Dual-link LVDS bridge
> > SN65DSI85 - Dual Channel DSI to Dual-link LVDS bridge
> > 
> > Right now the bridge driver is supporting Channel A with single
> > link, so dt-bindings documented according to it.
> 
> Do you know when we can expect a v4 for this?
> 
> I am currently working on top of your patch set to setup a dual-link LVDS
> bridge of SN65DSI84.

Ping
