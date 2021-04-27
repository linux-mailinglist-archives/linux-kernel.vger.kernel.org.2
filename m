Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3C36CB2B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 20:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbhD0ShS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 14:37:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57381 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236279AbhD0ShR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 14:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619548593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ylqZA32BdXXOojveMDSUGnGeN2hWjZk/d/9/tdxQ3bE=;
        b=W1xzp0WSpdIvnWTiW9h9Fqc1VlSjtqFqKcyYVeiRqCMJDw6e7OD7tOvyCkNxnv57QaJ+TA
        zLA5t9FFfiMka58KXLhoX9vq4gOVygbGcwkSFI/quDSkB0AAwRVhhpoWe586JPW5DUXeGO
        wQyOJZV8OR+bECxgH2SZ0LLl+rU6bp4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-NJiehrtAM5SXlwfNUAVcTw-1; Tue, 27 Apr 2021 14:36:31 -0400
X-MC-Unique: NJiehrtAM5SXlwfNUAVcTw-1
Received: by mail-qv1-f69.google.com with SMTP id l61-20020a0c84430000b02901a9a7e363edso18192845qva.16
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 11:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ylqZA32BdXXOojveMDSUGnGeN2hWjZk/d/9/tdxQ3bE=;
        b=Ny+vlnZ+sYRBPI/K4ykh5U5f5znbpAiMDGsFQfP3C0HvEyF8Luct9vdCJ1FvgkkjW1
         o7Jv4pqDEdYtmVUVHTqNVEjP913iTpV3arFbynKkl1lQ2WkTwbJJU8gTQisMaNYIiOOH
         sc3fzKdqeQXiDicMj7+UU4s149FDHhXt5tqlA/U/HCBKh9JZ8RwDUclU8IKtfC75QKS7
         I8QPTqZUQYd9MCXw9iaJGt0KsccCiyJ1mt4tpD3hXYTtWSre7UCKTToIgGKAGd9AOdx1
         wYh+75hkXfFJaqTSsn8CMtfyDfEE1AxXM6Mbgi/6ghvwsa4mp415kWsm9l4/KmbCWC7g
         YHLg==
X-Gm-Message-State: AOAM5328I1VQql5jyXWi6YVNwbyn28JgdXS0qSlOIAnYZBkkI2OL/Qns
        VB1v8eLkeE1L+I8E2rAHe4880XcOXswSSqrw6ryH5ysjUhepkb3dTPY7sv27URk6mMTQSFC4o5e
        u6Vw95cuaujs+k3aV4kU+e4Uw
X-Received: by 2002:a05:620a:11a6:: with SMTP id c6mr24703389qkk.51.1619548591110;
        Tue, 27 Apr 2021 11:36:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTRTZOGrYjVtWIToYrvuGbdEL+SWVIHmWMVs1r3zUB+HUuMDD6lN6ce95D6JqetXImN0MiWA==
X-Received: by 2002:a05:620a:11a6:: with SMTP id c6mr24703375qkk.51.1619548590928;
        Tue, 27 Apr 2021 11:36:30 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e15sm3557512qkl.9.2021.04.27.11.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 11:36:30 -0700 (PDT)
From:   trix@redhat.com
To:     stuyoder@gmail.com, laurentiu.tudor@nxp.com, nathan@kernel.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] bus: fsl-mc: fix improper free of mc_dev
Date:   Tue, 27 Apr 2021 11:36:24 -0700
Message-Id: <20210427183624.2790305-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this error

fsl-mc-bus.c:891:2: warning: Attempt to free released memory
        kfree(mc_dev);
        ^~~~~~~~~~~~~

In this block of code

if (strcmp(obj_desc->type, "dprc") == 0) {
..
  mc_bus = kzalloc(..)
  mc_dev = &mc_bus->mc_dev;

mc_dev is not alloc-ed, so it should not be freed.
Old handler triggers a false positive from checkpatch, so add a
comment and change logic a bit.

Fixes: a042fbed0290 ("staging: fsl-mc: simplify couple of deallocations")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 380ad1fdb745..fb3e1d8a7f63 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -887,8 +887,10 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 
 error_cleanup_dev:
 	kfree(mc_dev->regions);
+	/* mc_dev is only allocated when it is not part of mc_bus */
+	if (!mc_bus)
+		kfree(mc_dev);
 	kfree(mc_bus);
-	kfree(mc_dev);
 
 	return error;
 }
-- 
2.26.3

