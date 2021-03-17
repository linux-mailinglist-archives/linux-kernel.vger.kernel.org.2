Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A113633E7A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhCQD3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:29:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57128 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhCQD2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:28:41 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12H3SZP3029023;
        Tue, 16 Mar 2021 22:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615951715;
        bh=j1pCLc4ah7xrA0TwK8r4pcIwmJ8DVftAE1V1jKRnRVY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=U91Ys2GG394fNGnyB0YPZhw6zBYJC5ZJvPBTtKSkYNuaCAsBpd8swXzYSBaagX9Wd
         MwjWLPsveMtVspvily6kTGyIl8Au5txw28arlPxFiiOlBgZ/qeZ65eVY1qiX7SffwN
         sPpMO+KXsyBGJblPVETIDX/Wcr3TqwywpSs2Xl+Q=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12H3SZA7089318
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Mar 2021 22:28:35 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 16
 Mar 2021 22:28:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 16 Mar 2021 22:28:35 -0500
Received: from [10.250.235.175] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12H3SVVq034774;
        Tue, 16 Mar 2021 22:28:32 -0500
Subject: Re: [PATCH 0/3] AM64: Add SERDES DT bindings
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Nishanth Menon <nm@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
References: <20210310112745.3445-1-kishon@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <0a9ea985-b92d-0b35-432e-c0fea5abd632@ti.com>
Date:   Wed, 17 Mar 2021 08:58:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210310112745.3445-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 10/03/21 4:57 pm, Kishon Vijay Abraham I wrote:
> Patch series adds device tree bindings to support SERDES in AM64
> platform.
> 
> This is split from [1] since this binding is also required for AM64
> USB DT patches to be merged.
> 
> Vinod,
> 
> Once the 1st patch of the series is reviewed by Rob, can you merge and
> prepare a immutable tag to be used by Nishant Menon so that he can merge
> USB3 DT patches.

Now that Rob has Acked the 1st patch, can you prepare an immutable tag
for Nishant Menon on this series.

AM64 SERDES driver changes [1] can also be merged after this.

Thank You
Kishon

[1] -> http://lore.kernel.org/r/20210310120840.16447-1-kishon@ti.com
> 
> Changes from [1]:
> *) Reverted back to adding compatible under enum.
> 
> [1] -> http://lore.kernel.org/r/20210222112314.10772-1-kishon@ti.com
> 
> Kishon Vijay Abraham I (3):
>   dt-bindings: phy: ti,phy-j721e-wiz: Add bindings for AM64 SERDES
>     Wrapper
>   dt-bindings: phy: cadence-torrent: Add binding for refclk driver
>   dt-bindings: ti-serdes-mux: Add defines for AM64 SoC
> 
>  .../bindings/phy/phy-cadence-torrent.yaml     | 20 +++++++++++++++---
>  .../bindings/phy/ti,phy-j721e-wiz.yaml        |  4 ++++
>  include/dt-bindings/mux/ti-serdes.h           |  5 +++++
>  include/dt-bindings/phy/phy-cadence-torrent.h |  2 ++
>  include/dt-bindings/phy/phy-ti.h              | 21 +++++++++++++++++++
>  5 files changed, 49 insertions(+), 3 deletions(-)
>  create mode 100644 include/dt-bindings/phy/phy-ti.h
> 
