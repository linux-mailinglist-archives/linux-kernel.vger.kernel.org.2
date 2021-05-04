Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C17737268E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 09:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhEDH2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 03:28:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46446 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhEDH2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 03:28:12 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1447QoKq104263;
        Tue, 4 May 2021 02:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620113210;
        bh=eru3RqNbOBFAr0aUvS8kZEC79BoVl89sNoNjI1EN4qk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=oNnDMCbnU3qkAaYwe4xdAJHAEW6AZYCP4lLRowOfEXYItXzj6zWkclBrYRwNk7+MW
         5PDI9fXbMB2XB6uo/GKpdt7v4SS5n6tlZdD9Gd+SB+kl2jRMyBhyRjtqsYRvqaJ4Af
         /BiluQes64uEL8qTtYH00lITRNTN6C+v5Eoio7zA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1447QoQ8108124
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 May 2021 02:26:50 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 4 May
 2021 02:26:50 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 4 May 2021 02:26:50 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1447QnT9122975;
        Tue, 4 May 2021 02:26:50 -0500
Date:   Tue, 4 May 2021 12:56:49 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Alexander Williams <awill@google.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Heiko Thiery <heiko.thiery@gmail.com>
Subject: Re: [PATCH v4 2/2] mtd: spi-nor: add initial sysfs support
Message-ID: <20210504072647.cfcka5jcvnmlnvcc@ti.com>
References: <20210503155651.30889-1-michael@walle.cc>
 <20210503155651.30889-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210503155651.30889-3-michael@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/21 05:56PM, Michael Walle wrote:
> Add support to show the manufacturer, the partname and JEDEC identifier
> as well as to dump the SFDP table. Not all flashes list their SFDP table
> contents in their datasheet. So having that is useful. It might also be
> helpful in bug reports from users.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Acked-by: Pratyush Yadav <p.yadav@ti.com>

> ---
> Pratyush, Heiko, I've dropped your Acked and Tested-by because there
> were some changes.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
