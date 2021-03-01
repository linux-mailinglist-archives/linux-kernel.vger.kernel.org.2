Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42576328264
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 16:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbhCAPYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 10:24:16 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37924 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbhCAPYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 10:24:06 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 121FMRk7006699;
        Mon, 1 Mar 2021 09:22:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614612147;
        bh=kFBMGy9uiWTxUTLAQVlkV8PT6CJ/OnQoLDqfYJV2bRk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=U6AX4WuDXbpLkpzKB/xnAEf4JRC4jO3fonzO3+I2eadJ7bYWAQAjIMVR/lx+JL09I
         FeQ7TTrrb8zlyzUaaYv7b9aEfGEiDjYFY1+B8DT4r+PrrpTMcdiqrHPNs56mjCQk2r
         uecTgyKYa9D615FEdQFTJ67jXS8lFmQVlAj+bj2c=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 121FMRTm055528
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Mar 2021 09:22:27 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 1 Mar
 2021 09:22:27 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 1 Mar 2021 09:22:27 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 121FMRxZ038823;
        Mon, 1 Mar 2021 09:22:27 -0600
Date:   Mon, 1 Mar 2021 09:22:27 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] AM64:  Add USB support
Message-ID: <20210301152227.f6phla2m3rz457pj@passerby>
References: <20210301055109.17626-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210301055109.17626-1-a-govindraju@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:21-20210301, Aswath Govindraju wrote:
> The following series of patches, add USB support for AM64.
> 
> This series of patches depends on,
> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=439039
> 
> Aswath Govindraju (2):
>   arm64: dts: ti: k3-am64-main: Add DT node for USB subsystem
>   arm64: dts: ti: k3-am642-evm: Add USB support
> 
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 30 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 18 ++++++++++++++
>  2 files changed, 48 insertions(+)

Please update the series to include SK as well.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
