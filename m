Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677E43A9C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 15:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhFPNw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 09:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbhFPNwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 09:52:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6A5C061574;
        Wed, 16 Jun 2021 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Uuuw+EDFBfHtUMgcBMPNTshRzz5rBLJMAuak5V48lNU=; b=qaqnCkDXikQQBHKgCwgIp11kIy
        2ueiMB+Y0zbmFHTfaBG9LRfpZbgfNtkA5Q7qKMbXAOLHSSY9rsW3Wf85ytYrY4nIAB4If6RYEvWp6
        UV1NsPXMrvphdW/xoLmZw1vNDMgUPkrsGohQ9DQvqkNz9L06lyofIjHzEZskRnHLfOolctVu1R7J5
        zP6qO4qpbgevda75Lh/N7aJVVZODUeeRS9PJxHMBlRk3I16UwzgRQTMZ9Nhg3YndYXfnnw76+fWLe
        J+dDaT2q8blTLTXAIQcZ5q39iE094tXk6KQb7Q2DxP6L1t7g3NnUa9U2DXmuQTcO+8KtvXxgXIR5i
        dg29zMYQ==;
Received: from [2001:4bb8:19b:fdce:84d:447:81f0:ca60] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltVud-00863t-Nm; Wed, 16 Jun 2021 13:49:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 4/6] ARM: disable CONFIG_IDE in pxa_defconfig
Date:   Wed, 16 Jun 2021 15:46:56 +0200
Message-Id: <20210616134658.1471835-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616134658.1471835-1-hch@lst.de>
References: <20210616134658.1471835-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pxa_defconfig already enables libata including the pata_pcmcia driver, so
drop the legacy ide driver and idecs host driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/configs/pxa_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 875a3c28a267..363f1b1b08e3 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -215,8 +215,6 @@ CONFIG_IIO=m
 CONFIG_AD5446=m
 CONFIG_EEPROM_AT24=m
 CONFIG_SENSORS_LIS3_SPI=m
-CONFIG_IDE=m
-CONFIG_BLK_DEV_IDECS=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=m
 CONFIG_CHR_DEV_ST=m
-- 
2.30.2

