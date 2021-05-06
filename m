Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD6D3758D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhEFQ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:59:04 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48344 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbhEFQ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:59:00 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 146Gvh42048889;
        Thu, 6 May 2021 11:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620320263;
        bh=aKIZDf6p7yqHU0/M48XDUklaK10NPx/BO4DIR7oZzrY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ijY61wYFuw5qoikuyQDQI0Cct70HrFw5keE/JXRhmrN0uCyhBK/PcQrmQ3z0LBxwh
         Vr6txNOhlwB1PfBM5CxT4OKAxvMywn3EUCisikjbsb5BTGDrdq0o9+k3ZRaH3UlYDo
         7wq8GOxiI4K/NUh1H7BvBsz97V5ad+Yyvpz+W0jE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 146GvguR128888
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 May 2021 11:57:43 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 6 May
 2021 11:57:42 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 6 May 2021 11:57:42 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 146Gvf2n071542;
        Thu, 6 May 2021 11:57:42 -0500
Date:   Thu, 6 May 2021 22:27:41 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: otp: fix kerneldoc typos
Message-ID: <20210506165739.vlreo6bj6erpiyij@ti.com>
References: <20210505200017.17499-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210505200017.17499-1-michael@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/21 10:00PM, Michael Walle wrote:
> Use the correct argument names in the kerneldoc.
> 
> Reported-by: Pratyush Yadav <p.yadav@ti.com>
> Signed-off-by: Michael Walle <michael@walle.cc>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
