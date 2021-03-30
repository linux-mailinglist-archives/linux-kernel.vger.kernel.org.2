Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E506834EE30
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhC3QpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbhC3QpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C22C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:10 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x13so16871959wrs.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G+FYFjvrmmmlFKosOJsmCEZQd+qs37SblTzL1IxaAKE=;
        b=ew9BD7v9FEuHLK4DXVu6jasubMa9lxRBANiwewC971ATUhmfFA1lQSJVIjVA97akON
         eksbaTXBKYxz2E8ELGc3c1OWQr/wu1d0CFp+FyFKPOW4Jzy3VKVdQmIgdZp0RP+EY/Of
         CivdqEIfZS7ZmFwnZTPHJtSfuYIvs0cl3jrryuMWzaUVZ4bsB8MG2szkesG3lbHRg5Rr
         2F7ECPZbCjrQj5oILWcDSqd+WlhdzXL/vT5HERFcSquh6HICyWtWgqrw9uk86aQsDolU
         whurVb+6ctblrZo5pAws2YXX4JE4+b/tOUCRLFkWjG9FjYYlCTVdAzLljUrvA9g6ZV3C
         /hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G+FYFjvrmmmlFKosOJsmCEZQd+qs37SblTzL1IxaAKE=;
        b=FR/f4OhBePAZeBUbquHi5YO/8xA7LQQJc6S+z7WbX8HiaQfeXj9shSfOcZZ3SyorYO
         gq6+j0eH/YWK3onXgulJEJkNz24gNdSxH9L7bgHrCT9hhWnG2JfaK3zNqbJkkjPUZXpN
         vlcH0MvPQiJ5jSwn9lYF2yqO0LTAtcYlPpcm7HysD25Jyj7uwrC71lsLnYlF/vIv8eNt
         ZX1pO1nudRZB7j6IQxeUFCin5rdzTqqdwzxUVX/OA80LqbubFFWy0nWIdDWYO5SFPNwZ
         cgPYA2p5UyTgbZBDcgpNq4VbkI7AnI8TvIdioNnsNA0FqnYhT/krsQxJ4vpFThprSIas
         uwew==
X-Gm-Message-State: AOAM53285Q6UoIhXOKboRIr89XHNrdtsakASm7aloEIXj8r4zqhd+/eG
        syuHRlz4Z/2pcSsPEIaBawfSqg==
X-Google-Smtp-Source: ABdhPJwpE1SAXcHUx7I2lrtlx79K3iEngww10pKSJ2/1Ipp9H4x80nViQo/dXA6EcjEAzg8bZ2bWLA==
X-Received: by 2002:a5d:4203:: with SMTP id n3mr34548264wrq.116.1617122708907;
        Tue, 30 Mar 2021 09:45:08 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 08/31] fs: gfs2: aops: Fix a little potential doc-rot
Date:   Tue, 30 Mar 2021 17:44:35 +0100
Message-Id: <20210330164458.1625478-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/aops.c:560: warning: Function parameter or member 'rac' not described in 'gfs2_readahead'
 fs/gfs2/aops.c:560: warning: Excess function parameter 'file' description in 'gfs2_readahead'
 fs/gfs2/aops.c:560: warning: Excess function parameter 'mapping' description in 'gfs2_readahead'
 fs/gfs2/aops.c:560: warning: Excess function parameter 'pages' description in 'gfs2_readahead'
 fs/gfs2/aops.c:560: warning: Excess function parameter 'nr_pages' description in 'gfs2_readahead'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/aops.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index cc4f987687f3c..23b5be3db044c 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -540,10 +540,7 @@ int gfs2_internal_read(struct gfs2_inode *ip, char *buf, loff_t *pos,
 
 /**
  * gfs2_readahead - Read a bunch of pages at once
- * @file: The file to read from
- * @mapping: Address space info
- * @pages: List of pages to read
- * @nr_pages: Number of pages to read
+ * @rac: Read-ahead control structure
  *
  * Some notes:
  * 1. This is only for readahead, so we can simply ignore any things
-- 
2.27.0

