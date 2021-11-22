Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAC0459837
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 00:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhKVXK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 18:10:28 -0500
Received: from foss.arm.com ([217.140.110.172]:46148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231540AbhKVXKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 18:10:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C78B91516;
        Mon, 22 Nov 2021 15:07:10 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 385073F5A1;
        Mon, 22 Nov 2021 15:07:09 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        cristian.marussi@arm.com
Subject: [PATCH v6 04/16] include: trace: Add new scmi_xfer_response_wait event
Date:   Mon, 22 Nov 2021 23:06:28 +0000
Message-Id: <20211122230640.1345-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211122230640.1345-1-cristian.marussi@arm.com>
References: <20211122230640.1345-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a new step to trace SCMI stack while it waits for synchronous
responses is useful to analyze system performance when changing waiting
mode between polling and interrupt completion.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v5 --> v6
- removed atomic flag / poll is enough
- added timeout field
---
 include/trace/events/scmi.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/trace/events/scmi.h b/include/trace/events/scmi.h
index f3a4b4d60714..cee4b2b64ae4 100644
--- a/include/trace/events/scmi.h
+++ b/include/trace/events/scmi.h
@@ -33,6 +33,34 @@ TRACE_EVENT(scmi_xfer_begin,
 		__entry->seq, __entry->poll)
 );
 
+TRACE_EVENT(scmi_xfer_response_wait,
+	TP_PROTO(int transfer_id, u8 msg_id, u8 protocol_id, u16 seq,
+		 u32 timeout, bool poll),
+	TP_ARGS(transfer_id, msg_id, protocol_id, seq, timeout, poll),
+
+	TP_STRUCT__entry(
+		__field(int, transfer_id)
+		__field(u8, msg_id)
+		__field(u8, protocol_id)
+		__field(u16, seq)
+		__field(u32, timeout)
+		__field(bool, poll)
+	),
+
+	TP_fast_assign(
+		__entry->transfer_id = transfer_id;
+		__entry->msg_id = msg_id;
+		__entry->protocol_id = protocol_id;
+		__entry->seq = seq;
+		__entry->timeout = timeout;
+		__entry->poll = poll;
+	),
+
+	TP_printk("transfer_id=%d msg_id=%u protocol_id=%u seq=%u tmo_ms=%u poll=%u",
+		__entry->transfer_id, __entry->msg_id, __entry->protocol_id,
+		__entry->seq, __entry->timeout, __entry->poll)
+);
+
 TRACE_EVENT(scmi_xfer_end,
 	TP_PROTO(int transfer_id, u8 msg_id, u8 protocol_id, u16 seq,
 		 int status),
-- 
2.17.1

