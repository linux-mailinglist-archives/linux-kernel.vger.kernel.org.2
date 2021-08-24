Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6175C3F5FB1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbhHXOBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:01:19 -0400
Received: from foss.arm.com ([217.140.110.172]:36258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237681AbhHXOBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:01:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B8101042;
        Tue, 24 Aug 2021 07:00:26 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD91C3F766;
        Tue, 24 Aug 2021 07:00:24 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v4 08/12] firmware: arm_scmi: Declare virtio transport .atomic_capable
Date:   Tue, 24 Aug 2021 14:59:37 +0100
Message-Id: <20210824135941.38656-9-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824135941.38656-1-cristian.marussi@arm.com>
References: <20210824135941.38656-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI virtio transport support does not contain any sleeping pattern, so
declare it as .atomic_capable.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/virtio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 224577f86928..eabe430595f0 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -488,4 +488,5 @@ const struct scmi_desc scmi_virtio_desc = {
 	.max_rx_timeout_ms = 60000, /* for non-realtime virtio devices */
 	.max_msg = 0, /* overridden by virtio_get_max_msg() */
 	.max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
+	.atomic_capable = true,
 };
-- 
2.17.1

