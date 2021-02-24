Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA476323BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 13:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbhBXMWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 07:22:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53227 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbhBXMWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 07:22:34 -0500
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cascardo@canonical.com>)
        id 1lEtAm-0000rM-VA; Wed, 24 Feb 2021 12:21:45 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     mpe@ellerman.id.au, peterz@infradead.org,
        linux-kernel@vger.kernel.org, cascardo@canonical.com
Subject: [PATCH] powerpc/perf: prevent mixed EBB and non-EBB events
Date:   Wed, 24 Feb 2021 09:21:16 -0300
Message-Id: <20210224122116.221120-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EBB events must be under exclusive groups, so there is no mix of EBB and
non-EBB events on the same PMU. This requirement worked fine as perf core
would not allow other pinned events to be scheduled together with exclusive
events.

This assumption was broken by commit 1908dc911792 ("perf: Tweak
perf_event_attr::exclusive semantics").

After that, the test cpu_event_pinned_vs_ebb_test started succeeding after
read_events, but worse, the task would not have given access to PMC1, so
when it tried to write to it, it was killed with "illegal instruction".

Preventing mixed EBB and non-EBB events from being add to the same PMU will
just revert to the previous behavior and the test will succeed.

Fixes: 1908dc911792 (perf: Tweak perf_event_attr::exclusive semantics)
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 arch/powerpc/perf/core-book3s.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 43599e671d38..d767f7944f85 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1010,9 +1010,25 @@ static int check_excludes(struct perf_event **ctrs, unsigned int cflags[],
 			  int n_prev, int n_new)
 {
 	int eu = 0, ek = 0, eh = 0;
+	bool ebb = false;
 	int i, n, first;
 	struct perf_event *event;
 
+	n = n_prev + n_new;
+	if (n <= 1)
+		return 0;
+
+	first = 1;
+	for (i = 0; i < n; ++i) {
+		event = ctrs[i];
+		if (first) {
+			ebb = is_ebb_event(event);
+			first = 0;
+		} else if (is_ebb_event(event) != ebb) {
+			return -EAGAIN;
+		}
+	}
+
 	/*
 	 * If the PMU we're on supports per event exclude settings then we
 	 * don't need to do any of this logic. NB. This assumes no PMU has both
@@ -1021,10 +1037,6 @@ static int check_excludes(struct perf_event **ctrs, unsigned int cflags[],
 	if (ppmu->flags & PPMU_ARCH_207S)
 		return 0;
 
-	n = n_prev + n_new;
-	if (n <= 1)
-		return 0;
-
 	first = 1;
 	for (i = 0; i < n; ++i) {
 		if (cflags[i] & PPMU_LIMITED_PMC_OK) {
-- 
2.27.0

