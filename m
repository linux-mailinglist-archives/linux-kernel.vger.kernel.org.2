Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51FF453893
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 18:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbhKPRgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 12:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbhKPRf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 12:35:58 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828B4C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 09:33:01 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d27so39145747wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 09:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=m8SDQz+S6LtrB733L7RhS3+k/Tfso/qpbqH21msDXEY=;
        b=AvC9s75MTA2zg+Q7yc/81fLq158JQaPc4nmq3koHSFBIdq6i8UgmjrT5RxxeiJxDNV
         Oo0rc53GtlokOfOLqWzT1GXYMHuy/2MpXfd+47sZA1kE+eRD+6sbYt0pSXjLog9DXDdm
         biGfRZFd4M+8kfs8R5v9jDpEoNNAX/uv+0Q+abYGOJ9wZGGZul6w2IZFhfNQrPD6JZjI
         z+b6/j+3xX0fRQsFjo5F8Y8c/QB8rkLlzuC/R72vZxSEEte+5gjvsl+cC87ijttzGKZv
         YCnnS87UFzqadmwg9EtQ96wcR217jyfdle9doDiyhkbIY8xMuyZWKD8Fvu7eoBaGdlxN
         PA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m8SDQz+S6LtrB733L7RhS3+k/Tfso/qpbqH21msDXEY=;
        b=S4wnxxtPAB6XevFPkIzJ/FsV+wUKl5/5i1qSUqJVttpf2dxNiHtlOIoAnVlynP+Hu1
         C6Q/8cdT/vVxC2p/3CydxF4i84UmQIA/vaxuK9uI0vmAMn+S4IVe4vahr/ErGB6VaCWf
         zW9ysIM8rEu1okdrhnahEy4LbpgbLImYKGGStcnUOJKDP8H4Hw/t0e8DeeZOWu4jDwGG
         2LgRzLbfzTh8FxaBm4enF+/4SycHEdGSMub3XnjJacOcDXc7g3XhqtDigF++SY2r4cQ7
         GWHn/zYOg/mwFHj7PLvuJMiyyXgi4wMrHRJTvgCo5thxi6GVFKcdVQtGDySi0H+ugfjO
         mlzQ==
X-Gm-Message-State: AOAM533WYFCQ5A5pnbb+FHLGVCYlJJkB/hCGPA2TSVpG9C4JnDt2VWNj
        GohOS8WlmYXpJUKbf/YS+ljF5iP7p+yScg==
X-Google-Smtp-Source: ABdhPJzObjrDGoNnvV2TwwvPt9KDRI1wfpcJEpqZaMn03F/wwuaGKL4uWgbX0tKQQsjmRWDdtfAAyw==
X-Received: by 2002:a5d:674c:: with SMTP id l12mr11148052wrw.439.1637083979982;
        Tue, 16 Nov 2021 09:32:59 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:24f0:d30b:4818:6b7])
        by smtp.gmail.com with ESMTPSA id q8sm17720577wrx.71.2021.11.16.09.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 09:32:59 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] arm/scmi: fix base agent discover response
Date:   Tue, 16 Nov 2021 18:32:55 +0100
Message-Id: <20211116173255.19936-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to scmi specification, the response of the discover agent request
is made of:
- int32 status
- uint32 agent_id
- uint8 name[16]

but the current implementation doesn't take into account the agent_id field
and only allocates a rx buffer of SCMI_MAX_STR_SIZE length

Allocate the correct length for rx buffer and copy the name from the
correct offset in the response.

While no error were returned until v5.15, v5.16-rc1 fails with virtio_scmi
transport channel:

[    1.093253] arm-scmi firmware:scmi0: SCMI Notifications - Core Enabled.
[    1.114776] arm-scmi firmware:scmi0: SCMI Protocol v2.0 'Linaro:PMWG' Firmware version 0x2090000
[    1.117544] scmi-virtio virtio0: tx:used len 28 is larger than in buflen 24

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/firmware/arm_scmi/base.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index de416f9e7921..f5219334fd3a 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -34,6 +34,12 @@ struct scmi_msg_resp_base_attributes {
 	__le16 reserved;
 };
 
+struct scmi_msg_resp_base_discover_agent {
+	__le32 agent_id;
+	u8 name[SCMI_MAX_STR_SIZE];
+};
+
+
 struct scmi_msg_base_error_notify {
 	__le32 event_control;
 #define BASE_TP_NOTIFY_ALL	BIT(0)
@@ -225,18 +231,21 @@ static int scmi_base_discover_agent_get(const struct scmi_protocol_handle *ph,
 					int id, char *name)
 {
 	int ret;
+	struct scmi_msg_resp_base_discover_agent *agent_info;
 	struct scmi_xfer *t;
 
 	ret = ph->xops->xfer_get_init(ph, BASE_DISCOVER_AGENT,
-				      sizeof(__le32), SCMI_MAX_STR_SIZE, &t);
+				      sizeof(__le32), sizeof(*agent_info), &t);
 	if (ret)
 		return ret;
 
 	put_unaligned_le32(id, t->tx.buf);
 
 	ret = ph->xops->do_xfer(ph, t);
-	if (!ret)
-		strlcpy(name, t->rx.buf, SCMI_MAX_STR_SIZE);
+	if (!ret) {
+		agent_info = t->rx.buf;
+		strlcpy(name, agent_info->name, SCMI_MAX_STR_SIZE);
+	}
 
 	ph->xops->xfer_put(ph, t);
 
-- 
2.17.1

