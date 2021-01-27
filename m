Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2993130505C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 05:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbhA0EDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 23:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbhA0DCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:02:44 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DC0C061793
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 18:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=iT5qrCLArCszES5racsHcDNOM4jlffe8YL9XVjHGO6Y=; b=Ld4BxNv3RRPJqXRrS9jaAu2UKm
        o6KAsTpPPNbRQZkJxpO4jBYUzC1Uo8EhlsNX5vqoDkCz30SNoROkrzSfXbCJynC2DoPQaMz3d1dj3
        mO+FzJA4p2eNLyGEMAeLqhMJnm3h13C6rbRDej2WwSmqyHhbsI/EEjOPilEdYrUKxviXta3tPgVuY
        ymy3TTRY2ePt8E9vBAMxHctOFgL1pyZW9CHTc8A69SoQkqCDwieHWgp0OyirOaI/UTvpz+DKjahSx
        rsQIBPVVN+02HMdZd+swtCMHSmSgINO02gGtr7Z/Yh7kyM7pLZgk/v3RrZ3xxRe4mk8K/supFdaKs
        si4SGefQ==;
Received: from [2601:1c0:6280:3f0::7650] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4aRs-0002OR-HQ; Wed, 27 Jan 2021 02:20:49 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH RESEND] arm: dts: imx1-pinfunc.h: delete duplicate word
Date:   Tue, 26 Jan 2021 18:20:42 -0800
Message-Id: <20210127022042.25467-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "configurable".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/imx1-pinfunc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/arm/boot/dts/imx1-pinfunc.h
+++ linux-next-20200720/arch/arm/boot/dts/imx1-pinfunc.h
@@ -26,7 +26,7 @@
  *                2 - 0
  *                3 - 1
  *
- * 'pin' is an integer between 0 and 0xbf. i.MX1 has 4 ports with 32 configurable
+ * 'pin' is an integer between 0 and 0xbf. i.MX1 has 4 ports with 32
  * configurable pins each. 'pin' is PORT * 32 + PORT_PIN, PORT_PIN is the pin
  * number on the specific port (between 0 and 31).
  */
