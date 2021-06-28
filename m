Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198993B6424
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbhF1PFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236281AbhF1OrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 10:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624891476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=npbGF2ULVa7eofab+6oK3y2vWHP2r2nG679/RfmMcPI=;
        b=bBiL137sbpKfmDuYquSVrTZvVYPvD1Iyq2tR1wOWMgU7Y5AvikInDN2xec8XQMwTXLoF65
        ihCg0A6lPnLsokdFnmChGA+z/+jNXD+FwtDVRxbEpf+VWDXGvJ5S8WFnGC+VQ2+kJVSRkV
        RzL/M9jh7qPOKdYh+j+rzEePXy/2my0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-N5n7t7WuNZuhb0i3eb80tw-1; Mon, 28 Jun 2021 10:44:34 -0400
X-MC-Unique: N5n7t7WuNZuhb0i3eb80tw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4113D362FE;
        Mon, 28 Jun 2021 14:44:33 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-168.ams2.redhat.com [10.36.113.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E5765C1D0;
        Mon, 28 Jun 2021 14:44:27 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com,
        linux-kernel@vger.kernel.org, mihai.carabas@oracle.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, pizhenwei@bytedance.com,
        andriy.shevchenko@linux.intel.com, pbonzini@redhat.com,
        joe@perches.com
Subject: [PATCH] misc/pvpanic-pci: Allow automatic loading
Date:   Mon, 28 Jun 2021 16:44:22 +0200
Message-Id: <20210628144422.895526-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pvpanic-pci driver does not auto-load and requires manual
modprobe. Let's include a device database using the
MODULE_DEVICE_TABLE macro.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
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

