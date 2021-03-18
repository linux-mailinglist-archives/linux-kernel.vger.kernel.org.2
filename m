Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43E63402EC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhCRKLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhCRKK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:10:29 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A4AC06174A;
        Thu, 18 Mar 2021 03:10:29 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id by2so2860950qvb.11;
        Thu, 18 Mar 2021 03:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+3m60JeC3jcW717248QSX5WUD949KDlEAqc7aIaeSYg=;
        b=YeWGsrseemmcW24aWzVapHTFgdzxwtxUdZJ/asMlJ1D7IYUH4gyVxzX3uQ0jL7q6Nr
         Vu4J58J1wy32zv5yRGdWoiT7Kqm4PbQXxG/zqHYCUmREGM1ky8S5Xo3q7QM5w264rDdo
         s0ZAjkTShUHTpYjrgcp5EB36aU7Uk2dxCMhAXOu/NazJVc8qeuzzJAfj2KSCNrV9tNmy
         mZBZLrAAsRedspI712Fq+h8lwoN4PRxQ4JbUd0wQf67pZ2QaL2iIJCOIc7LQx7pKpJbs
         7CcMm/2odk5HMha1r5sao4e1GF9t/6R3KrrOCrWANYjHbYC7oh2uWgFVY1j6g8lUsPXp
         6p1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+3m60JeC3jcW717248QSX5WUD949KDlEAqc7aIaeSYg=;
        b=nV08iqJt8FgOUSbUuw23Vi87ckpMVCjk3l362fOCsV3+7qY6pLAzoTrDrQcfrEj+dm
         /8/rhHAgZy1uPD90cMBE+SUvglbzK73PVPIw6LYrVWDTta/AnnQQxeQMqf2xnQfnmQHY
         eulsFxRkldnr2dlkmwdzmCpHS7ErNi5J/iky9D/RtR7zny4hnePYqjqA05bfx/OiWfVY
         47P2PTLfB8NVU3JpQUkYJCACahkOlGeYx5goBDrHASP19by5p2LGQp2BOsfC5kyeg5/9
         aANpye+z1/MRYJ2IyEsREFxRNou1FeUY/2Lmwmyfu9n6OwxwWi45ANeiMhvtRalTiA0q
         Fc7g==
X-Gm-Message-State: AOAM531MYVXy/jx6EDCu77XOfi92YrDVPFTnaVF/IyAme10aR0p+rNDP
        +HS1WPpNAIRzzis+x4H63Ws=
X-Google-Smtp-Source: ABdhPJx3arxomKqg7xQUzyn/nuOtqEJEPH7qfw7lZLsrMV+s/7OJ+HpAL3kZwadzs4tHbutbNcYUYg==
X-Received: by 2002:ad4:4c4c:: with SMTP id cs12mr3409196qvb.35.1616062228440;
        Thu, 18 Mar 2021 03:10:28 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id d16sm1358101qka.43.2021.03.18.03.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 03:10:28 -0700 (PDT)
From:   sj38.park@gmail.com
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, gthelen@google.com, mgorman@suse.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, rppt@kernel.org, shakeelb@google.com,
        shuah@kernel.org, sj38.park@gmail.com, snu@amazon.de,
        vbabka@suse.cz, vdavydov.dev@gmail.com, zgf574564920@gmail.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v25 13/13] MAINTAINERS: Update for DAMON
Date:   Thu, 18 Mar 2021 10:08:56 +0000
Message-Id: <20210318100856.34715-14-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210318100856.34715-1-sj38.park@gmail.com>
References: <20210318100856.34715-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit updates MAINTAINERS file for DAMON related files.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2baeb5e4a68..4665a5699cf6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4952,6 +4952,18 @@ F:	net/ax25/ax25_out.c
 F:	net/ax25/ax25_timer.c
 F:	net/ax25/sysctl_net_ax25.c
 
+DATA ACCESS MONITOR
+M:	SeongJae Park <sjpark@amazon.de>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	Documentation/admin-guide/mm/damon/*
+F:	Documentation/vm/damon/*
+F:	include/linux/damon.h
+F:	include/trace/events/damon.h
+F:	mm/damon/*
+F:	tools/damon/*
+F:	tools/testing/selftests/damon/*
+
 DAVICOM FAST ETHERNET (DMFE) NETWORK DRIVER
 L:	netdev@vger.kernel.org
 S:	Orphan
-- 
2.17.1

