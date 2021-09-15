Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F47240C801
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 17:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbhIOPPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 11:15:16 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35316 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbhIOPPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:15:12 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 18FFDgfu010872;
        Wed, 15 Sep 2021 10:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631718822;
        bh=SlLW5Xj9oEORlw+AqDDG6RwUyumDe2hRBZ/TEGWdrAk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oW+UKS9jUXsaPDuvtDIvrmYFBC0Mbko/rPwKdslsIrPnVMTrHt2EI2Ji8oP9BvWBD
         lHJihiWrRf8p42J/BKScYw+ZbZyyvEoS2jm3a/b/TqNuYlqaA8TMOoXI14D/w7kz5J
         x+V/GGO9BdoUIMguesLi0W3VWSaeDtRhSQaicUrs=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 18FFDfPW069214
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Sep 2021 10:13:41 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Sep 2021 10:13:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Sep 2021 10:13:41 -0500
Received: from [10.250.232.51] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 18FFDbjn106503;
        Wed, 15 Sep 2021 10:13:38 -0500
Subject: Re: [PATCH v2 00/15] PHY: Add support for multilink configurations in
 Cadence Sierra PHY driver
To:     Swapnil Jakhade <sjakhade@cadence.com>, <vkoul@kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <lokeshvutla@ti.com>
References: <20210908122930.10224-1-sjakhade@cadence.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <23a8f4d9-3467-1cf5-eec7-a4d33fe03458@ti.com>
Date:   Wed, 15 Sep 2021 20:43:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210908122930.10224-1-sjakhade@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/09/21 5:59 pm, Swapnil Jakhade wrote:
> Cadence Sierra PHY is a multiprotocol PHY supporting different multilink
> PHY configurations. This patch series extends functionality of Sierra PHY
> driver by adding features like support for multilink multiprotocol
> configurations, derived reference clock etc.
> 
> The changes have been validated on TI J721E platform.
> 
> Version History:
> 
> v2:
>    - Added a new patch 3/15 to rename the SSC macros for dt-bindings
>      to use generic names. These macros are not yet used in any DTS file.
> 
> Swapnil Jakhade (15):
>   phy: cadence: Sierra: Use of_device_get_match_data() to get driver
>     data
>   phy: cadence: Sierra: Prepare driver to add support for multilink
>     configurations
>   dt-bindings: phy: cadence-torrent: Rename SSC macros to use generic
>     names
>   dt-bindings: phy: cadence-sierra: Add binding to specify SSC mode
>   phy: cadence: Sierra: Add support to get SSC type from device tree
>   phy: cadence: Sierra: Rename some regmap variables to be in sync with
>     Sierra documentation
>   phy: cadence: Sierra: Add PHY PCS common register configurations
>   phy: cadence: Sierra: Check cmn_ready assertion during PHY power on
>   phy: cadence: Sierra: Check PIPE mode PHY status to be ready for
>     operation
>   phy: cadence: Sierra: Update single link PCIe register configuration
>   phy: cadence: Sierra: Fix to get correct parent for mux clocks
>   phy: cadence: Sierra: Add support for PHY multilink configurations
>   phy: cadence: Sierra: Add PCIe + QSGMII PHY multilink configuration
>   dt-bindings: phy: cadence-sierra: Add clock ID for derived reference
>     clock
>   phy: cadence: Sierra: Add support for derived reference clock output
> 

for the complete series,

Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>

Thanks,
Aswath

>  .../bindings/phy/phy-cadence-sierra.yaml      |    9 +
>  .../bindings/phy/phy-cadence-torrent.yaml     |    4 +-
>  drivers/phy/cadence/phy-cadence-sierra.c      | 1299 +++++++++++++++--
>  include/dt-bindings/phy/phy-cadence.h         |    9 +-
>  4 files changed, 1226 insertions(+), 95 deletions(-)
> 

