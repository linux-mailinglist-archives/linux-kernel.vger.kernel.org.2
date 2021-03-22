Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7060E343BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhCVI1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:27:36 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34504 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhCVI1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:27:03 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12M8Qc2Z130183;
        Mon, 22 Mar 2021 03:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616401598;
        bh=6XDm6dbry0r+YwRaSouAqsdbNTu+SUnf4rka7kXFp4s=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=faZMeub+NihFppV8JJFPUIGbk2KZ+Rl3fHm4MhKWziqBDfkrCeFNHDkrQGZxoNKl/
         5pezCoXQ7MTwIMbbluCBB0ebDjrOl4XFOEoYSbXg/gE94A1zSfQVark9fItGiRgyJC
         xBqfZNnexsUGO/zSBwl5YVA8wyJ3eTmY32djiFjg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12M8Qcgf116234
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Mar 2021 03:26:38 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 22
 Mar 2021 03:26:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 22 Mar 2021 03:26:37 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12M8QbfD038199;
        Mon, 22 Mar 2021 03:26:37 -0500
Date:   Mon, 22 Mar 2021 13:56:36 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <vigneshr@ti.com>, <michael@walle.cc>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 2/2] mtd: spi-nor: swp: Improve code around
 spi_nor_check_lock_status_sr()
Message-ID: <20210322082634.6bpgsvpofw7o4pml@ti.com>
References: <20210322075131.45093-1-tudor.ambarus@microchip.com>
 <20210322075131.45093-3-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210322075131.45093-3-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/21 09:51AM, Tudor Ambarus wrote:
> - bool return value for spi_nor_check_lock_status_sr(), gets rid of
>   the return 1,
> - introduce temporary variables for better readability.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
