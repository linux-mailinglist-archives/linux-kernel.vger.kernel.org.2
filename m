Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2151393CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 07:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbhE1Fz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 01:55:59 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35196 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbhE1Fz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 01:55:56 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14S5sHFH090357;
        Fri, 28 May 2021 00:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622181257;
        bh=/dN75qdi+KeSwKPKt0j7TiXI5Dk2wUotagMlVzVKYZc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Elg5KnhVrPBo7qm7+h3jiFA84lf06++32wHBAz5L3LNx2VtYmOyZB5YYyYS1fMPlz
         SG2BaSuov4U9xXAdzWIG8E+lF0/rWB8BKup14Tme4BuTBYFP9Enas0Yw3LF8P0MDmP
         Duc/soSNPx8zzK7M2s/4LfSLf2rGPKq+Wq+jPLRQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14S5sHca029209
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 May 2021 00:54:17 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 28
 May 2021 00:54:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 28 May 2021 00:54:17 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14S5s9VO060752;
        Fri, 28 May 2021 00:54:12 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200: Remove "#address-cells"
 property from GPIO DT nodes
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210423064758.25520-1-a-govindraju@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <894b1e66-2fe0-ff27-0e56-74401dd255ba@ti.com>
Date:   Fri, 28 May 2021 11:24:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210423064758.25520-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/04/21 12:17 pm, Aswath Govindraju wrote:
> GPIO device tree nodes do not have child nodes. Therefore, "#address-cells"
> property should not be added.
> 
> Fixes: e0b2e6af39ea ("arm64: dts: ti: k3-j7200: Add gpio nodes")
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Looks like address-cells were added by mistake.

Reviewed-by: Lokesh  Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

