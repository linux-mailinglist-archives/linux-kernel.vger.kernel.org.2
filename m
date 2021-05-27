Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E9C39305E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhE0ODM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:03:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35240 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbhE0ODF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:03:05 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14RE1RRo023925;
        Thu, 27 May 2021 09:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622124087;
        bh=ZQ/svbz0N53adUyGvebp/Wvw8cc15mDSlblBsjbTShk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XinR5//TcugbUXeoHoWNL25Dluwp5WFX4iInL5/WBWARZqG84+XN1CvHeyAw2Fl0q
         LMGg3z+RGOmepsf6Falw26GOPV6EQIvX6MP1+SiJW+Mds5x8kfRdkvZwmluaDlz7jV
         k/+nnx0rYVbeVBTNN4z5borT6doIfdGbRpsgDews=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14RE1Rnq043305
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 May 2021 09:01:27 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 27
 May 2021 09:01:27 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 27 May 2021 09:01:27 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14RE1L9R068554;
        Thu, 27 May 2021 09:01:23 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-mcu: Fix the compatible string in
 GPIO DT node
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210423060133.16473-1-a-govindraju@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <2c4aae00-a432-16d4-656c-eabb6f3b3844@ti.com>
Date:   Thu, 27 May 2021 19:31:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210423060133.16473-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/04/21 11:31 am, Aswath Govindraju wrote:
> Fix the compatible string in mcu domain GPIO device tree node.
> 
> Fixes: 01a91e01b8fd ("arm64: dts: ti: k3-am64: Add GPIO DT nodes")
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh

