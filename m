Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98E93BE3B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 09:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhGGHiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 03:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhGGHiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 03:38:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71238C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 00:35:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso1067411pjp.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 00:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U++AYiLCIQ3aO8lSHeGEBojQNtUlJm2+BuKWMbH7HeU=;
        b=mLLVdV+iflZuP7WhIpckLL6oGmDZDvWd9gZiGFfxc6dmnH932qRdGpGvMQQUyL8YNx
         azgpER+zmlOBmCnR2HSYI74skD9Sdl2V0AP6WqO3b7N3EhPHBtjPpTM1zdrLfUISOG2v
         A6cV7jCKIJS17zl1PJqX4Xoyd3CGCOqZuqleo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U++AYiLCIQ3aO8lSHeGEBojQNtUlJm2+BuKWMbH7HeU=;
        b=X1g8SPSnMI2/RmI+Q5Pd6J0S/0KCokhew91jBNSZTf1dVYAmVaWahc78khofXNQWYz
         kDgYVHmcrU7MxY6Q/cKjMW86MXGcoJNLK5u42kJW2+DZKZuEaPshr/jDGHq12wY2zitq
         pm+wP/dEeVbMA2uaYakvqiNhOfnfMnxnz2uZm3nUP1C1JZjSYTnWOWy8TFWB+jtVLbx2
         QY9A1vWNwB2Vg/ZSOy8390UXxYJNg9Mb5+uzWcWJyPipq9O0q09tAfFZ0TPvVuZt+c/4
         xwmI+nrlj5qyC1n60RFW/UphDHGgHZ3aWbaXvMuOyhxTT5ikZTh8xTpC61i2N2HoepYB
         KlXg==
X-Gm-Message-State: AOAM532HvYM4fmITPdnCFHhFTjY3dAvZuDx6AeGmGTRKLYn7xOhw4b6q
        LE6yJqXX4/KOdPMck/B+D/G6ZChJTJ1F4w==
X-Google-Smtp-Source: ABdhPJyTxWMJZj7LL37hggFpu2OU5nP94sCxDsc4uf4pGXQ5BF+hjJgrZT9Q0di1Iz+GO8i0RnzpGg==
X-Received: by 2002:a17:90a:fd93:: with SMTP id cx19mr4663038pjb.65.1625643328866;
        Wed, 07 Jul 2021 00:35:28 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:ccb9:d95f:4dac:dbc4])
        by smtp.gmail.com with UTF8SMTPSA id 202sm18932514pfu.113.2021.07.07.00.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 00:35:28 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     houlong.wei@mediatek.com, enric.balletbo@collabora.com,
        wenst@chromium.org, yong.wu@mediatek.com, chunkuang.hu@kernel.org,
        Eizan Miyamoto <eizan@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 8/8] dts: mtk-mdp: remove mediatek,vpu property from primary MDP device
Date:   Wed,  7 Jul 2021 17:34:10 +1000
Message-Id: <20210707173108.v4.8.Ib681f06d5189351b7fda0e3dcd6b15f3863a0071@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210707073410.999625-1-eizan@chromium.org>
References: <20210707073410.999625-1-eizan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is no longer used by the mediatek MDP driver.

Signed-off-by: Eizan Miyamoto <eizan@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 3efcefd99720..2e468e24fdb6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -1056,7 +1056,6 @@ mdp_rdma0: rdma@14001000 {
 				 <&mmsys CLK_MM_MUTEX_32K>;
 			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_RDMA0>;
-			mediatek,vpu = <&vpu>;
 		};
 
 		mdp_rdma1: rdma@14002000 {
-- 
2.32.0.93.g670b81a890-goog

