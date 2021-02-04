Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB3130F6D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbhBDPvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:51:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237451AbhBDPuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:50:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 57A4E64F4D;
        Thu,  4 Feb 2021 15:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612453779;
        bh=6TZnOdJ21UcHF95chMIoNnhdjJ6X4cm9Mxwh6puwYtA=;
        h=From:To:Cc:Subject:Date:From;
        b=H2UEbw55ByU/LP1T8ydm5yazIPvj4yfSIhfuwjRkkm0ZjLjoBKwX+ImHktl5QTKEs
         W+sT7806r88aGetpzZX+Iqj6nXy3lPeP2VxRCougE4uWzUeE2PIZh/z5o9PattQO8j
         BYE3VoZkRbqfm13wCFW4LWWqwZX29Zc/ynOvA5L3xkWR8bEg/t+HEMXJ9sPFu2xRSO
         VtP61W6dPpuiMMsQhLsHDewLUNFSPvmYttB/xKZEaBmmXn2yz7VNUwEt+5Ly0KJtwD
         qihDi1/cnqOO3vR1Fh5iUVb/yIuKA9knRmECW4XE0M8QnLjHJGqwUKpCfEFfnn9nNr
         k/Px9MGlD4D5A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <sudeep.holla@arm.com>,
        Kai Stuhlemmer <kai.stuhlemmer@ebee.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: soc: atmel: fix type for same7
Date:   Thu,  4 Feb 2021 16:49:25 +0100
Message-Id: <20210204154934.1880048-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A missing comma caused a build failure:

drivers/soc/atmel/soc.c:196:24: error: too few arguments provided to function-like macro invocation

Fixes: af3a10513cd6 ("drivers: soc: atmel: add per soc id and version match masks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
It is broken in the soc tree at the moment, I can pick up
the fix directly if I get an Ack
---
 drivers/soc/atmel/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index a2967846809f..a490ad7e090f 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -191,7 +191,7 @@ static const struct at91_soc socs[] __initconst = {
 	AT91_SOC(SAME70Q20_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
 		 AT91_CIDR_VERSION_MASK, SAME70Q20_EXID_MATCH,
 		 "same70q20", "same7"),
-	AT91_SOC(SAME70Q19_CIDR_MATCH, AT91_CIDR_MATCH_MASK
+	AT91_SOC(SAME70Q19_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
 		 AT91_CIDR_VERSION_MASK, SAME70Q19_EXID_MATCH,
 		 "same70q19", "same7"),
 	AT91_SOC(SAMS70Q21_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
-- 
2.29.2

