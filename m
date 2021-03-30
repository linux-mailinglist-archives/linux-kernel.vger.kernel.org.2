Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0F334DF82
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 05:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhC3DmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 23:42:06 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:43364 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhC3Dli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 23:41:38 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id A0EE99801E4;
        Tue, 30 Mar 2021 11:41:36 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] [v2] linux/trace_events.h: Remove duplicate struct declaration
Date:   Tue, 30 Mar 2021 11:40:55 +0800
Message-Id: <20210330034056.2266969-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUEVDhcXV1kJDhceCFlBWTI1LTo3Mj9BS1VLWVdZFhoPEhUdFFlBFQ4XFwY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ky46Cyo4SD8VHjAdNDAxNkgc
        ChxPFDNVSlVKTUpMS0xOTUJNQ0pPVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTk9JNwY+
X-HM-Tid: 0a788138f470d992kuwsa0ee99801e4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct trace_array is declared twice. One has been declared
at forward declaration. Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
Changelog:
v2:
- Undo sorting forward declarations alphabetically.
---
 include/linux/trace_events.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 28e7af1406f2..0237094e51f6 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -404,7 +404,6 @@ trace_get_fields(struct trace_event_call *event_call)
 	return event_call->class->get_fields(event_call);
 }
 
-struct trace_array;
 struct trace_subsystem_dir;
 
 enum {
-- 
2.25.1

