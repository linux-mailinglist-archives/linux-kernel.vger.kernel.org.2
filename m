Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FF23EB261
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239795AbhHMINX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239698AbhHMINW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:13:22 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE7CC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 01:12:55 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id t68so9861962qkf.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 01:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rqKy9El38Ijq4tYdGCeWyBDAmZwgGz7n0gBvxv5RSNg=;
        b=bR19vG9HGiUHDxigIPxsvn3usFtuL+jqe+qjINDJtg0rVpIadKkYEKYKy8k7FgHnWS
         ZMw7LoMoaG7GFeaqxGJKesr0bPj5qrM9pZ8gcYC7pOMCigWt7egNN69ffLNz6GZB/Cwa
         0BVDZ9z/n59+uG5aJ1muGMK+P0mr4YZfKc+jDFnBIneOkMyJ3Lm0nOOJuObALI55dZV7
         YsBK3978l7j+bufGYegy0ENQfSVkzJZzMPHpS/csAFlkBkX5mITfQJ8OeDGkVFhIcsai
         KX5oiwUw4A6KsIZ2uRYaeaG2vbKu4Ch0dYWl3yJg1QPr3qRGH5OaTS01UNhuZypJlcoB
         Po0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rqKy9El38Ijq4tYdGCeWyBDAmZwgGz7n0gBvxv5RSNg=;
        b=cTQenljYRd1gUaOaOZHN/TTvrm4rnoVQKuhjpKcJjYnoj1NHzh+qxkKHANyR7gXmCI
         o10G5yXL89enq3p4+iFotARCH4bAeUyTs2R3+W+j8k2mLyt4zKmWItTO4UBDwBf2PaI6
         7+b1RPZAC6PA6iEzdeBlxK8b8bw5/eKV+ZSf5bwjza8nca/vrrkVcBSNn0Aih7uMDg7V
         vJX4yaxbM3NezQfF5DyqOgdAupl889MwcGfyrWclQdPK0JnoJA4lGd2jl13WcCBpKTCa
         0Qlx2UYn65kAUSx3snDxV8fGej0+3imxuBpZfcMPGHFV5u3clctCBJ8RoTtXVtdTWFsZ
         TPpw==
X-Gm-Message-State: AOAM530bq8QZEpzRLqZa1AwyFpNRhGG7Pg/aXgvfrULfsRh3xRJlsjQN
        FVqYRrRVEvMkBdFZfTFQfPE=
X-Google-Smtp-Source: ABdhPJwMEJtePlInhkbqFaKu8p1btYdBnKUcEXtaDFaAzMmQHk7RQ+pcuKI+ewHNHSGzpmmmNi1pAA==
X-Received: by 2002:a37:6643:: with SMTP id a64mr912038qkc.256.1628842375064;
        Fri, 13 Aug 2021 01:12:55 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id g145sm487893qke.25.2021.08.13.01.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:12:54 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     valdis.kletnieks@vt.edu, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH] mm/damon/Kconfig: Hide PAGE_IDLE_FLAG from users
Date:   Fri, 13 Aug 2021 08:12:38 +0000
Message-Id: <20210813081238.34705-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Commit 2a058a1a9914 ("mm/idle_page_tracking: make PG_idle reusable") of
linux-mm[1] makes CONFIG_PAGE_IDLE_FLAG option to be presented to the
user.  However, the option is hard to be understood by users.  Also, it
is not intended to be set by users but other kernel subsystems like
DAMON or IDLE_PAGE_TRACKING.  To avoid confusions, this commit removes
the prompt so that the option is not presented to the user.

[1] https://github.com/hnaz/linux-mm/commit/2a058a1a9914

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 8d3a005edea5..be726f61ef9b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -740,7 +740,7 @@ config DEFERRED_STRUCT_PAGE_INIT
 	  initialisation.
 
 config PAGE_IDLE_FLAG
-	bool "Add PG_idle and PG_young flags"
+	bool
 	select PAGE_EXTENSION if !64BIT
 	help
 	  This adds PG_idle and PG_young flags to 'struct page'.  PTE Accessed
-- 
2.17.1

