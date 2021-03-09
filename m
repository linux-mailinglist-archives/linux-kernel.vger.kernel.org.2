Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5EC332A4D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhCIPXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:23:13 -0500
Received: from gecko.sbs.de ([194.138.37.40]:53011 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231962AbhCIPXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:23:04 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 129FMtWk014950
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 16:22:55 +0100
Received: from [139.22.125.36] ([139.22.125.36])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 129FMsQp020098;
        Tue, 9 Mar 2021 16:22:55 +0100
Subject: Re: [PATCH v3 3/4] arm64: dts: ti: Add support for Siemens IOT2050
 boards
To:     Nishanth Menon <nm@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Bao Cheng Su <baocheng.su@siemens.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Le Jin <le.jin@siemens.com>
References: <cover.1613071976.git.jan.kiszka@siemens.com>
 <0c64b6ad43e7a691c1547524da4a9fd33e61c70c.1613071976.git.jan.kiszka@siemens.com>
 <95e4231c-6bee-ba64-412f-87d257df61c4@ti.com>
 <0561ad0d-7297-35ad-a3a9-49dc9a6bacd3@siemens.com>
 <aecad46d-bce6-5caf-254e-e6385ce8f44b@siemens.com>
 <20210309151019.kbay4ragt6ctyhmx@remote>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <58952252-1770-a226-828b-dd58fd466ae8@siemens.com>
Date:   Tue, 9 Mar 2021 16:22:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210309151019.kbay4ragt6ctyhmx@remote>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.21 16:10, Nishanth Menon wrote:
> On 09:38-20210309, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Add support for two Siemens SIMATIC IOT2050 variants, Basic and
>> Advanced. They are based on the TI AM6528 GP and AM6548 SOCs HS, thus
>> differ in their number of cores and availability of security features.
>> Furthermore the Advanced version comes with more RAM, an eMMC and a few
>> internal differences.
>>
>> Based on original version by Le Jin.
>>
>> Link: https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
>> Link: https://github.com/siemens/meta-iot2050
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
> 
> Jan,
> 
> I am not sure if
> https://lore.kernel.org/linux-arm-kernel/20210304160712.8452-2-s-anna@ti.com/
> is going to impact your platform. I am planning on picking that series up today.
> might be good to test against tomorrow's next - running through my basic
> tests right now before committing to the ICSS-G nodes being picked up.
> 
> If you could repost after testing against tomorrow's next, it will
> probably be better.

Thanks, I was already on CC. That series does not affect the board
features as configured in this patch. However, we are eagerly awaiting
ISCCG and then PRU Ethernet support in upstream as this is used on our
boards, with both SR1.0 and (upcoming) SR2.0.

However, I can update [1] with that series and retest our staging
integration. But as you can see from the topmost commit, it is
constantly shaking as upstreaming goes on.

Jan

[1] https://github.com/siemens/linux/commits/jan/iot2050

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
