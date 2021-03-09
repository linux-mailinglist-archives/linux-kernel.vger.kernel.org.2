Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E82332922
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 15:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhCIOvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 09:51:36 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33134 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhCIOvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 09:51:22 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 129EpDlW126720;
        Tue, 9 Mar 2021 08:51:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615301473;
        bh=K6cR1Ypau7motZcu9pQpB2cHI4HL1tc/VudlcgCVyKM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=EGuFt3r9GfvdT1oAi8Uc1l4mKwFLgr4KZ1g8na6DHsTinvMVm6zVg7Cp15hM/2mkx
         /TxxiTg/G2oLM4rqUesNwP5KvXsjb7OjhqLX2XOGqWXG4mWpHQkUhWvmpCwZVYaOY+
         NYei092D/B7MjLw3ZcQRSdLfbyaIjWOtYERoKdJI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 129EpD9r081071
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Mar 2021 08:51:13 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 9 Mar
 2021 08:51:13 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 9 Mar 2021 08:51:13 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 129EpDNB005167;
        Tue, 9 Mar 2021 08:51:13 -0600
Date:   Tue, 9 Mar 2021 08:51:13 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH v2 0/4] arm64: dts: ti: am642x: add CPSW3g DT nodes
Message-ID: <20210309145113.hdrswj7dmmsc4b25@unopposed>
References: <20210304211038.12511-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210304211038.12511-1-grygorii.strashko@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23:10-20210304, Grygorii Strashko wrote:
> Hi
> 
> This series adds corresponding AM642x CPSW3g nodes required to enable networking
> on TI am642-evm/sk platforms and adds required pinmux/PHY nodes in corresponding
> board files.
> 
> Kernel Boot Log: 
> EVM: https://pastebin.ubuntu.com/p/6Qkbw35Jg3/
> SK: https://pastebin.ubuntu.com/p/Pd3xxP9J9K/
> 
> Changes in v2:
> - minor comment fixed
> - add Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
> 
> v1: https://lore.kernel.org/patchwork/cover/1389305/
> 
> Grygorii Strashko (1):
>   arm64: dts: ti: k3-am64-main: add main CPTS entry
> 


Thanks, applied to ti-k3-dts-next.


PS: my -next branches are being rebased to 5.12-rc2 to keep a future bisect
clean.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
