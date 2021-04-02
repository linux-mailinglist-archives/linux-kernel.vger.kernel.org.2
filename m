Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A466535275C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 10:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbhDBIUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 04:20:39 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:41123 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbhDBIUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 04:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617351637; x=1648887637;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TWyPo3vF+CgtD3+SApEjDL8YDDwtxlPAN0yQZktdQyM=;
  b=YNRQT+Z4RGXAEXfbOekhIITUTmMrraMsswV5w44VvmPMQ1bSFzYnd8x1
   pw5oiqD0dunzUkjkK5zfL//FFFb5JcP2TpLsJOLT87WzAoZbW+pCTcFdh
   7ITURBQdOfK217w6F/p9/BYpooj88Piqj/UPBU73eR+asatuCzJt565Aa
   sGPW7VimEYSnZJOw9bmhccwGW5Qdlnt+6M6UMlo35G2kNcUon9A2Tqjwt
   KfMCaW5rBDLCEdZi1k4ZK3Yut9RcPR6SxVb53uJvJO49MqiWv08lj9jsg
   1Q/eMoQnjXMyHq7M1CIErcfSIfYiQtDFhn8/AUAPBTy/zIaoKzwYuHI/v
   g==;
IronPort-SDR: NTVQWnH0u/4LOtgRxo8oUN4t9QDWL/Y7V7dEXibvAvmRa5yT0YE2GgZdBGK2gbW/FW6WdbUYcF
 9BdYuce1ldccR9Qnmnahwq0YQYaRyFtSvXIkkFvkhPj8kvPynmwSPNjrLkND+WU7IUD/d3aIYW
 9zidqQaPVeFwvRHIDLdOX1K+7Cufp5S0qnfJHcj7eQH5IObdkEkqLX48AWgnX0Ng7Tq3em8wwD
 J8fKl/2PDKPCa8unu3uwBmNcNBqA/oJw+9VKjhH1XWWJeyZ9iceYDQ/uoPuWSbht4EnlxRu3ZM
 0qw=
X-IronPort-AV: E=Sophos;i="5.81,299,1610434800"; 
   d="scan'208";a="121543218"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Apr 2021 01:20:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Apr 2021 01:20:36 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 2 Apr 2021 01:20:32 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>, <vigneshr@ti.com>,
        <masonccyang@mxic.com.tw>, <zhengxunli@mxic.com.tw>,
        <ycllin@mxic.com.tw>, <juliensu@mxic.com.tw>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 0/2] mtd: spi-nor: macronix: mx25l51245g, mx66l51235l and mx66l51235f
Date:   Fri, 2 Apr 2021 11:20:29 +0300
Message-ID: <20210402082031.19055-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mx25l51245g and mx66l51235l have the same flash ID. The flash
detection returns the first entry in the flash_info array that
matches the flash ID that was read, thus for the 0xc2201a ID,
mx25l51245g was always hit, introducing a regression for
mx66l51235l. Revert mx25l51245g addition. A solution for these
flashes to coexist was proposed.

According to macronix website, there is no mx66l51235l part number.
Rename the part to mx66l51235f.

The difference betwenn mx25l51245g and mx66l51235f flash_info entries
was that mx25l51245g also set SECT_4K. Both flashes support 4K erases,
but the 4K erase should be discovered when parsing BFPT, so there's
no need to set the explicit SECT_4K flag.

Tudor Ambarus (2):
  Revert "mtd: spi-nor: macronix: Add support for mx25l51245g"
  mtd: spi-nor: macronix: Fix name for mx66l51235f

 drivers/mtd/spi-nor/macronix.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

-- 
2.25.1

