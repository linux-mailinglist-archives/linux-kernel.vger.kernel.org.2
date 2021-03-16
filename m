Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991F533D370
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhCPL4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:56:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49978 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbhCPLzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:55:54 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12GBtmFS110749;
        Tue, 16 Mar 2021 06:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615895748;
        bh=nxPGONndDz3YgJY8MtdT6DmTfIWCyvueeBm4r1ERtaw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=gz3qrd/hRJ3l/LI2X6EIjjr6yB3qFW1HnPkTgeVwW9ZweRp9hywBgq90QDmcoGnL3
         XhfO3afwyorLdgtgEciWMEXgLNisvC1m/CsLMSGpZ6UruNaN0Jq9U0Zr/K40DX53aC
         TV3bA93MGPzlrVDvY8aBiG8B3YkgMHbU4Wg3lMcg=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12GBtm7f091534
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Mar 2021 06:55:48 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 16
 Mar 2021 06:55:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 16 Mar 2021 06:55:47 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12GBtlea024493;
        Tue, 16 Mar 2021 06:55:47 -0500
Date:   Tue, 16 Mar 2021 06:55:47 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH 1/2] arm64: dts: ti: k3-am64-main: Add OSPI node
Message-ID: <20210316115547.7acr6sc5g242x5jh@acrobat>
References: <20210315120149.10606-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210315120149.10606-1-vigneshr@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:31-20210315, Vignesh Raghavendra wrote:
> AM64 SoC has a single Octal SPI (OSPI) instance under Flash SubSystem
> (FSS).  Add DT entry for the same.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
> ---
> Resend:
> Rebase onto latest -next
> 
> v1: lore.kernel.org/r/20210309130514.11740-1-vigneshr@ti.com


Thanks, but we will need to rebase -> so lets sequence this right
offline.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
