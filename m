Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59433F32D0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 20:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhHTSJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 14:09:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59482 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235964AbhHTSJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629482910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4OPGCf/bXJhFEwNiiTiwLH7EUHiCc1gHGIcxlKk1+ks=;
        b=VqBcHrx2v3NQMtWMxnXKpztcdFh/6eo1QTRST2PO8j7L00kQZz9Dqbxm0mvlgeIx16xbvZ
        fMH3fSGhsgIrvZ7HTs/BoJHnJYf2sAM63nOXdL6p79rev2SAD92Ztc1uBXb+8hCIKtmxgq
        5lsxpSd/Zf0JQRA1AckMQU2td3/TR6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-op8t1VePPC6KaSsVdbvpqQ-1; Fri, 20 Aug 2021 14:08:29 -0400
X-MC-Unique: op8t1VePPC6KaSsVdbvpqQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F643875048;
        Fri, 20 Aug 2021 18:08:28 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.9.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D0A65D9D5;
        Fri, 20 Aug 2021 18:08:26 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [RFC PATCH v2 4/4] sensehat: Add device tree overlay (do not merge)
Date:   Fri, 20 Aug 2021 14:08:01 -0400
Message-Id: <20210820180801.561119-5-cmirabil@redhat.com>
In-Reply-To: <20210820180801.561119-1-cmirabil@redhat.com>
References: <20210820180801.561119-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is an RFC. The overlay included here is suitable for the
Sense HAT but we are not sure where overlays like this should go, or if we
should even include it, because the Raspberry Pi kernel tree already
includes that device tree blob that this was based on and most
distributions for the Raspberry Pi include those blobs.

The overlay is just in the root of the source tree since we did not know
where to put it so this patch should not be merged in this state.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 sensehat.dtbs | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 sensehat.dtbs

diff --git a/sensehat.dtbs b/sensehat.dtbs
new file mode 100644
index 000000000000..3f1c12c8f75f
--- /dev/null
+++ b/sensehat.dtbs
@@ -0,0 +1,51 @@
+/dts-v1/;
+
+/ {
+	compatible = "brcm,bcm2835";
+
+	fragment@0 {
+		target = <0xffffffff>;
+
+		__overlay__ {
+			#address-cells = <0x01>;
+			#size-cells = <0x00>;
+			status = "okay";
+
+			sensehat@46 {
+				compatible = "raspberrypi,sensehat";
+				reg = <0x46>;
+				keys-int-gpios = <0xffffffff 0x17 0x01>;
+				status = "okay";
+			};
+
+			lsm9ds1-magn@1c {
+				compatible = "st,lsm9ds1-magn";
+				reg = <0x1c>;
+				status = "okay";
+			};
+
+			lsm9ds1-accel6a {
+				compatible = "st,lsm9ds1-accel";
+				reg = <0x6a>;
+				status = "okay";
+			};
+
+			lps25h-press@5c {
+				compatible = "st,lps25h-press";
+				reg = <0x5c>;
+				status = "okay";
+			};
+
+			hts221-humid@5f {
+				compatible = "st,hts221-humid\0st,hts221";
+				reg = <0x5f>;
+				status = "okay";
+			};
+		};
+	};
+
+	__fixups__ {
+		i2c1 = "/fragment@0:target:0";
+		gpio = "/fragment@0/__overlay__/sensehat@46:keys-int-gpios:0";
+	};
+};
-- 
2.27.0

