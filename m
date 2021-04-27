Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B183036BDC1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 05:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhD0Db1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 23:31:27 -0400
Received: from mail-m121145.qiye.163.com ([115.236.121.145]:23800 "EHLO
        mail-m121145.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhD0DbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 23:31:25 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 9AAC3800157;
        Tue, 27 Apr 2021 11:30:40 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] firmware: arm_scmi: Remove repeated struct declaration
Date:   Tue, 27 Apr 2021 11:30:31 +0800
Message-Id: <20210427033031.4580-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQk0fQ1YdGh8YT0xDTkxNGEhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pk06Dxw4Ij8KFlFDNBA9Okk6
        PTwaCilVSlVKTUpCT0JPSU9KSkhCVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTE5ONwY+
X-HM-Tid: 0a79116101f3b03akuuu9aac3800157
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct scmi_protocol_handle is declared at 34th line.
The declaration here is duplicate. Remove it.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/firmware/arm_scmi/notify.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/notify.h b/drivers/firmware/arm_scmi/notify.h
index ce0324be6c71..4e9b627edfef 100644
--- a/drivers/firmware/arm_scmi/notify.h
+++ b/drivers/firmware/arm_scmi/notify.h
@@ -79,8 +79,6 @@ struct scmi_protocol_events {
 
 int scmi_notification_init(struct scmi_handle *handle);
 void scmi_notification_exit(struct scmi_handle *handle);
-
-struct scmi_protocol_handle;
 int scmi_register_protocol_events(const struct scmi_handle *handle, u8 proto_id,
 				  const struct scmi_protocol_handle *ph,
 				  const struct scmi_protocol_events *ee);
-- 
2.25.1

