Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D663B25BE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 05:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFXD7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 23:59:40 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:60944 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhFXD7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 23:59:38 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 15O3gSQj076749;
        Thu, 24 Jun 2021 11:42:28 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Jun
 2021 11:57:15 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <linux-hwmon@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH] hwmon: (aspeed-pwm-tacho) Using falling edge.
Date:   Thu, 24 Jun 2021 11:58:21 +0800
Message-ID: <20210624035821.25375-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 15O3gSQj076749
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tach shouldn't use both edges to measure. When the tach input
duty cycle isn't 50% the return value will inaccurate.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/hwmon/aspeed-pwm-tacho.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index 3d8239fd66ed..0a70a0e22acf 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -158,7 +158,7 @@
  * 10: both
  * 11: reserved.
  */
-#define M_TACH_MODE 0x02 /* 10b */
+#define M_TACH_MODE 0x00 /* 10b */
 #define M_TACH_UNIT 0x0210
 #define INIT_FAN_CTRL 0xFF
 
-- 
2.25.1

