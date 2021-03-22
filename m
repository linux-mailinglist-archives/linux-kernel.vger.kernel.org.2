Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5498343AED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhCVHxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:53:06 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:40063 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhCVHw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1616399547; x=1647935547;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GHbviN382mS0WFoielS1QhqNDpObeQ8Ts5XNId4GLX8=;
  b=qEtuFmjuoLL+i8kQCiaZrMYNYwEB99IS3EF+irqF/q1IJqeL5JY2KX/G
   QEDFew5u3HAo/pW9123R2RJ4D0TINq2qCrbI0nNaWk1ulPjBeb4hLPedF
   Uuutc9Uwe/QlOF2cMq2UUnv9D0woND/6/6gL7bfUrLf+HvgNdsXu4k22C
   9vRufDHsUvfxyjLtFXiHkf69eA9T9mjP3APUG3uWNkogYd9sEiuprvjzm
   +tIcLiQhDNB0SFpwij0RJ4RcoR1pLlCg5lZ8B5XNHNUGZ9FmVAjiw56KO
   C7+2W4KcgJmYlvuV9oZZTzWlZf5Wjw1WgQpOuyDCLGCdubP9zwjUoDxTQ
   g==;
IronPort-SDR: 9ff6a23kY5W7Z85zPDzRHIKAul0wJWYoclkOlwUKUKIunxCI+MsdKKsxrn7CTrrTiljAjM7lLU
 xt4BIhpsDIEd42bSqEMO6iUCvDpZ1UfAsJHPU6f+RGmpgfM5k5WSkien4R18znfLges0YvUZ2n
 gXEDWVuom+htD+PXBOOUmjUvktzPMhrQCY3fg1ANNkfMebT4oEXOTHtbeLidcrAMXBo4B6Oe15
 Br1s+U75b+Za9A8V2dLyNAY5pxzl/E/0psYcMJ5jVcArQldx22J7qkhOEUrSBUD9hiKdJkYG0s
 0EA=
X-IronPort-AV: E=Sophos;i="5.81,268,1610434800"; 
   d="scan'208";a="113597878"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Mar 2021 00:51:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 22 Mar 2021 00:51:35 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 22 Mar 2021 00:51:33 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vigneshr@ti.com>, <michael@walle.cc>, <p.yadav@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v3 0/2] mtd: spi-nor: Cleanup patches
Date:   Mon, 22 Mar 2021 09:51:29 +0200
Message-ID: <20210322075131.45093-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various cleanup patches done while reviewing contributions.

Tudor Ambarus (2):
  mtd: spi-nor: Move Software Write Protection logic out of the core
  mtd: spi-nor: swp: Improve code around spi_nor_check_lock_status_sr()

 drivers/mtd/spi-nor/Makefile |   2 +-
 drivers/mtd/spi-nor/core.c   | 406 +--------------------------------
 drivers/mtd/spi-nor/core.h   |   4 +
 drivers/mtd/spi-nor/swp.c    | 427 +++++++++++++++++++++++++++++++++++
 4 files changed, 435 insertions(+), 404 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/swp.c

-- 
2.25.1

