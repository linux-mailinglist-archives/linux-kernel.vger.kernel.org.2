Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8C443FDA5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 15:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhJ2N6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 09:58:17 -0400
Received: from 11.mo550.mail-out.ovh.net ([188.165.48.29]:59659 "EHLO
        11.mo550.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhJ2N6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 09:58:15 -0400
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Oct 2021 09:58:15 EDT
Received: from player770.ha.ovh.net (unknown [10.108.20.46])
        by mo550.mail-out.ovh.net (Postfix) with ESMTP id 0370023424
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 12:38:02 +0000 (UTC)
Received: from RCM-web10.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player770.ha.ovh.net (Postfix) with ESMTPSA id 5DEA823DC6CDD;
        Fri, 29 Oct 2021 12:37:51 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 29 Oct 2021 14:37:51 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Justin Chen <justinpopo6@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/7] watchdog: bcm7038_wdt: Add platform device id for
 bcm63xx-wdt
In-Reply-To: <20211028172322.4021440-6-f.fainelli@gmail.com>
References: <20211028172322.4021440-1-f.fainelli@gmail.com>
 <20211028172322.4021440-6-f.fainelli@gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <02cb3c1a160854c92895d024e59a831b@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16945356551679290136
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrvdeghedgheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvufgjfhgfkfigihgtgfesthejjhdttdervdenucfhrhhomheptfgrfhgrlhgpofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepveefvdetjeffueefkeeuuedvgefhgeegjefgvedvgeeiteduueeivdeltedthfetnecukfhppedtrddtrddtrddtpdduleegrddukeejrdejgedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeejtddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehrrghfrghlsehmihhlvggtkhhirdhplhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-28 19:23, Florian Fainelli wrote:
> In order to phase out bcm63xx_wdt and use bcm7038_wdt instead, 
> introduce
> a platform_device_id table that allows both names to be matched.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/watchdog/bcm7038_wdt.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/watchdog/bcm7038_wdt.c 
> b/drivers/watchdog/bcm7038_wdt.c
> index 506cd7ef9c77..2535f450e8a1 100644
> --- a/drivers/watchdog/bcm7038_wdt.c
> +++ b/drivers/watchdog/bcm7038_wdt.c
> @@ -223,6 +223,13 @@ static const struct of_device_id 
> bcm7038_wdt_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, bcm7038_wdt_match);
> 
> +static const struct platform_device_id bcm7038_wdt_devtype[] = {
> +	{ .name = "bcm7038-wdt" },
> +	{ .name = "bcm63xx-wdt" },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(platform, bcm7038_wdt_devtype);

Do we really want "bcm7038-wdt" here? I don't think it will ever be used
as apparently BCM7038 uses DT.

I'd also prefer to have Rob's comment on mapping blocks vs. mapping
registers.

If we were to map whole hardware blocks, we should have per-SoC
bindings and handling registers layouts in a driver. Right now
bcm63xx arch code maps selected part of hardware block that is
meant to match driver's logic (offsets 0x00 and 0x04).
