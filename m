Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896963AD821
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 08:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhFSGbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 02:31:41 -0400
Received: from mail.loongson.cn ([114.242.206.163]:45474 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233081AbhFSGbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 02:31:37 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx70DBjs1gXRcUAA--.23357S3;
        Sat, 19 Jun 2021 14:29:22 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [RFC PATCH 1/2] ftrace: Introduce cmdline argument ftrace_disabled
Date:   Sat, 19 Jun 2021 14:29:19 +0800
Message-Id: <1624084160-3342-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1624084160-3342-1-git-send-email-yangtiezhu@loongson.cn>
References: <1624084160-3342-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dx70DBjs1gXRcUAA--.23357S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtw1DZFykWrWrCF4rJF4ktFb_yoWkGrX_XF
        srX3WDXr13Cw1vyw1rX3yrZry0gw1IgF4q9w1xKry5J3W8J3y5Ka13XwnIy3Wvgr40qF9x
        Ar47Jr15KF4fGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbhxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
        0Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r47MxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjLZ2DUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If set CONFIG_FUNCTION_TRACER=y, we can use the following command to
disable ftrace after boot up:
echo 0 > /proc/sys/kernel/ftrace_enabled

ftrace_disabled is much stronger than ftrace_enabled, introduce a new
cmdline argument ftrace_disabled for user to control whether to disable
ftrace when boot up.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 kernel/trace/ftrace.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 72ef4dc..a015699 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5517,6 +5517,14 @@ static char ftrace_filter_buf[FTRACE_FILTER_SIZE] __initdata;
 /* Used by function selftest to not test if filter is set */
 bool ftrace_filter_param __initdata;
 
+static int __init set_ftrace_disabled(char *str)
+{
+	pr_info("Set ftrace_disabled to disable ftrace\n");
+	ftrace_disabled = 1;
+	return 1;
+}
+__setup("ftrace_disabled", set_ftrace_disabled);
+
 static int __init set_ftrace_notrace(char *str)
 {
 	ftrace_filter_param = true;
-- 
2.1.0

