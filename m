Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784F33328C8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCIOlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:41:53 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59226 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhCIOle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:41:34 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 129EfMjA123087;
        Tue, 9 Mar 2021 08:41:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615300882;
        bh=t0lgka7BBgeBvzk8r49qSqM6idjhHljqTbTaId51RjU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=WyKp6RhFBd7LfcrJd1QvFmmGxIkXp40ExzJb6wm2xEbNRaUVETNCxCpSm2nYzEMBQ
         MJSbN53uEMK/ZuGtvVZ7Vlc6N0mrt7uPZgO/iC90hKd/+r6OCP6zRpXMPJzbLMKtpo
         IFFDTob/bTMgRsNWJmNgEC7zhSbtmz+QfDzyRGio=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 129EfMBX038860
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Mar 2021 08:41:22 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 9 Mar
 2021 08:41:22 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 9 Mar 2021 08:41:22 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 129EfMQU115949;
        Tue, 9 Mar 2021 08:41:22 -0600
Date:   Tue, 9 Mar 2021 08:41:22 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Le Jin <le.jin@siemens.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: ti: Add support for Siemens IOT2050
 boards
Message-ID: <20210309144122.jmynbzgbor65cxv4@chemicals>
References: <cover.1613071976.git.jan.kiszka@siemens.com>
 <0c64b6ad43e7a691c1547524da4a9fd33e61c70c.1613071976.git.jan.kiszka@siemens.com>
 <95e4231c-6bee-ba64-412f-87d257df61c4@ti.com>
 <0561ad0d-7297-35ad-a3a9-49dc9a6bacd3@siemens.com>
 <aecad46d-bce6-5caf-254e-e6385ce8f44b@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aecad46d-bce6-5caf-254e-e6385ce8f44b@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:38-20210309, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Add support for two Siemens SIMATIC IOT2050 variants, Basic and
> Advanced. They are based on the TI AM6528 GP and AM6548 SOCs HS, thus
> differ in their number of cores and availability of security features.
> Furthermore the Advanced version comes with more RAM, an eMMC and a few
> internal differences.
> 
> Based on original version by Le Jin.
> 
> Link: https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
> Link: https://github.com/siemens/meta-iot2050
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

Jan,

Could you post the full series as V3 please? it works better
that way for b4 workflow for me.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
