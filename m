Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74ACE45300B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhKPLRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:17:39 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46468 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbhKPLRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:17:34 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AGBEXvV019693;
        Tue, 16 Nov 2021 05:14:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637061273;
        bh=bkfHM0wQ7vVJKzK151DTk1uBUBNfb6mf+5a9j8kjaz8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=QtI9TPA4l3p5D+/mvGi92y5ErysNe/GEtF5DFnTlX4HJKDDWGY2P1mLizmTWvARYh
         GEFAp8nR9a/vpflC9d/4g2Z4ZtCpouWPtzaQ2q6Fnisj+T7Hz7IwS3HEQobfEG2bll
         dlgjshQK8vvvssk+3HFaZ6NrxHF3V+4ThBS/P6Sc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AGBEXOY115791
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Nov 2021 05:14:33 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 16
 Nov 2021 05:14:33 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 16 Nov 2021 05:14:33 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AGBEWcd104951;
        Tue, 16 Nov 2021 05:14:33 -0600
Date:   Tue, 16 Nov 2021 16:44:31 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <michael@walle.cc>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Constify part specific fixup hooks
Message-ID: <20211116111429.detkpyoqxuyan6lw@ti.com>
References: <20211106102915.153552-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211106102915.153552-1-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/21 12:29PM, Tudor Ambarus wrote:
> Respect flash_info structure declaration.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
