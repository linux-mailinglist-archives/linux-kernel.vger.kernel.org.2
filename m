Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7032D31020E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhBEBD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 20:03:59 -0500
Received: from o1.ptr2625.egauge.net ([167.89.112.53]:47945 "EHLO
        o1.ptr2625.egauge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbhBEBD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 20:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
        h=from:subject:in-reply-to:references:mime-version:to:cc:
        content-transfer-encoding:content-type;
        s=sgd; bh=IEPAMvsErF4on0w4c1/wgnmJi3zDMaCh4y9Z0aEAvOM=;
        b=ZajNt/Y6zgOVfr5GOtkeE1LTSFwhGtI0bUaJey2ABDTeWgbgucdj2z9btQZoD/tn0zsl
        uCWuYVqbbQ+nGzYrs4sgrWotj/OnmaZ9DFuUjCip1PYeoeC9HJjQZCLDptMI26f5BWWl6G
        wlda27dung+Wl4cpCMnpBAkLbJent9YFU=
Received: by filterdrecv-p3iad2-558d65d586-7gjw2 with SMTP id filterdrecv-p3iad2-558d65d586-7gjw2-19-601C992E-18
        2021-02-05 01:02:38.233796266 +0000 UTC m=+112947.447761158
Received: from pearl.egauge.net (unknown)
        by ismtpd0010p1las1.sendgrid.net (SG) with ESMTP
        id TMRlEBKZSce7_ScTsGDFLg
        Fri, 05 Feb 2021 01:02:37.941 +0000 (UTC)
Received: by pearl.egauge.net (Postfix, from userid 1000)
        id 097907004FD; Thu,  4 Feb 2021 18:02:37 -0700 (MST)
From:   David Mosberger-Tang <davidm@egauge.net>
Subject: [PATCH] lib: crc-itu-t: Fix typo in comment
Date:   Fri, 05 Feb 2021 01:02:38 +0000 (UTC)
Message-Id: <20210205010232.478567-1-davidm@egauge.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0e0976ef-42a1-880d-2ec0-d22632004ff9@infradead.org>
References: <0e0976ef-42a1-880d-2ec0-d22632004ff9@infradead.org>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvEYRpSGuc32+HP5az?=
 =?us-ascii?Q?cPh0zejqTf3rrA9K6rN=2F3f3Mgi2V9dQ+VULZZ6t?=
 =?us-ascii?Q?UT9emp2gVT1=2FMs5Loa3mnMXcaoSlso695QcbzNz?=
 =?us-ascii?Q?cCYPQq8Wlp7MzwkTMpxFE1lQbhBGwem24KtlEYg?=
 =?us-ascii?Q?f6ZbhNTaAcIu2rlPeGI3GLSIFWkW3Bko89zUln1?=
 =?us-ascii?Q?siJ0GxoeSlCuaZkxf6m7g=3D=3D?=
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
index 1974b355c148..1d26a1647da5 100644
--- a/lib/crc-itu-t.c
+++ b/lib/crc-itu-t.c
@@ -7,7 +7,7 @@
 #include <linux/module.h>
 #include <linux/crc-itu-t.h>
 
-/** CRC table for the CRC ITU-T V.41 0x1021 (x^16 + x^12 + x^15 + 1) */
+/* CRC table for the CRC ITU-T V.41 0x1021 (x^16 + x^12 + x^5 + 1) */
 const u16 crc_itu_t_table[256] = {
 	0x0000, 0x1021, 0x2042, 0x3063, 0x4084, 0x50a5, 0x60c6, 0x70e7,
 	0x8108, 0x9129, 0xa14a, 0xb16b, 0xc18c, 0xd1ad, 0xe1ce, 0xf1ef,
-- 
2.25.1

