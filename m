Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50D03DC599
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 12:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhGaKli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 06:41:38 -0400
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:43536 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232182AbhGaKlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 06:41:36 -0400
Received: from MTA-10-4.privateemail.com (mta-10-1.privateemail.com [68.65.122.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 5B5CC800E0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 06:41:29 -0400 (EDT)
Received: from mta-10.privateemail.com (localhost [127.0.0.1])
        by mta-10.privateemail.com (Postfix) with ESMTP id 3F25918000B6;
        Sat, 31 Jul 2021 06:41:28 -0400 (EDT)
Received: from localhost.localdomain (unknown [10.20.151.234])
        by mta-10.privateemail.com (Postfix) with ESMTPA id E444518000AE;
        Sat, 31 Jul 2021 06:41:26 -0400 (EDT)
From:   Jordy Zomer <jordy@pwning.systems>
To:     linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jordy Zomer <jordy@pwning.systems>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH] firewire: ohci: make reg_(read|write) unsigned
Date:   Sat, 31 Jul 2021 12:41:12 +0200
Message-Id: <20210731104112.512449-1-jordy@pwning.systems>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reg_(read|write) functions used to
take a signed integer as an offset parameter.
The callers of this function only pass an unsigned integer to it.
Therefore to make it obviously safe, let's just make this an unsgined
integer as this is used in pointer arithmetics.

Signed-off-by: Jordy Zomer <jordy@pwning.systems>
---
 drivers/firewire/ohci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 17c9d825188b..0119aa9cbc7c 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -524,12 +524,12 @@ static void log_ar_at_event(struct fw_ohci *ohci,
 	}
 }
 
-static inline void reg_write(const struct fw_ohci *ohci, int offset, u32 data)
+static inline void reg_write(const struct fw_ohci *ohci, u32 offset, u32 data)
 {
 	writel(data, ohci->registers + offset);
 }
 
-static inline u32 reg_read(const struct fw_ohci *ohci, int offset)
+static inline u32 reg_read(const struct fw_ohci *ohci, u32 offset)
 {
 	return readl(ohci->registers + offset);
 }
-- 
2.27.0

