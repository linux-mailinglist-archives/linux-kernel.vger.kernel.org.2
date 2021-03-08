Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5188E3314DE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhCHR3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:29:18 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48448 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhCHR2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:28:51 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 128HSU7Y052912;
        Mon, 8 Mar 2021 11:28:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615224510;
        bh=GpREsgSTwcq19+cPP74hfnW6aIqIvYUcq82ps0QLSf4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wzYsypbj9q4hdeszGRtzVDAhJTopc3GXt32elNGdD/YfryPLY2DlNgJH8B4cqEfee
         +8waHOMmIBRhxW1BqELVynVeYt/eB5VTVJ1bsiEd282QuYOI7fN25W51W5+W1jCdxK
         rGYLlJFwkXjvav6Oj6spS8miwYvMzG7CiTgQX/yQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 128HSTHt107616
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Mar 2021 11:28:29 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 8 Mar
 2021 11:28:28 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 8 Mar 2021 11:28:29 -0600
Received: from [10.250.234.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 128HSQob124335;
        Mon, 8 Mar 2021 11:28:27 -0600
Subject: Re: [PATCH v2 4/5] mtd: spi-nor: Move Software Write Protection logic
 out of the core
To:     Tudor Ambarus <tudor.ambarus@microchip.com>, <p.yadav@ti.com>,
        <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
 <20210306095002.22983-5-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <963232a4-9100-ebca-927c-7f5a1e947fbe@ti.com>
Date:   Mon, 8 Mar 2021 22:58:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210306095002.22983-5-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/6/21 3:20 PM, Tudor Ambarus wrote:
> It makes the core file a bit smaller and provides better separation
> between the Software Write Protection features and the core logic.
> All the next generic software write protection features (e.g. Individual
> Block Protection) will reside in swp.c.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/Makefile |   2 +-
>  drivers/mtd/spi-nor/core.c   | 407 +---------------------------------
>  drivers/mtd/spi-nor/core.h   |   4 +
>  drivers/mtd/spi-nor/swp.c    | 419 +++++++++++++++++++++++++++++++++++

Hmmm, name swp.c does not seem intuitive to me. How about expanding it a
bit:

soft-wr-protect.c or software-write-protect.c ?

Regards
Vignesh
