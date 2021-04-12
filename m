Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6B535C27A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241553AbhDLJpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:45:03 -0400
Received: from netsrv01.beckhoff.com ([62.159.14.10]:59547 "EHLO
        netsrv01.beckhoff.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238945AbhDLJVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:21:04 -0400
X-Greylist: delayed 899 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Apr 2021 05:21:03 EDT
Received: from 10.1.0.27 by netsrv01.beckhoff.com (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey256); Mon, 12 Apr 2021 09:05:47 GMT
Received: from localhost.localdomain (172.17.204.1) by NT-Mail02.beckhoff.com
 (10.1.0.27) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 12 Apr 2021
 11:05:43 +0200
From:   Steffen Dirkwinkel <linux-kernel-dev@beckhoff.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
Subject: [PATCH] platform/x86: pmc_atom: Match all Beckhoff Automation baytrail boards with critclk_systems DMI table
Date:   Mon, 12 Apr 2021 11:04:31 +0200
Message-ID: <20210412090430.167463-1-linux-kernel-dev@beckhoff.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.17.204.1]
X-OLX-Disclaimer: Done
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

pmc_plt_clk* clocks are used for ethernet controllers so need to stay
turned on. This adds the affected board family to critclk_systems DMI
table so the clocks are marked as CLK_CRITICAL and not turned off.

This replaces the previosly listed boards with a match for the whole
device family. There are new affected boards that would otherwise need
to be listed. There are only few unaffected boards in the family and
having the clocks turned on is not an issue on those.

Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 drivers/platform/x86/pmc_atom.c | 28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index ca684ed760d1..a9d2a4b98e57 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -393,34 +393,10 @@ static const struct dmi_system_id critclk_systems[] = {
 	},
 	{
 		/* pmc_plt_clk* - are used for ethernet controllers */
-		.ident = "Beckhoff CB3163",
+		.ident = "Beckhoff Baytrail",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),
-			DMI_MATCH(DMI_BOARD_NAME, "CB3163"),
-		},
-	},
-	{
-		/* pmc_plt_clk* - are used for ethernet controllers */
-		.ident = "Beckhoff CB4063",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),
-			DMI_MATCH(DMI_BOARD_NAME, "CB4063"),
-		},
-	},
-	{
-		/* pmc_plt_clk* - are used for ethernet controllers */
-		.ident = "Beckhoff CB6263",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),
-			DMI_MATCH(DMI_BOARD_NAME, "CB6263"),
-		},
-	},
-	{
-		/* pmc_plt_clk* - are used for ethernet controllers */
-		.ident = "Beckhoff CB6363",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Beckhoff Automation"),
-			DMI_MATCH(DMI_BOARD_NAME, "CB6363"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "CBxx63"),
 		},
 	},
 	{
-- 
2.31.1
