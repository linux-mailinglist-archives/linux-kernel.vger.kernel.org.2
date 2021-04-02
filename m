Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1EF35269A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 08:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhDBGif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 02:38:35 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:46487 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbhDBGie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 02:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617345513; x=1648881513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OoX4cNeKEIkkiFfvhPIvQVOX3Xtu6YxWKxsj4cFR3BA=;
  b=dGhLqzU22cvHT+531+HLyZM++hoDrRGAMN1FXCWdfbVgqxaAl7jmA/So
   0I2lKfcDbN5eTSLmlYN+4KYn4eegK0Ea+QX4y54VDhAU+2hrfHLaiXuco
   CCj0PUyab/cMtmxt8KX6ebXNJ2SZiAzFVE9aS8Y+igog07XBBkrPsqCn+
   BH92yabA6TCPdpcTTg2PFgAaic92LzIhHHwp0SqmM05Ub402JtLNHv5s5
   Br2zxG+LyUW6pmMt1xECeSXAwZQVCjGUA+QBlvZxo0Y+5/XuWtAwo4u2s
   WVsrmq1KJhO4okxJWac1lPCFD/4rbPKWNT+Zh7LpujqC5IN+zCjadFlPt
   w==;
IronPort-SDR: jdxJBQSii9C3nvRn0FXiC8+fWtAILLvX9RCn0YS/e585v9+w0qGtZzhlNtvx36R/jGAHk1UsZ2
 5O0HJ8RQkcYmY0IBlVdGD0qPRaJyYFNbvm9X8Zhdm+wOqXrzYifB2aVMP1lJFStyhEVzCuQO2a
 WDPFpy1uEMFQFqwK7TrsE8TEcsEtctrB4m6Ycs8hsAvmEWOR9niqw5QS0/8y/L80+FXhWBgcGT
 nIB3W08QK4OwrxtcL9erQ3fez0vDL3cYyJUqamIn7mfc0aUNzjmumRu9bcTVywtEb1ik53Bmde
 gS8=
X-IronPort-AV: E=Sophos;i="5.81,299,1610434800"; 
   d="scan'208";a="49777315"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Apr 2021 23:38:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 23:38:33 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 1 Apr 2021 23:38:30 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vigneshr@ti.com>, <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>, <p.yadav@ti.com>
CC:     <miquel.raynal@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v3 0/2] mtd: spi-nor: Cleanup patches
Date:   Fri, 2 Apr 2021 09:38:25 +0300
Message-ID: <161734495497.5882.9424697028347909012.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322075131.45093-1-tudor.ambarus@microchip.com>
References: <20210322075131.45093-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2021 09:51:29 +0200, Tudor Ambarus wrote:
> Various cleanup patches done while reviewing contributions.
> 
> Tudor Ambarus (2):
>   mtd: spi-nor: Move Software Write Protection logic out of the core
>   mtd: spi-nor: swp: Improve code around spi_nor_check_lock_status_sr()
> 
>  drivers/mtd/spi-nor/Makefile |   2 +-
>  drivers/mtd/spi-nor/core.c   | 406 +--------------------------------
>  drivers/mtd/spi-nor/core.h   |   4 +
>  drivers/mtd/spi-nor/swp.c    | 427 +++++++++++++++++++++++++++++++++++
>  4 files changed, 435 insertions(+), 404 deletions(-)
>  create mode 100644 drivers/mtd/spi-nor/swp.c

Applied to spi-nor/next, thanks!

[1/2] mtd: spi-nor: Move Software Write Protection logic out of the core
      https://git.kernel.org/mtd/c/c4c795105f29
[2/2] mtd: spi-nor: swp: Improve code around spi_nor_check_lock_status_sr()
      https://git.kernel.org/mtd/c/b6cbd9167d44

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
