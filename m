Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF343A16C1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 16:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbhFIOPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 10:15:21 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44064 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbhFIOPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 10:15:20 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 159EDMil052653;
        Wed, 9 Jun 2021 09:13:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623248003;
        bh=r8+D2pC2VUVTcqwuz9N3ARWdMkp56Z6Fvts12GmrQeA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cdUl4Phb8x+GbmFRw17Fw7LvGxMf8S/5de+P19UyIfIKqafYj8OxSByfEqwf2huJ1
         cVC9KWzNXGNaqViXbfc0V9jZCAWIJDXEJbwVgGlxnf2KWIdO8miFI15OlgvC7vMB/q
         tveNgrHuDJCLGEBRaVdsxgIvUmbnQ/8KFNFnj4/4=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 159EDMMp066296
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jun 2021 09:13:22 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 9 Jun
 2021 09:13:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 9 Jun 2021 09:13:22 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 159EDGdM116300;
        Wed, 9 Jun 2021 09:13:20 -0500
Subject: Re: [PATCH] arm64: dts: ti: Drop reg-io-width/reg-shift from UART
 nodes
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20210607134558.23704-1-vigneshr@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <5e7116ce-0cf0-2615-eaef-f4e0f653e86b@ti.com>
Date:   Wed, 9 Jun 2021 19:43:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210607134558.23704-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/06/21 7:15 pm, Vignesh Raghavendra wrote:
> 8250_omap compatible UART IPs on all SoCs have registers aligned at 4
> byte address boundary and constant byte addressability. Thus there is no
> need for reg-io-width or reg-shift DT properties.  These properties are
> not used by 8250_omap driver nor documented as part of binding document.
> Therefore drop them.
> 
> This is in preparation to move omap-serial.txt to YAML format.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh
