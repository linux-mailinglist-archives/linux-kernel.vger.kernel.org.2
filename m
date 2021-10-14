Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCA742D0C6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhJNDJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhJNDJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:09:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE59C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:06:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so5933090pjw.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5+ykdt9ot6T7oBHTIi7wAsxJD1bUMNJgiKwFhmhCpNI=;
        b=aEqSgQ8N635hp1T62kE0RW1EXD87DIU2jo9u7uhSKKX6tAPGXJtZcMmPieEQJMyROG
         2r/wo2DUQn7GjYRVjG5i3YBVyT6BZWw2pho+f0bYVpNjXbj9W6s+VdjdEajMw9bo/pJL
         1e3SZdfKzt3iZb+I19AtejOUoqbsSj4Xp+yk0HJbL+B5KAM2MMy96ha/dAJt2q6mw69/
         noPfn/KbFt5RF1anh31AJhF9OYxier2ChhVCUgRbe7glWOlbQCigIRszVVyADhws/NBt
         L9HZeOdeEn8S3VP3nvqsHnmdnr/hUef2kV4AkHm6FXc3+nQlxuiHysPHplZ+pK03SZRR
         2pRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5+ykdt9ot6T7oBHTIi7wAsxJD1bUMNJgiKwFhmhCpNI=;
        b=ma2H74C6h3OrfAScym8L/O9kSRMquyFt3oy6xAe2XWDDXwOTWv0hSR0GV/teDR34Ka
         VwBxOKsy/ysgVRFYYbyXgeiypQEN4yROFXiA/h7QaSDq/eX2obLBrwJnDf/cUYEZGBkh
         lBrl0g4ulDut1QmaTWPfLs4UzM9werYI7TuFa+YoCHeh5I0MWTzvJ6mEb4tiU1rtci3M
         AmtflRecBBFnUMvlhLACSaxJGvixri718pDDEWUNpDMCCTYOjD+DSiSnXJIil/88phjh
         EzfPtqMkJhP95b9TY4siSTfG/rjnSrJS2UM3CD762BZbSinIfnTUiQbYEW0w+l6qIGh+
         KDjA==
X-Gm-Message-State: AOAM533pMoEmU38Fw0Fqq+4XZacmQUW8TLQWEw7DVVSKZWSV/iQ191Sq
        aj8yU8nSOBxKlFaO4t6XPpKpcYulI2uqxQ==
X-Google-Smtp-Source: ABdhPJwmSx3dZTl9X0lpEsrsE+Lo228CwRZQofBQcOJSwKwqmT7Fn6wxcgjws9llpmUCE94nDaV0ng==
X-Received: by 2002:a17:90a:414c:: with SMTP id m12mr17809974pjg.187.1634180819060;
        Wed, 13 Oct 2021 20:06:59 -0700 (PDT)
Received: from desktop.cluster.local ([162.14.19.95])
        by smtp.gmail.com with ESMTPSA id p17sm7253652pju.34.2021.10.13.20.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 20:06:58 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: mengensun@tencent.com
To:     tj@kernel.org
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        Mengen Sun <mengensun@tencent.com>
Subject: [PATCH] hotfix: make sysfs of unbound kworker cpumask more clever
Date:   Thu, 14 Oct 2021 11:06:41 +0800
Message-Id: <20211014030641.2182803-1-mengensun@tencent.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mengen Sun <mengensun@tencent.com>

some unfriendly component eg, dpdk, write the same mask to unbound
kworker cpumask again and agin. every time it write to this interface
some work is queue to cpu, by rr evenly the mask is same with the
original mask.

so, fix it, if the writing cpumask is equal with the old cpumask
just return success and do nothing.

Signed-off-by: Mengen Sun <mengensun@tencent.com>
---
 kernel/workqueue.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1b3eb1e9531f..8216fc45c77b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5394,6 +5394,11 @@ int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 	cpumask_and(cpumask, cpumask, cpu_possible_mask);
 	if (!cpumask_empty(cpumask)) {
 		apply_wqattrs_lock();
+		if (cpumask_equal(cpumask, wq_unbound_cpumask)) {
+			apply_wqattrs_unlock();
+			free_cpumask_var(saved_cpumask);
+			return 0;
+		}
 
 		/* save the old wq_unbound_cpumask. */
 		cpumask_copy(saved_cpumask, wq_unbound_cpumask);
-- 
2.27.0

