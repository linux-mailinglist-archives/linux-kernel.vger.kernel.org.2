Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7424232BB90
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381309AbhCCMh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835993AbhCCIDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:03:35 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8C4C061222;
        Wed,  3 Mar 2021 00:01:32 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id d3so35619595lfg.10;
        Wed, 03 Mar 2021 00:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/mjreVpadpKOEE3R8AOsVJMSrNInXRosIgT1ZILxxiE=;
        b=dE3+/vWuyuvijq2HriwGlgqNrY5erKdcaSErmK2duCWF6WD/2C8h7EOQjVGcS4zSmM
         pPhbNhDXsrbEJAYBQPQFQ7R2NdMRhtfkm7VAk7lsjd9Td+rBrmsF+pbzCoxYaMHS1RmZ
         QlDEhnV7zX8cBN4r3P1vM5Qsa6xO4+a4B4Yk+X1z+WCYcQn1S8byA33tyjjONVhOjit7
         PIHHXe+jAaoS8P21A/MdB+FWaifv7hnSjVwtQ3ssmV+puKaYZ7Y1tlHCFVxeg8UU6wb1
         OKT6E+KqdTeu1wY/Wbk1z/EYBj23ULaEemJkHUtyTH/ujsoRFhJMjFsm9kbvunzPhFuY
         VWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/mjreVpadpKOEE3R8AOsVJMSrNInXRosIgT1ZILxxiE=;
        b=SERBu1WopTYWVvSYrCCITMGKPAvfW3iy7SBh4plz75s85V1SA33NHBJqtS6RkJX/Yt
         zw2euOhwUl0Fe+kMFobknXfM4aAZ/8kEfGKMWh1zvS+MH8xyQcIvyKaH9OtLIDqGt7px
         I5nK4Jl83XH8TEPSYKU2KfRcakxvf0R9yjAZ/zQYV/4+C0RoZuOZU5T8R4mq8h+bg3jH
         J4eM5BPHWACKkh+XY1yc20aRDaczTABYnL4l/8T+pun1vXkG8zGMwGDE0F4idudwpR2q
         7vdFscovAZBOQbvV8rOzA9Ya4xFnoqPepU/EmiznDuZvDz61pEHetTiKZNZ30dNogJsC
         AAtg==
X-Gm-Message-State: AOAM531j4rIGGAx7RYO4ibXFcokq+aoIulIdSf4sa7BNXNiu7XJyoBQs
        0vUzVbkSgCSkYSJMqB/BW4M=
X-Google-Smtp-Source: ABdhPJxIv82bYEfW2FtkSgcrkkPmEi4YuJBSF8dFVeltzkVrfDT63RtTSW0Z+cHfYdd1Ew7+iTp9bQ==
X-Received: by 2002:ac2:490b:: with SMTP id n11mr14054883lfi.491.1614758491002;
        Wed, 03 Mar 2021 00:01:31 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id b25sm2360395lff.268.2021.03.03.00.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 00:01:30 -0800 (PST)
Subject: Re: [PATCH v2 2/3] mtd: core: add nvmem-partitions compatible to
 parse mtd as nvmem cells
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Richard Weinberger <richard@nod.at>
Cc:     devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20210216212638.28382-1-ansuelsmth@gmail.com>
 <20210216212638.28382-3-ansuelsmth@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <e1182d56-441e-c827-6b95-d756720054a1@gmail.com>
Date:   Wed, 3 Mar 2021 09:01:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210216212638.28382-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.02.2021 22:26, Ansuel Smith wrote:
> Partitions that contains the nvmem-partitions compatible will register
> their direct subonodes as nvmem cells and the node will be treated as a
> nvmem provider.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

Tested-by: Rafał Miłecki <rafal@milecki.pl>


I applied this patch on top of the:
[PATCH] mtd: parsers: ofpart: limit parsing of deprecated DT syntax

I succesfully used NVMEM cell defined in bootloader mtd partition for
reading device MAC address.

partitions {
	compatible = "fixed-partitions";
	#address-cells = <1>;
	#size-cells = <1>;

	partition@0 {
		compatible = "nvmem-partitions";
		label = "bootloader";
		reg = <0x0 0x100000>;
		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0 0x0 0x100000>;

		base_mac_addr: mac@106a0 {
			reg = <0x106a0 0x6>;
		};
	};
}
