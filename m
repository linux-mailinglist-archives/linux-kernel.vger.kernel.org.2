Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B4A387914
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349350AbhERMmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349319AbhERMmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:42:43 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50640C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:41:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r12so10081603wrp.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ldAI2BEKXxmJwnRzX0pdIQjXTGeWN2MbcUVMx3/xOUs=;
        b=O5FmbtkdFv+oxMelevJi0tWdjn++hJ44o/jcC2ZARwh5sLYFn/lBlDfzF0XNMlknGC
         4oengB49L5SsD1PCzBRJUNCWqKKGU7W8K5jmQ0+jZ8Je+iEByHJnSUzoKFoBAqCZ7jJQ
         JheLx6ziP873975yjnVewJo7F9qgF2qp/5Tf7VyddT2ZVykln/d6yMPEJezmBC5KoRMJ
         FDFMHzr1T23wTcwGR7T3lIXTVw2NsqSnAD2GXe8b0dblFIFQhoA1tlmccGF5nZ7NPQUm
         7oxaAWpvnYIEX1aMh+9JO9Lofgt3Nx/w/ELjJyMhDtPOXS7lYpscDGScCov/uX+Kgcji
         ZmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ldAI2BEKXxmJwnRzX0pdIQjXTGeWN2MbcUVMx3/xOUs=;
        b=oJ0PARpat121vcIjWWGZ8TtmoRbVu313+KN5n1/TuMkOi//yuRdcR2R4ni4vrv0NwL
         M3Jy1bkDHmfDkI9fiQeH2mdzaQ7lIL9h1HIUYwkAswTP1T+61onEHDnruVECt/xu5OjZ
         e7SCPdn3QDwjEwlmookxEO4VX89v4wiQgjdzHdMBJFurDl5hHimSdE0U8P605dAT11sK
         nQE2i/TeorH6wPr0pT1XJBZaLFtDOw/9aK3nd0YyIvF0EnTw7vJl4nqpGA6/q0DIYTH8
         4wZvOFlF+ANExC4BFGn/iRcdS8GIdB5Ga93WlKRlmKz3NyTKDPvkTBWU56C3434BrGU0
         gsBA==
X-Gm-Message-State: AOAM530t4wW6mzwtv9cmbQGNsLRKTx1d99+R5+XN7wHPLIdLvkLcPBBh
        IslyEevp8D7qYbqb7vsYUUG4aw==
X-Google-Smtp-Source: ABdhPJwfe0oVtQR6+PwolxvP1DrBzzzVAuvX50itJs00RINjQWwDB1/8Aby8FoFAtrGLlYghJslkrQ==
X-Received: by 2002:adf:e484:: with SMTP id i4mr6694239wrm.117.1621341684097;
        Tue, 18 May 2021 05:41:24 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z3sm1677239wrq.42.2021.05.18.05.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 05:41:23 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mjpeg-users@lists.sourceforge.net,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 5/5] staging: media: zoran: change asm header
Date:   Tue, 18 May 2021 12:41:13 +0000
Message-Id: <20210518124113.1823055-5-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518124113.1823055-1-clabbe@baylibre.com>
References: <20210518124113.1823055-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As asked by checkpatch, convert a asm/xxx header to a linux one.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zr36050.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/zoran/zr36050.c b/drivers/staging/media/zoran/zr36050.c
index 8bb101fa18bc..c62af27f2683 100644
--- a/drivers/staging/media/zoran/zr36050.c
+++ b/drivers/staging/media/zoran/zr36050.c
@@ -16,7 +16,7 @@
 #include <linux/wait.h>
 
 /* I/O commands, error codes */
-#include <asm/io.h>
+#include <linux/io.h>
 
 /* headerfile of this module */
 #include "zr36050.h"
-- 
2.26.3

