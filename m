Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4FB44C8FB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 20:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbhKJT32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 14:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhKJT30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 14:29:26 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACACC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:26:38 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b12so5869851wrh.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=67RflP8EMvWl3pms6qSQzXgIsULKMBC3q9PmqMFeHNI=;
        b=6Z+nm+/nqAhDht1rZGlH/mNfNev5GGs2XCS2grf4aCItbDCNfifaUAIHKy9l8+BQyj
         uhI5IDMkB24u5Qi++8U15ZgIa0ko5Gk8cXFmcZKIJJ4d8qzjA3Bw84qnik4R4seqk5NJ
         YV6ZCg8YWAoLspbhtwdWPjGtqTGSQ6g849jommWhtF6Q5VINSclLpCYLG9241Db6Ou3x
         sx2cvLka6b4WicRbGJsP1RmCistSuGKqaEPK8N7rU/itSFmuxm92sU3RqxNwCK6DsumG
         faG76Avn4/z2ySDBa0X/xgWlEPbL2Voq2dAkzqnNSa6hTLXjgMiLNP8D+KHz/qSQfheM
         1qBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=67RflP8EMvWl3pms6qSQzXgIsULKMBC3q9PmqMFeHNI=;
        b=HwgoaRR6+7Tc1DN+2ThdB3etBfK6qj/I8DeaiN8EmMRdz4Gqb3CR1Wa+HR2dgIoPzn
         rg08jlTj0E/xBeWLZsGrcHg6zYKS46DowXbcFN6V44Gi1sXuyS33WDNPahqORPTxGg8F
         abDK/fbrp0RUhov0YoePwRzhsmFjujGgAqsMKMnjb1u51Ng3j5FIG3EENh5iG4NJoDST
         DGnnhoA6I7QwUIVfhagiDBWj/ShMKD0hLfrfivNpR9Pai6UeHPo1fy8vuHWbEXHEIuHZ
         ige1zFREOWkFlBYYShcA7B9JkT0t24SKStxwXxJgeD+leHMH4ZtOEfV+M6DE/0EFKjzu
         aISA==
X-Gm-Message-State: AOAM531agKqXQNeEbK7WalHxgefCDkGgd38UaiMup0EUhwJgwVbR+Hsn
        4eH28CNBX1wbm0vrFuV5HmQ+Kg==
X-Google-Smtp-Source: ABdhPJz6hgMMPdrdO/rkxLRSJQ8E+hfok+dIssCwkfCmuwTnnaVIj/RzSyF9FTfspETklUhTNBXD7w==
X-Received: by 2002:a5d:604a:: with SMTP id j10mr1781746wrt.93.1636572397342;
        Wed, 10 Nov 2021 11:26:37 -0800 (PST)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id m14sm1282370wrp.28.2021.11.10.11.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 11:26:36 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: mediatek: mt8183-evb: Add node for thermistor
Date:   Wed, 10 Nov 2021 20:26:31 +0100
Message-Id: <20211110192631.4182485-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node to be able to read the temperature for the thermistor
connected to AUXIN0.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index 7bc0a6a7fadf..f3fd3cca23e9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -36,6 +36,14 @@ scp_mem_reserved: scp_mem_region {
 			no-map;
 		};
 	};
+
+	ntc@0 {
+		compatible = "murata,ncp03wf104";
+		pullup-uv = <1800000>;
+		pullup-ohm = <390000>;
+		pulldown-ohm = <0>;
+		io-channels = <&auxadc 0>;
+	};
 };
 
 &auxadc {
-- 
2.33.1

