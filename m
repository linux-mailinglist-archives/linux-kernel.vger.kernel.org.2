Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDC333D37E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbhCPMDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:03:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52074 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237557AbhCPMDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:03:16 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12GC38vE113760;
        Tue, 16 Mar 2021 07:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615896188;
        bh=JUZxNgAAlZvvc/jMKRjU1b/5rgQyQZ9P6xe6l9jYb4Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=P9U4MgeFyjsgys3GcUbucDbseTujEUj1IlkGJX8qeBSulPU2URmWVcNa9zkceGcEc
         aesueUX4FZk8WZjmIZrxegjzZYjIqv3cWosN8Y5IjVUsJNyGn4V1mTuJLDGCIlVcDb
         rHMEo9k5jDyIh7JPcs9KsZt58UVRnQo/XELFxRJI=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12GC38tA084521
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Mar 2021 07:03:08 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 16
 Mar 2021 07:03:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 16 Mar 2021 07:03:08 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12GC34xc084945;
        Tue, 16 Mar 2021 07:03:05 -0500
Subject: Re: [PATCH v5 2/3] arm64: dts: ti: k3-j7200-common-proc-board:
 Disable unused gpio modules
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210310161924.22256-1-a-govindraju@ti.com>
 <20210310161924.22256-3-a-govindraju@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <28391514-7946-4db0-598e-b53b75fc30b5@ti.com>
Date:   Tue, 16 Mar 2021 14:01:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210310161924.22256-3-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/2021 18:19, Aswath Govindraju wrote:
> From: Faiz Abbas <faiz_abbas@ti.com>
> 
> There are 6 gpio instances inside SoC with 2 groups as show below:
>      Group one: wkup_gpio0, wkup_gpio1
>      Group two: main_gpio0, main_gpio2, main_gpio4, main_gpio6
> 
> Only one instance from each group can be used at a time. So use main_gpio0
> and wkup_gpio0 in current linux context and disable the rest of the nodes.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>   .../boot/dts/ti/k3-j7200-common-proc-board.dts   | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
