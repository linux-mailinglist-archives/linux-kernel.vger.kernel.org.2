Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A771321A53
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhBVO0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:26:02 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:31512 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232278AbhBVORL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 09:17:11 -0500
Received: from tack.localdomain (unknown [77.6.175.183])
        (Authenticated sender: albeu@free.fr)
        by smtp1-g21.free.fr (Postfix) with ESMTPA id 3BAB2B0053B;
        Mon, 22 Feb 2021 15:16:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1614003384;
        bh=TZ9+cDW0kygWpcgAq0mKt1NNqaK39r50gICGvobY+gU=;
        h=From:To:Cc:Subject:Date:From;
        b=XO2LpFyWXAP5Uj3qK+0f0x4QR+eahnABsNwHU9TtNaWkhtDuXHzqPKpAZt2N/ik2l
         Bu3F3SStzWuDVwb5nHC8WVU1l7OrBoy7+rs4/6r+T2GGdz+0lyamOfsHN71VBkTRch
         tNF8+R/k8D2VTDwoeTTU8IKl8b49w1SJ9EItbBWWtOKkaga5LDTFrA2i9FyoDCGCpk
         4L9BeXW3bx48CUsPCjLtXrs1BW4oq8MpXBNUNjkHYf1y5Qu4TlEWt3B2wx2RTeqreR
         cda/MLRyNMMD+khOu2jCZGBBzZZWIVpBuoAvgCvR5hvdr/+TAaACvUxcqiKQnHQusY
         3jZxydHULa5Lw==
From:   Alban Bedel <albeu@free.fr>
To:     Alex Hung <alex.hung@canonical.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH] platform/x86: intel-hid: Support Lenovo ThinkPad X1 Tablet Gen 2
Date:   Mon, 22 Feb 2021 15:15:59 +0100
Message-Id: <20210222141559.3775-1-albeu@free.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like a few other system the Lenovo ThinkPad X1 Tablet Gen 2 miss the
HEBC method, which prevent the power button from working. Add a quirk
to enable the button array on this system family and fix the power
button.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 drivers/platform/x86/intel-hid.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index 2f5b8d09143e..57cc92891a57 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -90,6 +90,13 @@ static const struct dmi_system_id button_array_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP Spectre x2 Detachable"),
 		},
 	},
+	{
+		.ident = "Lenovo ThinkPad X1 Tablet Gen 2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X1 Tablet Gen 2"),
+		},
+	},
 	{ }
 };
 
-- 
2.27.0

