Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220933EF8B6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 05:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbhHRDgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 23:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbhHRDgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 23:36:32 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85086C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 20:35:58 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id u15so916950plg.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 20:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EoTD+9gdzWVQQgsWt1rt2oOyKjIz9skCn5yxqOmC3zo=;
        b=pVeg7w7P875hbyg3bTn84brdJTkJ8iFc7UK5zIrFpTJ8irRojNeSsVZKELAr1Myctn
         EqII4735e2rObDRI3Yd56bHjnL9ZWIB60ctbOgg09/wHWMN2bB/HcLyQlOVGJZYWCM5h
         482t0+BrLDhliLZR/jRD466g0KeMFwG+QO8RhauTw0lMnZ5rSgoEUZGKJDpFW9AAxJjn
         m3I6R8zzO5gATxEiD2CYqmL/wzrIlkMzDrtUheaLlSNB5UK8I06zIDvtncy+QFfxuwUv
         Q5sqUZOcIrwpQPCtWuoGZOSghergP2bJRY+na3GilNXjzWmDeYxuwywrh0NQv+1ndK9k
         NphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EoTD+9gdzWVQQgsWt1rt2oOyKjIz9skCn5yxqOmC3zo=;
        b=jRChiJ2yhLNhi0MPP9nWM9SIjPc5XdhdLaYIjwlt57mBoI5IBcntM5DvqHDRwfIGDe
         fPqn9T37RsoCYDqPmPdW3xXjn6wqTwzNBL/iQ9+4B09Yah2RiXMwmp67J8MnHVWXrMET
         gr7J8E6gUN9Hmv/pt/n9gmaiLuya5Id39F0KKXpxtqrJA85HG6E0bQMzsIIPJnkAtaTI
         u/xqhcomnBiNmz10k08AtOe2Mkmc0/Y6VdkcP3Q40c+qBj2XppsZoatKn0mo0+GWjQuk
         t5OdvM2wOLl5Ay2lLdMkQQXD8EO5jirFsLQkb5S5a8Qe++s9fhynUJTftHq1UgG+PdXl
         wUyg==
X-Gm-Message-State: AOAM530kiwEKveN8sm7t4q+NV9XleaMdJf3D7danGk7FTd0415nMWZ62
        LMZ1pCAgeBKMtx3ceGZZ3J4DWw==
X-Google-Smtp-Source: ABdhPJy7/RHf3X+g1zoSTwUZ+x+dwqR2Mme5lAt2zkS8vxqJXUy6l+yqqb3nxmP7N//YmDMbzSNIfQ==
X-Received: by 2002:a17:90b:1950:: with SMTP id nk16mr7099560pjb.11.1629257757974;
        Tue, 17 Aug 2021 20:35:57 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id j5sm3431254pjv.56.2021.08.17.20.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 20:35:57 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wolfram Sang <wsa@kernel.org>, Jie Deng <jie.deng@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, arnd@kernel.org,
        linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: virtio: Update i2c-adapter's of_node
Date:   Wed, 18 Aug 2021 09:05:50 +0530
Message-Id: <376bd0a3a34e8f0de297103dd2f711bb236a8615.1629257677.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set of-node of the adapter to the virtio device's of-node to enable
automatic parsing the of the I2C devices, if present in the DT.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/i2c/busses/i2c-virtio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index d3e60d9cde10..2dde69cfb9aa 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -228,6 +228,7 @@ static int virtio_i2c_probe(struct virtio_device *vdev)
 	vi->adap.algo = &virtio_algorithm;
 	vi->adap.quirks = &virtio_i2c_quirks;
 	vi->adap.dev.parent = &vdev->dev;
+	vi->adap.dev.of_node = vdev->dev.of_node;
 	i2c_set_adapdata(&vi->adap, vi);
 
 	/*
-- 
2.31.1.272.g89b43f80a514

