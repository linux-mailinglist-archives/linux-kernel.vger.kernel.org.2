Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BAA379B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhEKAa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:30:29 -0400
Received: from mx1.opensynergy.com ([217.66.60.4]:31975 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhEKA3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:29:50 -0400
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 1B765A1A30;
        Tue, 11 May 2021 02:22:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=uVXQj8vtCYso
        WfIdT2YmI6MruqMQhZ51sMrsMngt+4c=; b=bub2NUPQ/1YkHW/fBbb4rG6AQdkz
        53zguMOjN7F+aEjMXK1IfPIpCrOOb0eNS5MMVhePifFi074BXvPPYN/sAWXRvrmX
        TdwmYlCc9MAPpVMEB15jf6tLCejtiebPengFdBWMFH0RDhUIiBRM45bOTU7bnupZ
        z6Slz8DMjiJ1/7jmL7EzPoZtR7vEDYjhQnVY3+7j/yekK7HDF5wXZMGQ718WK9Pb
        lRTLW3ZWqKv7QkP7ZK0+Up369Rrm3ZV8bZ9CKbe3VcbPy0lGlQrYkzrlppef/5fA
        SHAOMj5sSelTbNboJRAcJbQIWyHjSDPupXKXtlortgkHOaIVnQWRoQYnXA==
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     Peter Hilber <peter.hilber@opensynergy.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>,
        <souvik.chakravarty@arm.com>, <alex.bennee@linaro.org>,
        <jean-philippe@linaro.org>, <igor.skalkin@opensynergy.com>,
        <mikhail.golubev@opensynergy.com>,
        <anton.yakovlev@opensynergy.com>,
        Vasyl Vavrychuk <Vasyl.Vavrychuk@opensynergy.com>,
        Andriy Tryshnivskyy <Andriy.Tryshnivskyy@opensynergy.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [RFC PATCH v3 06/12] firmware: arm_scmi: Add is_scmi_protocol_device()
Date:   Tue, 11 May 2021 02:20:34 +0200
Message-ID: <20210511002040.802226-7-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511002040.802226-1-peter.hilber@opensynergy.com>
References: <20210511002040.802226-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-02.open-synergy.com (10.26.10.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scmi-virtio transport driver will need to distinguish SCMI protocol
devices from the SCMI instance device in the chan_setup() and
chan_free() ops. Add this internal helper to be able to distinguish the
two.

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 drivers/firmware/arm_scmi/bus.c    | 5 +++++
 drivers/firmware/arm_scmi/common.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 784cf0027da3..06148e972d1a 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -134,6 +134,11 @@ static struct bus_type scmi_bus_type = {
 	.remove = scmi_dev_remove,
 };
 
+bool is_scmi_protocol_device(struct device *dev)
+{
+	return dev->bus == &scmi_bus_type;
+}
+
 int scmi_driver_register(struct scmi_driver *driver, struct module *owner,
 			 const char *mod_name)
 {
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 61b22cdeaeeb..9488c682a51d 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -231,6 +231,8 @@ struct scmi_protocol {
 	const struct scmi_protocol_events	*events;
 };
 
+bool is_scmi_protocol_device(struct device *dev);
+
 int __init scmi_bus_init(void);
 void __exit scmi_bus_exit(void);
 
-- 
2.25.1


