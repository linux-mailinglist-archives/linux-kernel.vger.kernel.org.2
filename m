Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED20D30A87E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhBANSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhBANRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:17:39 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE20C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 05:16:18 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id y18so1471403edw.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 05:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s5/eeM3qa/btb6EM5+rqph0mqVQc4OkKhh4e2aNhbos=;
        b=m87Lr8zKV+MWdDb7raetVApFGHICYKY8EJdIP9ETAiOBMiNT2TFieYVZmcploC8Smh
         ACF7A/UKchIQSr568o0U9d4/K3JZ5rc+knDPQXGAMO2DBEHhwosYaDHw8Ru1B4Hn/9s9
         wnec0uqgS+EVQ5VBv2m50QrPeWBmJRIPZcc3yWTxo+vFcbOpLYQNEwf3hUomuu104+05
         Mi845qlXS5qoPXIOAQPzM8ZV3BCnw4yVNki6Bo6/x1pHFXqORdRR64iXYU0+7szPGoV7
         vMn5paP2Ule3dUhHbS1yrRnZ9PblNpoMmdt8VvHEl0rh7pXcrDQgIJyxuIXO6ToZ0Z56
         C6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=s5/eeM3qa/btb6EM5+rqph0mqVQc4OkKhh4e2aNhbos=;
        b=rfhaMNzTQGMdOmF5uyFjRvEmQf96NPYf8AJZ3plXWbN8K70JuDMqFtcNmZOno0rNya
         jnvCdj/lmGhEMur04CgN8IgnLy00F2j9Z6ZXsypqIGPi1PX8FsD4vq6CnFOdGXedb2qF
         8ApWYDNGl94BoFL1unXfkGqMjaUAmU6q4gVLwt8yI2yGIrAL+ulk6Y1cf8JT4GSXh7Rc
         vi2B5Hw8n5bpur0CGPlH7VcY3mkLrL3toMq+10vX/7WPl2DcBxhECybxq8RUm6KfCsB8
         fSRqnP52eGr8qMQkWzOUYJ4GJsd5jQvN7yy4Td5GiVqvQCoY/sycnVnh6G4ZRYopjuHQ
         KUbg==
X-Gm-Message-State: AOAM532pcJ8ZmHkTM0GZSXxaTyFUaNTwywhGZa2FyXFzFf/KnzHjkEBd
        9FDEGtW9pegDhysyazgtcol9dyIe9iKS6OA8
X-Google-Smtp-Source: ABdhPJxiUReEE3I89ozFL6M9ht8nS0MhSjZrDZ+3PtQPvDXz0ZjVFoziMWRmfPMvB029Ad3kencGiQ==
X-Received: by 2002:a05:6402:50c6:: with SMTP id h6mr18475460edb.117.1612185377090;
        Mon, 01 Feb 2021 05:16:17 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id m26sm7874408ejr.54.2021.02.01.05.16.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Feb 2021 05:16:16 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: arm: xilinx: Add missing Zturn boards
Date:   Mon,  1 Feb 2021 14:16:12 +0100
Message-Id: <f6f642d75c1b1160ed78f6de0a2944ab64017691.1612185370.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing DT compatible strings for Zturn boards.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Patches are based on
https://lore.kernel.org/linux-arm-kernel/20210120194033.26970-3-michael@walle.cc/
---
 Documentation/devicetree/bindings/arm/xilinx.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
index aaca69d0199f..05217537fb0c 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.yaml
+++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
@@ -23,6 +23,8 @@ properties:
               - digilent,zynq-zybo
               - digilent,zynq-zybo-z7
               - ebang,ebaz4205
+              - myir,zynq-zturn-v5
+              - myir,zynq-zturn
               - xlnx,zynq-cc108
               - xlnx,zynq-zc702
               - xlnx,zynq-zc706
-- 
2.30.0

