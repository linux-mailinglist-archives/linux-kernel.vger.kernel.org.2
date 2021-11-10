Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9096044BBFE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 08:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhKJHP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 02:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhKJHP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 02:15:27 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF60C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 23:12:40 -0800 (PST)
Received: from [192.168.1.111] (91-158-153-130.elisa-laajakaista.fi [91.158.153.130])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F167E8BB;
        Wed, 10 Nov 2021 08:12:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1636528356;
        bh=ZwBxE70dRrKURPed6R+qPwS+SvLdIxA4HAckIX1C/kM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LfKu564aiaOMmC7UUDER0mebN9GCJRy6WgohmXUSJMp9op36l48jCR9sTmdQCE2mr
         5mSGwIQaw+1Oq07FFAZ6/tmX0JuST8eBBfwR35HPAJgpc1n98uK0/NtWf747tVsCyN
         oxh5scw4bO9Rfhn4WAUnkN64FmUD1mv1bOZzdXHM=
Subject: Re: [PATCH] drm/bridge: cdns-dsi: Make sure to to create proper
 aliases for dt
To:     Nishanth Menon <nm@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, nikhil.nd@ti.com,
        r-ravikumar@ti.com, Milind Parab <mparab@cadence.com>
References: <20210921174059.17946-1-nm@ti.com>
 <20211109145538.fh3vsfnvfvvmcovb@automated>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Message-ID: <324d3d79-3ab2-f8ee-2a21-14d24f72fdce@ideasonboard.com>
Date:   Wed, 10 Nov 2021 09:12:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211109145538.fh3vsfnvfvvmcovb@automated>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2021 16:55, Nishanth Menon wrote:
> On 12:40-20210921, Nishanth Menon wrote:
>> Add MODULE_DEVICE_TABLE to the device tree table to create required
>> aliases needed for module to be loaded with device tree based platform.
>>
>> Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>   drivers/gpu/drm/bridge/cdns-dsi.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
>> index d8a15c459b42..829e1a144656 100644
>> --- a/drivers/gpu/drm/bridge/cdns-dsi.c
>> +++ b/drivers/gpu/drm/bridge/cdns-dsi.c
>> @@ -1284,6 +1284,7 @@ static const struct of_device_id cdns_dsi_of_match[] = {
>>   	{ .compatible = "cdns,dsi" },
>>   	{ },
>>   };
>> +MODULE_DEVICE_TABLE(of, cdns_dsi_of_match);
>>   
>>   static struct platform_driver cdns_dsi_platform_driver = {
>>   	.probe  = cdns_dsi_drm_probe,
>> -- 
>> 2.32.0
>>
>>
> 
> Hi, Ping?
> 

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi
