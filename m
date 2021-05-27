Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4293393070
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 16:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbhE0OJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 10:09:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36440 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbhE0OJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 10:09:23 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14RE7cZa025987;
        Thu, 27 May 2021 09:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622124458;
        bh=W5zWcl19RViZmcBzfL24u2KssqK+v83PJP5qli8LjAw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Y+yRUYzdKwXgrd5iYsIihVTHg1eNKIA5nlZoCwzY4/UNa6pme5kiMOQa37TB1lym0
         b6UKwr7/GJxzA3noxfmKcNR7LBoJhr2xUa2SNiXluPrI9oBQafA99jxNWUCuFTzA27
         4BqGV+uSrgHpc7iqs156uw5QiwjLzlhZbyzCh2fU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14RE7cex070668
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 May 2021 09:07:38 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 27
 May 2021 09:07:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 27 May 2021 09:07:37 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14RE7ImN079307;
        Thu, 27 May 2021 09:07:18 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v1 1/1] mtd: spi-nor: Use SPI_MODE_X_MASK
Date:   Thu, 27 May 2021 19:36:52 +0530
Message-ID: <162212417121.9400.7341872419015074097.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510141343.56805-1-andriy.shevchenko@linux.intel.com>
References: <20210510141343.56805-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2021 17:13:43 +0300, Andy Shevchenko wrote:
> Use SPI_MODE_X_MASK instead of open coded variant.

Updated $subject to:
 "mtd: spi-nor: nxp-spifi: Use SPI_MODE_X_MASK"

Applied to spi-nor/next, thanks!
[1/1] mtd: spi-nor: Use SPI_MODE_X_MASK
      https://git.kernel.org/mtd/c/5c26d52c9e

--
Regards
Vignesh

