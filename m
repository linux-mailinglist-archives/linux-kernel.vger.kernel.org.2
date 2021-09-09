Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491CE4046A8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhIIIAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbhIIIAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:00:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5DBC061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 00:59:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 124-20020a251182000000b005a027223ed9so1392443ybr.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 00:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WcYm8uYsLLRTYU+PtwqvI4JRAdNPeq6FKx6GnHlWW0Y=;
        b=Nhfeljr+CRD0C+ZBC5t6I1v0SCtXvXJ7SZCY/QSwbeI2ESTKjjUjUxGVF7SuvA37vX
         IIQk5+R49X3/Wb6UxljXvyJJ1f/cuh31Rf1HVIgJCd4u/idE86oJA50cq5hni6ocAfTh
         56ozQRae3Qu74xCY0wKs5AOCrrINxjTa3MKXxNgYybv2SAPbJdDi4u7K8xuIwjd+xk6S
         67AcCv+R2fAZNZ86cllbf5aADHkYk0kWfkpPGp3y1NpPLKP0pdFXMbFefdLCxVLM2qw+
         iAj2IVrPCWQKcyScZPlPIElzUZ9zv5lfZVlNVTSx1Sm7h95m0tJ7MXizJC0ndSagpOzM
         KBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WcYm8uYsLLRTYU+PtwqvI4JRAdNPeq6FKx6GnHlWW0Y=;
        b=uTHPjV/ej2bVrE45vsEiRN6PVlLJuKRA4we/r4gNT2QWeTJT6CTBEwt+QL8t7NpWBM
         mOsBqU1n1Uu++Da/7kyiECkH39buV3A6PqbDz9PPZZwhrO9QdgChu1PCEdE1cB8k43Mj
         QwZ+eUSoOgqu278dRXo/CPHEkajdJLKhweR0jJb4hbj9Lq4YkaaPdzLelm05jdpvP5ea
         8GUOGm3dx0rO+UDbBp59x4T0udO/lcSGqkEBLYvWeQOMYenpZuuXPkDyNXuxfe5d7Ol1
         FHfAVUuvgzntKSvO9r7N76it1KddMOLGlr3fDUollCsDMRwXRtsQ/miPN8Mq9V7FlJDo
         e33g==
X-Gm-Message-State: AOAM531rgV6NkVGY2DipwptVe6v54AsXOBiIwXJLWpLeuu5UEo08Eav8
        QtiEwDQDbYvV0j7iApDspLMHoEgvCWV/6wOOXvFvMOd6yMzuVQBPauM0ZytlnJ01tFSqL2mPK7r
        flIPs0vIoJM7p+LRxCFpgBiteiRLgomFSkwDZui9u8gXPo//gqumAErdKbSbXFMDMdhIjySRC
X-Google-Smtp-Source: ABdhPJwEIN6Y5BK9Z250510pzleUsWn9XkE2WONaXPNoyKGB6XU3s2b+SUcxtu01RRzmiyKI9xUbKPoD4AQv
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:f950:61f2:f1ec:ae8b])
 (user=eranian job=sendgmr) by 2002:a25:4f8a:: with SMTP id
 d132mr2134757ybb.486.1631174341998; Thu, 09 Sep 2021 00:59:01 -0700 (PDT)
Date:   Thu,  9 Sep 2021 00:56:57 -0700
In-Reply-To: <20210909075700.4025355-1-eranian@google.com>
Message-Id: <20210909075700.4025355-11-eranian@google.com>
Mime-Version: 1.0
References: <20210909075700.4025355-1-eranian@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v1 10/13] perf tools: add branch-brs as a new event
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although branch-brs is specific to AMD Zen3, we provide it in the list of events
recognized by perf as a convenience. It allows:
 $ perf stat -e branch-brs
 $ perf list

and enable some test suite to pass.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/parse-events.l | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 923849024b15..ae229f5c4758 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -361,6 +361,7 @@ mem-loads-aux				|
 mem-stores				|
 topdown-[a-z-]+				|
 tx-capacity-[a-z-]+			|
+branch-brs				|
 el-capacity-[a-z-]+			{ return str(yyscanner, PE_KERNEL_PMU_EVENT); }
 
 L1-dcache|l1-d|l1d|L1-data		|
-- 
2.33.0.153.gba50c8fa24-goog

