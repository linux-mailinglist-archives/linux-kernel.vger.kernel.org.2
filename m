Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675A1331005
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhCHNvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhCHNvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:51:18 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB8EC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 05:51:17 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id v9so21129020lfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 05:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fEBYHOeJmoDLedRNLK+730twQNE9o6QKDts6T+ggwUw=;
        b=U7Ld9nLPBKwukUC77T14sY8bn8YJmrYJkDuAxzufzP1MWYAPo/qFOJRWmwFoKUh6pj
         02f7CdaTuiCEwmqmK3Cdh4NGu77Ea1DkAvl/+9Jzr6YLGwZaS1CtwQyY+5CECTFsLiC3
         DAINuJKS+utvShMiBvpnQqYLAtwotk+E5ZnCs9Lh5iNieWsrmbT/Y5mw3wUqAVexZAjX
         KhhVyavppversuKgdIfBGQSz6ujqEmAHU5rOawfrGO9yQ5NSyJClKyF2n8LYl8Tqef/7
         g/bIUgSSXSpKVOA3mLSnrPMjR0AdzalodY9MfR4NqcTUd2WsrE5IzZTlhFDtVxXLpmgy
         W3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fEBYHOeJmoDLedRNLK+730twQNE9o6QKDts6T+ggwUw=;
        b=rTzu7+N3GZmTxTZq/eTHFLd1G1kNz9Qa0OXVtJg8wEdErUo1B6uYC8MXDz+oN3LWFX
         R7wefd48jFs2QB93faq9gT9B4DHZAOSXxzs2KnIDMTyhdZpggP67s1aOnJCws+thRx8P
         5TXwuFGovAd5x1R4jnpDAm/UA9GhSwRnP7xL6Rx1GGZxqr2YEuIXoQDUPbfYDbc1C4eq
         0GNAL2Wk8mdHzu5qRx4jkcyeyTiHoBnynNXy/cWUDVDb9VwdBSSI+/rBbQSLzuvLZxUI
         9rqKg5R9Ju97rnXGzN54AlqpfanCmrFf0pKVtruzwxK12DrW3uRW6YrP0hQhZPAaj+gj
         bkMw==
X-Gm-Message-State: AOAM5323pGZOB1dXpPhloWOF6o6Jw7tRl+bXAzuBBrmX89Eg/z+kGrQC
        XESFoA/1mLUOZQlryiFTTJVi9+9dUwsu7ZAD
X-Google-Smtp-Source: ABdhPJy/hOdrWSRUbyZnMofoPUYrs3dZ2/pz7ECHvekYUG3v0TEAjrR46Nkp3/aqnXEODSQHPCkgCw==
X-Received: by 2002:ac2:482b:: with SMTP id 11mr13949371lft.642.1615211475673;
        Mon, 08 Mar 2021 05:51:15 -0800 (PST)
Received: from [192.168.1.213] (81.5.99.6.dhcp.mipt-telecom.ru. [81.5.99.6])
        by smtp.googlemail.com with ESMTPSA id s7sm1407317lfi.140.2021.03.08.05.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 05:51:15 -0800 (PST)
Subject: Re: [PATCH 1/2] net: allwinner: reset control support
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
References: <20210307031353.12643-1-boger@wirenboard.com>
 <20210307031353.12643-2-boger@wirenboard.com>
 <20210308133617.xqbjv7jybxbbqa27@gilmour>
From:   Evgeny Boger <boger@wirenboard.com>
Message-ID: <f4463df0-6669-fc20-ab8e-c82457e441fb@wirenboard.com>
Date:   Mon, 8 Mar 2021 16:51:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210308133617.xqbjv7jybxbbqa27@gilmour>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thank you for your review!


3/8/21 4:36 PM, Maxime Ripard пишет:
> Hi,
>
> On Sun, Mar 07, 2021 at 06:13:51AM +0300, Evgeny Boger wrote:
>> R40 (aka V40/A40i/T3) and A10/A20 share the same EMAC IP.
>> However, on R40 the EMAC is gated by default.
>>
>> Signed-off-by: Evgeny Boger <boger@wirenboard.com>
> On which device was it tested?
It's custom-made Allwinner A40i device with two IP101GRI PHYs in MII mode.
>> ---
>>   drivers/net/ethernet/allwinner/sun4i-emac.c | 21 ++++++++++++++++++++-
>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
>> index 5ed80d9a6b9f..c0ae06dd922c 100644
>> --- a/drivers/net/ethernet/allwinner/sun4i-emac.c
>> +++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
>> @@ -28,6 +28,7 @@
>>   #include <linux/of_platform.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/phy.h>
>> +#include <linux/reset.h>
>>   #include <linux/soc/sunxi/sunxi_sram.h>
>>   
>>   #include "sun4i-emac.h"
>> @@ -85,6 +86,7 @@ struct emac_board_info {
>>   	unsigned int		link;
>>   	unsigned int		speed;
>>   	unsigned int		duplex;
>> +	struct reset_control *reset;
> You should align this with the rest of the other fields

>
>>   
>>   	phy_interface_t		phy_interface;
>>   };
>> @@ -791,6 +793,7 @@ static int emac_probe(struct platform_device *pdev)
>>   	struct net_device *ndev;
>>   	int ret = 0;
>>   	const char *mac_addr;
>> +	struct reset_control *reset;
>>   
>>   	ndev = alloc_etherdev(sizeof(struct emac_board_info));
>>   	if (!ndev) {
>> @@ -852,6 +855,19 @@ static int emac_probe(struct platform_device *pdev)
>>   		goto out_release_sram;
>>   	}
>>   
>> +	reset = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
>> +	if (IS_ERR(reset)) {
>> +		dev_err(&pdev->dev, "unable to request reset\n");
>> +		ret = -ENODEV;
>> +		goto out_release_sram;
>> +	}
> Judging from your commit log, it's not really optional for the R40. The
> way we usually deal with this is to have a structure associated with a
> new compatible and have a flag tell if that compatible requires a reset
> line or not.
>
> The dt binding should also be amended to allow the reset property
>
got it
>> +	db->reset = reset;
>> +	ret = reset_control_deassert(db->reset);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "could not deassert EMAC reset\n");
>> +		goto out_release_sram;
>> +	}
>> +
> The programming guidelines in the datasheet ask that the reset line must
> be deasserted before the clock in enabled.
right, found it at section 3.3.2.6, thanks
>
> Maxime
