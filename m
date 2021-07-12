Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A973C607D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhGLQ3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:29:45 -0400
Received: from foss.arm.com ([217.140.110.172]:57970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233887AbhGLQ3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:29:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67793106F;
        Mon, 12 Jul 2021 09:26:52 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AECE73F774;
        Mon, 12 Jul 2021 09:26:50 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v3 3/8] include: trace: Add new scmi_xfer_response_wait event
Date:   Mon, 12 Jul 2021 17:26:20 +0100
Message-Id: <20210712162626.34705-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210712162626.34705-1-cristian.marussi@arm.com>
References: <20210712162626.34705-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a new step to trace SCMI stack while it waits for synchronous
responses is useful to analyze system performance when changing waiting
mode between polling and interrupt completion.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 include/trace/events/scmi.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/trace/events/scmi.h b/include/trace/events/scmi.h
index f3a4b4d60714..ba82082f30d7 100644
--- a/include/trace/events/scmi.h
+++ b/include/trace/events/scmi.h
@@ -33,6 +33,34 @@ TRACE_EVENT(scmi_xfer_begin,
 		__entry->seq, __entry->poll)
 );
 
+TRACE_EVENT(scmi_xfer_response_wait,
+	TP_PROTO(int transfer_id, u8 msg_id, u8 protocol_id, u16 seq,
+		 bool poll, bool atomic),
+	TP_ARGS(transfer_id, msg_id, protocol_id, seq, poll, atomic),
+
+	TP_STRUCT__entry(
+		__field(int, transfer_id)
+		__field(u8, msg_id)
+		__field(u8, protocol_id)
+		__field(u16, seq)
+		__field(bool, poll)
+		__field(bool, atomic)
+	),
+
+	TP_fast_assign(
+		__entry->transfer_id = transfer_id;
+		__entry->msg_id = msg_id;
+		__entry->protocol_id = protocol_id;
+		__entry->seq = seq;
+		__entry->poll = poll;
+		__entry->atomic = atomic;
+	),
+
+	TP_printk("transfer_id=%d msg_id=%u protocol_id=%u seq=%u poll=%u atomic=%u",
+		__entry->transfer_id, __entry->msg_id, __entry->protocol_id,
+		__entry->seq, __entry->poll, __entry->atomic)
+);
+
 TRACE_EVENT(scmi_xfer_end,
 	TP_PROTO(int transfer_id, u8 msg_id, u8 protocol_id, u16 seq,
 		 int status),
-- 
2.17.1

