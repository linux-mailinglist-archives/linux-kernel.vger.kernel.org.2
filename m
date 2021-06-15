Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169463A88D6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhFOSwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:52:00 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48626 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhFOSv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:51:59 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15FInpJ9083789;
        Tue, 15 Jun 2021 13:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623782991;
        bh=b9L+wh099n8zOFVlLv4DyNZCUnB5ka2MM+y3CQVCV+I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Z4nryT/0G3polQI9GhtLJ91t4rj3dPQuA6BwK5CznVXlz188ZhEZgTG4uIDFGH3Np
         kJ0gMPOiFXiNUAqjANvwQMaWpk0I9O5K/P5fOXSk/xl/+4NAZyxPDgFwiUsZPzTHy3
         qIW9DnBFFB+TR8sFje0ixduQYBvPCvLjntQwmZIU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15FInper062970
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jun 2021 13:49:51 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 15
 Jun 2021 13:49:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 15 Jun 2021 13:49:51 -0500
Received: from [10.250.35.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15FInp5Q023193;
        Tue, 15 Jun 2021 13:49:51 -0500
Subject: Re: [PATCH v4 0/3] AM64: Update the locations of various elements in
 SRAM
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210615174325.22853-1-a-govindraju@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <44cdc18f-2d22-24c0-fc7d-53b3c90b9ef9@ti.com>
Date:   Tue, 15 Jun 2021 13:49:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210615174325.22853-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath,

On 6/15/21 12:43 PM, Aswath Govindraju wrote:
> The following series of patches,
> - Increase the maximum size of TF-A
> - Update the location of TF-A due to a limitation for DFU boot
> - Indicate reserved locations for DMSC code and secure proxy
> 
> changes since v3:
> - fixed the title of patches 1 and 2

Thanks for fixing these. I have been able to verify these on my AM64x EVM using
the corresponding U-Boot changes as well.

regards
Suman

> 
> changes since v2:
> - split the patches into three
> - added regions for indicating memory regions reserved for
>   dmsc and secure proxy
> - moved the TFA location to 0x701c4000
> 
> Aswath Govindraju (3):
>   arm64: dts: ti: k3-am64-main: Update TF-A's maximum size and node name
>   arm64: dts: ti: k3-am64-main: Reserve OCMRAM for DMSC-lite and secure
>     proxy communication
>   arm64: dts: ti: k3-am64-main: Update the location of TF-A
> 
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 

