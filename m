Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0668D3F14B9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbhHSIBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:01:49 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:45915 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236952AbhHSIBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:01:47 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 17J7gPT1024041;
        Thu, 19 Aug 2021 15:42:25 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from ChiaWeiWang-PC.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 19 Aug
 2021 16:00:37 +0800
From:   Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To:     <joel@jms.id.au>, <robh+dt@kernel.org>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ryan_chen@aspeedtech.com>
Subject: [PATCH v2 3/5] clk: aspeed: Add eSPI reset bit
Date:   Thu, 19 Aug 2021 16:00:38 +0800
Message-ID: <20210819080040.31242-4-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210819080040.31242-1-chiawei_wang@aspeedtech.com>
References: <20210819080040.31242-1-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 17J7gPT1024041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bit field definition for the eSPI reset control

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 include/dt-bindings/clock/ast2600-clock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
index 62b9520a00fd..964934b1caef 100644
--- a/include/dt-bindings/clock/ast2600-clock.h
+++ b/include/dt-bindings/clock/ast2600-clock.h
@@ -89,6 +89,7 @@
 #define ASPEED_CLK_MAC4RCLK		70
 
 /* Only list resets here that are not part of a gate */
+#define ASPEED_RESET_ESPI		57
 #define ASPEED_RESET_ADC		55
 #define ASPEED_RESET_JTAG_MASTER2	54
 #define ASPEED_RESET_I3C_DMA		39
-- 
2.17.1

