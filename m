Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078B240F8EB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 15:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhIQNPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 09:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhIQNPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 09:15:53 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BC2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 06:14:31 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id j23-20020ac86657000000b0029cb70967ebso89917312qtp.14
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 06:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JrjnNmu7/Xbl/QIjypxVMk3ociL3bf/wAlM5pRyPRyI=;
        b=bjM1k9R28SXqglwFD8qF0kwjiVTjTr3BEYdv/f80g6uQZqDwGxZHEWnTfY1quD4BCh
         sEwAO+hyvQ8UuPhbrWgXcAz/7r6d76IVIiv37UChKjbLKsRpcL/ZJlbrT26ffZhrHCl1
         k8T5rLl4myRv3E+VT5cKZajxfdIoBocSiRJ0Xd9wp5NcfvU4yejgFaJsWZqdFRPUmp5r
         Mr43DnnCdEz9h3tbWrfvlx/uPY7X4Tn1qGLCGBUAR9PY2CANyXy0RMhexDruFVO7kwYl
         Jd7XvhW8Ib/STch4nZCNxmg4rlQLgdKa/MMZDlcyPuBA86pNQZ3femc7hjAMOCOK0MVS
         VuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JrjnNmu7/Xbl/QIjypxVMk3ociL3bf/wAlM5pRyPRyI=;
        b=GcACK7DFV1FuGaX7KrrTx0nmD8w3QgskBpZZDop+2mF/AkAwsa5IZeHOkjIJE6TKcw
         ahWGCsNCdPrP+q2A320fxOkbSG3MOOzZCynv6bvLYwgECPUGSg2KJk2gMFZYqdsDU52m
         je3a0aduDQD/umLTpZcQmiWgwhu736M963Yj2bnUKE3//F3tLuXbd7+uDUZ1VxVwZcvY
         pb/tmT0KFkgtIwOooGpqJKZs0Y2zoI7Z3aRWdpZ57pTV+mwgRgvB0ZXunQK8ql0bApvK
         m/Iav8/1IweixjhcC7YaJewFOyBkj7iFb+VMMCAgXE46kqrynwvgDWqqbGsGGqNf4ixk
         gfVQ==
X-Gm-Message-State: AOAM531kKRtKtZNF6gQOdusA3AaUFjmiEaeiOw4LTk1CBi8hDH5SiWUE
        mT23mk7UmjOnAX1Nv9/u1GZLEIUs1Z8/RQ==
X-Google-Smtp-Source: ABdhPJzGxPRERqbFVuDutl/KOYevoTCiuYPRff1GNHJAeyMg+opV8RXRckW7/Ap7pXE8j9MGP5SJDcvs0Qny3w==
X-Received: from zachary-panic1.lon.corp.google.com ([2a00:79e0:d:209:25f4:f11e:ff5e:bad])
 (user=dbrazdil job=sendgmr) by 2002:ad4:554b:: with SMTP id
 v11mr11093886qvy.31.1631884470574; Fri, 17 Sep 2021 06:14:30 -0700 (PDT)
Date:   Fri, 17 Sep 2021 14:14:23 +0100
Message-Id: <20210917131423.2760155-1-dbrazdil@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH] of: restricted dma: Fix condition for rmem init
From:   David Brazdil <dbrazdil@google.com>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_dma_set_restricted_buffer fails to handle negative return values from
of_property_count_elems_of_size, e.g. when the property does not exist.
This results in an attempt to assign a non-existent reserved memory
region to the device and a warning being printed. Fix the condition to
take negative values into account.

Fixes: f3cfd136aef0 ("of: restricted dma: Don't fail device probe on
rmem init failure")
Cc: Will Deacon <will@kernel.org>
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 drivers/of/device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 5b043ee30824..b0800c260f64 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -85,7 +85,11 @@ of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
 			break;
 	}
 
-	if (i != count && of_reserved_mem_device_init_by_idx(dev, of_node, i))
+	/*
+	 * Attempt to initialize a restricted-dma-pool region if one was found.
+	 * Note that count can hold a negative error code.
+	 */
+	if (i < count && of_reserved_mem_device_init_by_idx(dev, of_node, i))
 		dev_warn(dev, "failed to initialise \"restricted-dma-pool\" memory node\n");
 }
 
-- 
2.33.0.464.g1972c5931b-goog

