Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F43B3A1977
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbhFIP2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:28:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53984 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbhFIP2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:28:38 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 159FQe40046481;
        Wed, 9 Jun 2021 10:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623252400;
        bh=mnSyj3seYJVrCfWRp82o87lUcvOOqJKfbM7He6wKok4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hDpbAyFe6Aq6Eciy09ajT34xKs3erfhTl9tBOU/T8YKwC7gE3QttdT/DMrZDwlr9V
         C7OQNpjkdYx3Ipy6zMALucQo9tiBGILjcKoswSZ+zV5C8BRg7ChA6YVrztOQlA2Wdd
         yau7ptcqApGDn1Crp4ARjrB72/4TTI60GcKkeDzs=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 159FQe4I121947
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jun 2021 10:26:40 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 9 Jun
 2021 10:26:40 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 9 Jun 2021 10:26:39 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 159FQWOL084446;
        Wed, 9 Jun 2021 10:26:37 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-main: Add SYSFW reserved ranges
 in OCRAM
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20210609140604.9490-1-vigneshr@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <81e61d1a-efde-0bff-719c-607752bfdbc1@ti.com>
Date:   Wed, 9 Jun 2021 20:56:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210609140604.9490-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/21 7:36 pm, Vignesh Raghavendra wrote:
> Last 256K of OCRAM (256K@0x701c0000) is reserved for SYSFW usage. Hence
> add an entry in DT so that its not used for generic pool memory
> allocation.
> 
> Without this certain drivers using SRAM as generic shared memory pool
> may end up being allocated memory from this range and will lead to boot
> time crash when the reserved range is accessed (due to firewall
> violation).
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

You might want to re-base on top of Aswath's patch updating ATF address. Otherwise:

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

