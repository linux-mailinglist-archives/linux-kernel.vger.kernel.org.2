Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B7A348748
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 04:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhCYDEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 23:04:13 -0400
Received: from mx316.baidu.com ([180.101.52.236]:44955 "EHLO
        njjs-sys-mailin04.njjs.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229719AbhCYDDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 23:03:46 -0400
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Mar 2021 23:03:45 EDT
Received: from bjhw-sys-rpm015653cc5.bjhw.baidu.com (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by njjs-sys-mailin04.njjs.baidu.com (Postfix) with ESMTP id C60681180004B;
        Thu, 25 Mar 2021 10:57:09 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     zhaolei27@baidu.com, linux-kernel@vger.kernel.org
Subject: [PATCH] perf x86 kvm-stat: support to analyze kvm msr
Date:   Thu, 25 Mar 2021 10:57:09 +0800
Message-Id: <1616641029-20644-1-git-send-email-lirongqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lei Zhao <zhaolei27@baidu.com>

usage:
    - kvm stat
      run a command and gather performance counter statistics

    - show the result:
      perf kvm stat report --event=msr

See the msr events:

Analyze events for all VMs, all VCPUs:

MSR Access Samples  Samples% Time%  Min Time Max Time  Avg time

  0x6e0:W   67007  98.17%   98.31%  0.59us   10.69us  0.90us ( +-  0.10% )
  0x830:W    1186   1.74%    1.60%  0.53us  108.34us  0.82us ( +- 11.02% )
   0x3b:R      66   0.10%    0.09%  0.56us    1.26us  0.80us ( +-  3.24% )

Total Samples:68259, Total events handled time:61150.95us.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Lei Zhao <zhaolei27@baidu.com>
---
 tools/perf/arch/x86/util/kvm-stat.c | 46 +++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
index 072920475b65..c5dd54f6ef5e 100644
--- a/tools/perf/arch/x86/util/kvm-stat.c
+++ b/tools/perf/arch/x86/util/kvm-stat.c
@@ -133,11 +133,56 @@ static struct kvm_events_ops ioport_events = {
 	.name = "IO Port Access"
 };
 
+ /* The time of emulation msr is from kvm_msr to kvm_entry. */
+static void msr_event_get_key(struct evsel *evsel,
+				 struct perf_sample *sample,
+				 struct event_key *key)
+{
+	key->key  = evsel__intval(evsel, sample, "ecx");
+	key->info = evsel__intval(evsel, sample, "write");
+}
+
+static bool msr_event_begin(struct evsel *evsel,
+			       struct perf_sample *sample,
+			       struct event_key *key)
+{
+	if (!strcmp(evsel->name, "kvm:kvm_msr")) {
+		msr_event_get_key(evsel, sample, key);
+		return true;
+	}
+
+	return false;
+}
+
+static bool msr_event_end(struct evsel *evsel,
+			     struct perf_sample *sample __maybe_unused,
+			     struct event_key *key __maybe_unused)
+{
+	return kvm_entry_event(evsel);
+}
+
+static void msr_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
+				    struct event_key *key,
+				    char *decode)
+{
+	scnprintf(decode, decode_str_len, "%#llx:%s",
+		  (unsigned long long)key->key,
+		  key->info ? "W" : "R");
+}
+
+static struct kvm_events_ops msr_events = {
+	.is_begin_event = msr_event_begin,
+	.is_end_event = msr_event_end,
+	.decode_key = msr_event_decode_key,
+	.name = "MSR Access"
+};
+
 const char *kvm_events_tp[] = {
 	"kvm:kvm_entry",
 	"kvm:kvm_exit",
 	"kvm:kvm_mmio",
 	"kvm:kvm_pio",
+	"kvm:kvm_msr",
 	NULL,
 };
 
@@ -145,6 +190,7 @@ struct kvm_reg_events_ops kvm_reg_events_ops[] = {
 	{ .name = "vmexit", .ops = &exit_events },
 	{ .name = "mmio", .ops = &mmio_events },
 	{ .name = "ioport", .ops = &ioport_events },
+	{ .name = "msr", .ops = &msr_events },
 	{ NULL, NULL },
 };
 
-- 
2.17.3

