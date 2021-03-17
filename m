Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDB633E85A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 05:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhCQETR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 00:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCQESm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 00:18:42 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2C4C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 21:18:31 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id t4so37697984qkp.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 21:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i9HzaCNHLYapkJARQwzPE3iRnUT4hBOFpAns1/tLwNE=;
        b=FsyFTKF5Un7I/qCmza52NTzjNh1Mx4HwdrS0cz4AkE3IJ9S1NSTNNdUc/oMx2iGm0n
         WF/jBTrUDZ+9vseuffMfahGxCNgmXUPF2zQiqzmsmQhJxIguQq3ImqjT+mKRN4nNpMER
         vnjX3apdQSETT7ioaetmxbH1fPXXb8Ybd8zcCzWo8Gy8euO+tdTVJqfPXFUuFRfkOi7q
         F8dzrqnRSxAP7uZZcidfIdVjo6WJRW2F4cfiiiTZe6HsJkDR3HDQBhMsw+gWK2ebjWTo
         ThtkIQFosOLgTxeeayfUHEdAtZYZvrFSZlnydsDcWKr1lau9Wwa8QP5uOHRbTTDamdvD
         ILnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i9HzaCNHLYapkJARQwzPE3iRnUT4hBOFpAns1/tLwNE=;
        b=kwSKOgpOj2uDSl8wL6ebz8uk/MhMFb/vYqsWFutySD695FDR5UpfUIR7uQ1W5TptPs
         wOm+t1KXKl4qgFcl4knuCVFVYVfFr2iv99kxTQAFkMCndPYoprmmwlBByX/YUHGenhjs
         LtWnMcI29OGbXgopN0ENsPmdKYQXyy9/39rUUSSJdWWbwFkqQwqc3Qh0MQC3TbR5f3AW
         hz47nIYCxc9Zg8OM+CYdXas9447bbX90xV2ThdTVWbpqx+krcnZPVXRu0MJALNg4YWgv
         TdnArsOJYXR9frpY+nS7h/yehcsQHqdkmXnE+qU9mG4FSxe6gNYmmywy5aJ/tydwwhO+
         iXOw==
X-Gm-Message-State: AOAM530QbV9juWoWU+HrRJL0Yuezr+NsIXE0Zm24DshryuIANUvXtQJC
        JlsH6lSMknNSwBZfsSpehL8=
X-Google-Smtp-Source: ABdhPJxCqUawR8eLCytHoJtp8MjzyQOAZhPSoT3A4RTu66pD4eqvmCtrgCp6sBD0D2QdwiaJTJGJwQ==
X-Received: by 2002:a37:87c4:: with SMTP id j187mr2650565qkd.408.1615954710740;
        Tue, 16 Mar 2021 21:18:30 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.5])
        by smtp.gmail.com with ESMTPSA id d3sm7036017qke.27.2021.03.16.21.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 21:18:30 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] kernel: locking: Mundane typo fix in the file rwsem.c
Date:   Wed, 17 Mar 2021 09:48:06 +0530
Message-Id: <20210317041806.4096156-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/folowing/following/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 kernel/locking/rwsem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index abba5df50006..fe9cc65cd522 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -632,7 +632,7 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 }

 /*
- * The rwsem_spin_on_owner() function returns the folowing 4 values
+ * The rwsem_spin_on_owner() function returns the following 4 values
  * depending on the lock owner state.
  *   OWNER_NULL  : owner is currently NULL
  *   OWNER_WRITER: when owner changes and is a writer
--
2.30.2

