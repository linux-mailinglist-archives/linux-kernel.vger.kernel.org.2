Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948DF305F72
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhA0PWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:22:19 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45542 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343746AbhA0PQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:16:11 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10RFEVCG058568;
        Wed, 27 Jan 2021 09:14:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611760471;
        bh=4NQBA4dCnOaDfbMECaOrJvmo/NRM4KAaRb+m2hEf9hc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Wz9Ku7VryzljpzemnYEFqMC3Dtk/2IbrVchF2rXdF05OoeRrMddUnwoR5puTy4s0y
         0At5KYZpE3dlVMwhfM8uWvN0SgZpP2DNwWS6gyWIdxYY+UQU5Yge3Y3dWvocbn2crd
         EsVThcd7KzqJOwdIFCA9kLpJ1TrF+X+1fefQkzso=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10RFEVBV079130
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jan 2021 09:14:31 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 27
 Jan 2021 09:14:31 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 27 Jan 2021 09:14:31 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10RFEVXH107951;
        Wed, 27 Jan 2021 09:14:31 -0600
Date:   Wed, 27 Jan 2021 09:14:31 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: k3-j7200: Add support for higher
 speed modes in MMCSD subsystems
Message-ID: <20210127151431.pzqpbtumqzpqiqop@delta>
References: <20210127150815.16991-1-a-govindraju@ti.com>
 <20210127150815.16991-3-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210127150815.16991-3-a-govindraju@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:38-20210127, Aswath Govindraju wrote:
> The following speed modes are now supported in J7200 SoC,
> - HS200 and HS400 modes at 1.8 V card voltage, in MMCSD0 subsystem [1].
> - UHS-I speed modes in MMCSD1 subsystem [1].
> 
> Add support for UHS-I modes by adding voltage regulator device tree nodes
> and corresponding pinmux details, to power cycle and voltage switch cards.
> Also set respective tags in sdhci0 and remove no-1-8-v tag from sdhci1
> device tree nodes.
> 
> [1] - section 12.3.6.1.1 MMCSD Features, in
>       https://www.ti.com/lit/ug/spruiu1a/spruiu1a.pdf
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> performance test logs using EXT4 filesystem for eMMC HS400 speed mode,
> https://pastebin.ubuntu.com/p/KFphDYXj93/
> 

5.11.0-rc3-next-20210118-00004 :

a) could you make sure to post patches when you test with latest next?
b) I see 2 patches in this series, but delta seems to be 4 patches, is
there a dependency I am not aware of?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
