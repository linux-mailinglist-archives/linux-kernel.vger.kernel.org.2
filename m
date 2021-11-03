Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF0B443D68
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 07:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhKCGuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 02:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhKCGuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 02:50:20 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048DAC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 23:47:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w9-20020a17090a1b8900b001a6b3b7ec17so637433pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 23:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=clCWFcgTum5tE9Tq40EAguqPo9Q3/lsmvWziGtgtDKs=;
        b=gZo+LfkknTySRPhPrCljHO7GjlvLm5Vf7nI1NaHCS4BqS27XsPxLc4lHRa6IgI9vM1
         xOTDLylcvU6zO4rYhJ/gMdPZgdzabMSsECrf7wOO5f5UJNgLMLhQfaeqMf6XDgPm+0H4
         rhEW4twLxhp/ULjUgOz2XvC/pf/A+ximObqVT1Pr1C5DyXZNOoUMrUkqSZHBHVQFSMIU
         ENfSSV7xTuFeRNZwXggZjHxuZ6y9XEThzgMQbutmNAI2/8geCF0uwCJ0cTNBbs1xMiH0
         6mzSo+xLi7FEweJx4QwXyzAJOP9h1qnRas2ww88GVRNAZKd95xow/DC27czqIql8JXs1
         FmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=clCWFcgTum5tE9Tq40EAguqPo9Q3/lsmvWziGtgtDKs=;
        b=BLt6cS+6D0mGBtsfQb71hWQvUVWmlZSV9oEeOSzqM01bELMn8ZB5ITGyFXfZ9+i9Of
         9KAnDqt9oUaQNZFg/b6QOpluSXBEukrTSudUJwesio7DqKhZJ2b55zC6tKFXAmIpf5Zy
         dHCPkk/5PsPWBsd013NMGnbAA6xzsy8B3xo1JaHPQ3a0IS63xlJ0xVwFYsdyLwuOJgSZ
         7uOJpTnCfTEcS30WWIG2OWHycw62nHdTSJt1YI8Bd+UDHssEQtDejPH5Jtxpd9Eu+ZWf
         WdZtkPD+Ohedi56XknGqPrkyt9WluHUEm3s+bOLaA3Yr1WmrQHvJm6skL6sWYbMrDx3c
         73Mg==
X-Gm-Message-State: AOAM532q/ZqPhxGdEwmDf4LhScKj/X4JYW6MRXddS2/cbA79FBQZF4Hw
        xok8QDH9Rm7fM0sP7H/vxmHy38qvdhQ=
X-Google-Smtp-Source: ABdhPJzFlUGbJnFxGdJ5EVLm4hLFnEpu0QSipv96BgD3lERQm2gSxMNcjlGLvyHOMm4MHMi5ZKojyg==
X-Received: by 2002:a17:90a:a503:: with SMTP id a3mr12517810pjq.122.1635922063637;
        Tue, 02 Nov 2021 23:47:43 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d18sm1213710pfv.161.2021.11.02.23.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 23:47:43 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.mingyu@zte.com.cn
To:     anton@tuxera.com
Cc:     linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Zhang Mingyu <zhang.mingyu@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] NTFS:Remove unneeded semicolon
Date:   Wed,  3 Nov 2021 06:47:39 +0000
Message-Id: <20211103064739.27110-1-zhang.mingyu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Mingyu <zhang.mingyu@zte.com.cn>

Eliminate the following coccinelle check warning:
fs/ntfs/lcnalloc.c:902:2-3

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>
---
 fs/ntfs/lcnalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
index eda9972e6159..66c2b29e09dd 100644
--- a/fs/ntfs/lcnalloc.c
+++ b/fs/ntfs/lcnalloc.c
@@ -899,7 +899,7 @@ s64 __ntfs_cluster_free(ntfs_inode *ni, const VCN start_vcn, s64 count,
 		}
 		/* We have freed @to_free real clusters. */
 		real_freed = to_free;
-	};
+	}
 	/* Go to the next run and adjust the number of clusters left to free. */
 	++rl;
 	if (count >= 0)
-- 
2.25.1

