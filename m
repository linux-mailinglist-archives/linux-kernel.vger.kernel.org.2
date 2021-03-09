Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A6A332CBE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhCIRCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:02:18 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39040 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCIRBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:01:51 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 129H1jiu104065;
        Tue, 9 Mar 2021 11:01:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615309305;
        bh=pQhUgC9EUvu8RJisEr9//vmNVfCP4iQIQ+24urk1vZI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=psNww5x8Pl1c4kydAqINc1dHT2zC8d1mz3jYJas0o7JdQUQaYKzx3s251KPQ/m9E7
         hlsgbsO7VQtOSaE7ad6GhiXOEORxOFvrFUUoaxxoTzlu0lKCARGqjsXYqO3l9uNc01
         GMrbekh1t3AeTcVfjkTLBDEJ8A3LxIpUZnhNlAUI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 129H1jPL063481
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Mar 2021 11:01:45 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 9 Mar
 2021 11:01:45 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 9 Mar 2021 11:01:45 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 129H1jrW113144;
        Tue, 9 Mar 2021 11:01:45 -0600
Date:   Tue, 9 Mar 2021 11:01:45 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Pratyush Yadav <p.yadav@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: ti: k3-j7200-som-p0: Add nodes for
 OSPI0
Message-ID: <20210309170145.chq55fsynvq73p4i@unmovable>
References: <20210305153926.3479-1-p.yadav@ti.com>
 <20210305153926.3479-4-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210305153926.3479-4-p.yadav@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:09-20210305, Pratyush Yadav wrote:
> TI J7200 has the Cadence OSPI controller for interfacing with OSPI
> flashes. Add its node to allow using SPI flashes.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
> 
> Notes:
>     Changes in v2:
>     - Do not force a pulldown on the DQS line because it already has a
>       pulldown resistor.
> 
>  .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 17 +++++++++
>  arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   | 36 +++++++++++++++++++
>  2 files changed, 53 insertions(+)

I see this with dtbs_check on v5.12-rc2:

/workdir/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dt.yaml: flash@0: 'cdns,read-delay', 'cdns,tchsh-ns', 'cdns,tsd2d-ns', 'cdns,tshsl-ns', 'cdns,tslch-ns' do not match any of the regexes: '^partition@', 'pinctrl-[0-9]+'

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
