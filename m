Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465FF330806
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 07:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbhCHGUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 01:20:35 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:19309 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbhCHGU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615184428; x=1646720428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cNUFkLLEIoqMFqJYVsIH5x0g/HfTKJzj54C+4PKLThg=;
  b=eZrMAk1MO8A1crcrcsiT83lyhot9n7/JJfFubARBuvFAe5sta6orDGol
   GEnObT4j0lt0j5COVLAChL5/Y281BAY3ZZhY4+t++E2jKkXEDuSqsNWfS
   ELQyeDSW1FdA14jQBfqk9HBblNg1iVxtX7g0868F+3wJSLO4vgrNzHqIj
   2TCVF1qZwY7teIaT/K3nM+0+wwO+Hfef2oJSCatdlX4exj9pnBIMFIQ5p
   PTXM9ZXeh9Jls2b8IwNrRlDXVWJTLAleMdmtoZCHMHKIn92pQLaWKY0as
   V7kCIbFERTANhQzlgs+QEdBhnXhEQiuapMYgalYU6RW4vAgcm/zhser3T
   g==;
IronPort-SDR: aX6ADHPrVJgGoouxDLpihNnVrEy9CnJZ98dVe27lxuws4xFq/CU+TasJHDh3PcmY8F0e5g+Rei
 Zj6W8u5y70V26DGMrcM3mxNajvNOIrW2zgCbnoY/yDRnqT1RveoUuACy1wftxSWBGULJDRyx7w
 6Q1MabkGlTERjouHkBO2+6Y4ZjsykEm3HqJ8zIMwmt+jBZ9EtIK+KKbo84qaTUhHWYK/ekhAlC
 N9tErH0dHFo0rlmFJfLgS9GCPJopC702GouQoV40tHAQN1QTBdijGZHPJI1yE1nut6VT6t5BvS
 aq0=
X-IronPort-AV: E=Sophos;i="5.81,231,1610434800"; 
   d="scan'208";a="46622120"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2021 23:20:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 7 Mar 2021 23:20:28 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Sun, 7 Mar 2021 23:20:26 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        "Michael Walle" <michael@walle.cc>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Vignesh Raghavendra" <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: use is_power_of_2()
Date:   Mon, 8 Mar 2021 08:20:24 +0200
Message-ID: <161518441282.69910.7961092195039294624.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305234552.19204-1-michael@walle.cc>
References: <20210305234552.19204-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Mar 2021 00:45:52 +0100, Michael Walle wrote:
> There is already a function to check if an integer is a power of 2. Use
> it.

Applied to spi-nor/next, thanks!

[1/1] mtd: spi-nor: use is_power_of_2()
      https://git.kernel.org/mtd/c/04fc298c7d08

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
