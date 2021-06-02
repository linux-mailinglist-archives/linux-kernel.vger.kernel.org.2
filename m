Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43F2398015
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 06:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFBERr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 00:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhFBERn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 00:17:43 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BA6C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 21:16:00 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id b17-20020a63eb510000b029021a1da627beso889670pgk.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 21:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BKOZH6cxK8H9gN/NAu+gVbuI/VQYZv1qm1QPaLOLjHI=;
        b=ilMn61oqRM2Lkr1rRMXwrky4dts/4DoVebjHQHw1fhnH/vuUOm9+LTKdaUCtMY/STw
         DzTLXbdzQGvl9s2K8N0w8cifD9rODA5xbpZq6u0RN/NBGoeAqA04HGELINuvvBQtKnUg
         OIrRZ0ofDcCstAan7FJfuEW3KOk3exzjGNHfKq22f9cv5yooM0VGy6RkEM+dsE5O3SYO
         0RSonkVgvkONNTeSSM/6L7bMkURRhdr0QhQQhLk1PVN3heaECznM11cLY4AWzXmvOxDW
         MRNS5kHYa1r4GsB0YSobdNRAtEhh56hfEopCFOi6Qm9CQ2nz+tGtFk9ZttKn6Mz4w5o8
         8Omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BKOZH6cxK8H9gN/NAu+gVbuI/VQYZv1qm1QPaLOLjHI=;
        b=ht0+UQiAzik1oNutBjmRwjOsU5UuyE/7KuL2h806eIZvTXmhMGCneEyPmsDaqGnRvc
         c3b2Y+h+7RiPsvBAqUSDoA8bpSipk7AQmbQs6HN24mTYWDE6wKh75IPlQx7praHchUgd
         manr/b81Yzi3WjXLVBMgPRibx/uULVJuWjsgPuW1a5z6qbau3V/ZzbFI4hqUoy35A5AO
         aSX3l1hFk8/spgPM4AUJzn5FsqyL2v37KLtLE35wJweroIDHEo1+1f7U768OOSHTWCFV
         EFPgzt0if/bBSFm5biwA32qWU/sHLP+MFghqb6t1111DvU8Fir9hSjLksqJfOf4DXPIq
         2QAA==
X-Gm-Message-State: AOAM530PrKrLifFoY5/h032MHeBpU1y1bc0OVnMYhneqHejIlnE0CzTK
        wYwe/NA03RhxMKsqPrcD9qZykSMXni4=
X-Google-Smtp-Source: ABdhPJx3EPn11cJAZFQbbLtQn7yZRTKw3SHAIWbgcrOqO941WNYsCpYzO0S8sqLgdG0Ts39zGQH2ZATm4Wg=
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a17:90b:3b41:: with SMTP id
 ot1mr283480pjb.1.1622607359362; Tue, 01 Jun 2021 21:15:59 -0700 (PDT)
Date:   Wed,  2 Jun 2021 04:15:38 +0000
In-Reply-To: <20210602041539.123097-1-drosen@google.com>
Message-Id: <20210602041539.123097-2-drosen@google.com>
Mime-Version: 1.0
References: <20210602041539.123097-1-drosen@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH 1/2] f2fs: Show casefolding support only when supported
From:   Daniel Rosenberg <drosen@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The casefolding feature is only supported when CONFIG_UNICODE is set.
This modifies the feature list f2fs presents under sysfs accordingly.

Fixes: 5aba54302a46 ("f2fs: include charset encoding information in the superblock")
Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index dc71bc968c72..09e3f258eb52 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -720,7 +720,9 @@ F2FS_FEATURE_RO_ATTR(lost_found, FEAT_LOST_FOUND);
 F2FS_FEATURE_RO_ATTR(verity, FEAT_VERITY);
 #endif
 F2FS_FEATURE_RO_ATTR(sb_checksum, FEAT_SB_CHECKSUM);
+#ifdef CONFIG_UNICODE
 F2FS_FEATURE_RO_ATTR(casefold, FEAT_CASEFOLD);
+#endif
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 F2FS_FEATURE_RO_ATTR(compression, FEAT_COMPRESSION);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_written_block, compr_written_block);
@@ -829,7 +831,9 @@ static struct attribute *f2fs_feat_attrs[] = {
 	ATTR_LIST(verity),
 #endif
 	ATTR_LIST(sb_checksum),
+#ifdef CONFIG_UNICODE
 	ATTR_LIST(casefold),
+#endif
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	ATTR_LIST(compression),
 #endif
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

