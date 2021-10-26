Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430E043B497
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbhJZOqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:46:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:13756 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236906AbhJZOpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:45:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="253467467"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="253467467"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 07:34:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="635200460"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Oct 2021 07:34:14 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@google.com>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        "Gopal, Saranya" <saranya.gopal@intel.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/4] tools: usb: Hideous test tool for USB PD char device
Date:   Tue, 26 Oct 2021 17:33:52 +0300
Message-Id: <20211026143352.78387-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211026143352.78387-1-heikki.krogerus@linux.intel.com>
References: <20211026143352.78387-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interim.

The Makefile needs to be tuned so we can include to correct
files.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 tools/usb/Build     |   1 +
 tools/usb/Makefile  |   8 ++-
 tools/usb/pd-test.c | 123 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 131 insertions(+), 1 deletion(-)
 create mode 100644 tools/usb/pd-test.c

diff --git a/tools/usb/Build b/tools/usb/Build
index 2ad6f97458168..7116198533a75 100644
--- a/tools/usb/Build
+++ b/tools/usb/Build
@@ -1,2 +1,3 @@
 testusb-y += testusb.o
 ffs-test-y += ffs-test.o
+pd-test-y += pd-test.o
diff --git a/tools/usb/Makefile b/tools/usb/Makefile
index 1b128e551b2e4..e3e41a3397f23 100644
--- a/tools/usb/Makefile
+++ b/tools/usb/Makefile
@@ -16,7 +16,7 @@ MAKEFLAGS += -r
 override CFLAGS += -O2 -Wall -Wextra -g -D_GNU_SOURCE -I$(OUTPUT)include -I$(srctree)/tools/include
 override LDFLAGS += -lpthread
 
-ALL_TARGETS := testusb ffs-test
+ALL_TARGETS := testusb ffs-test pd-test
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 
 all: $(ALL_PROGRAMS)
@@ -36,6 +36,12 @@ $(FFS_TEST_IN): FORCE
 $(OUTPUT)ffs-test: $(FFS_TEST_IN)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
 
+PD_TEST_IN := $(OUTPUT)pd-test-in.o
+$(PD_TEST_IN): FORCE
+	$(Q)$(MAKE) $(build)=pd-test
+$(OUTPUT)pd-test: $(PD_TEST_IN)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $< -o $@
+
 clean:
 	rm -f $(ALL_PROGRAMS)
 	find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.o.cmd' -delete
diff --git a/tools/usb/pd-test.c b/tools/usb/pd-test.c
new file mode 100644
index 0000000000000..bb38dd4134581
--- /dev/null
+++ b/tools/usb/pd-test.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * USB Power Delivery device tester.
+ *
+ * Copyright (C) 2021 Intel Corporation
+ * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
+ */
+
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <linux/types.h>
+
+struct pd_message {
+	__le16 header;
+	__le32 payload[7];
+} __attribute__((packed));
+
+struct pd_info {
+	__u8 specification_revision;
+	__u32 ctrl_msgs_supported;
+	__u32 data_msgs_supported;
+	__u32 ext_msgs_supported;
+} __attribute__((packed));
+
+#define USBPDDEV_INFO		_IOR('P', 0x70, struct pd_info)
+#define USBPDDEV_CONFIGURE	_IOW('P', 0x71, __u32)
+#define USBPDDEV_PWR_ROLE	_IOR('P', 0x72, int)
+#define USBPDDEV_GET_MESSAGE	_IOWR('P', 0x73, struct pd_message)
+#define USBPDDEV_SET_MESSAGE	_IOW('P', 0x74, struct pd_message)
+#define USBPDDEV_SUBMIT_MESSAGE	_IOWR('P', 0x75, struct pd_message)
+
+enum pd_data_msg_type {
+	/* 0 Reserved */
+	PD_DATA_SOURCE_CAP = 1,
+	PD_DATA_REQUEST = 2,
+	PD_DATA_BIST = 3,
+	PD_DATA_SINK_CAP = 4,
+	PD_DATA_BATT_STATUS = 5,
+	PD_DATA_ALERT = 6,
+	PD_DATA_GET_COUNTRY_INFO = 7,
+	PD_DATA_ENTER_USB = 8,
+	/* 9-14 Reserved */
+	PD_DATA_VENDOR_DEF = 15,
+	/* 16-31 Reserved */
+};
+
+int dump_source_pdos(int fd)
+{
+	struct pd_message msg = {};
+	int ret;
+	int i;
+
+	msg.header = PD_DATA_SOURCE_CAP;
+	ret = ioctl(fd, USBPDDEV_GET_MESSAGE, &msg);
+	if (ret < 0) {
+		printf("No cached Source Capabilities %d\n", ret);
+		return ret;
+	}
+
+	printf("Source Capabilities:\n");
+
+	for (i = 0; i < (msg.header >> 12 & 7); i++)
+		printf("  PDO%d: 0x%08x\n", i + 1, msg.payload[i]);
+
+	return 0;
+}
+
+int dump_sink_pdos(int fd)
+{
+	struct pd_message msg = {};
+	int ret;
+	int i;
+
+	msg.header = PD_DATA_SINK_CAP;
+	ret = ioctl(fd, USBPDDEV_GET_MESSAGE, &msg);
+	if (ret < 0) {
+		printf("No cached Sink Capabilities %d\n", ret);
+		return ret;
+	}
+
+	printf("Sink Capabilities:\n");
+
+	for (i = 0; i < (msg.header >> 12 & 7); i++)
+		printf("  PDO%d: 0x%08x\n", i + 1, msg.payload[i]);
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	unsigned int role;
+	int ret;
+	int fd;
+
+	if (argc != 2) {
+		fprintf(stderr, "Usage: %s [DEV]\n"
+				"       %% %s /dev/pd0/port\n\n",
+				argv[0], argv[0]);
+		return -1;
+	}
+
+	fd = open(argv[1], O_RDWR);
+	if (fd < 0)
+		return fd;
+
+	ret = ioctl(fd, USBPDDEV_PWR_ROLE, &role);
+	if (ret < 0) {
+		printf("USBPDDEV_PWR_ROLE failed %d\n", ret);
+		goto err;
+	}
+
+	if (role)
+		ret = dump_source_pdos(fd);
+	else
+		ret = dump_sink_pdos(fd);
+err:
+	close(fd);
+
+	return ret;
+}
-- 
2.33.0

