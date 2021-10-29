Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7B944052E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 23:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhJ2V5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 17:57:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231504AbhJ2V5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 17:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635544500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mNrRTixzTKSgKnwsOUkxZe+bVeMeYbHOptQr8o/LpiM=;
        b=dq664kdc0lVOzWwTEhFTfFt3Wfa92t14o+ce39AupPdNzO4e3fYn+6mCdQEcZ5zn5ZjHsq
        EfrKs/itd4Zt7x2eHC7IZ75C/FbXDnUuO4nzIfLf16bBY9GnxL4BzC+EMXpFdDRYyAcHXV
        msphHZTALC4P88D451eeEn5veIeV36k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-r8RENY_rNTukQXHUx0UPUw-1; Fri, 29 Oct 2021 17:54:57 -0400
X-MC-Unique: r8RENY_rNTukQXHUx0UPUw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58B27362F9;
        Fri, 29 Oct 2021 21:54:56 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.8.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C612E5DF56;
        Fri, 29 Oct 2021 21:54:52 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH 5/5] MAINTAINERS: Add sensehat driver authors to MAINTAINERS
Date:   Fri, 29 Oct 2021 17:55:16 -0400
Message-Id: <20211029215516.801593-6-cmirabil@redhat.com>
In-Reply-To: <20211029215516.801593-1-cmirabil@redhat.com>
References: <20211029215516.801593-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the driver authors to MAINAINERS.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b79fd441dde..90fdd21d1db9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16882,6 +16882,17 @@ S:	Maintained
 F:	drivers/misc/phantom.c
 F:	include/uapi/linux/phantom.h
 
+SENSEHAT DRIVER
+M:	Charles Mirabile <cmirabil@redhat.com>
+M:	Mwesigwa Guma <mguma@redhat.com>
+M:	Joel Savitz <jsavitz@redhat.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/raspberrypi,sensehat.yaml
+F:	drivers/auxdisplay/sensehat-display.c
+F:	drivers/input/joystick/sensehat-joystick.c
+F:	drivers/mfd/sensehat-core.c
+F:	include/linux/mfd/sensehat.h
+
 SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
 M:	Tomasz Duszynski <tomasz.duszynski@octakon.com>
 S:	Maintained
-- 
2.31.1

