Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D83032F8A6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 07:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhCFGjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 01:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhCFGia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 01:38:30 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86008C06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 22:38:30 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 18so3690306pfo.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 22:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqgUCBwByEzSr+WOUvqSnS8dCYqi7wfQ+sbjDLlUbrw=;
        b=BkJBOncWgRw7WMDw606mX3urzitu3rDyLc9xJfzuuJ30Yza9dUivY+lWDNQw81uIar
         jzuSxr/9b5aw4jIObJGe9vWClJpjWG12DG3/41jJRA6H1mYMcuU+RrrQaYsGs/yRujnf
         eQTabO+nT46t9ysHOX7IVAXHgP05yA5bQQRu5Hzz6lanq/XX1nzhReTq5mq/5ZEkFApp
         HZxH1Cp7c5weyI+ZAIH0BKLT4yb+MlJxhhXFBHLF/6rhUy7kQkmJNaEhzNwDBpg0XG1l
         wLfYm3ZBl3Ej88E1q2YfDUyrOrCnhFX+wZ5SQhMk1dVqHcn4f1qC2BgxpabfbvF8Wo6d
         fWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xqgUCBwByEzSr+WOUvqSnS8dCYqi7wfQ+sbjDLlUbrw=;
        b=UHOo+oVhwOh3fgCo5QGs2nVJF/oS5dbB/DlKlBlnSZNHM83KviG5YgNXgwKivs4Tzq
         9xgsaTTd05DQ0jH1m2B2Mageadan8iV9o+Yv/KyAo3b2PMy1pvbQ65VxdvxGN8jheZFx
         Ou5Jxzn4kQZCncqsCTCC+ftv6spO/cA9klzbg9sXujBqVhZ1TZzcpm6irkELfJ4TE4va
         RiQgVbZRqxgr+y8C0M8uTLtHXTHErPHk8IXr20e7yAK5RGMfH+8MjItpCxgx0hy3oTQH
         ygXARpb5o0S3xrNRDIVAj/g5TnKw8go9Ybe4xc7bn1Wm+vgZdGDMwgXJIKiC20Na0AKw
         E88A==
X-Gm-Message-State: AOAM530s0pesLav4u5QERcUouZS3WiscgeiY8psz0OmXGAyKD78fbS03
        D7nlEGxy/SCppNc9hCNnXYw=
X-Google-Smtp-Source: ABdhPJwaB6kZYuPuX7/Z0OsdSb90MMdYmGjEpmncAGt50rXcMC1F+ildMEqy5VoyMrambRPlwNliKA==
X-Received: by 2002:a05:6a00:854:b029:1b7:6233:c5f with SMTP id q20-20020a056a000854b02901b762330c5fmr12409801pfk.73.1615012710036;
        Fri, 05 Mar 2021 22:38:30 -0800 (PST)
Received: from localhost.localdomain ([103.157.202.86])
        by smtp.gmail.com with ESMTPSA id h7sm4287175pfo.45.2021.03.05.22.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 22:38:29 -0800 (PST)
From:   nabil5352 <nabil.ibn.mahmud@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        nabil5352 <nabil.ibn.mahmud@gmail.com>
Subject: [PATCH] Staging: android: ashmem: fixed a struct without const
Date:   Sat,  6 Mar 2021 12:38:17 +0600
Message-Id: <20210306063817.674041-1-nabil.ibn.mahmud@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a struct without const

Signed-off-by: nabil5352 <nabil.ibn.mahmud@gmail.com>
---
 drivers/staging/android/ashmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index d66a64e42273..7854fd410efa 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -376,7 +376,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
 
 static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	static struct file_operations vmfile_fops;
+	static const struct file_operations vmfile_fops;
 	struct ashmem_area *asma = file->private_data;
 	int ret = 0;
 
-- 
2.25.1

