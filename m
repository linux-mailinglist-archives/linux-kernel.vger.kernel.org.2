Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAD3339CAD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 09:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbhCMH6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 02:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbhCMH57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 02:57:59 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79D0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 23:57:59 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id k68so19900263qke.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 23:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8JNiZUfBDRjXaPYBpQeMTXnhFbhlF+xtdVruxqSh3cA=;
        b=IxvaJGLX6pUI5R+Y+pYVqc8/0gQYUuErDfxr3dMFZudBUHTyTTMgRdE0XBcCau7R3l
         WVURZXlPOHDzjeCRAmjp2GkNmw3M99Sx/iwvc+iSD8ohg8gx7Cj3TzTxPdzUCsghnFFL
         Hv+lIk4SezNfKgceCzGd/c+Rf6ueoDDPEzD62ZXkdDxk/uLmQc4GjBU0Knksz2+dLsVo
         b2U0CgK0WmdW2qIHy4OyEo2nBB4jmzDFCPxxlIobZYlIAsooUXen6yoe28K/2f1TgtI5
         p1/lftklJT4PvJibzbIlGo6vGha2wAL2lU0ks0AxI4l1lf/1Bf/PVsGVaXXW7+F/fJFj
         Y3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8JNiZUfBDRjXaPYBpQeMTXnhFbhlF+xtdVruxqSh3cA=;
        b=gAD0lTpWpuRmUv2Dlufjuw7ZklBUzo8DSa0cxSlaWPJunVm1RpqFGuQ0dz/Q5SDxC8
         e2XkyRSyCbrJ2qPrJUA+p5trg9qCQq4i4twAOZW4+6JOmPcDhnjMZ5aZGSzfoiMIRsoT
         4EV2Q02mcFvf2IuUgWli5WndTXndhzHNpFWCsogvzS+JWqWb6aY+e+5tJWSfWH3kCiDw
         t8uRvv61lDKzNQeIpa/ZbY8MFF4olHkRwvO5FMf2xUfghMxRoosJSB3DdLIiwC8NEbpr
         g7dGskt+2tbLFnNCykjqc81I4A/sSyeBg95oUKs9PNAIBgIoAQlvqOizUcVccM9r97dk
         dPYA==
X-Gm-Message-State: AOAM533j3NWtnjtXQODMvkwfUeiEAcpKyeqz3jm23oO6viFDFeKf35BJ
        zE9lWSBpsopJHLabXkGrebl2ktdd2BY=
X-Google-Smtp-Source: ABdhPJwORNu5jWRG63mEkIrwerIFX+r6WsDRo4k6jBRlD+35Q3Ytikr16dVGNSyDCuR7br75GADeWLQhEY0=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:f931:d3e4:faa0:4f74])
 (user=yuzhao job=sendgmr) by 2002:ad4:5ce8:: with SMTP id iv8mr1757086qvb.16.1615622278881;
 Fri, 12 Mar 2021 23:57:58 -0800 (PST)
Date:   Sat, 13 Mar 2021 00:57:35 -0700
In-Reply-To: <20210313075747.3781593-1-yuzhao@google.com>
Message-Id: <20210313075747.3781593-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20210313075747.3781593-1-yuzhao@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v1 02/14] include/linux/nodemask.h: define next_memory_node()
 if !CONFIG_NUMA
From:   Yu Zhao <yuzhao@google.com>
To:     linux-mm@kvack.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, page-reclaim@google.com,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently next_memory_node only exists when CONFIG_NUMA=y. This patch
defines the macro for the !CONFIG_NUMA case.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/nodemask.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index ac398e143c9a..89fe4e3592f9 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -486,6 +486,7 @@ static inline int num_node_state(enum node_states state)
 #define first_online_node	0
 #define first_memory_node	0
 #define next_online_node(nid)	(MAX_NUMNODES)
+#define next_memory_node(nid)	(MAX_NUMNODES)
 #define nr_node_ids		1U
 #define nr_online_nodes		1U
 
-- 
2.31.0.rc2.261.g7f71774620-goog

