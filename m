Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9EB3F9248
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 04:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244083AbhH0CUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 22:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244004AbhH0CUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 22:20:09 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADADC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 19:19:21 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id k24so4712461pgh.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 19:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Fudd8jhG4G4A8TwkFkc6LJ/nOYeKTZZ7GsfAF8ps2HA=;
        b=ioQSQPB8D9MKu84GyC5cgvx9tWkRTwbjHbZSufgrUucdYRk+9P+kTkZlP6RN4MlVeW
         QiO93lCjZV/Fh6SK/geKFBFDRgedEoZ0wg3UQkcLcdrGhQ5JRfsWPb2XtkK7JYK3fWNY
         dUKYWAalDqikYs5OnLUvtK+fboeFWTPlSqAb8l1ruh5wjFxCSC8gHUI53vZKQO8KDYTd
         WcOk6ZjrzNta6WgBzOC4+coi2PFbcoWkLhVbkIV3HU2RvNt1dLuGLpZghKkvN2WmX01m
         guoIG+wWS94FclSn7meiJG9S6gAdotRVEHNFEKI3CKyBO7Um4Fxl/N9LKNH2Xbg9fMXT
         bFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Fudd8jhG4G4A8TwkFkc6LJ/nOYeKTZZ7GsfAF8ps2HA=;
        b=Lhiq9WAKAWetb3iftUuvyWeebFjnAw3iV9oi/U/Za9KWpkezm9Iy0n4+epX8oXWE9N
         nR7lMH5KfyoxMr2ZfVNbQ41TyOb7Brjj36S2WDliCF7MeW86SlXQV3yMjSmqxGK9EAyu
         O9E2NBmAwqhxDnZNOBRyJcCICHTDLN1m5pc4jDlHEKbzi7nmL8KVK+p+DIXaKByuseZd
         YUzinTRumrOwMPYCApiNVOZHMhosoi2tlA+cFlF7sl5P91EU5IYa05df5NHJG9KN1yQw
         WDqrFF/lvMyGPmTj0Gs9o4UEB4O8vFp3qTqdDzmDe5szZP5XbVJVrchfQG32A8WK4l6X
         DJhg==
X-Gm-Message-State: AOAM531Ls5ID19dODR7sGGosr5WlmN077n5kds0bEwnqjfiGR+tl8Joj
        cex0zHFtoWfAxTCWVH8fUKNVCfqY6T6gKUPhxzcHI/Zbaq5CVg==
X-Google-Smtp-Source: ABdhPJzPncJRHk/FAgE2+ofNzYkFgWmhUlDvdavaj7iMan8VQN0/qLk92WXneZWSlbpZxcsOBukXrJSWMGoaSN67bmM=
X-Received: by 2002:a63:fd12:: with SMTP id d18mr5934077pgh.129.1630030760887;
 Thu, 26 Aug 2021 19:19:20 -0700 (PDT)
MIME-Version: 1.0
From:   Krish Jain <krishjain02939@gmail.com>
Date:   Fri, 27 Aug 2021 04:19:08 +0200
Message-ID: <CAPGkw+wucg8DKwP0QRfamLHXMjXOYsQiKwdU=wX6LEbLv__XnA@mail.gmail.com>
Subject: [PATCH] Declare the file_operations struct as const
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 From: Krish Jain <krishjain02939@gmail.com>

Declare the file_operations struct as const as done elsewhere in the
kernel, as there are no modifications to its fields.

Signed-off-by: Krish Jain <krishjain02939@gmail.com>
---
 drivers/staging/android/ashmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index ddbde3f8430e..ec18f2ddd66c 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -377,7 +377,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file,
unsigned long addr,

 static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
-       static struct file_operations vmfile_fops;
+       const static struct file_operations vmfile_fops;
        struct ashmem_area *asma = file->private_data;
        int ret = 0;

--
2.25.1
