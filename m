Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEABD3101E2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhBEAxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:53:32 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:60872 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhBEAx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:53:29 -0500
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Feb 2021 19:53:28 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:mime-version:to:cc:content-transfer-encoding:
        content-type;
        s=sgd; bh=8wYhsG9ypNZH5/9XVTBlKvQcvO/2qvqhCcX2jmFthdc=;
        b=dc9UddYPMEh96wkWaH6bOADIVi4P1Boi9QDiMC0fsx2yG+CtQiA+UQAz/Jp1rHFsK2Op
        SNlgHszOJYdjOzMVz2q5L2b+/iWSFtU9wP40ShtIy1Y5CmkEeWfx6EA9B6uUmySplNMY2V
        TmZG0D3V1mJujJsIa1acmhYmL+It5xb1c=
Received: by filterdrecv-p3iad2-558d65d586-rsdn8 with SMTP id filterdrecv-p3iad2-558d65d586-rsdn8-18-601C9586-23
        2021-02-05 00:47:02.39069665 +0000 UTC m=+112012.498573789
Received: from pearl.egauge.net (unknown)
        by ismtpd0007p1sjc2.sendgrid.net (SG) with ESMTP
        id 2c_Eb3xcQXWPdSKpYLooDw
        Fri, 05 Feb 2021 00:47:02.152 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id 508F47004FD; Thu,  4 Feb 2021 17:47:01 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH] lib: crc-itu-t: Fix comment in typo
Date:   Fri, 05 Feb 2021 00:47:02 +0000 (UTC)
Message-Id: <20210205004636.477935-1-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvCFRhE7BYVSf24SmS?=
 =?us-ascii?Q?2E0xJZW3hbFHOBvqVZS92iTsV9od+R19uyeQcON?=
 =?us-ascii?Q?ypV7YJgvl6R6JxlipNwnGLArreY3ZCcuu+3JqrU?=
 =?us-ascii?Q?NvWHTCxopubPUNlT7B3C4aVX5W+OoCYLNppunxn?=
 =?us-ascii?Q?mPCrVBEUjbmAB10aBR91kql5FyrBbK0CcNyLRvK?=
 =?us-ascii?Q?SJDnVvImioXGB3xeJVlbQ=3D=3D?=
To:     Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        David Mosberger-Tang <davidm@egauge.net>
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Mosberger-Tang <davidm@egauge.net>
---
 lib/crc-itu-t.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/crc-itu-t.c b/lib/crc-itu-t.c
index 1974b355c148..56e6e0d63d1e 100644
--- a/lib/crc-itu-t.c
+++ b/lib/crc-itu-t.c
@@ -7,7 +7,7 @@
 #include <linux/module.h>
 #include <linux/crc-itu-t.h>
 
-/** CRC table for the CRC ITU-T V.41 0x1021 (x^16 + x^12 + x^15 + 1) */
+/** CRC table for the CRC ITU-T V.41 0x1021 (x^16 + x^12 + x^5 + 1) */
 const u16 crc_itu_t_table[256] = {
 	0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50a5, 0x60c6, 0x70e7,
 	0x8108, 0x9129, 0xa14a, 0xb16b, 0xc18c, 0xd1ad, 0xe1ce, 0xf1ef,
-- 
2.25.1

