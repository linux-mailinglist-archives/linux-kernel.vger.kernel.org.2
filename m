Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495CC3B6EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 09:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhF2HZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 03:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57838 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232182AbhF2HY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 03:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624951350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fi/7Qx2yln55j8zBjq30/tL733tojfBq2QD0UYX+4+s=;
        b=XANzJSyxero02BBSBfecMlZlWyOIaZCEyyKSu0qStRk/NgJVdovw0TrcOU9OuHF2lueHnv
        MwX/E1mhYoN/9AzXOuZd0UaHXN73MgnnZoGytKHW3JIhHm7TNzP8D4JPu6UlVJDzFox38S
        EfaWxG4aFx+SAL+sFNOfBtuXSKEK1hc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-7W97HWoRMweEThjS2c5Ejg-1; Tue, 29 Jun 2021 03:22:28 -0400
X-MC-Unique: 7W97HWoRMweEThjS2c5Ejg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA70B804158;
        Tue, 29 Jun 2021 07:22:26 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-168.ams2.redhat.com [10.36.113.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AA4C60854;
        Tue, 29 Jun 2021 07:22:20 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org, mihai.carabas@oracle.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com
Cc:     arnd@arndb.de, pizhenwei@bytedance.com, pbonzini@redhat.com,
        joe@perches.com, drjones@redhat.com
Subject: [PATCH v2] misc/pvpanic-pci: Allow automatic loading
Date:   Tue, 29 Jun 2021 09:22:14 +0200
Message-Id: <20210629072214.901004-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The virtual machine monitor (QEMU) exposes the pvpanic-pci
device to the guest. On guest side the module exists but
currently isn't loaded automatically. So the driver fails
to be probed and does not its job of handling guest panic
events.

Instead of requiring manual modprobe, let's include a device
database using the MODULE_DEVICE_TABLE macro and let the
module auto-load when the guest gets exposed with such a
pvpanic-pci device.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- enhance the commit message with additional info (Greg, Andy)
---
 drivers/misc/pvpanic/pvpanic-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
index 9ecc4e8559d5d..30290d42d8aa8 100644
--- a/drivers/misc/pvpanic/pvpanic-pci.c
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -122,4 +122,6 @@ static struct pci_driver pvpanic_pci_driver = {
 	},
 };
 
+MODULE_DEVICE_TABLE(pci, pvpanic_pci_id_tbl);
+
 module_pci_driver(pvpanic_pci_driver);
-- 
2.26.3

