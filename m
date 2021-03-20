Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB31342FA6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 22:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCTVSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 17:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhCTVSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 17:18:36 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E5BC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 14:18:36 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id g20so6717833qkk.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 14:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eW9CLPE8dtw7JzUG1BTnbHhfZGWuTtjFDhmBxQP6eUs=;
        b=oJI9nJzB69Aa8YIQ2keAyDToFkzIgChBEqReqhYSus+mfZfBnXX1TXubIvCi4XOTO1
         77o1O9z7bMBDFkPGltfRFs3FhoOlJ0uka/QZvYvOxaZgKcWlE6RecmbMg7x7C5hFyWqB
         VsyZ3cYwT/68uICMrGMuL0an/cjwIrC+R1ELsAXH/yoecI+zYX0oRgrYpLGY3nCspcxQ
         E5sEHFBzNT+LvqttN09BQJ0WNXLw4N3HMGA5qLS4dS/bDCgErmREg8aNm2xzWF2zsaT8
         cGysUoSFcil59EpHGk3BtGFeMMoRdtKIQDznpKFmldhXDs+KlaqiXSw8GMxzB7Mx5C4X
         mm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eW9CLPE8dtw7JzUG1BTnbHhfZGWuTtjFDhmBxQP6eUs=;
        b=jr19EyVzG3/PMJ1aZ0YW9ypgjv47nDnBx/K9UgEbCMp1XV8Do+7igxuaYtKgBx2w34
         WmeOkQRPreoZcZWSr6a3O1RFiNJRp+DPSj/F58x4aj/CWb7fG/UIvPQ5SIdtGnaODOUd
         m64q7GlSClyNnL2NXr0vWY+k4Q9ua75A8nWvxMAYll42dNiLPpwhaINnSLK81JL/2uB3
         6UcS3IjzLBnhxnitebH7xk/IidbUrAcCAJIGHXWH9MDOitgr3jLlxKNN3l/gc52/+3uM
         U5RherP6JYbCMV3LXzZcLnf1fTbIdpwjnfR9/MsmkhkutpNGcAvOPmV+/blzjgrEb+xk
         UgJg==
X-Gm-Message-State: AOAM532wzj5j37YICex2RfUfP8RDSPdiuz9UcQuTTziuy1tPGF7H2Fsz
        OiOp5jQiWnQPwxejLl3g5PM=
X-Google-Smtp-Source: ABdhPJw4pHIkaWnH2Q9mj7fDLSlRthADMyqtLAmzflt1CSaQWrcX1kAZPuP65ibqTJ0FhIphEjh24g==
X-Received: by 2002:a05:620a:1277:: with SMTP id b23mr4255955qkl.457.1616275115448;
        Sat, 20 Mar 2021 14:18:35 -0700 (PDT)
Received: from localhost.localdomain ([138.199.13.205])
        by smtp.gmail.com with ESMTPSA id s6sm7452644qke.44.2021.03.20.14.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 14:18:34 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     linux-graphics-maintainer@vmware.com, sroland@vmware.com,
        zackr@vmware.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drm/vmwgfx: Fix a typo
Date:   Sun, 21 Mar 2021 02:46:17 +0530
Message-Id: <20210320211617.30746-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/particuar/particular/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_so.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_so.c b/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
index 7369dd86d3a9..6cd38e407145 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_so.c
@@ -33,7 +33,7 @@
  * The currently only reason we need to keep track of views is that if we
  * destroy a hardware surface, all views pointing to it must also be destroyed,
  * otherwise the device will error.
- * So in particuar if a surface is evicted, we must destroy all views pointing
+ * So in particular if a surface is evicted, we must destroy all views pointing
  * to it, and all context bindings of that view. Similarly we must restore
  * the view bindings, views and surfaces pointed to by the views when a
  * context is referenced in the command stream.
--
2.26.2

