Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4108834D3EB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhC2P2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46619 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231321AbhC2P2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617031700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O2qGIcL3gPlDmT/SXMBUkWim0YVW929F3PLS859iGE4=;
        b=GKnMxfFxof6j1zeYD3JAP3xhumz8M4gmojUckztRbDljEiiATHj5G/bnDp1ex8bDoC3Vbb
        rnVdBB9W4MnewQ9PgGAg+Ic0Uxo6Syi7ToKo022hNPJsEe2ZaW+XxijG0A7uBEVLRVPmxe
        cYrnoruozSQZwzI1qKN5psFpsspTSyg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-SLmbsMCgMiyPu4Pvq-Wulw-1; Mon, 29 Mar 2021 11:28:13 -0400
X-MC-Unique: SLmbsMCgMiyPu4Pvq-Wulw-1
Received: by mail-ed1-f69.google.com with SMTP id h5so8777662edf.17
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 08:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O2qGIcL3gPlDmT/SXMBUkWim0YVW929F3PLS859iGE4=;
        b=rVPWwkQeSLLCCUSX+/DcGIQWcPoZSxYXWjg+0iA8+bQOxB9pL7Q9iNSGjQfSJ2tHYW
         pj0GsIpPVjqftAsws+h2TVY0zWrh7FEePhs6WFDw9EiLC+zk9cQPhK7nOjgGPQ6bcOkE
         obDhkAZFS7AMJ37EbRfczHSDl0QJtIZZXcPpQjvEZj/tpgLR9StTEEGXbXG+6o/rIKGZ
         /OGDbCglRGqWkD16Ymynj6xFWxzyzdgaE0j4kIgwMTp8A5DDHPhqmKoYgewnOevzpWua
         R3RfTl3hTvLT/xvlnmpllps8eU7IMCofvXpAZqVE3fyQapsbLlOSCSzJTjIVIAEhNs6q
         /azQ==
X-Gm-Message-State: AOAM533u/0mCPwrshBaUxtpRRWMIzhggLzcewi0ltjzQmdMzmpKRbWpp
        MSYn/gamWPPZuE0ILQoHxACHKAlC3C/l22uMcFqpF5H0RTWNf8h7JEshJVLAOREs2B3wQa5TZlf
        i//b2fdefnh81vBoss/IqcG4CY3wbZQacY32V7hahqmk5dfggzlHJc/XZoFXjSTJ0L6HXBm0GLV
        JN
X-Received: by 2002:a17:907:62a7:: with SMTP id nd39mr29228267ejc.510.1617031692361;
        Mon, 29 Mar 2021 08:28:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwN35hX/sQ1xF+aGTdUEvUTjiZjJvSoyEdPEOyIZez2kJAtO9JX2POrqlOnGoU+JKFMOHXM4w==
X-Received: by 2002:a17:907:62a7:: with SMTP id nd39mr29228239ejc.510.1617031692156;
        Mon, 29 Mar 2021 08:28:12 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id s14sm6924976ejm.110.2021.03.29.08.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 08:28:11 -0700 (PDT)
Subject: Re: [PATCH 07/12] i2c: cht-wc: Constify the software node
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210329105047.51033-1-heikki.krogerus@linux.intel.com>
 <20210329105047.51033-8-heikki.krogerus@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ec0358e7-2545-2723-994d-653bb5c47bde@redhat.com>
Date:   Mon, 29 Mar 2021 17:28:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210329105047.51033-8-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/29/21 12:50 PM, Heikki Krogerus wrote:
> Additional device properties are always just a part of a
> software fwnode. If the device properties are constant, the
> software node can also be constant.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/i2c/busses/i2c-cht-wc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
> index f80d79e973cd2..08f491ea21ac9 100644
> --- a/drivers/i2c/busses/i2c-cht-wc.c
> +++ b/drivers/i2c/busses/i2c-cht-wc.c
> @@ -280,6 +280,10 @@ static const struct property_entry bq24190_props[] = {
>  	{ }
>  };
>  
> +static const struct software_node bq24190_node = {
> +	.properties = bq24190_props,
> +};
> +
>  static struct regulator_consumer_supply fusb302_consumer = {
>  	.supply = "vbus",
>  	/* Must match fusb302 dev_name in intel_cht_int33fe.c */
> @@ -308,7 +312,7 @@ static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
>  		.type = "bq24190",
>  		.addr = 0x6b,
>  		.dev_name = "bq24190",
> -		.properties = bq24190_props,
> +		.swnode = &bq24190_node,
>  		.platform_data = &bq24190_pdata,
>  	};
>  	int ret, reg, irq;
> 

