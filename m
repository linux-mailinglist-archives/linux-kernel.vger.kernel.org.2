Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1075D3EF658
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 01:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbhHQXwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 19:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbhHQXwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 19:52:31 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C97C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 16:51:58 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id q19-20020ac87353000000b0029a09eca2afso67335qtp.21
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 16:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=66LPn3qAi6+RNBmqfq0UYvC3j3r/16uwPxDAmwkK1Rw=;
        b=MuXuzaYjkly6ZK6hbdIJnuw+v7wznvPbDZ0p5MMYdjR2zpPsmOU1mOJZDjly7T7t3h
         Vor+OvLRGzh8Bd/dUJ2iiV+DJ0Ze5P5CHK6O7sVdw1/fyIv8SifmAFvv85DVwZ3Yhg/f
         v2YLLY2yEtoEC8PlqkLlQ1zTUixMwAtTfMUU4hV6yvSERkh2717O6RPgTjCsfEhzbWbQ
         /m/fH4YcNnEF09btKf/x6aznzeFYMFpsPy4JV/tV1Rytsyr5wGgD1pA7JusBqJyL1NmS
         eRvD8GALaACkO8jsXXmBOgSaURGv6FEuiGC4FXzQD6sTey3/a5DANaYeVFzVIVe0uw5m
         TaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=66LPn3qAi6+RNBmqfq0UYvC3j3r/16uwPxDAmwkK1Rw=;
        b=Dvw7VGryjVNESnyJHw06exiTpMvN8TKK6RFLYAH80q/xdatilZ4iq3kYjvR6L57hsS
         tc4hlwaeeNXRMZC9BIgHYHt4dGVHHsEqv1JmWamnuzKtq8Gh3qRPbSAnF+TuV3Ls6WP9
         mRfDu8nam5qOvacHz8jnAv+Ex0dmhYQW6oYYI/VUR+6rn6c+YWb5A2SpxS9wTtCdPHl+
         iVIY+r2JFLwEYxnTrq/Gm6jFt3I9UX/dVUOzPMFl0vZ5txkNki8FSwifsvO5imPBxW88
         imlQgEBXJKG7rnWE9C3lNVDzqi8X9lOwes9+k/JYcE+eXccFDNgcFE2i/FqQ2ejXfPP3
         ZYYg==
X-Gm-Message-State: AOAM5307YzIyDZvXrknnMA6KxTVVXg8UMR4+mO630utoZjiVBnpUeBSI
        teu9ovhdNp+BXSOnNc2Fkx6CcIabuY3UkneYz2BFaw==
X-Google-Smtp-Source: ABdhPJxJBFWKOxzMxsf1ZaOmZuY64y/gaCGF1flpnHOTiBjvAE8aVUtkkKkBy0xIE8sDlAx/xsrBfH/7aExo84L29XKv6Q==
X-Received: from mustash.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:337b])
 (user=richardsonnick job=sendgmr) by 2002:a05:6214:f2e:: with SMTP id
 iw14mr6100161qvb.36.1629244317401; Tue, 17 Aug 2021 16:51:57 -0700 (PDT)
Date:   Tue, 17 Aug 2021 23:51:38 +0000
In-Reply-To: <20210817235141.1136355-1-richardsonnick@google.com>
Message-Id: <20210817235141.1136355-4-richardsonnick@google.com>
Mime-Version: 1.0
References: <20210817235141.1136355-1-richardsonnick@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v3 3/3] pktgen: Add output for imix results
From:   Nicholas Richardson <richardsonnick@google.com>
To:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org
Cc:     nrrichar@ncsu.edu, promanov@google.com, arunkaly@google.com,
        Nick Richardson <richardsonnick@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ye Bin <yebin10@huawei.com>, Leesoo Ahn <dev@ooseel.net>,
        Di Zhu <zhudi21@huawei.com>,
        Yejune Deng <yejune.deng@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Richardson <richardsonnick@google.com>

The bps for imix mode is calculated by:
sum(imix_entry.size) / time_elapsed

The actual counts of each imix_entry are displayed under the
"Current:" section of the interface output in the following format:
imix_size_counts: size_1,count_1 size_2,count_2 ... size_n,count_n

Example (count = 200000):
imix_weights: 256,1 859,3 205,2
imix_size_counts: 256,32082 859,99796 205,68122
Result: OK: 17992362(c17964678+d27684) usec, 200000 (859byte,0frags)
  11115pps 47Mb/sec (47977140bps) errors: 0

Summary of changes:
Calculate bps based on imix counters when in IMIX mode.
Add output for IMIX counters.

Signed-off-by: Nick Richardson <richardsonnick@google.com>
---
 net/core/pktgen.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 9e78edf0f69b..699f76779f0c 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -695,6 +695,18 @@ static int pktgen_if_show(struct seq_file *seq, void *v)
 		   (unsigned long long)pkt_dev->sofar,
 		   (unsigned long long)pkt_dev->errors);
 
+	if (pkt_dev->n_imix_entries > 0) {
+		int i;
+
+		seq_puts(seq, "     imix_size_counts: ");
+		for (i = 0; i < pkt_dev->n_imix_entries; i++) {
+			seq_printf(seq, "%llu,%llu ",
+				   pkt_dev->imix_entries[i].size,
+				   pkt_dev->imix_entries[i].count_so_far);
+		}
+		seq_puts(seq, "\n");
+	}
+
 	seq_printf(seq,
 		   "     started: %lluus  stopped: %lluus idle: %lluus\n",
 		   (unsigned long long) ktime_to_us(pkt_dev->started_at),
@@ -3281,7 +3293,19 @@ static void show_results(struct pktgen_dev *pkt_dev, int nr_frags)
 	pps = div64_u64(pkt_dev->sofar * NSEC_PER_SEC,
 			ktime_to_ns(elapsed));
 
-	bps = pps * 8 * pkt_dev->cur_pkt_size;
+	if (pkt_dev->n_imix_entries > 0) {
+		int i;
+		struct imix_pkt *entry;
+
+		bps = 0;
+		for (i = 0; i < pkt_dev->n_imix_entries; i++) {
+			entry = &pkt_dev->imix_entries[i];
+			bps += entry->size * entry->count_so_far;
+		}
+		bps = div64_u64(bps * 8 * NSEC_PER_SEC, ktime_to_ns(elapsed));
+	} else {
+		bps = pps * 8 * pkt_dev->cur_pkt_size;
+	}
 
 	mbps = bps;
 	do_div(mbps, 1000000);
-- 
2.33.0.rc1.237.g0d66db33f3-goog

