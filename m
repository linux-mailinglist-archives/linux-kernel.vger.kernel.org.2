Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6913B3280C9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbhCAO2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:28:12 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49794 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbhCAO0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:26:55 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 121EP2YT110234;
        Mon, 1 Mar 2021 08:25:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614608702;
        bh=oomUxLH+BoZYl0+zIicGqRwhTquC7dxS8FZ/fvZJv80=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=LBgvK+zPza2jFNTOwYEXpK0w5it4GGRj/1K2J3GSn34cob3spjW3/zLEcReNn/1Ln
         HUmBcHKfXr0IjzZjOYveU3PopmR/cj0x2Tkb1d+vmD2b2o+Ot35oQwX+c6DhnskEur
         0prq0cwZuy5yi/nBZy+46/T5+kuOuaGEnsWHEhic=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 121EP2K1083926
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Mar 2021 08:25:02 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 1 Mar
 2021 08:25:02 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 1 Mar 2021 08:25:02 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 121EP15j095857;
        Mon, 1 Mar 2021 08:25:01 -0600
Date:   Mon, 1 Mar 2021 08:25:01 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-main: Add GPIO DT nodes
Message-ID: <20210301142501.7fj6jdlpv4nqznlh@pulverize>
References: <20210301061908.22460-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210301061908.22460-1-a-govindraju@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:49-20210301, Aswath Govindraju wrote:
> Add device tree nodes for GPIO modules and interrupt controller in main
> domain.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> This patch depends on,
> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=439039

> 
> 
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 45 ++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 


Please add MCU GPIO instance[1] as well. We may not use it in the evm, in
which case disable it, but squash the domains into a single patch.

[1] https://www.ti.com/lit/pdf/spruim2

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
