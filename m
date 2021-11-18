Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACE045538A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 04:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242819AbhKRD5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 22:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbhKRD5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 22:57:02 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3089C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 19:54:01 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1637207640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LrREcXjwq/HQrMWsNHaboy2+0WfVGFfGEWKwZ20dsZY=;
        b=XVAeP9VRMqOFpQnv4qcODLUcsoz3wM/pt/b7nLnJ5S2bmXNz3mdNQhmoXMpFaC7pppyyED
        Zu4bsGUcPIB8G6CkyCAOSFESdO7MrtsMAbgPCGO11uXF7BNyQNF0j411KWl22jbGzievWU
        ByEpmvYvvHj1VB0P9ZFy5cF5W6ofrNQ=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] refcount: introduce refcount_is_one() helper function
Date:   Thu, 18 Nov 2021 11:53:28 +0800
Message-Id: <20211118035328.5730-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yajun.deng@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many cases where it is necessary to determine if refcount is one,
introduce refcount_is_one() helper function for these cases.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/linux/refcount.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index b8a6e387f8f9..1cc23c0e7454 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -147,6 +147,11 @@ static inline unsigned int refcount_read(const refcount_t *r)
 	return atomic_read(&r->refs);
 }
 
+static inline bool refcount_is_one(const refcount_t *r)
+{
+	return refcount_read(r) == 1;
+}
+
 static inline __must_check bool __refcount_add_not_zero(int i, refcount_t *r, int *oldp)
 {
 	int old = refcount_read(r);
-- 
2.32.0

