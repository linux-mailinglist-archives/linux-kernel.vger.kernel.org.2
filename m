Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730A93DD5ED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 14:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhHBMpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 08:45:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43088 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbhHBMpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 08:45:31 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 172Cj9qX103776;
        Mon, 2 Aug 2021 07:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1627908309;
        bh=00bjhzU5J4EpKONm0gCPD+Fj4hqYQBMsj5Auae0vEZ0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=E7aUIuCqXdZmQtTPz4GbHk9KrgwW1/xSyoyOU974CFXIqVGuVWkgB9G2BFCbAQCRn
         t3D5JlNiufvyVK2vDU8ql2tMQkbKl4pU7mj+5zl44jOVW9szJmmXSDejlnmWuDEs7D
         bJuH4osY5BXdzG74R5nueHVr7qp5dPCwyHTN7cJw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 172Cj9uY087378
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Aug 2021 07:45:09 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 2 Aug
 2021 07:45:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 2 Aug 2021 07:45:09 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 172Cj9DF091970;
        Mon, 2 Aug 2021 07:45:09 -0500
Date:   Mon, 2 Aug 2021 07:45:09 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 0/6] CAN: Add support for CAN in AM65,J721e and AM64
Message-ID: <20210802124509.z23lfg7xxkqaakbo@truce>
References: <20210726101012.26983-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210726101012.26983-1-a-govindraju@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:40-20210726, Aswath Govindraju wrote:
> The following series of patches add support for CAN in SoC's AM65, J721e
> and AM64.
> 
> This patch series is dependent on [1] and [2] and I have requested for an
> immutable tag from the Marc Kleine-Budde(maintainer of net tree).
> 
> [1] - https://lore.kernel.org/patchwork/patch/1423048/
> [2] - https://www.spinics.net/lists/linux-can/msg08108.html
> 
> changes since v1 -
> - changed the message ram configuration to use the maximum value
>   in each field, for better performance.
> 
> Aswath Govindraju (3):
>   arm64: dts: ti: am654-base-board: Disable mcan nodes
>   arm64: dts: ti: k3-am64-main: Add support for MCAN
>   arm64: dts: ti: k3-am642-evm/sk: Add support for main domain mcan
>     nodes in EVM and disable them on SK
> 
> Faiz Abbas (3):
>   arm64: dts: ti: k3-am65-mcu: Add Support for MCAN
>   arm64: dts: ti: k3-j721e: Add support for MCAN nodes
>   arm64: dts: ti: k3-j721e-common-proc-board: Add support for mcu_mcan
>     nodes

I noticed in my checkup: https://pastebin.ubuntu.com/p/zSk39M943N/
warnings with dtbs_check, I think the bindings need a little more help
here (please also notice the iot platform warnings getting introduced).

Since we are still working on the bindings[1], lets clean that up
before we consider the dts addition. I suspect we need to cook this
more towards the next cycle.

[1] https://lore.kernel.org/patchwork/patch/1470806/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
