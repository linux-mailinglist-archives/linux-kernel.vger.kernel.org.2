Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B373440DA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhCVMYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:24:03 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57510 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhCVMXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:23:37 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12MCNLxj086841;
        Mon, 22 Mar 2021 07:23:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616415802;
        bh=PiRW0/9mtm/S8YiQ/PLn61d98+Y3SPEfOvjSFUm16bE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=iks2DHarvcRQVAn75QK7cWi39dMfM8IZFTmaebZNmLEQb1Xq02gsrac9OIp9bpaOL
         +l1jPOE+FHz6CdBRQ2bQJxRe6ZQmlwhsgIzijrlqNGXBgbtd3kZCR++SQi5RgInE50
         tnYLeNvwdd07hWSlWFfY2fFmWpkD994MvRvlKESs=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12MCNLUG077120
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Mar 2021 07:23:21 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 22
 Mar 2021 07:23:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 22 Mar 2021 07:23:21 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12MCNL60074361;
        Mon, 22 Mar 2021 07:23:21 -0500
Date:   Mon, 22 Mar 2021 07:23:21 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] arm64: dts: ti: k3-j7200: Add support for higher
 speed modes and update delay select values for MMCSD subsystems
Message-ID: <20210322122321.tpvvhr2jqao7rgjd@tingle>
References: <20210319034422.17630-1-a-govindraju@ti.com>
 <20210319034422.17630-4-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210319034422.17630-4-a-govindraju@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:14-20210319, Aswath Govindraju wrote:
> The following speed modes are now supported in J7200 SoC,
> - HS200 and HS400 modes at 1.8 V card voltage, in MMCSD0 subsystem [1].
> - UHS-I speed modes in MMCSD1 subsystem [1].
> 
> Add support for UHS-I modes by adding voltage regulator device tree nodes
> and corresponding pinmux details, to power cycle and voltage switch cards.
> Set respective tags in sdhci0 and remove no-1-8-v tag from sdhci1
> device tree nodes.
> 
> Also update the delay values for various speed modes supported, based on
> the revised january 2021 J7200 datasheet[2].
> 
> [1] - section 12.3.6.1.1 MMCSD Features, in
>       https://www.ti.com/lit/ug/spruiu1a/spruiu1a.pdf,
>       (SPRUIU1A – JULY 2020 – REVISED JANUARY 2021)
> 
> [2] - https://www.ti.com/lit/ds/symlink/dra821u.pdf,
>       (SPRSP57B – APRIL 2020 – REVISED JANUARY 2021)
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
[...]

> +
> +	vdd_sd_dv_pins_default: vdd_sd_dv_pins_default {

	Nope. Use:
		vdd_sd_dv_pins_default: vdd-sd-dv-pins-default

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
