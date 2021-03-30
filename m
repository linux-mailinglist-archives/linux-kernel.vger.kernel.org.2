Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816AC34EE5E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhC3Qqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbhC3QpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35869C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b9so16861798wrt.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FGLqWsMKMFzu8AgI6vn47Mo1M3gcJ+HFYMnTl8CpPNE=;
        b=o4bsLxAzdSzHC0+9O7V9WippeyBZyIFoaExXWagIEpDMWv+3pp6EiKlUqT+iayCPd/
         DvHHF6pEfy0QkpD8CkbVq7VRz08PQKFurCSQExR2bQWBFY93e30cZAGGJGZjGDZw15/L
         WdfymAwc7stogcnhnhEjjFD0D2YcWycjNkHj16+4K/Z0jKgdzccPrAy7SKww0TKnkZj+
         E8jcs6uEcBT8BTLk2+ajJJUj3Y0Wm9lx8eATHonea8OhadtR1UaPy8QwhMSUJ0s9Y6RQ
         A6FFctxGaVuESjBTrol4Yup1xe7jQPsJbsfXcT3a7VTHhrtQFIjv7M/IPfhxPXIBBqij
         YWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FGLqWsMKMFzu8AgI6vn47Mo1M3gcJ+HFYMnTl8CpPNE=;
        b=DId6lWxEKCKxdh7qLQeTeSZ5d5eINTVYwIfbQ0r35mvJKiJM7PTMLif2eovyTjqaoW
         q6pKfFtexwBMI5LuHmCsYYbhx5XQsIISDxCuTVrZQQwqdO2KEysKFiFOHJM+wasJIqXS
         x7Lqjig/2Cm5+1VvhTPnV8Zn09+Rz+5Jk/tlL4sbssTVFCG+paID16wB9cwOOzACYBOO
         cjhEsE5pxMh876gsquhZymI5XJGKXKUyRTbeTc2jPzoni10vUNK/ThCrEwjJxXeYYKhk
         6jKrhjisArZTPEq8PSuiOXtk7To4+53srryflrZqzjtHNb1TEJftZVx1gP+N98n5YuqI
         b/sg==
X-Gm-Message-State: AOAM531h2cwb/vlPDCfG5Vru/G1ThOwvBmtlxvYBTBpbLduQGronaCtP
        AYMqMNpksoyqxujM8KaZGcURHg==
X-Google-Smtp-Source: ABdhPJzUAIEBCF/coONe9qTuIaNbIWSdajRwOSR6JlpTYwJ5gWcoN4SvarRGJvPz9oSpzL2RmmJV5w==
X-Received: by 2002:adf:bc01:: with SMTP id s1mr35009295wrg.240.1617122715996;
        Tue, 30 Mar 2021 09:45:15 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:15 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 15/31] fs: gfs2: recovery: Provide missing param descriptions and remove one other
Date:   Tue, 30 Mar 2021 17:44:42 +0100
Message-Id: <20210330164458.1625478-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/recovery.c:169: warning: Function parameter or member 'head' not described in 'get_log_header'
 fs/gfs2/recovery.c:169: warning: Excess function parameter 'lh' description in 'get_log_header'
 fs/gfs2/recovery.c:199: warning: Function parameter or member 'pass' not described in 'foreach_descriptor'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/recovery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 2821737740055..26004d5431165 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -154,7 +154,7 @@ int __get_log_header(struct gfs2_sbd *sdp, const struct gfs2_log_header *lh,
  * get_log_header - read the log header for a given segment
  * @jd: the journal
  * @blk: the block to look at
- * @lh: the log header to return
+ * @head: the log header to return
  *
  * Read the log header for a given segement in a given journal.  Do a few
  * sanity checks on it.
@@ -187,6 +187,7 @@ static int get_log_header(struct gfs2_jdesc *jd, unsigned int blk,
  * @jd: the journal
  * @start: the first log header in the active region
  * @end: the last log header (don't process the contents of this entry))
+ * @pass: iteration number (foreach_descriptor() is called in a for() loop)
  *
  * Call a given function once for every log descriptor in the active
  * portion of the log.
-- 
2.27.0

