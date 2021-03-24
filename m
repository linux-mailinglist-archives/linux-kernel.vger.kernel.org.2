Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B956B3471A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 07:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbhCXGdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 02:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhCXGdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 02:33:05 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF83CC061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 23:33:04 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id g20so17020228qkk.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 23:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dr9jAGq3XCBEKD5miWJ7SRdpms+r36rKblFylD5bbSw=;
        b=ClS1JKychuCuV/wp29mYuMdQFoLOQLOg0eNzug/TKd2GoX03p4+ECOjY9ZY7nfGcOx
         VySjJZTRNRQ9cGbkbbpcTeoux0t/bZsXFCwh+e+i1ALIX6sdjCcl1huIG9Nlug3swKvf
         9FjkUtvrYmjNur04CPZEv/GSE/UlxaID8d4SkGvbWWQWwiYMtYPaoonOrZd7yVighdKT
         DyZhOEJoe0KV4Z1MuVCbdq+xC0swo7HaJLC5Roh2qPqqZ4GWzs13RCFbW6Ugno2mD+8l
         xMltepqDnpU8BXgOJiEaSeJOCjz+cvSIky6uTHI0iHm7YRXv1l8Xsaqlzs/NiI/X4Xze
         Q8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dr9jAGq3XCBEKD5miWJ7SRdpms+r36rKblFylD5bbSw=;
        b=DyYQV+YBzcpGrX51cb7m13SfygR2ObW0QtMc1O8DjpKb2GtNIehxN9o45jaP7077ZP
         yoUmmNNZATBu4ysBOu2txopTSQmAJrECypOavlZwjs12ZiU6wa4Z1eHMGGJfZPB46vjd
         J8Ie89mSGi9nAx6hqk7WnQ4bjuWJDprUA3YKz/g36IquVQFuHnH4roK/kIirALdmCV0U
         cLKzc/MzNHQO4Yd8CVvnFdyVaKIwe5GnWBoL2paURfgsBVnq9NhswzgVyE747pu2VMOL
         Tr7KAQ77aMA8PdsBm975Ak6kazSvLjrYLN2tysI4bNZ9wen5BmRU+1vhVnpBOGb5Ny0+
         i0HQ==
X-Gm-Message-State: AOAM5303Djq0RFrHTuE70t+kO0gHbWzHPmcX9uHLJZ9UVvDTKxmwzWfZ
        8N1gunAjU/72qBJiQPYLYrpNa1w79+B3CMia
X-Google-Smtp-Source: ABdhPJx08Wqua/7QV4jRNH4tZmpPSNaQ9479WSYnC6bWd0xFFtPFlVDf0DpJTfL7sX3Rh/ECQz9uWw==
X-Received: by 2002:a05:620a:118f:: with SMTP id b15mr1628415qkk.5.1616567584114;
        Tue, 23 Mar 2021 23:33:04 -0700 (PDT)
Received: from Slackware.localdomain ([156.146.37.194])
        by smtp.gmail.com with ESMTPSA id k4sm1080755qke.13.2021.03.23.23.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 23:33:03 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        unixbhaskar@gmail.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] drm/nouveau/bios/init: A typo fix
Date:   Wed, 24 Mar 2021 12:04:40 +0530
Message-Id: <20210324063440.14969-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/conditon/condition/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
index 9de74f41dcd2..142079403864 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
@@ -401,7 +401,7 @@ init_table_(struct nvbios_init *init, u16 offset, const char *name)
 #define init_macro_table(b) init_table_((b), 0x04, "macro table")
 #define init_condition_table(b) init_table_((b), 0x06, "condition table")
 #define init_io_condition_table(b) init_table_((b), 0x08, "io condition table")
-#define init_io_flag_condition_table(b) init_table_((b), 0x0a, "io flag conditon table")
+#define init_io_flag_condition_table(b) init_table_((b), 0x0a, "io flag condition table")
 #define init_function_table(b) init_table_((b), 0x0c, "function table")
 #define init_xlat_table(b) init_table_((b), 0x10, "xlat table");

--
2.30.1

