Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1913F5FB5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbhHXOBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:01:30 -0400
Received: from foss.arm.com ([217.140.110.172]:36258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237771AbhHXOBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:01:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D73B41042;
        Tue, 24 Aug 2021 07:00:33 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E1A33F766;
        Tue, 24 Aug 2021 07:00:32 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v4 12/12] [RFC] firmware: arm_scmi: Make smc support atomic commands replies
Date:   Tue, 24 Aug 2021 14:59:41 +0100
Message-Id: <20210824135941.38656-13-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824135941.38656-1-cristian.marussi@arm.com>
References: <20210824135941.38656-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable sync_cmds_atomic_replies in the SMC transport descriptor.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
NOTE THAT this flag is probably better to be also optionally settable
using an optional DT property to address the fact that the same
transport could expose or not this feature depending on where the SCMI
server sits.
(e.g. an SCMI server in S-EL1 accessed via smc dispatcher sitting in EL3)
---
 drivers/firmware/arm_scmi/smc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
index c13edaace8a3..479382f3cc96 100644
--- a/drivers/firmware/arm_scmi/smc.c
+++ b/drivers/firmware/arm_scmi/smc.c
@@ -209,4 +209,5 @@ const struct scmi_desc scmi_smc_desc = {
 	.max_msg = 20,
 	.max_msg_size = 128,
 	.atomic_capable = true,
+	.sync_cmds_atomic_replies = true,
 };
-- 
2.17.1

