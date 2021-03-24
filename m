Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB2B347A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbhCXN5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235785AbhCXN4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:56:43 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E81C061763;
        Wed, 24 Mar 2021 06:56:43 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4F58sz32hLz1sHHY;
        Wed, 24 Mar 2021 14:56:39 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4F58sz0rwWz1qsk8;
        Wed, 24 Mar 2021 14:56:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id b0EY_bXTK-ox; Wed, 24 Mar 2021 14:56:38 +0100 (CET)
X-Auth-Info: VfJp0AaRJ905mdNW4KKeAflxaJ6T5GkmMDFPGmFJZjA=
Received: from [10.88.0.186] (dslb-084-056-254-233.084.056.pools.vodafone-ip.de [84.56.254.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 24 Mar 2021 14:56:37 +0100 (CET)
Subject: Re: [PATCH v3 1/2] dt-bindings: display: bridge: Add bindings for
 SN65DSI83/84/85
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-amarula@amarulasolutions.com
References: <20210214174453.104616-1-jagan@amarulasolutions.com>
From:   Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
Message-ID: <d7f9b241-3cfc-836a-2519-3b6621899108@denx.de>
Date:   Wed, 24 Mar 2021 14:56:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210214174453.104616-1-jagan@amarulasolutions.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

On 2021-02-14 18:44, Jagan Teki wrote:
> SN65DSI83/84/85 devices are MIPI DSI to LVDS based bridge
> controller IC's from Texas Instruments.
> 
> SN65DSI83 - Single Channel DSI to Single-link LVDS bridge
> SN65DSI84 - Single Channel DSI to Dual-link LVDS bridge
> SN65DSI85 - Dual Channel DSI to Dual-link LVDS bridge
> 
> Right now the bridge driver is supporting Channel A with single
> link, so dt-bindings documented according to it.

Do you know when we can expect a v4 for this?

I am currently working on top of your patch set to setup a dual-link 
LVDS bridge of SN65DSI84.

thanks and kind regards,
Claudius
