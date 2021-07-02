Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCCC3B9BA5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 06:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhGBEwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 00:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhGBEwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 00:52:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36430C061762;
        Thu,  1 Jul 2021 21:50:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id v20so14103364eji.10;
        Thu, 01 Jul 2021 21:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=W3XAzBcIgnUxyFMAmxxdlqQo/wCBISZyi6Hw8WfdbJ0=;
        b=tzFwN6+MzKANEbIv3UVbg6l3QpYVG4/rFGRbNfT9Si9HQb98BY9zOhLS18n8WruD1f
         1I9/ClAfw/dZcJcCOvnybZTg303EMLHbBcbsUNZDfpfcEVyilNXPbjoC1qqOig2PCEhe
         tgscbEMlTDt6GpMo7GKMBkd0frp5ats4CdnNMV3WoLFXHlpCJLCXoPKmrsmtHl6PD6gm
         zrOYCoaKM7qJvYs4Vd2jS6pbPzdeuZEoprJPwc/cJmgFSXX2mYuI5r6gPxvWVe5FY8VK
         0Xfwlt+/bciznTavmtl2eyo8PUvcDtKYyvvA2xhkNGKIXa3vBEQqGhoM4j0P8G86gh5i
         EDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W3XAzBcIgnUxyFMAmxxdlqQo/wCBISZyi6Hw8WfdbJ0=;
        b=Mvi4p2KurTMsbMJjea49I56riKZKD10QrIti3MQ9VF5RyABubyT+f+orjgFIYEWoxO
         UC3Gc+J+vY1Nw6I742wRASLnjKBQfCDmQvlxdApEZbvOBcIoM3KQtuTTepmID7qBEyfn
         fMNlAl8YPjq7cc4+OI64BQ6cNyupOxvRF+vXMqGoAuKNLTheYtuM/VAVqZ/6/35K2sw+
         eyf1oEJSNH3EdDr5ZavVcmZU8NJKLdu49G+gbhMBga1lZjI/1yOi1mEWR2hfJWuXV30W
         UudDH8yxALRtRnWm+ZPCrhIcv/3sCNoBmlwxG6gPjOP2sSKJmR4enz21iNxu0o7JNPI6
         TgCA==
X-Gm-Message-State: AOAM530sQ5RI1FXJDBiV+IZYUI9dy4ujhwoRm99mCQjMuQzYpS3IfF1y
        bN/wptmIpKdQsJt5uN4BUfY=
X-Google-Smtp-Source: ABdhPJxDRSEEzWRayCPT8xlFm9J5t61EVhOtx37ojN+ducybh8mOFiDJLFFZfq5KKfakeVg60/PLTA==
X-Received: by 2002:a17:906:28d5:: with SMTP id p21mr3437635ejd.358.1625201405601;
        Thu, 01 Jul 2021 21:50:05 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d6c:b200:425:6af1:c28a:24e7])
        by smtp.gmail.com with ESMTPSA id yh13sm606074ejb.28.2021.07.01.21.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 21:50:05 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] gcov: clang: rectify gcov_info_add's kernel-doc
Date:   Fri,  2 Jul 2021 06:49:50 +0200
Message-Id: <20210702044950.10411-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For gcov_info_add, ./scripts/kernel-doc -none kernel/gcov/clang.c warns:

  warning: Function parameter or member 'dst' not described in 'gcov_info_add'
  warning: Function parameter or member 'src' not described in 'gcov_info_add'
  warning: Excess function parameter 'dest' description in 'gcov_info_add'
  warning: Excess function parameter 'source' description in 'gcov_info_add'

Obviously, the kernel-doc's and function's parameter names slightly mismatch.

Adjust the kernel-doc description to make kernel-doc happy.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 kernel/gcov/clang.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
index cbb0bed958ab..214696e28ec1 100644
--- a/kernel/gcov/clang.c
+++ b/kernel/gcov/clang.c
@@ -264,10 +264,10 @@ int gcov_info_is_compatible(struct gcov_info *info1, struct gcov_info *info2)
 
 /**
  * gcov_info_add - add up profiling data
- * @dest: profiling data set to which data is added
- * @source: profiling data set which is added
+ * @dst: profiling data set to which data is added
+ * @src: profiling data set which is added
  *
- * Adds profiling counts of @source to @dest.
+ * Adds profiling counts of @src to @dst.
  */
 void gcov_info_add(struct gcov_info *dst, struct gcov_info *src)
 {
-- 
2.17.1

