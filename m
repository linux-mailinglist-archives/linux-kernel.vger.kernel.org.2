Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393BE3675DA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 01:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244160AbhDUXmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 19:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232353AbhDUXmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 19:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619048522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lYWmA1IVqQm1Tc92b7ofSSX1Uc8jPsQyYwpqd2nV+74=;
        b=PPcrsdirLsFb/7V6PO2HcHCevBp9AYOFGTMS/Bcqamdpg4U9qhafsGpweWCiqDeveHyb2a
        DGM3dZmPGHOfdnGGSlqszb5oXbR89GG0t+MojulpsU/Z2XPyrvpYxsROMZmbzIIiNH1N+p
        zhLpIrF3+g5Mn47efdp0P3UcWGqVZBw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-Wg7NUV9DOG2ggYvcbVzqcA-1; Wed, 21 Apr 2021 19:42:00 -0400
X-MC-Unique: Wg7NUV9DOG2ggYvcbVzqcA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 079168030A1;
        Wed, 21 Apr 2021 23:41:59 +0000 (UTC)
Received: from rtux.redhat.com (unknown [10.33.36.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF97E19D80;
        Wed, 21 Apr 2021 23:41:57 +0000 (UTC)
From:   Alexey Klimov <aklimov@redhat.com>
To:     thomas@weissschuh.net
Cc:     hdegoede@redhat.com, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: gigabyte-wmi: add support for B550M AORUS PRO-P
Date:   Thu, 22 Apr 2021 00:41:56 +0100
Message-Id: <20210421234156.3942343-1-aklimov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Klimov <klimov.linux@gmail.com>

From: Alexey Klimov <klimov.linux@gmail.com>

Add the B550M AORUS PRO-P motherboard description to
gigabyte_wmi_known_working_platforms.

Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>
---

The driver works fine on this motherboard with force_load=1 and
it seems that temperature values are correct.

gigabyte_wmi-virtual-0
Adapter: Virtual device
temp1:        +30.0°C  
temp2:        +35.0°C  
temp3:        +30.0°C  
temp4:        +32.0°C  
temp5:        +28.0°C  
temp6:        +42.0°C

The patch is created against review-hans branch on platform-drivers-x86.git
I am available for further testing on this board if required, feel free
to reach me. Thanks.

 drivers/platform/x86/gigabyte-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
index e127a2077bbc..13d57434e60f 100644
--- a/drivers/platform/x86/gigabyte-wmi.c
+++ b/drivers/platform/x86/gigabyte-wmi.c
@@ -138,6 +138,10 @@ static const struct dmi_system_id gigabyte_wmi_known_working_platforms[] = {
 		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
 		DMI_EXACT_MATCH(DMI_BOARD_NAME, "B550 GAMING X V2"),
 	}},
+	{ .matches = {
+		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
+		DMI_EXACT_MATCH(DMI_BOARD_NAME, "B550M AORUS PRO-P"),
+	}},
 	{ .matches = {
 		DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
 		DMI_EXACT_MATCH(DMI_BOARD_NAME, "B550M DS3H"),
-- 
2.31.1

