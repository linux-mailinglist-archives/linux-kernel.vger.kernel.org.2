Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F2C333610
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 07:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhCJG5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 01:57:17 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36386 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhCJG5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 01:57:14 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12A6v5Cx127299;
        Wed, 10 Mar 2021 00:57:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615359425;
        bh=dF9ceGIvt34ZUESWe+LK4sFqbey7DgA8gj39dr7gbgM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Tj30gZZKLCzByzcwnTZYmqcj5N1ST/zKoTg3z15X1F8rgqhyfu+IpO4p29A6OlWof
         Q4HpF5eaavULnGPO1/1EJd7Lnlm77NgyGcpFnBfkp8lQvEl9LQHt+xb8WrYKVic6cS
         wf69HN4R7jcEiCNpZ0LlkDN/nMPx9WnlFhdtifbI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12A6v5O3066550
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 00:57:05 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 00:57:05 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 00:57:05 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12A6v1ET034724;
        Wed, 10 Mar 2021 00:57:02 -0600
Subject: Re: [PATCH 0/2] AM64: Add USB support
To:     Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210301055109.17626-1-a-govindraju@ti.com>
 <20210301152227.f6phla2m3rz457pj@passerby>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <85b1b60f-455c-51b8-9e28-019226413885@ti.com>
Date:   Wed, 10 Mar 2021 12:27:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210301152227.f6phla2m3rz457pj@passerby>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 01/03/21 8:52 pm, Nishanth Menon wrote:
> On 11:21-20210301, Aswath Govindraju wrote:
>> The following series of patches, add USB support for AM64.
>>
>> This series of patches depends on,
>> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=439039
>>
>> Aswath Govindraju (2):
>>   arm64: dts: ti: k3-am64-main: Add DT node for USB subsystem
>>   arm64: dts: ti: k3-am642-evm: Add USB support
>>
>>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 30 ++++++++++++++++++++++++
>>  arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 18 ++++++++++++++
>>  2 files changed, 48 insertions(+)
> 
> Please update the series to include SK as well.
> 

I was planning on posting patches that add support for USB in SK later
because of phy dependencies.

Thanks,
Aswath
