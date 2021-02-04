Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4DD30F92E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 18:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238335AbhBDRKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:10:00 -0500
Received: from foss.arm.com ([217.140.110.172]:33884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238297AbhBDRBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:01:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03F0D12FC;
        Thu,  4 Feb 2021 09:00:26 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 414F03F73B;
        Thu,  4 Feb 2021 09:00:24 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, robh@kernel.org
Subject: [PATCH v5 2/3] firmware: arm_scmi: add System Power utility macro
Date:   Thu,  4 Feb 2021 16:59:12 +0000
Message-Id: <20210204165913.42582-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210204165913.42582-1-cristian.marussi@arm.com>
References: <20210204165913.42582-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a trivial macro to check the kind of SCMI SystemPower request.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 include/linux/scmi_protocol.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index fb8c8f16a49b..ecc14251a547 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -747,6 +747,7 @@ struct scmi_power_state_changed_report {
 struct scmi_system_power_state_notifier_report {
 	ktime_t		timestamp;
 	unsigned int	agent_id;
+#define SCMI_SYSPOWER_IS_REQUEST_GRACEFUL(flags)	((flags) & BIT(0))
 	unsigned int	flags;
 	unsigned int	system_state;
 };
-- 
2.17.1

