Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F85836A8AB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 19:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhDYRuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 13:50:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51468 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhDYRuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 13:50:01 -0400
Received: from mail-ed1-f71.google.com ([209.85.208.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1laisi-0005G8-Vb
        for linux-kernel@vger.kernel.org; Sun, 25 Apr 2021 17:49:21 +0000
Received: by mail-ed1-f71.google.com with SMTP id i2-20020a0564020542b02903875c5e7a00so2312955edx.6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 10:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hwe4LiI2mB2p7vvt78qDlg9KbaNBJtoApmcjF0+mFaI=;
        b=DVdY60D2jh4BfrIwsGKP+uutd+0XYMSwMGzm7a5lMhKTLoyuyHPsfmBYDxnOdB9HRs
         gHj/nPrBCUvXIW2lGNtzjWH0Ms+S+mOwFC6bGP9KFQtxRxAexU04aCJBCJrzDzKWhJql
         QgcSWLbKbj9Ay9C8do+3iWVdUy5TB8/K7U8NSbGrx8TiGYUlp2Zwe5uMsRYZW/CM3NRX
         LjuDIxxUuyl5QGe5Ertdnnr1dn5ky4fl+ke+TyFRonqndPkRvZmeHcCCm3l7mPgD3E6e
         JBNzkJeDfY3atxJfzTE+SJEvqNQuF42PrVF4YD/gicMExzi5dGvpPULjV6zENgapjZr0
         +uXQ==
X-Gm-Message-State: AOAM531QYo9barHc0DCHe7TsY7DXGMLZmCd9pXi5F+1YXmOKY2Tmjlrk
        iBELK/nIcS2Pws396L/8KmpYxSNLG3WD1mwQqAzbCfpiCwGZ/x4mRaavzgEwpYnSdAQXm7Gr7pc
        Ctf4Fb92eXItSIJpgtMCzS//EzFj14BEaBCgC3nhUIA==
X-Received: by 2002:aa7:d9ce:: with SMTP id v14mr16921388eds.110.1619372960669;
        Sun, 25 Apr 2021 10:49:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2a5Ye4BWF/Syln3Li03foCbrkIbPmJ88zvLzsdqLilS9jE2MfCrBCU8lMkLvF1sifmkLDYg==
X-Received: by 2002:aa7:d9ce:: with SMTP id v14mr16921380eds.110.1619372960519;
        Sun, 25 Apr 2021 10:49:20 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id b22sm12503206edr.52.2021.04.25.10.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 10:49:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] mfd: Add missing of_node_put for loop iteration
Date:   Sun, 25 Apr 2021 19:49:18 +0200
Message-Id: <20210425174918.164470-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early exits from for_each_child_of_node() should decrement the
node reference counter.  Reported by Coccinelle:

  drivers/mfd/mfd-core.c:197:2-24: WARNING:
    Function "for_each_child_of_node" should have of_node_put() before goto around lines 209.

Fixes: c94bb233a9fe ("mfd: Make MFD core code Device Tree and IRQ domain aware")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mfd/mfd-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 6f02b8022c6d..fa7d86302be8 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -198,6 +198,7 @@ static int mfd_add_device(struct device *parent, int id,
 			if (of_device_is_compatible(np, cell->of_compatible)) {
 				/* Ignore 'disabled' devices error free */
 				if (!of_device_is_available(np)) {
+					of_node_put(np);
 					ret = 0;
 					goto fail_alias;
 				}
@@ -205,6 +206,7 @@ static int mfd_add_device(struct device *parent, int id,
 				ret = mfd_match_of_node_to_dev(pdev, np, cell);
 				if (ret == -EAGAIN)
 					continue;
+				of_node_put(np);
 				if (ret)
 					goto fail_alias;
 
-- 
2.25.1

