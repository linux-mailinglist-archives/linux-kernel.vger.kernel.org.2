Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9923D5ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 15:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhGZNQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 09:16:16 -0400
Received: from smtpbg128.qq.com ([106.55.201.39]:65269 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230421AbhGZNQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:16:13 -0400
X-QQ-mid: bizesmtp34t1627307797tmqz1b8g
Received: from ficus.lan (unknown [171.223.99.141])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 26 Jul 2021 21:56:36 +0800 (CST)
X-QQ-SSF: 0100000000200090B000C00A0000000
X-QQ-FEAT: WxvWionyWT6QKTrHhJM38Ng4bznx34znBiAWssqtHTpWYf0L5tr2q8X5gZAqa
        8RXDBfaMFJu2QfBLLdRgkseNZgJ/z3UjYyvsiYRg6qjL+Q3ZbCqZ36O/JjC3oHlIwN+LF4o
        mCsMWAOKn7nqghr/VRkXvA/WqJVInJ+tx8+lvMIyaXRb/FYn0BwP8p0nd+6Rbb+r3kb7oha
        73LqsLNHcRPUAAlV8BkTWhq2PunCNOLgxFLO7AAwaH7W1NTCpzP4QwZDvZASiIzYfXiRkVH
        ir9eiyZaD+TRyW1wQcc2Ht+NpWbwPziyZk2+SyCpCdtoLBp05b//SfJ17IZMs5RysK+Q3K2
        391DuI/aitpDeb6nKQ=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] tracing: use WARN_ONCE
Date:   Mon, 26 Jul 2021 21:56:35 +0800
Message-Id: <20210726135635.143285-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk + WARN_ON_ONCE can be just WARN_ONCE.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 kernel/trace/trace_output.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index a0bf446bb034..c06726b6d8b4 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1574,9 +1574,8 @@ __init static int init_events(void)
 
 		ret = register_trace_event(event);
 		if (!ret) {
-			printk(KERN_WARNING "event %d failed to register\n",
-			       event->type);
-			WARN_ON_ONCE(1);
+			WARN_ONCE(1, "event %d failed to register\n",
+				  event->type);
 		}
 	}
 
-- 
2.32.0

