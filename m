Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EC540F81C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244662AbhIQMmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244492AbhIQMmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:42:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2920D610C9;
        Fri, 17 Sep 2021 12:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631882444;
        bh=p1JDp2ez5z7QUwMAm1hC63DlakzzZ7n0efTl54YKOKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YPnYiFeKmwRwsnT2yW9ilSC+7hJB9SOOPjiVF/9vAMKwfwyFB/b8hvMFbKt2cVivz
         +qu4JHuGxNMGsNEsLgzMRua8dkWDPIpsykBM9JObywJmSF5KXEy+vdBMKO4c/hYWT8
         UcjkX56Opd0NDfe0PswbxtFF89fIxx5BXJX0YwPApQg9JH4cVcIsJ0+APDaRkxqwQt
         zNxQTg5zEkbA54TNAVSzKE/mpBwZp6sV0zFGsDKEqMRT+m9jSVsyb+PKCtvGRYwU/c
         1aMfq8aXd8B7DrRIBCF5wItRay56qBa6UIUK4XJxjTZoDSN8aa9YoVfedRuBqR/5VT
         EcPuvuFfO3h3A==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, sj@kernel.org, linux-damon@amazon.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 4/5] include/linux/damon.h: Fix kernel-doc comments for 'damon_callback'
Date:   Fri, 17 Sep 2021 12:39:57 +0000
Message-Id: <20210917123958.3819-5-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210917123958.3819-1-sj@kernel.org>
References: <20210917123958.3819-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

A few Kernel-doc comments in 'damon.h' are broken.  This commit fixes
those.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d68b67b8d458..755d70804705 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -62,7 +62,7 @@ struct damon_target {
 struct damon_ctx;
 
 /**
- * struct damon_primitive	Monitoring primitives for given use cases.
+ * struct damon_primitive - Monitoring primitives for given use cases.
  *
  * @init:			Initialize primitive-internal data structures.
  * @update:			Update primitive-internal data structures.
@@ -108,8 +108,8 @@ struct damon_primitive {
 	void (*cleanup)(struct damon_ctx *context);
 };
 
-/*
- * struct damon_callback	Monitoring events notification callbacks.
+/**
+ * struct damon_callback - Monitoring events notification callbacks.
  *
  * @before_start:	Called before starting the monitoring.
  * @after_sampling:	Called after each sampling.
-- 
2.17.1

