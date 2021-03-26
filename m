Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75DF34A3DE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhCZJMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhCZJME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:12:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738D2C0613B1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u5so7311945ejn.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rh7+6VZagF62oLd2fZv1hzXiSRvNqAreFqP0LRkuxi0=;
        b=P05CJV9kgXH2ttqjrebPKgfektCLZLb026dQMT7OopkpWqUSlEqkil3BbfzLI6IpRK
         Tl5a2k9oUky2kCOOpZTxNg3OMl7aERMLxl3cERqyQSbjbG554y9JfYJfoqaZjpCk0Qt9
         bynCGvyJux2ung2LzyzVwgE7MW8hyuuYjn5Mu/Z81r/D15nt9Gx+5hQb7mY3kkhfAn+y
         T2c+s/kzbtAGtSVk/yimarJMAGCtYM2Vcn6Eawk5t+0pcmSnaPHylaglpNvHlxF/85fc
         vI3bt3hdLOoca0hf5Xy370vlKUhEztVftVeuAkeWoYXJFCrgqY7sZeYIUAbpp8jOH8A4
         0IrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rh7+6VZagF62oLd2fZv1hzXiSRvNqAreFqP0LRkuxi0=;
        b=e76L0Hj+TcvcKOrt0HRPSaXZWB0p6zxlP4oc4z/I0U6zAux5Ygqyd1AtGVcd74aAZw
         dxgGvEOdHO8xyAw7LBxUtsWHrX2LQcO8RM5R6wVa/Lqi1dU9UHhqXxMgOsYE4TjrTWjq
         rAPkSNF5Bw1Yn2aSbJ3iyqas4Enm5QbJRv+SvUp4dZHohc7oPL1E+mqTk92HG83Pv5G8
         Fv0x9JaHiqAKv8YQK6xN5lhHEFQxocsHFizx0ViJ5gxQ+FoT9Xm0Okn/+g7DpjsgbHEk
         UtAdi2II5LU2bmJlTIBt1h4YryR6oa46YQQGXclAElbf63L1h4tiM1V8gjoB+xlPYNKy
         zB/g==
X-Gm-Message-State: AOAM533MBE1C3xhdONWWrua5ZekfjWdsXa/lyIGo6XOtf1twvlYvZV00
        7pVdsQyZ4ZF14TvPWuy2H2VhVw==
X-Google-Smtp-Source: ABdhPJwCi3YrMGQvYH+fYdfuHsO82T/noAw26g1FP4zB7xqJBJI4+uQmJUb3Ccy9RQV8eutefbumXQ==
X-Received: by 2002:a17:906:b7d5:: with SMTP id fy21mr14181298ejb.153.1616749923237;
        Fri, 26 Mar 2021 02:12:03 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id r13sm3895645edy.3.2021.03.26.02.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:12:02 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 09/18] fs: gfs2: meta_io: Add missing description for 'rahead' param
Date:   Fri, 26 Mar 2021 09:11:42 +0000
Message-Id: <20210326091151.311647-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326091151.311647-1-lee.jones@linaro.org>
References: <20210326091151.311647-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/meta_io.c:249: warning: Function parameter or member 'rahead' not described in 'gfs2_meta_read'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/meta_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 2db573e31f78d..23ce2a82a0e7f 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -239,6 +239,7 @@ static void gfs2_submit_bhs(int op, int op_flags, struct buffer_head *bhs[],
  * @gl: The glock covering the block
  * @blkno: The block number
  * @flags: flags
+ * @rahead: Do read-ahead
  * @bhp: the place where the buffer is returned (NULL on failure)
  *
  * Returns: errno
-- 
2.27.0

