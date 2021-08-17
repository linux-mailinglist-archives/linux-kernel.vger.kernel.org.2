Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3D43EF657
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 01:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbhHQXw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 19:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbhHQXw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 19:52:28 -0400
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com [IPv6:2607:f8b0:4864:20::e4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5FDC061796
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 16:51:53 -0700 (PDT)
Received: by mail-vs1-xe4a.google.com with SMTP id i2-20020a67e2c20000b02902bae9a0967fso212080vsm.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 16:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=k3/pK0CBn1A5G7wmRtLTVqgpdu0r/GTbQhPeFcXxvFY=;
        b=ezCUgRcS7hbHqYdcKEr0XSHh+C2g/EVQSoS+dFXfsQKC64yA6NqxjFkKItwWO38uTV
         ncg15u+8n6C9kxFndEqdo+y/ngDMPaQHUeX+SZ9lAsM8d60DcGfPhy3HStG0hLMnnfXq
         TQsKr+Zv5Tdvu+gNjoBahmERLn2B63skVaLAPqCps7UZ40KngExg60kCO67gJCkU8JXj
         FH/xn33919O6rUD2kl2KlQpao9ht9L+ZKuZMsLdtcMuZ5C2E+EsYD957mZqjiex5I5lI
         +DOpiOPhaHvJBkkH1OsUjD7zbUFSO3g4lfOsG3tzwfhWLaazNVm6utpPInfscLfuKdGy
         EQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k3/pK0CBn1A5G7wmRtLTVqgpdu0r/GTbQhPeFcXxvFY=;
        b=sgphIk9N1fzcJ51SrYPPUzN83csbBnrqmt8OC8ZEBFaTb+i3lQoyeebZHy4GR38xXH
         5gNRDqJXAmtrIKGmyXepgUFdwgnjjnT/aqGcRGahG3+dovK1bBPXbC6ERoOTosESiVRr
         J8kKHGskC2iSKnOfKd10kW2hNEfcLHN3cCP3WrdNgcW6Un2hrRwDd4UrhGVBJIOG1sHF
         v7gc397Rl+htG+9cY+tovrhpWTpL/GTPjChSIAUk0TzQCPwxSTs/wEgvAPlo7FkoY+Aa
         pXx17SjtVo6vQisT+1XRvsIngTeUCK4F8ElT8SKqZ9YoIWBpcTNJeVp7+RHPtG8zd6rq
         ZoFQ==
X-Gm-Message-State: AOAM533JWvKDUmhAdLTZGBR+uwuXQR2G3ATCzk1d01p4wg8JbzeTWoUC
        Ujq21D38ZFSsipAcwyRMYb7XrUnZnH7OTwu52P5+tQ==
X-Google-Smtp-Source: ABdhPJzLRv1JuVVLa9pCsI3wSB+ZLbyYwnSYcTz35ZEQSZ5fitRriUlcdld3rPgAndZCZWnWNXZ7POBq8Sbb3KdQ8rB51A==
X-Received: from mustash.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:337b])
 (user=richardsonnick job=sendgmr) by 2002:a05:6102:3f50:: with SMTP id
 l16mr5638742vsv.10.1629244312829; Tue, 17 Aug 2021 16:51:52 -0700 (PDT)
Date:   Tue, 17 Aug 2021 23:51:37 +0000
In-Reply-To: <20210817235141.1136355-1-richardsonnick@google.com>
Message-Id: <20210817235141.1136355-3-richardsonnick@google.com>
Mime-Version: 1.0
References: <20210817235141.1136355-1-richardsonnick@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v3 2/3] pktgen: Add imix distribution bins
From:   Nicholas Richardson <richardsonnick@google.com>
To:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org
Cc:     nrrichar@ncsu.edu, promanov@google.com, arunkaly@google.com,
        Nick Richardson <richardsonnick@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ye Bin <yebin10@huawei.com>, Leesoo Ahn <dev@ooseel.net>,
        Yejune Deng <yejune.deng@gmail.com>,
        Di Zhu <zhudi21@huawei.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Richardson <richardsonnick@google.com>

In order to represent the distribution of imix packet sizes, a
pre-computed data structure is used. It features 100 (IMIX_PRECISION)
"bins". Contiguous ranges of these bins represent the respective
packet size of each imix entry. This is done to avoid the overhead of
selecting the correct imix packet size based on the corresponding weights.

Example:
imix_weights 40,7 576,4 1500,1
total_weight = 7 + 4 + 1 = 12

pkt_size 40 occurs 7/total_weight = 58% of the time
pkt_size 576 occurs 4/total_weight = 33% of the time
pkt_size 1500 occurs 1/total_weight = 9% of the time

We generate a random number between 0-100 and select the corresponding
packet size based on the specified weights.
Eg. random number = 358723895 % 100 = 65
Selects the packet size corresponding to index:65 in the pre-computed
imix_distribution array.
An example of the  pre-computed array is below:

The imix_distribution will look like the following:
0        ->  0 (index of imix_entry.size == 40)
1        ->  0 (index of imix_entry.size == 40)
2        ->  0 (index of imix_entry.size == 40)
[...]    ->  0 (index of imix_entry.size == 40)
57       ->  0 (index of imix_entry.size == 40)
58       ->  1 (index of imix_entry.size == 576)
[...]    ->  1 (index of imix_entry.size == 576)
90       ->  1 (index of imix_entry.size == 576)
91       ->  2 (index of imix_entry.size == 1500)
[...]    ->  2 (index of imix_entry.size == 1500)
99       ->  2 (index of imix_entry.size == 1500)

Create and use "bin" representation of the imix distribution.

Signed-off-by: Nick Richardson <richardsonnick@google.com>
---
 net/core/pktgen.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index a7e45eaccef7..9e78edf0f69b 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -177,6 +177,7 @@
 #define MPLS_STACK_BOTTOM htonl(0x00000100)
 /* Max number of internet mix entries that can be specified in imix_weights. */
 #define MAX_IMIX_ENTRIES 20
+#define IMIX_PRECISION 100 /* Precision of IMIX distribution */
 
 #define func_enter() pr_debug("entering %s\n", __func__);
 
@@ -354,6 +355,8 @@ struct pktgen_dev {
 	/* IMIX */
 	unsigned int n_imix_entries;
 	struct imix_pkt imix_entries[MAX_IMIX_ENTRIES];
+	/* Maps 0-IMIX_PRECISION range to imix_entry based on probability*/
+	__u8 imix_distribution[IMIX_PRECISION];
 
 	/* MPLS */
 	unsigned int nr_labels;	/* Depth of stack, 0 = no MPLS */
@@ -483,6 +486,7 @@ static void pktgen_stop_all_threads(struct pktgen_net *pn);
 
 static void pktgen_stop(struct pktgen_thread *t);
 static void pktgen_clear_counters(struct pktgen_dev *pkt_dev);
+static void fill_imix_distribution(struct pktgen_dev *pkt_dev);
 
 /* Module parameters, defaults. */
 static int pg_count_d __read_mostly = 1000;
@@ -1046,6 +1050,8 @@ static ssize_t pktgen_if_write(struct file *file,
 		if (len < 0)
 			return len;
 
+		fill_imix_distribution(pkt_dev);
+
 		i += len;
 		return count;
 	}
@@ -2573,6 +2579,14 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 				t = pkt_dev->min_pkt_size;
 		}
 		pkt_dev->cur_pkt_size = t;
+	} else if (pkt_dev->n_imix_entries > 0) {
+		struct imix_pkt *entry;
+		__u32 t = prandom_u32() % IMIX_PRECISION;
+		__u8 entry_index = pkt_dev->imix_distribution[t];
+
+		entry = &pkt_dev->imix_entries[entry_index];
+		entry->count_so_far++;
+		pkt_dev->cur_pkt_size = entry->size;
 	}
 
 	set_cur_queue_map(pkt_dev);
@@ -2580,6 +2594,32 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 	pkt_dev->flows[flow].count++;
 }
 
+static void fill_imix_distribution(struct pktgen_dev *pkt_dev)
+{
+	int cumulative_probabilites[MAX_IMIX_ENTRIES];
+	int j = 0;
+	__u64 cumulative_prob = 0;
+	__u64 total_weight = 0;
+	int i = 0;
+
+	for (i = 0; i < pkt_dev->n_imix_entries; i++)
+		total_weight += pkt_dev->imix_entries[i].weight;
+
+	/* Fill cumulative_probabilites with sum of normalized probabilities */
+	for (i = 0; i < pkt_dev->n_imix_entries - 1; i++) {
+		cumulative_prob += div64_u64(pkt_dev->imix_entries[i].weight *
+						     IMIX_PRECISION,
+					     total_weight);
+		cumulative_probabilites[i] = cumulative_prob;
+	}
+	cumulative_probabilites[pkt_dev->n_imix_entries - 1] = 100;
+
+	for (i = 0; i < IMIX_PRECISION; i++) {
+		if (i == cumulative_probabilites[j])
+			j++;
+		pkt_dev->imix_distribution[i] = j;
+	}
+}
 
 #ifdef CONFIG_XFRM
 static u32 pktgen_dst_metrics[RTAX_MAX + 1] = {
-- 
2.33.0.rc1.237.g0d66db33f3-goog

