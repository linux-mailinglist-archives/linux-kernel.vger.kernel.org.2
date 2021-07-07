Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9373BE5E3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhGGJvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhGGJv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:51:27 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950C9C061574;
        Wed,  7 Jul 2021 02:48:46 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id y17so1619326pgf.12;
        Wed, 07 Jul 2021 02:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e2xjwDG/oZGI2BDWWVUZ80C0oSrUvvIT1iby/SeB9H8=;
        b=JhvyPBxeQDK0AX7lHIYF3EBROFvkLgtaCEPz9WylHwpHVc9kbRdh7rqGKjqL/eKDf2
         sYk1Qj14BNzFx2wJSWs35fR5G16VsNcaAMrWL6AX8Irn/nTKm6JkH1za1WNlf5BsuA9h
         8Iz9jAwS75U8loxeXMPhYjKTeJRBsBo/PWJDoz2Wz0YyGDPx08DZfWWFR3bsI5c01gvE
         CHKHR15hjJXlV/laOcvLng8piA9Nswly05jShlaOJKaIQ8x5qfyqFid+Rmnt6fTycTWR
         T8OYE25BrFYEI6HzzzDeMm4/se9UDIRt1kUPmEMFygVDM7wfGcmD05iFE+fVXkFQWj7i
         pPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e2xjwDG/oZGI2BDWWVUZ80C0oSrUvvIT1iby/SeB9H8=;
        b=texzqHUQ71q9bxT6Q+rJXMk4oH2d/BvekfxJ5oug6WjC2sB53utFXCqBMGhPjSd2h/
         Kw34Beipl9tkEfhU1FemLIks7lk0jW2Zom3IQ+mLz4L/Hhqgxegii/NyvIr50wz1KNDb
         hXrupFSu1fK+ThSaS3hkt5JBPPgn0C/CALKrYxL+XbrvKiHLm+IUwFJ0Nbk7D9nApoVK
         9in1dsNuh1c06Zuc2Bo6hRbTA9nYg8plELKp5XPDp2wPsxj8uvosun2rDBTA3cVpM1It
         bVhChnd8x/4LQTLKif4TxAb55ozIjVdpal5kv+25IvGDbuNwYn8vp+fDXmts1n28kBAn
         YdDg==
X-Gm-Message-State: AOAM5329jjtjCcdTM4rGxCMrE4Ww7Wmx9sSS2ryjpxq2ML6/9XE3ubu/
        5xBnclVuHGgBWOFdJlS8GMA=
X-Google-Smtp-Source: ABdhPJxbAff96iAwb62k1W8EoH/Tur/OtZ1Hoy6jobDRa8e4k0z/uQDOjaIRWXVGkXxtudSLvaJOnw==
X-Received: by 2002:a65:434c:: with SMTP id k12mr25259494pgq.17.1625651326178;
        Wed, 07 Jul 2021 02:48:46 -0700 (PDT)
Received: from carrot.localdomain (i60-35-90-140.s42.a014.ap.plala.or.jp. [60.35.90.140])
        by smtp.gmail.com with ESMTPSA id gd19sm80137pjb.38.2021.07.07.02.48.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jul 2021 02:48:44 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] nilfs2: fix memory leak in nilfs_sysfs_delete_snapshot_group
Date:   Wed,  7 Jul 2021 18:48:26 +0900
Message-Id: <1625651306-10829-7-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1625651306-10829-1-git-send-email-konishi.ryusuke@gmail.com>
References: <1625651306-10829-1-git-send-email-konishi.ryusuke@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nanyong Sun <sunnanyong@huawei.com>

Kobject_put() should be used to cleanup the memory associated with
the kobject instead of kobject_del(). See the section "Kobject removal"
of "Documentation/core-api/kobject.rst".

Link: https://lkml.kernel.org/r/20210629022556.3985106-7-sunnanyong@huawei.com
Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 44b9ad70a564..57afd06db62d 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -215,7 +215,7 @@ int nilfs_sysfs_create_snapshot_group(struct nilfs_root *root)
 
 void nilfs_sysfs_delete_snapshot_group(struct nilfs_root *root)
 {
-	kobject_del(&root->snapshot_kobj);
+	kobject_put(&root->snapshot_kobj);
 }
 
 /************************************************************************
-- 
1.8.3.1

