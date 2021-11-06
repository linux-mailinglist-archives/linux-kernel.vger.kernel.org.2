Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474D9446CF3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 08:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhKFH7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 03:59:04 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25463 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhKFH7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 03:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1636185382; x=1667721382;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pKs/JTvbqAJPdXz+GBkilVJdmNiQD67bqrDbRYYV5tY=;
  b=AB5AfXKKHmXWrqTIiqjNDmYTAIVT0Q7f4vTGdCPz3tZARdDJqWKXzblV
   3MF0L+yXNpt+7mrezzIz8hveW2angQwsF58xiVublKEA9HYFQd6tmA5Hs
   zGRkWJM2fWdq8WdfZ/H6LU3BQqiOHrEiVRGzQG037G+evx8koEdKNSZuj
   v/PF0MVgCcahAKUWts1/wGRi3fjvK4VXiFSIAPkUtsehf2L4ssKDWEiL+
   OLHieMrtLAJ0N50it/p4tdXJ0qBMGblZ+kje+EC/NY6eP+lSG2/2QCpy5
   vEm2n8MMcagElyY0xaArJa537J2KLsHoWI6h/g7uFjH+KeHK6Ju4Dv5LP
   A==;
IronPort-SDR: xW1TKyB7d+p7Lw7cDZWlabqazY6c6SZxEISmVt+JqZVlmfGE6slDwGp1s56XFcGNg4R0+5P8yk
 XGkQRKfKw+t0Cte0ifzv15/5tF2IMUpzFDdEhxB8YDbwc7mxKPjMic6tI2peEFqHIRhmuhE4v6
 8lfBwcvrKvYC4ejf1gLlSDcJOzpvuepROGOWAmUnXqAuz8LXKyvIvcqx/Y8Mmbiu9ph2T9d+E6
 pD+RjH4MHrKGt0eP61K37VY31LlA4kRFfnGxvB5Gl3rys+oB/vJ1rR5NCTnTsyJovk6aFe+Zro
 55AkTHlQUEHk+b7mDG8NeCvA
X-IronPort-AV: E=Sophos;i="5.87,213,1631602800"; 
   d="scan'208";a="75559099"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2021 00:56:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 6 Nov 2021 00:56:20 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 6 Nov 2021 00:56:18 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <Alexander.Stein@tq-group.com>, <michael@walle.cc>,
        <p.yadav@ti.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 0/2] mtd: spi-nor: Erase fixes
Date:   Sat, 6 Nov 2021 09:56:14 +0200
Message-ID: <20211106075616.95401-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depends on:
https://lore.kernel.org/all/20211029172633.886453-19-tudor.ambarus@microchip.com/T/

Tudor Ambarus (2):
  mtd: spi-nor: Fix shift-out-of-bounds
  mtd: spi-nor: Skip erase logic when SPI_NOR_NO_ERASE is set

 drivers/mtd/spi-nor/core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

-- 
2.25.1

