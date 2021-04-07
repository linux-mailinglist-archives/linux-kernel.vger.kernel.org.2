Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D7B356ED3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352999AbhDGOf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbhDGOfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:35:24 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80397C061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 07:35:14 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id n198so17400166iod.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 07:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=McRaPZtaI1790tMkGUX982lxKKNwJ+80GSAvJnU1nu4=;
        b=WcBkhGP7Nysne78NG4fnVBZWzjevmx21rC2qbAUg4IlDiM3kfIf14TnPrUsBkZKykL
         6TXktiCGa4MsmfGuLxOg9BQCgdO6CSIaJNAPeEtyxeECP2wZQiFLgpJufnh6v8nNNZ7X
         Q5CILzPDHOMIIvoL1jKQWKFnPQxwbpuJEdEVsFmGeZsdNq4YruIL5ni0sjS9YXhGCiCK
         NaT9sDT7TshdSUBjObb2ZUv6FtkJHtGueH+ucSPo7Ee1pG+kkVuud3X+fCP4J24J2K5y
         dY+Bg7397uzLLtqDOjH/zbg4i8sUBTPIlEYecYEcr4CG3TlJfYvpcoCBsVhEyPtg0c+m
         0jGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=McRaPZtaI1790tMkGUX982lxKKNwJ+80GSAvJnU1nu4=;
        b=HtWtALkHDN+ketOFaISDWBgXczAPIrxmHaitzb2tWAqiwY2gqNdJNpaSUwxonkMwaL
         LWoNuJaNby0lUlty+aOqWD5iLOhpytpX+pi2cj6kHUu5c5CIU5jcqeoRgjSvkc7dO1x9
         3DFBzdAMn6u3rC9v6paVQiZc49/Il6+pR1GAF2WuLOarYRFYyuGiOjeFFQqg++m0ravp
         L4Lt25MUvosF3Iflu9T+d0H2MCnz6tnJhARssKz8uA4S8Yve9TmO34caJNjZt0uBEEsM
         udMKVqoK0Zg3vrx3I9pcGjuWPPfbDbJtH39hz168Tbg9+K06OZjiynuYajPe/mQ4DQll
         VgOw==
X-Gm-Message-State: AOAM532gbDPmYereh4e/6xkytM3mIlKJGFm5xRxkkurlneRSnvk2+neJ
        TahN6A+/yKsl6gVR8N0b5zYOur8o/7qgOIAx
X-Google-Smtp-Source: ABdhPJwixaGP6whEJsF6nRmSeCzhqKzUSt7Mhs/eJYWYBR/YNb0TbcJ8fadKJhz4NEEBRuQvQCEAOA==
X-Received: by 2002:a6b:ec14:: with SMTP id c20mr2872508ioh.122.1617806113932;
        Wed, 07 Apr 2021 07:35:13 -0700 (PDT)
Received: from Ubu (97-116-48-27.mpls.qwest.net. [97.116.48.27])
        by smtp.gmail.com with ESMTPSA id v8sm954276ilq.0.2021.04.07.07.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 07:35:13 -0700 (PDT)
From:   Barney Goette <barneygoette@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Barney Goette <barneygoette@gmail.com>
Subject: [PATCH] Staging: android: ashmem: Fixed a const coding style issue
Date:   Wed,  7 Apr 2021 09:35:02 -0500
Message-Id: <20210407143502.3414-1-barneygoette@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue.
Reported by checkpatch.

Signed-off-by: Barney Goette <barneygoette@gmail.com>
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

