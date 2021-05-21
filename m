Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EAA38C9AA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbhEUPDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbhEUPDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:03:41 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA08CC06138A
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 08:02:16 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so18337895oto.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 08:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xm6m2knyDpL/AilBChBzFOY2/qamtbXCofZcDB02RLQ=;
        b=Q22x2wvK1MAFQV8Zzl+hmt/CTI4iB5OIFaZsce8GvK9OmOk71oW3p/M7t5Gsns1reo
         rU1RrseTh2g4HJDdqKKLYSfggRaJflV80K2fwhCwLQULeujBvsLK2FSoURhqxfhtDIE6
         B4nCAI5170tL6L0QCC0AfoVQJDtNzUU2oZ6f7oGOYsctL7dC8WuKjhExUjGNFGLxhurb
         EPGMzKvyOhK3NqteGRQw6J2v5HkdBl7kudaqoD2lBzpEY6YXpx2vCycZSdHDhbRL3iXD
         Xl5JfQ89f2974pNcqAds5jZ7bvhxfcGjikJH4G+MBy6b9SqmWT+4Ok5XVN6H8HLH/YDW
         0g4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Xm6m2knyDpL/AilBChBzFOY2/qamtbXCofZcDB02RLQ=;
        b=TJa11ec+DzeDIV215C9ZfTkPieQ0dks7gPXGeCMFqi+aw51p8wN5DQmT9CNfXofuni
         /G8Sj8cCxqsUvuuuNp7UCpbUJdYysb8wM6d5JnukQUmLrQN4gX0Yy2+yU0ffrVIh9L8+
         R9/KjC/mqL4OGVDVoLjEgNXgcyHIvTvrwh/vZ/4AjLHLUaWyYqZpXc8exKmDLofbVj1t
         Vddn0M1ErY1t6MQ+Lpu617hWKlGe+xA8JYaQhGmsSWWnDXC+e098psECyOGParyclh0y
         wAJJn3RaPij48goXFa4Urf0mA4kK69M3Dx8hnFGrcPGo9XqmknWiML/D2098kb7SSzha
         1YCw==
X-Gm-Message-State: AOAM532TF/ALWkjnndSN0i2mO9X7hMfpdYccsMIbtQ1ckcZ9eyQ13Lxf
        utnpvbA8qgLZra6jK7mqLC4=
X-Google-Smtp-Source: ABdhPJzBX1h4p+8/h8rsfNFD7cFOY65U2w6cXqocFALaQLA8lV0n7ScJpvmaq04SDHCvCuYexmlhAA==
X-Received: by 2002:a9d:4d84:: with SMTP id u4mr8749017otk.136.1621609335861;
        Fri, 21 May 2021 08:02:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 88sm1331650otb.7.2021.05.21.08.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 08:02:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Felix Kuehling <Felix.Kuehling@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] drm/amd/amdkfd: Drop unnecessary NULL check after container_of
Date:   Fri, 21 May 2021 08:02:12 -0700
Message-Id: <20210521150212.2076151-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first parameter passed to container_of() is the pointer to the work
structure passed to the worker and never NULL. The NULL check on the
result of container_of() is therefore unnecessary and misleading.
Remove it.

This change was made automatically with the following Coccinelle script.

@@
type t;
identifier v;
statement s;
@@

<+...
(
  t v = container_of(...);
|
  v = container_of(...);
)
  ...
  when != v
- if (\( !v \| v == NULL \) ) s
...+>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 5b6c5669c03d..2f8d352e0069 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -110,8 +110,6 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
 
 	workarea = container_of(work, struct kfd_sdma_activity_handler_workarea,
 				sdma_activity_work);
-	if (!workarea)
-		return;
 
 	pdd = workarea->pdd;
 	if (!pdd)
-- 
2.25.1

