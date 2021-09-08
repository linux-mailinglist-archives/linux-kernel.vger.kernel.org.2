Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D975403E8C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352672AbhIHRrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352585AbhIHRrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:47:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D35C0612A8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:46:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gp20-20020a17090adf1400b00196b761920aso2068801pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Baz922XdUGTh23cMvISXGBnGRTu0s4UeMCwdvdLeytg=;
        b=bPFlZkprfGTtM5GKmqvWBCCS8Ea8K6CDkrwOgDrIhEGLjYXU33pJyZ+YgKmoXk4V+u
         6CuTDmW4NQbKL6QNZUd3ZhdZ/oZVJ5Tb+G7pIrFi8OGlkWNT1iC2CrIRcu8WfxEm2d3r
         +8qJXpcY9B2iSDb+cRcW0CxCAwGNltsOb0rdz0S1xPxpf8rBHqhF/zD0YNJJfi2BpZI8
         vHW1kBAB5lfubTzhupAmmdVmveWZWEpArXo7gd67n6CJTdgVZ9zcwRaC1dkz85g1qb2I
         JUAVOGBIqdgxiOla342bOzgmv7N7+gSH8uxYZB1JXPByeG/KETRbWWX+YYFNai8Q4vVg
         zpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Baz922XdUGTh23cMvISXGBnGRTu0s4UeMCwdvdLeytg=;
        b=wAqStGnf0z6fvr/sv8ic05BbdiWIYgSvfrvMSVf0XQyNejDFqbh9CUZ5Y3rsVXDLr+
         wKyTMduyOBuPCSckb/A43QHcX+b4evYufvK/BVjDqv776uxb4LF+m5vJ/5JQTFmeYJxn
         35r2Q6ACvEy/u+DJH9hGYw64Xz1wWvKxNOG4YeonR/AHJDjTC7NiG6IUTdvoFCoXK+n3
         g2JLmlZ0SBcLfwwoXLkgn3xRRJoZvX9OEI9DwT1K741jUDpODtgZcEmFByJkkXeYWGPu
         iHIfMpyAagVYXoxfSJyIvxvBS/VVNwsLzWo7K0lUsR/OjhrJ0HXzIfgdDsRI88xElu6L
         WgjA==
X-Gm-Message-State: AOAM531oaY+lQy6K2fAvEdzX3TsVmf+J44PKTreot6+nD25KWMxaF+YK
        KJ2R9rbJj4xC1ULsOjtFQcDff9v8Lka+Kw==
X-Google-Smtp-Source: ABdhPJwVBkkg8Gt0T+XxJWkdO7tCZ5buazt5UIWlW7wDw/gIQ/CynRw1Vj/5W3LGyLCOiEGw4si9pQ==
X-Received: by 2002:a17:903:22d0:b0:137:630b:5d7e with SMTP id y16-20020a17090322d000b00137630b5d7emr4082390plg.51.1631123160924;
        Wed, 08 Sep 2021 10:46:00 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b5sm3108466pfr.26.2021.09.08.10.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:46:00 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: [RFC PATCH v8 16/21] riscv: Initialize vector registers with proper vsetvli then it can work normally
Date:   Thu,  9 Sep 2021 01:45:28 +0800
Message-Id: <5589514eb2d20504725821807800b5bbccf36fe6.1631121222.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It may cause an illegal instruction exception if it doesn't use vsetvli
before vmv.v.i v0, 0.

Co-developed-by: Han-Kuan Chen <hankuan.chen@sifive.com>
Signed-off-by: Han-Kuan Chen <hankuan.chen@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/kernel/head.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index cf331f138142..42eb3203fa77 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -442,6 +442,7 @@ ENTRY(reset_regs)
 
 	li	t1, SR_VS
 	csrs	CSR_STATUS, t1
+	vsetvli t1, x0, e8, m1
 	vmv.v.i v0, 0
 	vmv.v.i v1, 0
 	vmv.v.i v2, 0
-- 
2.31.1

