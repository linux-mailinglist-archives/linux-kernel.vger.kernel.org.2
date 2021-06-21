Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D993AE48B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhFUIHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:07:35 -0400
Received: from mail-m17639.qiye.163.com ([59.111.176.39]:63310 "EHLO
        mail-m17639.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhFUIHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:07:31 -0400
DKIM-Signature: a=rsa-sha256;
        b=iQ08HtD1Ww+Y7Ub7N/2dhEwLyH9fcjisnG306k28qYY0r3W+bDfcA9p8+V6HiLya7XyT7veUqH8Yw221f8PdkUkXhSi/dk7Eofqtl4nSQSEx0ldQe2vlhXfZNriXOXik/3YJx8Zs8ws2YUfnA7YUnxEdkieZ7Andh9pUUfHCiCE=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=RQwbyqHpijFkdqtQEMeYjob4O05U7NCN/vkk1R8SfSo=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.232])
        by mail-m17639.qiye.163.com (Hmail) with ESMTPA id F1F313800DF;
        Mon, 21 Jun 2021 16:05:14 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH RFC] hrtimer: support hrtimer suspend when CPU suspend
Date:   Mon, 21 Jun 2021 16:04:36 +0800
Message-Id: <1624262676-27548-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ05ISlYeTE1DTE5LTElITk5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NjY6FBw4CD9LFDgSKj02CAhP
        OB1PFCJVSlVKTUlPSU1JTEpOT0tCVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISVlXWQgBWUFJSk9CNwY+
X-HM-Tid: 0a7a2d9a26d4d994kuwsf1f313800df
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the CPU suspend, in order to achieve a more power-saving effect,
it is hoped that the CPU sleeps as long as possible, but the timer is an 
important reason for the CPU to wake up. 

In some cases, when the CPU suspend, the timer doesn’t have to work either,
such as watchdog hrtimer. The maximum suspend time of the CPU is 4s if enable
lockup detector, which is unacceptable on some products, and in fact, watchdog
timer can suspend when the cpu suspend.

This is a patch for comments, I'm not sure if there any ill-considerations. 
If this feature is really needed, I will continue to develop.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 include/linux/hrtimer.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index bb5e7b0..6d8e4f3
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -112,6 +112,7 @@ enum hrtimer_restart {
  * @is_soft:	Set if hrtimer will be expired in soft interrupt context.
  * @is_hard:	Set if hrtimer will be expired in hard interrupt context
  *		even on RT.
+ * @allow_suspend:	Set if hrtimer will suspend when CPU suspend
  *
  * The hrtimer structure must be initialized by hrtimer_init()
  */
@@ -124,6 +125,7 @@ struct hrtimer {
 	u8				is_rel;
 	u8				is_soft;
 	u8				is_hard;
+	u8				allow_suspend;
 };
 
 /**
-- 
2.7.4

