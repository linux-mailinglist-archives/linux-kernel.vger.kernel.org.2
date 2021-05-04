Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EBE372597
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 07:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhEDFrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 01:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhEDFrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 01:47:12 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9841C061574
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 22:46:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id p4so6348428pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 22:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3OaSiVF5MtL/VroYDmXFrkkWbMJTL0iUxMjRnNHvBY=;
        b=gnKIY3By1313xe3KI2MzJaEImpUN67oJ493K6SIizHHcdFT8s+tI+l63jcfiY+tbfx
         prf1DKp3+Q5VfwRSBu/A5kse+Lv/iD8UXwYNZcbdMb0Ino7l5Urqy+n+dxZkgjjzKglm
         bOG2zfjflgNvbpasC3EoVH1cU7yB6UoOhknUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3OaSiVF5MtL/VroYDmXFrkkWbMJTL0iUxMjRnNHvBY=;
        b=HMLTn0BqXdHswEMf7GcE/6/p46OsNttoNTqt9qWvX+nS7MtLMOr3MmWOFq92PPPZHj
         h9htEjAZkCLOkW1FCbvm/qyHV52nZJKdGKEayJbhZlhJ9JjrrlzvKKL4ntHikl201pPv
         nUnWrcEHf5qrKmFMF0hf3vhwuARwLLM5KYf8Fj6GkQdx8Xd28UdiaZLTw6F6ktlLRfeF
         Mm354x5f/Y1jdW6VQE6mtG5beDxWwieDwzHGr6178qL4mTMekmddnvavLozpkBHOl7X3
         M80lO+21Bcm7n57MKJKzn/K+fEbw7eRumTgGOnHktDV0KU3ECTFfpfXzlIavuoUqF6iH
         j9ag==
X-Gm-Message-State: AOAM530Ex++dmr+b6TY8bNNElY8DGwLIAh0Lszd/kh7+BF0ZavsTxAxj
        R1b8Hnd9hGhrB/BJ38ceyKgc8g==
X-Google-Smtp-Source: ABdhPJyAysLJfiaWYGW5sH5Dtp5sZypcC0nLxN7CWjNcj3jP9SuliBIkHoO3P7VeB69JgC6B2ubZKw==
X-Received: by 2002:a63:5245:: with SMTP id s5mr22167254pgl.234.1620107177329;
        Mon, 03 May 2021 22:46:17 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:bf4e:921c:69e1:5d86])
        by smtp.gmail.com with ESMTPSA id g21sm11512515pjl.28.2021.05.03.22.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 22:46:16 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] arm64: dts: mt8183: add mediatek,gce-events in mutex
Date:   Tue,  4 May 2021 13:46:11 +0800
Message-Id: <20210504054612.3585017-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mediatek,gce-events is read by mutex node.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index c5e822b6b77a..cf22d71161e5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1250,6 +1250,8 @@ mutex: mutex@14016000 {
 			reg = <0 0x14016000 0 0x1000>;
 			interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_LOW>;
 			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
+			mediatek,gce-events = <CMDQ_EVENT_MUTEX_STREAM_DONE0>,
+					      <CMDQ_EVENT_MUTEX_STREAM_DONE1>;
 		};
 
 		larb0: larb@14017000 {
-- 
2.31.1.527.g47e6f16901-goog

