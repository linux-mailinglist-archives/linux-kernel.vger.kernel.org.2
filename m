Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67483CFCA2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhGTOFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 10:05:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43290 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239910AbhGTNuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:50:05 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16KEUb0g022980;
        Tue, 20 Jul 2021 09:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626791437;
        bh=xqLs4uPBmopprys6+rZE0nVDkXI9dp1oo6bfI2FiNyk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fZk122/CtJawBzCPjnk7EIheu92Lm+RR0+cgBP2I3Bj2pUiSN0csjPHLzPE+oQouZ
         wbR0rkPPpyf8V9HP3tP83GgSAYd6pnKcGeCcb6oz3cT1K+Pcr4hASyBCnEbNbHRU5E
         HS5qlcM6YJDY4jGgWAJCb8GaeTw8+K/fY/bP5Jzo=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16KEUbgu119593
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Jul 2021 09:30:37 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 20
 Jul 2021 09:30:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 20 Jul 2021 09:30:36 -0500
Received: from [10.250.235.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16KEUX4X130354;
        Tue, 20 Jul 2021 09:30:34 -0500
Subject: Re: [PATCH 1/6] arm64: dts: ti: k3-am65-mcu: Add Support for MCAN
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <20210720141642.24999-1-a-govindraju@ti.com>
 <20210720141642.24999-2-a-govindraju@ti.com>
 <20210720142047.mfqssyj4lwh3yi2k@pengutronix.de>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <f3560ac8-8ffe-87d6-a21f-87f6251f1750@ti.com>
Date:   Tue, 20 Jul 2021 20:00:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210720142047.mfqssyj4lwh3yi2k@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 20/07/21 7:50 pm, Marc Kleine-Budde wrote:
> On 20.07.2021 19:46:37, Aswath Govindraju wrote:
>> From: Faiz Abbas <faiz_abbas@ti.com>
>>
>> Add Support for two MCAN controllers present on the am65x SOC. Both support
>> classic CAN messages as well as CAN-FD.
> 
> Thanks for the patch!
> 
> Why don't you disable the CAN cores by default in the dtsi?

As far as I know, in the dtsi file we mention all the subsystems or
periherals present in the SoC and in the specific board dts file we
enable or disable the DT nodes depending on whether the  pins are
brought out.

Thanks,
Aswath

> 
> regards,
> Marc
> 

