Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C4632AB25
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836457AbhCBUIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448132AbhCBRaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:30:25 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47437C061221;
        Tue,  2 Mar 2021 08:53:59 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id a17so24833909ljq.2;
        Tue, 02 Mar 2021 08:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=faWbq/WMv3ZR1gToxIr2aLjBRTdDNxo7+ThXJjNGaIo=;
        b=hmBekdGUxUExGQJ6JMFq6hE1MDzFwReePVI8GOf5z4T/95msnW4QO3MIEmsO/NaKEZ
         LQfdb7pOMUeCUrqJguC1IlMp+uzDJsrDME3ZJ4TsZsp8DARjnnLKhq2geD/GpRoRy+qk
         cK4b3GUoy4msSiT31Kdapphy7vtzuw8gdONd1mdwu2R8etVGOFwIvxuofeUW0ov7Kxv2
         +N+ERu2Szxo46lPTqNtzQbUcmsKEovWNcqH4YXgOc9MWnQmlPjDlE5Y1jvsqYLYljb7x
         HmARZIYImzMPiiltdmcOdY6Jm7gSjKsYT2xwxXTTekQIGMZxxulQAND9KJOoHvar31hO
         91uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=faWbq/WMv3ZR1gToxIr2aLjBRTdDNxo7+ThXJjNGaIo=;
        b=AjMM2zPLZ0vA7OXF6y4anfSf53FrNJyWkGmrR6ptVFk2aOccYsbI+mTSmCaVcibxTr
         3IVNoyVEGNGwdzCGps9EUD2NT7ElxWX5wZIAvGdqJaQBmMg2D4Hy77qgV2tRG/fIZNNJ
         VYJqJ4SkrtVW7iDIPVWn1sEWw6w+wGRhUG/YFc+fQHmOgmS/HgHtOz6ECDx+d35oYGwO
         BII8h+qoDWr7nZxJpOT3PJ/54Fg19ARzcA72XhsicGczuwka5iAwkGf6PLXLdNU+JjPv
         3zAMPf+EpSSUbfNv2Nd58vZtivoe/M4Fi+kSXQwqoR83bRJp0GGA8LZqCnmimVVX96ZF
         GXIw==
X-Gm-Message-State: AOAM5304r+NFavhdWBDLKx/xSnbexHrUyspzRz/LrDZU9zEeA15LYcEv
        1xO1Wr0FVazDFkhcLfF60vw=
X-Google-Smtp-Source: ABdhPJw/W01gIjsqpMNr8JSw/9SiRbUKcitCde7eXbhpqsWpDs9pwVC/y07CdIyBdlketTmha75GtQ==
X-Received: by 2002:a2e:2e19:: with SMTP id u25mr38659lju.487.1614704037798;
        Tue, 02 Mar 2021 08:53:57 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id g2sm2894780ljk.15.2021.03.02.08.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 08:53:56 -0800 (PST)
Subject: Re: [PATCH v2 1/3] mtd: partitions: ofpart: skip subnodes parse with
 compatible
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20210216212638.28382-1-ansuelsmth@gmail.com>
 <20210216212638.28382-2-ansuelsmth@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <d504a4df-b1f7-b7c9-e62a-599d114d8a18@gmail.com>
Date:   Tue, 2 Mar 2021 17:53:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210216212638.28382-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.02.2021 22:26, Ansuel Smith wrote:
> If a partitions structure is not used, parse direct subnodes as
> fixed-partitions only if a compatible is not found or is of type
> fixed-partition. A parser can be used directly on the subnode and
> subnodes should not be parsed as fixed-partitions by default.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>   drivers/mtd/parsers/ofpart.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mtd/parsers/ofpart.c b/drivers/mtd/parsers/ofpart.c
> index daf507c123e6..4b363dd0311c 100644
> --- a/drivers/mtd/parsers/ofpart.c
> +++ b/drivers/mtd/parsers/ofpart.c
> @@ -50,6 +50,11 @@ static int parse_fixed_partitions(struct mtd_info *master,
>   			 master->name, mtd_node);
>   		ofpart_node = mtd_node;
>   		dedicated = false;
> +
> +		/* Skip parsing direct subnodes if a compatible is found and is not fixed-partitions */
> +		if (node_has_compatible(ofpart_node) &&
> +		    !of_device_is_compatible(ofpart_node, "fixed-partitions"))
> +			return 0;
>   	} else if (!of_device_is_compatible(ofpart_node, "fixed-partitions")) {
>   		/* The 'partitions' subnode might be used by another parser */
>   		return 0;

I admit I'm not familiar with the old binding, so let me know if my
understanding is incorrect.

It seems to me however that your change will break parsing in cases
like:

spi-flash@0 {
	compatible = "jedec,spi-nor";
	reg = <0x0>;

	partition@0 {
		label = "bootloader";
		reg = <0x0 0x100000>;
	};
};

nandcs@0 {
	compatible = "brcm,nandcs";
	reg = <0>;

	partition@0 {
		label = "bootloader";
		reg = <0x0000000 0x10000>;
	};
};

Did we ever use "fixed-partitions" without partitions { } subnode?
