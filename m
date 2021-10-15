Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081A542FC1A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 21:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242718AbhJOT25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 15:28:57 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:58433 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbhJOT2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 15:28:54 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id EF65ED6788
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 19:21:47 +0000 (UTC)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 257CCC0002;
        Fri, 15 Oct 2021 19:21:26 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] rtc: add alarm related features
Date:   Fri, 15 Oct 2021 21:21:14 +0200
Message-Id: <20211015192121.817642-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015192121.817642-1-alexandre.belloni@bootlin.com>
References: <20211015192121.817642-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct and add alarm related features to be declared by drivers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 include/uapi/linux/rtc.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/rtc.h b/include/uapi/linux/rtc.h
index f950bff75e97..60ea711b1843 100644
--- a/include/uapi/linux/rtc.h
+++ b/include/uapi/linux/rtc.h
@@ -113,8 +113,10 @@ struct rtc_pll_info {
 /* feature list */
 #define RTC_FEATURE_ALARM		0
 #define RTC_FEATURE_ALARM_RES_MINUTE	1
-#define RTC_FEATURE_NEED_WEEK_DAY	2
-#define RTC_FEATURE_CNT			3
+#define RTC_FEATURE_ALARM_RES_2S	2
+#define RTC_FEATURE_UPDATE_INTERRUPT	3
+#define RTC_FEATURE_NEED_WEEK_DAY	4
+#define RTC_FEATURE_CNT			5
 
 #define RTC_MAX_FREQ	8192
 
-- 
2.31.1

