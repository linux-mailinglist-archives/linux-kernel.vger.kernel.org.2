Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E685367533
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 00:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343571AbhDUWe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 18:34:58 -0400
Received: from phobos.denx.de ([85.214.62.61]:43076 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235362AbhDUWe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 18:34:57 -0400
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 0907B82B2A;
        Thu, 22 Apr 2021 00:34:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1619044462;
        bh=YHOt5rEQqqgrZKlawGGCxmHmff9BaDd36mWnVdSB7p0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IUCgkY6kwyEpjXvQxLUyT/icyvRa0CnSNUQ/IEkl4w8zsHpjv8Dco2D2tYywdDujC
         OIBLasP3UEBwrIYELghIJ+nzsuvMaoNMi1GZ1wiuQc08Ag/0C0/IODeZ8K6xmKy6Q6
         qYVLzVFEkTnfDSG7kEKN953aYe7U2z2M2Rc96AQ3mCciSIjBYBPA2IoY6ukedYya4v
         qUbWBrHINadGy5YoVxe3nTsBWPOMS6InU7DRGI8NwXbEMxc16uqEa0J1jnH86xjgDB
         wZWctxBCZxRSg2i1pnccqRSY1GnWRaPINKtkH7h7XHolB41jtydnZWMrzdf388GzLM
         MtBHnPHklkNPQ==
Subject: Re: [PATCH v3 1/2] dt-bindings: display: bridge: Add bindings for
 SN65DSI83/84/85
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Claudius Heine <ch@denx.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
References: <20210214174453.104616-1-jagan@amarulasolutions.com>
 <d7f9b241-3cfc-836a-2519-3b6621899108@denx.de>
 <CAMty3ZBMt+bx7ZrCQf0b3wrJUtZVe3CS=8-t_wYZ4+=PwP+mbQ@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <2d9a88e9-e443-0243-4b68-85fc01d9677b@denx.de>
Date:   Thu, 22 Apr 2021 00:34:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAMty3ZBMt+bx7ZrCQf0b3wrJUtZVe3CS=8-t_wYZ4+=PwP+mbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.102.4 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/21 4:45 PM, Jagan Teki wrote:
> On Wed, Mar 24, 2021 at 7:26 PM Claudius Heine <ch@denx.de> wrote:
>>
>> Hi Jagan,
>>
>> On 2021-02-14 18:44, Jagan Teki wrote:
>>> SN65DSI83/84/85 devices are MIPI DSI to LVDS based bridge
>>> controller IC's from Texas Instruments.
>>>
>>> SN65DSI83 - Single Channel DSI to Single-link LVDS bridge
>>> SN65DSI84 - Single Channel DSI to Dual-link LVDS bridge
>>> SN65DSI85 - Dual Channel DSI to Dual-link LVDS bridge
>>>
>>> Right now the bridge driver is supporting Channel A with single
>>> link, so dt-bindings documented according to it.
>>
>> Do you know when we can expect a v4 for this?
>>
>> I am currently working on top of your patch set to setup a dual-link
>> LVDS bridge of SN65DSI84.
> 
> Yes, I'm planning to send v4 this week. will keep you in CC. thanks!

I haven't seen any activity here for over two weeks, so I decided to 
send V2 of the driver I wrote, now tested on both DSI83 and DSI84.
