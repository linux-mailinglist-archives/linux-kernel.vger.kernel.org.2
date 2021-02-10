Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A4C316CF3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhBJRht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:37:49 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39700 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbhBJRfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:35:36 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 11AHXoh8103871;
        Wed, 10 Feb 2021 11:33:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612978430;
        bh=umzjJvW0wOMjx75fffyEcLWSY4EvNvLfMJyk20S88YE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Cc/TcNlOhqhqTTkqOh9cgT9E7hT/NtHPS0VbCUD9+ozynEksojr2lSyAErVKVWUrT
         a46EzlOIff/xDj1GsPhfjLtFoyzhK6gQXUyztsVMGxnlb64GHfWeYSG+xuWUTtDFmk
         X0kbRPXLNxL6KHMApMCHodfL/xTJQ7McDYQZUMaw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 11AHXoqe028291
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Feb 2021 11:33:50 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 10
 Feb 2021 11:33:49 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 10 Feb 2021 11:33:49 -0600
Received: from [10.250.39.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 11AHXnbY020112;
        Wed, 10 Feb 2021 11:33:49 -0600
Subject: Re: [RESEND PATCH v3] MAINTAINERS: add Dan Murphy as TI LP8xxx
 drivers maintainer
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastian Reichel <sre@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>
References: <20210210172908.336537-1-krzk@kernel.org>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <1b31c98b-2344-c502-6071-89b9d4a886a5@ti.com>
Date:   Wed, 10 Feb 2021 11:33:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210172908.336537-1-krzk@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof

On 2/10/21 11:29 AM, Krzysztof Kozlowski wrote:
> Milo Kim's email in TI bounces with permanent error (550: Invalid
> recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
> credits and add Dan Murphy from TI to look after:
>   - TI LP855x backlight driver,
>   - TI LP8727 charger driver,
>   - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Dan Murphy <dmurphy@ti.com>

Unfortunately I need to remove my ACK.  My TI email will be disabled 
this Friday.

No replacement has been identified

Dan

