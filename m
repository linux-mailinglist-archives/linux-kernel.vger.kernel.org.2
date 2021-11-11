Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E295444D0F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 05:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbhKKETS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 23:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbhKKESR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 23:18:17 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266D4C06120C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 20:15:29 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v133-20020a25c58b000000b005c20153475dso7461100ybe.17
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 20:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kIC1LMcPIHE6ohL1Kwjd6ilZ7X8GMiNaA5GrQJ5M6q4=;
        b=DSZDX2TS+IiqWyINEcziE2ZPMV4wgH5I2PBc0aBvEMA0s5evl6R+qAyN7ZJehvxAq9
         bfS9VzJK7jBYgQ5pT/IRcjC+HWzlCJqn0Ky7+mISN5WTc8LvtGIdIAooird63y4SYnzd
         l8BFUmYGCao2goH7hiiIncaE9NsFCr2Xv5+JS42Fx8Bw3FIMTje+p+g7cN0GxFaOstPw
         NpREzvq2mLPcCxwH7v9kz0BnHH0LH17/ArmHjq4AyaX+z1ppg7fWOPA+46LaHJlctiH2
         ITak0prmcS3w4p8UJ0HM55jWVlGzIlI8icJ9Q0luh16+c9JI9z50nxe95dDCx9VPzbI0
         CF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kIC1LMcPIHE6ohL1Kwjd6ilZ7X8GMiNaA5GrQJ5M6q4=;
        b=cX/U8XvyIQH4TJgebTq7pXluWzcC72uEiwx6bh+15jGVFlHOohRou+yqEYaMr29w/f
         8mBidwSPRXheYmUFrgI5XeF3vxXL1Gid+z/u/98M1GvkhTllCVBB2AGRpz5RFB7oe9xR
         blQwPwx6DkRIFGsPNKDxej3hn8/iZxpnNaJ2/VQ70W0K75zRtrU9RqKJR/6NONjdVuiS
         pulGMPHc8qhL1pasUVgNUPoxp5pvZF+NWRAuyzhg3bBG1FNQjPRSVMiDA9oQUw8a64Oy
         d0tcDuIs2ZYkouYX7oNiDDr5sjSgY40ljkXi2Jui3fPGSGuAK1+RkTSS/lAkoBSWjOeU
         6J4w==
X-Gm-Message-State: AOAM53145FVhC5w6wIBIK9VZq6SrdIzztuEoa7mRg90oJOpE2fCeqd9C
        P3uhlgbxEVkIJLskeTaGedI1BfxRHkU=
X-Google-Smtp-Source: ABdhPJz92Zjq3t52xmpJLjYhav+djnH4c5unlUZlbCxpx8Nb7FEsbdwUxBg+ssTaG7ws2vXelVoynsmiSdQ=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:346b:bb72:659e:f91c])
 (user=yuzhao job=sendgmr) by 2002:a25:ade0:: with SMTP id d32mr5133433ybe.510.1636604128314;
 Wed, 10 Nov 2021 20:15:28 -0800 (PST)
Date:   Wed, 10 Nov 2021 21:15:09 -0700
In-Reply-To: <20211111041510.402534-1-yuzhao@google.com>
Message-Id: <20211111041510.402534-10-yuzhao@google.com>
Mime-Version: 1.0
References: <20211111041510.402534-1-yuzhao@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v5 09/10] mm: multigenerational lru: Kconfig
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, page-reclaim@google.com,
        holger@applied-asynchrony.com, iam@valdikss.org.ru,
        Yu Zhao <yuzhao@google.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add configuration options for the multigenerational lru.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
---
 mm/Kconfig | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index d16ba9249bc5..48e7babb22e5 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -896,4 +896,63 @@ config SECRETMEM
 
 source "mm/damon/Kconfig"
 
+# the multigenerational lru {
+config LRU_GEN
+	bool "Multigenerational LRU"
+	depends on MMU
+	# the following options may leave not enough spare bits in page->flags
+	depends on !MAXSMP && (64BIT || !SPARSEMEM || SPARSEMEM_VMEMMAP)
+	help
+	  A high performance LRU implementation to heavily overcommit workloads
+	  that are not IO bound. See Documentation/vm/multigen_lru.rst for
+	  details.
+
+	  Warning: do not enable this option unless you plan to use it because
+	  it introduces a small per-process and per-memcg and per-node memory
+	  overhead.
+
+config LRU_GEN_ENABLED
+	bool "Turn on by default"
+	depends on LRU_GEN
+	help
+	  The default value of /sys/kernel/mm/lru_gen/enabled is 0. This option
+	  changes it to 1.
+
+	  Warning: the default value is the fast path. See
+	  Documentation/static-keys.txt for details.
+
+config LRU_GEN_STATS
+	bool "Full stats for debugging"
+	depends on LRU_GEN
+	help
+	  This option keeps full stats for each generation, which can be read
+	  from /sys/kernel/debug/lru_gen_full.
+
+	  Warning: do not enable this option unless you plan to use it because
+	  it introduces an additional small per-process and per-memcg and
+	  per-node memory overhead.
+
+config NR_LRU_GENS
+	int "Max number of generations"
+	depends on LRU_GEN
+	range 4 31
+	default 7
+	help
+	  This will use order_base_2(N+1) spare bits from page flags.
+
+	  Warning: do not use numbers larger than necessary because each
+	  generation introduces a small per-node and per-memcg memory overhead.
+
+config TIERS_PER_GEN
+	int "Number of tiers per generation"
+	depends on LRU_GEN
+	range 2 5
+	default 4
+	help
+	  This will use N-2 spare bits from page flags.
+
+	  Larger values generally offer better protection to active pages under
+	  heavy buffered I/O workloads.
+# }
+
 endmenu
-- 
2.34.0.rc0.344.g81b53c2807-goog

