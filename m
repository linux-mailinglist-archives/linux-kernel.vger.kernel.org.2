Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7C13372A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhCKMcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:32:11 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60356 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbhCKMbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:31:45 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12BCVZZ7081573;
        Thu, 11 Mar 2021 06:31:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615465895;
        bh=nLyeqtv8EnVsSl2C1jr9xQfWZIv7JOMvu47lgPEN2yg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=q5weBMr2vEAfx9ydL777ffX6EAHt1DCwSx5FELsk9FcTqnD2eCBUzeBLEoXkZ7qdG
         iE38pvBna2AiCgLRL65GDohHK4y++9nTHz5gVH9iz55dwYfiAZnEoz74bZH2kj+kvZ
         uW2EpeVRK+i3lvPzyGun5F7K9cL0rAc0ZDQ/4Mpk=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12BCVZ6R044793
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Mar 2021 06:31:35 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 11
 Mar 2021 06:31:35 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 11 Mar 2021 06:31:35 -0600
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12BCVVcU004700;
        Thu, 11 Mar 2021 06:31:32 -0600
Subject: Re: [PATCH v5 1/3] arm64: dts: ti: k3-j7200: Add gpio nodes
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
 <20210310161924.22256-2-a-govindraju@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <a52993f1-9477-4ed2-cfd6-b2cf35b24d10@ti.com>
Date:   Thu, 11 Mar 2021 14:30:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210310161924.22256-2-a-govindraju@ti.com>
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
> There are 4 instances of gpio modules in main domain:
> 	gpio0, gpio2, gpio4 and gpio6
> 
> Groups are created to provide protection between different processor
> virtual worlds. Each of these modules I/O pins are muxed within the
> group. Exactly one module can be selected to control the corresponding
> pin by selecting it in the pad mux configuration registers.
> 
> This group in main domain pins out 69 lines (5 banks). Add DT modes for
> each module instance in the main domain.
> 
> Similar to the gpio groups in main domain, there is one gpio group in
> wakeup domain with 2 module instances in it.
> 
> The gpio group pins out 72 pins (6 banks) of the first 85 gpio lines. Add
> DT nodes for each module instance in the wakeup domain.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 72 +++++++++++++++++++
>   .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 34 +++++++++
>   2 files changed, 106 insertions(+)
> 
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
