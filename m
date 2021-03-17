Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E972933ED67
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCQJs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhCQJsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:48:52 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98A7C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:48:40 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id t5so1064639qvs.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LXFx5mVxBa1Pa0shsdjl9mOOnBsXD49A5V8O38pzRhE=;
        b=e0az2cDlbWxEb19vuubACALjyPkGPpdIEWAVYgBE9WVOeo7U0KMNink2j2z/6KVZnO
         oTq9AZn8SbJSN3Qi7OmuM0y2YLnU4d1ML8rNdRFnEm+oEYg3fGzPGCahPl0KaCwl2I2B
         h+fDeA6QuueTTUEcL4Xe31M8yyFktLQNVJEVBJfcXXF1tLJcrDqUUL3tm8+T10O/KhX/
         pVF9siI5ycxB1iLiaIqTF/hhiFddMCjYTjUWziO8VRVFig6B4eooQ3GB5zxSCNQa9Hb5
         X5Wzaqz9HX3gJCLTt6kMM1g9/ph/3jUZTf6gSYSS0n0lWjE6DdT1jg0CkQBCVdZme63A
         RxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LXFx5mVxBa1Pa0shsdjl9mOOnBsXD49A5V8O38pzRhE=;
        b=SDCsWvdqVzq4vsJEEHfzZyEr+8PMkxecDrUyAMxns6LW/9cYpT+VWH0pQyzaQc2xax
         O5w/amDnuzWPo/8eDhcpfMArlKn+bNuDnZ/e3uYcKGN1Irjq7m5GX9DieNVDpyqBlObJ
         2dlV23Wb9Hyc8HMfJGp1HKN27HVmcuvdk9jQJkJNM6TGA9baDvrlnuw20rFsw7OM2Laq
         DSg7sLS/ioAX6xo+l3B6NmclwdgezsHAzbogpGMmbprKShe/OkvghKsfhlYMNGtNYMv+
         lDpaT5PyRtGisJXMKtHcmERe3EUacK74Bm90iYmQlIunPoVrwvKQ+Il+T0TA7Zx8qU+L
         9zAg==
X-Gm-Message-State: AOAM533BLuKodwa0ROmdKgWKKZh5mkwlYhs6yPzIJ26n0pgJudmXGtWb
        MvbRT3I3JBfowPjWQ+c4jiAl+0e3kPaDq3tn
X-Google-Smtp-Source: ABdhPJzTLnT3O4s+JR2v44hyKay3WgkWSYt20Io1o+Jqc7ZLbvZxqZcYqmrQTuYnoPTw8IaKmLA/nw==
X-Received: by 2002:ad4:4c83:: with SMTP id bs3mr4458147qvb.41.1615974520100;
        Wed, 17 Mar 2021 02:48:40 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.48])
        by smtp.gmail.com with ESMTPSA id k28sm17537187qki.101.2021.03.17.02.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:48:39 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     tytso@mit.edu, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] char: Fix a typo in the file random.c
Date:   Wed, 17 Mar 2021 15:18:22 +0530
Message-Id: <20210317094822.1630276-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/progams/programs/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 0fe9e200e4c8..afb0195e06f3 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -763,7 +763,7 @@ static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);

 #ifdef CONFIG_NUMA
 /*
- * Hack to deal with crazy userspace progams when they are all trying
+ * Hack to deal with crazy userspace programs when they are all trying
  * to access /dev/urandom in parallel.  The programs are almost
  * certainly doing something terribly wrong, but we'll work around
  * their brain damage.
--
2.30.2

