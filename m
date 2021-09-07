Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4421B402BC0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345209AbhIGP2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:28:51 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:53825 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344974AbhIGP2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:28:50 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 187FRYW0032695
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Sep 2021 17:27:34 +0200
Received: from [167.87.245.242] ([167.87.245.242])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 187FRXYv011004;
        Tue, 7 Sep 2021 17:27:33 +0200
Subject: Re: [PATCH 3/3] arm64: dts: ti: iot2050: Add support for product
 generation 2 boards
To:     Nishanth Menon <nm@ti.com>
Cc:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
References: <cover.1631024536.git.jan.kiszka@siemens.com>
 <d678e0a2d77fbd71c95d554dcac4646c7e8e6cf0.1631024536.git.jan.kiszka@siemens.com>
 <20210907151648.5z4hnlgppurheloz@stroller>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <37f18b9e-f640-2642-2849-ed5b61493bfa@siemens.com>
Date:   Tue, 7 Sep 2021 17:27:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907151648.5z4hnlgppurheloz@stroller>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.21 17:16, Nishanth Menon wrote:
> On 16:22-20210907, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Product Generations 1 and 2 differ in the SOC revision which requires
>> separate device trees.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  arch/arm64/boot/dts/ti/Makefile               |  2 +
>>  .../dts/ti/k3-am65-iot2050-common-pg1.dtsi    | 46 ++++++++++++++++
>>  .../dts/ti/k3-am65-iot2050-common-pg2.dtsi    | 51 ++++++++++++++++++
>>  .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 35 +-----------
>>  ...ts => k3-am6528-iot2050-basic-common.dtsi} | 12 ++---
>>  .../dts/ti/k3-am6528-iot2050-basic-pg2.dts    | 21 ++++++++
>>  .../boot/dts/ti/k3-am6528-iot2050-basic.dts   | 53 ++-----------------
>>  ...=> k3-am6548-iot2050-advanced-common.dtsi} |  8 +--
>>  .../dts/ti/k3-am6548-iot2050-advanced-pg2.dts | 26 +++++++++
>>  .../dts/ti/k3-am6548-iot2050-advanced.dts     | 52 ++----------------
>>  10 files changed, 161 insertions(+), 145 deletions(-)
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
>>  copy arch/arm64/boot/dts/ti/{k3-am6528-iot2050-basic.dts => k3-am6528-iot2050-basic-common.dtsi} (80%)
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dts
>>  copy arch/arm64/boot/dts/ti/{k3-am6548-iot2050-advanced.dts => k3-am6548-iot2050-advanced-common.dtsi} (86%)
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dts
> 
> 
> Few things:
> 
> a) Could you split this patch so that the refactoring for SR1 is the
>    first patch and then introduce the SR2?

Can do, sure

> b) Please call these as sr (silicon revision) rather than pg.

Nope, this is only motivated by the SR1->SR2 switch. The new products
are called "PG2", and that is what the DT name must reflect. Took me a
while to grasp that as well.

> c) usual request: Please add urls for the board

Where should they go? I think there is only one reasonable to share:

https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html

If that is a stable link, I can't tell.

Thanks
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
