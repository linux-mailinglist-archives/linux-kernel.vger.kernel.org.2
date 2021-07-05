Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505393BC0C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 17:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhGEPha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 11:37:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233018AbhGEPfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 11:35:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A37C8619C4;
        Mon,  5 Jul 2021 15:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625499094;
        bh=yoEupvIG13rkSPCBNt/1/0a+R8uCASg4mOmdBqM7PQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Opu2/lY0pAvFfhkTkELfuQWpGsky3ZAe0S2Fq6HfM+4diLGUv6tq0RdXG1SreAuwJ
         QYg1n3xtAvJUCEAOBLLMtyHkiHmJEYdc8CFQ6PQrEJq1JXNMNlSAK7mGa3Avhd8dw6
         1P/BhQXx4ltNwawekQviuJo5qtAu5VvVKWqeBEy5Ad04/RzX+B2xUs2iwglX+ATPaq
         kPte1doUEfoSu699TM4baQqqL/q9N/cDExKbeG8HT97LGTwPX9QEoRfF6NP4dhRPjY
         YzdvgjHdTK7zShOLWKOgRWeUsGhrrNDLad7d5GLNHG49SScrVGhzXnAl6ZCUc3qqKf
         ydRpcbUH2lhqQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jason Gerecke <killertofu@gmail.com>,
        Jason Gerecke <jason.gerecke@wacom.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 16/17] HID: wacom: Correct base usage for capacitive ExpressKey status bits
Date:   Mon,  5 Jul 2021 11:31:12 -0400
Message-Id: <20210705153114.1522046-16-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210705153114.1522046-1-sashal@kernel.org>
References: <20210705153114.1522046-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gerecke <killertofu@gmail.com>

[ Upstream commit 424d8237945c6c448c8b3f23885d464fb5685c97 ]

The capacitive status of ExpressKeys is reported with usages beginning
at 0x940, not 0x950. Bring our driver into alignment with reality.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/wacom_wac.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 46da97162ef4..0abed1e5b526 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -126,7 +126,7 @@
 #define WACOM_HID_WD_TOUCHONOFF         (WACOM_HID_UP_WACOMDIGITIZER | 0x0454)
 #define WACOM_HID_WD_BATTERY_LEVEL      (WACOM_HID_UP_WACOMDIGITIZER | 0x043b)
 #define WACOM_HID_WD_EXPRESSKEY00       (WACOM_HID_UP_WACOMDIGITIZER | 0x0910)
-#define WACOM_HID_WD_EXPRESSKEYCAP00    (WACOM_HID_UP_WACOMDIGITIZER | 0x0950)
+#define WACOM_HID_WD_EXPRESSKEYCAP00    (WACOM_HID_UP_WACOMDIGITIZER | 0x0940)
 #define WACOM_HID_WD_MODE_CHANGE        (WACOM_HID_UP_WACOMDIGITIZER | 0x0980)
 #define WACOM_HID_WD_MUTE_DEVICE        (WACOM_HID_UP_WACOMDIGITIZER | 0x0981)
 #define WACOM_HID_WD_CONTROLPANEL       (WACOM_HID_UP_WACOMDIGITIZER | 0x0982)
-- 
2.30.2

