Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A383332A40
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhCIPVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:21:06 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:58434 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231909AbhCIPVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:21:00 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 129FKovi014080
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 16:20:50 +0100
Received: from [139.22.125.36] ([139.22.125.36])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 129FFnZt010978;
        Tue, 9 Mar 2021 16:15:49 +0100
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
 <20210309144122.jmynbzgbor65cxv4@chemicals>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0920aec9-b264-c835-9b43-89ccdfc994e5@siemens.com>
Date:   Tue, 9 Mar 2021 16:15:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210309144122.jmynbzgbor65cxv4@chemicals>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.21 15:41, Nishanth Menon wrote:
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
> 
> Jan,
> 
> Could you post the full series as V3 please? it works better
> that way for b4 workflow for me.
> 

Sure, give me a minute. All 4 patches then, I assume.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
