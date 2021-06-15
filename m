Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830D63A8808
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhFORro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:47:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36678 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhFORrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:47:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15FHjapU062259;
        Tue, 15 Jun 2021 12:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623779136;
        bh=xq8N0+Ag0aM5XxV7oawpiSjnWkX3GbNwWzSoJIYFQd8=;
        h=Subject:CC:References:From:Date:In-Reply-To;
        b=Su2d/xQ9Zdk3sxKs1sPPML8QQdiZOHiufpaJ6FKRMYdwHkWlOvPsAo0iIgCvWpZFb
         Y6UIhcayMLy5Llt+7DvqRy0R5kxT4RBDQxa2c1GzUI2DFL1y8rpeH5/W9e5z80Eixe
         /d2mahAMWrMQpuUZBIchf5hTuf81gNM//Z9ilAI8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15FHjauL055665
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jun 2021 12:45:36 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 15
 Jun 2021 12:45:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 15 Jun 2021 12:45:35 -0500
Received: from [10.250.235.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15FHjUqq114642;
        Tue, 15 Jun 2021 12:45:31 -0500
Subject: Re: [PATCH v3 0/3] AM64: Update the locations of various elements in
 SRAM
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Suman Anna <s-anna@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210615155115.28902-1-a-govindraju@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <779294d5-e3e3-1c12-4ab7-7130341f41e1@ti.com>
Date:   Tue, 15 Jun 2021 23:15:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210615155115.28902-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 15/06/21 9:21 pm, Aswath Govindraju wrote:
> The following series of patches,
> - Increase the maximum size of TF-A
> - Update the location of TF-A due to a limitation for DFU boot
> - Indicate reserved locations for DMSC code and secure proxy
> 
> changes since v2:
> - split the patches into three
> - added regions for indicating memory regions reserved for
>   dmsc and secure proxy
> - moved the TFA location to 0x701c4000
> 

Posted respin(v4) after correcting the titles of patches 1 and 2.

Thanks,
Aswath

> Aswath Govindraju (3):
>   dts: ti: k3-am64-main: Update TF-A's maximum size and node name
>   arm64: dts: ti: k3-am64-main: Indicate the memory reserved for
>     DMSC-lite code and secure proxy communication buffer
>   arm64: dts: ti: k3-am64-main: Update the location of TF-A
> 
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

