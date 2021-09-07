Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4260D40274F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 12:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243563AbhIGKmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 06:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhIGKmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 06:42:50 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5ACC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 03:41:44 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mNYXu-00CHF7-94
        for linux-kernel@vger.kernel.org; Tue, 07 Sep 2021 12:41:42 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,HELO_MISC_IP,
        RDNS_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [85.234.217.28] (helo=[10.0.1.5])
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mNYXu-00CHEw-3j; Tue, 07 Sep 2021 12:41:42 +0200
Subject: Re: [PATCH v2 5/5] ARM: multi_v7_defconfig: Add support for Airoha
 EN7523 SoC
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, John Crispin <john@phrozen.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Olivier Moysan <olivier.moysan@st.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Lionel Debieve <lionel.debieve@st.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210907102722.47543-1-bert@biot.com>
 <20210907102722.47543-6-bert@biot.com>
 <93abbefa-1ee6-7913-a41e-3e587e9a747a@gmail.com>
From:   Bert Vermeulen <bert@biot.com>
Message-ID: <1a04688d-46fc-8885-feba-d2ffa532f2d9@biot.com>
Date:   Tue, 7 Sep 2021 12:41:41 +0200
MIME-Version: 1.0
In-Reply-To: <93abbefa-1ee6-7913-a41e-3e587e9a747a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/21 12:39 PM, Dmitry Osipenko wrote:
> 07.09.2021 13:27, Bert Vermeulen пишет:
>> From: John Crispin <john@phrozen.org>
>> 
>> This enables basic bootup support for the Airoha EN7523 SoC.
>> 
>> Signed-off-by: John Crispin <john@phrozen.org>
>> Signed-off-by: Bert Vermeulen <bert@biot.com>
>> ---
>>  arch/arm/configs/multi_v7_defconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index d9abaae118dd..a9370a95dc38 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -31,6 +31,7 @@ CONFIG_MACH_BERLIN_BG2=y
>>  CONFIG_MACH_BERLIN_BG2CD=y
>>  CONFIG_MACH_BERLIN_BG2Q=y
>>  CONFIG_ARCH_DIGICOLOR=y
>> +CONFIG_ARCH_AIROHA=y
>>  CONFIG_ARCH_EXYNOS=y
>>  CONFIG_ARCH_HIGHBANK=y
>>  CONFIG_ARCH_HISI=y
>> @@ -983,6 +984,7 @@ CONFIG_STAGING_BOARD=y
>>  CONFIG_MFD_CROS_EC_DEV=m
>>  CONFIG_CROS_EC_I2C=m
>>  CONFIG_CROS_EC_SPI=m
>> +CONFIG_COMMON_CLK_EN7523=y
> 
> If SoC doesn't work without clk support, then this option should be
> auto-selected by the arch option.
> 
> It also doesn't look like upstream kernel has COMMON_CLK_EN7523 at all.

Oops, you're right -- the clock driver is coming as soon as the base system 
is in. I guess this option (under ARCH_AIROHA) should come in at that time 
as well? I'll respin after some more comments.


-- 
Bert Vermeulen
bert@biot.com
