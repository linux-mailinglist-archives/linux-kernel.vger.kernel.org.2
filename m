Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2559F3F3807
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 04:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240984AbhHUCPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 22:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhHUCPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 22:15:36 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8AFC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 19:14:57 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d9so8994577qty.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 19:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6STgSGZ0ne/Nx/83VAe+oOZszhRqsF3iqXGqkGSzJtQ=;
        b=QH1qTpBPHpaHV7ujU/tafTzRoGh3Yj6auyTQC+8KUQiQnhbcNjfyKdSu1OqGt1u1OB
         g+3fkf0YkOPjZNofYj6QR9OB+ErT1wb/e7tUIhOkPZUkLdCoUoWvStsvhDVWlBE+bQoE
         xNpYJnQOkP3Z3DotJCZBKVgNg53GOjo1IakiQxqgUKhmdqEdpvBHDrolfkkYB1dQHBRs
         3zM884eUF3ZbreP3E6cQI8ooF+VmTWWeUHPm9r98RKsN/yINGp4OXeJ69r//aolO6g4R
         ASCmlmOWGMyOLORz6Em9Z9pj2S6LzrltjZ4d87QF+vZhCsZg4l3csgeSgNqk5TOX504i
         2aWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6STgSGZ0ne/Nx/83VAe+oOZszhRqsF3iqXGqkGSzJtQ=;
        b=DfW5y0dwIvQZaMlTPQgA+j3Lgm7EvKc43f28z9GY2E17q0eCFkT0HrlHlsMgr5m0vi
         BQymXgCcDUApxDN7qBo1yhZ97Y1SS1Qb9lbdW/+EreXJSvyHBoJrYVnvKDzT1swj8Bg5
         NYOqGq5wkavGSgCe0sP++G24RFWhc1OVrWNv6V4LKrOO4cJGSWeG4J6k99WbfGycXRKt
         sSmzFZVd/7q+uWtD1ZRgWju10N1aIMH6gPtckltydXIle3HNasW7RsK+UvvUady9mIg8
         hB0S8ORXd1czM3Y14fHP0QmbCWmE3mGSOfK1XzP+bgY21vHY3ti1LpolbY7MsirdQmjL
         nhYg==
X-Gm-Message-State: AOAM5311aJMmNvi5PGYYSXiPrrKZ48dHj/eXTV5eqP4t0irlcFhA6p/4
        B7XjX/3RlU6UAFIE4CDcMv4=
X-Google-Smtp-Source: ABdhPJwAwcTplKmsBZ6biN522ujUKacGXgA8/tlud3TXc71xAg7CU2I/Q1v+lFMtuRmOPzvkXRa76g==
X-Received: by 2002:ac8:5a96:: with SMTP id c22mr20523886qtc.229.1629512096831;
        Fri, 20 Aug 2021 19:14:56 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y13sm4495075qkj.37.2021.08.20.19.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 19:14:56 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <luo.penghao@zte.com.cn>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Alistair Popple <apopple@nvidia.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/nouveau/mmu/gp100-: drop unneeded assignment in the if condition.
Date:   Fri, 20 Aug 2021 19:14:47 -0700
Message-Id: <20210821021447.27097-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luo penghao <luo.penghao@zte.com.cn>

In order to keep the code style consistency of the whole file,
the 'inst' assignments should be deleted.

The clang_analyzer complains as follows:

drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c:499:8: warning:
Although the value storedto 'inst' is used in the enclosing expression,
the value is never actually read from 'inst'.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Luo penghao <luo.penghao@zte.com.cn>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
index f02abd9..5d7766a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgp100.c
@@ -502,7 +502,7 @@ gp100_vmm_fault_cancel(struct nvkm_vmm *vmm, void *argv, u32 argc)
 	args->v0.inst |= 0x80000000;
 
 	if (!WARN_ON(nvkm_gr_ctxsw_pause(device))) {
-		if ((inst = nvkm_gr_ctxsw_inst(device)) == args->v0.inst) {
+		if ((nvkm_gr_ctxsw_inst(device)) == args->v0.inst) {
 			gf100_vmm_invalidate(vmm, 0x0000001b
 					     /* CANCEL_TARGETED. */ |
 					     (args->v0.hub    << 20) |
-- 
2.15.2


