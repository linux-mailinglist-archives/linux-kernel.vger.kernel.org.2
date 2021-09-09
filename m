Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BC14046A3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhIIIAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhIIIAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:00:00 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F65BC061757
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 00:58:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f8-20020a2585480000b02905937897e3daso1441964ybn.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 00:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6Ldm7rOr6cPWy6VdSTV6Dek8K97Lju1gAu8+gD97c5A=;
        b=gJIp86Bm3AjRMR+5uf6Mx4PcWUqg08fuXVTo4AqsDCVb/gVZIDhZ02hjtU0+J5YbQ9
         5WAL0ZfaBmgCjtVg2bYeU0Qspt2fp75iVbLnH0U2rTyvhIH4PHoeMdbevwr4pOqhgTR8
         vQfYOrq4/nDYdggoVTwkIXEnw5BOGsvAm+ggnEeRtYUPTtjtkDXRbKyL4tUAjhaunM63
         jEEBPRblQC0VVlP0sHPTa/xHmMQ8eO6pdRORWsPZosluK0ItDY6frDSk492fzfpwoA9f
         K6NxyilPJ90YpENKWG+PgTjjpjlCMXZ+C8TvsYKpDEiF39Slx5HXQOdB43cLaDQ+ebek
         JctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6Ldm7rOr6cPWy6VdSTV6Dek8K97Lju1gAu8+gD97c5A=;
        b=ZCQyxpeVR0wpV7y00mpdzEJiVp9L1eW0w41YC/jh2ttEqdqdXTKHmmf+fDJRb4OKBx
         bfA4XvDjsUhnpiPuktZu6PX3Vy8kSBcgliUoNduL8WPjsaYIXMjBOY3JJjfNmh5cWlMQ
         BONWzz2wlpws78Cje3yNZPEi7H8RoTKcdAPtI5MoxWmN1yQZBoQygpObN2NqZb10U0uY
         KQ5mISheVJ7zO/jlqmZp4OLDJfo++leATFNy98F1kXJSNTTOewsk/Hg1tESkvd6GheWp
         hG9/Q7I+1lzaznWDlyk4ZnKydYW2iM35wsxgC5+CF0n5TaehNW8dBq/4Hcg6I5XiaeVj
         /B5A==
X-Gm-Message-State: AOAM530iwdU0oacjPQ6dwzAjTTSFFPYGn55qTdTK3zj/aYigcwaFisDN
        glIxfUVDJGvEmqDYXknPK8lR3+8oaQM2A1wo4c3/p9yZOhzlMphnxL2VJq9xSbKsYn2xGvqydrc
        3fycPIdVd4bYB6hC3lC0e4uPKwIJuo9Axpn6Q5O71uIxDC2Bi6L3G8+U9OHVqyBnBhsJhOCsZ
X-Google-Smtp-Source: ABdhPJz3/lZZSxM9ga7XgyT86Nw0nvepuwbEsIXOfvpv/DGs0ZiIZoZdl/zSbdRvUOV23N2yI0LJm2FKcf2i
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:f950:61f2:f1ec:ae8b])
 (user=eranian job=sendgmr) by 2002:a25:d04a:: with SMTP id
 h71mr2372733ybg.418.1631174330436; Thu, 09 Sep 2021 00:58:50 -0700 (PDT)
Date:   Thu,  9 Sep 2021 00:56:52 -0700
In-Reply-To: <20210909075700.4025355-1-eranian@google.com>
Message-Id: <20210909075700.4025355-6-eranian@google.com>
Mime-Version: 1.0
References: <20210909075700.4025355-1-eranian@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v1 05/13] perf/x86/amd: enable branch sampling priv level filtering
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD Branch Sampling features does not provide hardware filtering
by privilege level. The associated PMU counter does but not the branch
sampling by itself. Given how BRS operates there is a possibility that
BRS captures kernel level branches even though the event is programmed to
count only at the user level. This patch implements a workaround in software
by removing the branches which belong to the wrong privilege level. The privilege
level is evaluated on the target of the branch and not the source so as to be
compatible with other architectures. As a consequence of this patch, the number
of entries in the PERF_RECORD_BRANCH_STACK buffer may be less than the maximum (16).
It could even be zero. Another consequence is that consecutive entries in the
branch stack may not reflect actual code path and may have discontinuities,
in case kernel branches were suppressed. But this is no different than what
happens on other architectures.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/amd/brs.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 86dbc6d06815..23b969001857 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -92,10 +92,6 @@ int amd_brs_setup_filter(struct perf_event *event)
 	if ((type & ~PERF_SAMPLE_BRANCH_PLM_ALL) != PERF_SAMPLE_BRANCH_ANY)
 		return -EINVAL;
 
-	/* can only capture at all priv levels due to the way BRS works */
-	if ((type & PERF_SAMPLE_BRANCH_PLM_ALL) != PERF_SAMPLE_BRANCH_PLM_ALL)
-		return -EINVAL;
-
 	return 0;
 }
 
@@ -181,6 +177,21 @@ void amd_brs_disable(void)
 	}
 }
 
+static bool amd_brs_match_plm(struct perf_event *event, u64 to)
+{
+	int type = event->attr.branch_sample_type;
+	int plm_k = PERF_SAMPLE_BRANCH_KERNEL | PERF_SAMPLE_BRANCH_HV;
+	int plm_u = PERF_SAMPLE_BRANCH_USER;
+
+	if (!(type & plm_k) && kernel_ip(to))
+		return 0;
+
+	if (!(type & plm_u) && !kernel_ip(to))
+		return 0;
+
+	return 1;
+}
+
 /*
  * Caller must ensure amd_brs_inuse() is true before calling
  * return:
@@ -237,8 +248,6 @@ void amd_brs_drain(void)
 		if (to == BRS_POISON)
 			break;
 
-		rdmsrl(brs_from(brs_idx), from);
-
 		/*
 		 * Sign-extend SAMP_BR_TO to 64 bits, bits 61-63 are reserved.
 		 * Necessary to generate proper virtual addresses suitable for
@@ -246,6 +255,11 @@ void amd_brs_drain(void)
 		 */
 		to = (u64)(((s64)to << shift) >> shift);
 
+		if (!amd_brs_match_plm(event, to))
+			continue;
+
+		rdmsrl(brs_from(brs_idx), from);
+
 		cpuc->lbr_entries[nr].from = from;
 		cpuc->lbr_entries[nr].to   = to;
 
-- 
2.33.0.153.gba50c8fa24-goog

