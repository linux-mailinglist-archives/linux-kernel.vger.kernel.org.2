Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349683C6EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 12:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbhGMKxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 06:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbhGMKxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 06:53:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA14C0613F0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 03:50:58 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h1-20020a17090a3d01b0290172d33bb8bcso1195355pjc.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 03:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jpLLVifshAbN8p9woBgv2ZTKXWPkKhiksBb+TTgeAU0=;
        b=xPiyCCSNVpUMFrtC2LlEfZacKYLM5pphD5lCNG/nuXs3LaUM5dOdfAlFOW8nZwkqhu
         KkEF7hs6FWetfVpeyk/kj3vIOQp4c6kMkbj6KB3alHAs2XmY8I3JJLGZsAfy8sG9X+dY
         MlDtHTK4uyqX6888rCNx/o5Z7cT6DVqqrP4t3QalqFpSyc4jzUya9kWF44FBWSom0UvP
         k2s8/NkxjOW2mRNP0ZkIt0ONSWCgLwQWrPScrazAgHeRnZd+2gznoA9yhDKk8YDfK2w+
         yGYMNjQG8zE+vM4M3R7yjJNtvjpVzhwmWwlT3+wIeF14JFd7vkYNAXazbJKODKH7zP7X
         H+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jpLLVifshAbN8p9woBgv2ZTKXWPkKhiksBb+TTgeAU0=;
        b=eB2Zv8qm49tFWC/pmuDrg9mkSuTeAyVFduwJ2DPhINdy+Ej5W8sioH8SbjQXVXixIB
         aAAosnknN7mW3UMXYRuXDhKPt1AHsTxZEKHSEhWWPliHETxxWpArWG8gIlNCK2rh2XTp
         QrsrnL0vV5xpDqkdMLSACGxXqYlDFouxeN6A7tuPXEN2+rnBesk4y9ER2g2FYnQwTkba
         y1WiMcjg5ikscTcslvFc/lpgY58q87ySNt9rhf3Z8Mx+by4WH6sZgGdqquqYMHVVSSkj
         rtFlgbH+DpvPbPbdvvSDFmNBDpgfd612eh/swhOyIlYAt3z+qkNVwZ9AOMHayhMkWJfI
         ojiA==
X-Gm-Message-State: AOAM532yl5nMUDL/yCNQvOeyE9z6ymKNGduklgVGqm27m/4Lma6Tu5UL
        UnRI4Veo1hIXyo9EbYBaymuL0w==
X-Google-Smtp-Source: ABdhPJyA0h7pGPn9Q2oO94AvZyMMvb0OAUTS7pkEtEgXnaYJk7eDeP5GAW7/sEilxZeKxmzO7loJrw==
X-Received: by 2002:a17:902:9b87:b029:11e:7c15:a597 with SMTP id y7-20020a1709029b87b029011e7c15a597mr3091660plp.6.1626173458228;
        Tue, 13 Jul 2021 03:50:58 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id m13sm18415675pfc.119.2021.07.13.03.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 03:50:57 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH 4/5] i2c: virtio: Update i2c-adapter's of_node
Date:   Tue, 13 Jul 2021 16:20:33 +0530
Message-Id: <5465df68b2e18d510fa47e691907287fe655fe8b.1626173013.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1626173013.git.viresh.kumar@linaro.org>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set of_node of the adapter from the virtio device to enable automatic
parsing the of the I2C devices present in DT.

Cc: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Depends on:

https://lore.kernel.org/linux-i2c/984ebecaf697058eb73389ed14ead9dd6d38fb53.1625796246.git.jie.deng@intel.com/
---
 drivers/i2c/busses/i2c-virtio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index 0139cdc33cae..cb8cfae2748f 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -223,6 +223,7 @@ static int virtio_i2c_probe(struct virtio_device *vdev)
 		 "i2c_virtio at virtio bus %d", vdev->index);
 	vi->adap.algo = &virtio_algorithm;
 	vi->adap.dev.parent = &vdev->dev;
+	vi->adap.dev.of_node = vdev->dev.of_node;
 	i2c_set_adapdata(&vi->adap, vi);
 
 	/*
-- 
2.31.1.272.g89b43f80a514

