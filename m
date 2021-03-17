Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E887433F517
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhCQQIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:08:38 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50972 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbhCQQIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:08:21 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12HG8FbO066072;
        Wed, 17 Mar 2021 11:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615997295;
        bh=MXA3mwzYXUdtkyTPzmKYdoJSlYboxEQDB3qFHto5cjA=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=lMUJuOUIowxb4r+6hjRQtufnoPKsarpdeOixK9cCusPszZwN0x6g2JMyiB1UmS4Ax
         sctfcJRz7zkvtdz2F3X8I7zYg0veUi6KoiymvVmu0l5Q2vMkqQ1B0X5d2jD8F9D0bf
         sLxUthy1W5nMJ9gktbqAieWEHinmXL1thZUT1sGY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12HG8FHV123935
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Mar 2021 11:08:15 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 17
 Mar 2021 11:08:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 17 Mar 2021 11:08:15 -0500
Received: from [10.250.235.239] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12HG8A4K001718;
        Wed, 17 Mar 2021 11:08:11 -0500
Subject: Re: [PATCH v3 0/2] AM64: Add USB support
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210317043007.18272-1-a-govindraju@ti.com>
 <33c7b945-5a3b-649b-ebaf-26465e480edc@ti.com>
Message-ID: <ea7d50d2-1a54-7730-c40b-d66efeadcc30@ti.com>
Date:   Wed, 17 Mar 2021 21:38:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <33c7b945-5a3b-649b-ebaf-26465e480edc@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/03/21 8:22 pm, Kishon Vijay Abraham I wrote:
> Aswath and Nishanth,
> 
> On 17/03/21 10:00 am, Aswath Govindraju wrote:
>> The following series of patches, add USB support for AM642 evm.
>>
>> USB test logs,
>> https://pastebin.ubuntu.com/p/YSQRBWGmzd/
> 
> Vinod has provided stable tag [1]
> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git
> tags/ti-serdes-for-5.13
> 
> This should unblock us from up-streaming SK along with this.

In case you prefer to send SK support as follow up patches

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon

> 
> Thanks
> Kishon
> 
> [1] -> http://lore.kernel.org/r/YFGjPNonIlA4Anar@vkoul-mobl.Dlink
>>
>> Changes since v2:
>> - dropped compatible string "ti,j721e-usb" leading to DT schema errors
>> - Reran test logs
>> - Couldn't pick up reviewed-by from kishon as a change was made in the
>>   patch
>>
>> Changes since v1:
>> - Rebased the patches on top of ti-k3-dts-next
>> - Added test logs
>>
>> Aswath Govindraju (2):
>>   arm64: dts: ti: k3-am64-main: Add DT node for USB subsystem
>>   arm64: dts: ti: k3-am642-evm: Add USB support
>>
>>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 30 ++++++++++++++++++++++++
>>  arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 18 ++++++++++++++
>>  2 files changed, 48 insertions(+)
>>
