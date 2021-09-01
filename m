Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505D03FD8E9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 13:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243888AbhIALmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 07:42:21 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55448 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243879AbhIALmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 07:42:20 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 181Betbw002043;
        Wed, 1 Sep 2021 06:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1630496455;
        bh=Xpb1FcBWvzWF5SJEoAQG8wUxc92uDd/rzNCrD8V7YDs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=gicr6BVkBuyaEUvQYbf4CsrscG4Xf8qMkmjgQsiRnQSXZHWrOROD07iJNaiB6Jyic
         gyUxilNPy7kZJC1rLMowM7HwNEoFq4+WtCV81dCQvg7h0SZFwe7pv1qUk04X9Zj+PU
         74EeeHa2tXoWZF3Mtmy7fBsfKZSocOtnSSxtPyME=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 181Betsx080673
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Sep 2021 06:40:55 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 1
 Sep 2021 06:40:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 1 Sep 2021 06:40:54 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 181BesxE094343;
        Wed, 1 Sep 2021 06:40:54 -0500
Date:   Wed, 1 Sep 2021 17:10:53 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: hisi-sfc: Make use of the helper function
 devm_platform_ioremap_resource_byname()
Message-ID: <20210901114051.5cokevyl5hpgwrju@ti.com>
References: <20210901074259.9683-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210901074259.9683-1-caihuoqing@baidu.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/21 03:42PM, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource_byname() helper instead of
> calling platform_get_resource_byname() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Acked-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
