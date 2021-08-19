Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6703F1FD2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 20:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhHSSX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 14:23:58 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:51060
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232481AbhHSSXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:23:55 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 0ED35411F3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 18:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629397398;
        bh=wXv+g9MByShu0tv6L5ordxjhpc+MsSSwpZ4DgfMhl7E=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Tw/6DYmDUAqjWQoln6W/lijlr4fSV11mi5RSxq0YJxy0pf2MChX2rXYBko45p6zM+
         h8YlUWkFf7VmcCUEvvU5BkNt+yzxoB0K/7lp0Weitx8YCuaunM6ZGrHknWeiKpkVZV
         vclaqR3a31eU3zxBZOfJ8QFT+8HAdCFbr8vvVBf2cFCXhV9djWBVM1XE6xHS9ODUqc
         5ujGYPoIfdXuJG9Sx2AhHcQFfqEULuWr3UOOR5Rxhg10GKvRvaEO4u3Gkpuo34jVoE
         yfGzv/BkhrWG4toapGNI4OWbZfbmnBngzCzO7y016rOUqoCBnhFNxZXnQfyDSw1Znc
         bYpe5/Zfh+nXg==
Received: by mail-ed1-f69.google.com with SMTP id p2-20020a50c9420000b02903a12bbba1ebso3242621edh.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 11:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wXv+g9MByShu0tv6L5ordxjhpc+MsSSwpZ4DgfMhl7E=;
        b=pXQVAM4NmAaNOHa4PZ2KeXEqrHwo4H9YgYPraGtYYnpdgSgViSmCptkIgoVrSCicje
         eTH76Xm7xJSOBUniIFDhb3tmMAk24hBIl/bULAqOmLmqcSpIPRrN5VyC/NdCB0O69/V+
         WCIB43jvfOsTTQ1RogMWuqubKOJouNlg8sWFFS1uSUSIj9uOgbBnCNYIFNtMC9hhsY7r
         KueO+xp6GabkP2kqMnusdd9W4XooNU0XENM5myKnuJGl9gkCR+VhtxZy5A8E8hz9CC4S
         19va5bCdpPArOnx522+HZmWbK0/JTPHSelunC2tAMv34bBNCXNnOEOukrC67xZtlVZDG
         nGOg==
X-Gm-Message-State: AOAM5311Dd4yyYxPcagWH+5pfFYk39AwKVPdfpY7TbfUlA3UAQ44n9hN
        vurLm6jzaY5z1OKbrTHp7lsHJpLJU1bf374vhfDprMAC3rJnIIM6uCJlf1OYR4KggLHpXfNWe85
        QGZlxYlIQ6zvUX+ElPJoZJ3uqI6qCKUlyzWPG+KTI7Q==
X-Received: by 2002:a17:906:b286:: with SMTP id q6mr17000392ejz.120.1629397397748;
        Thu, 19 Aug 2021 11:23:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrG9+2tCoz8kPE9jEeoLuD0BBvKPHrr35QvvOIc37v4HQRU5a/njfqp1KeCSZm/azbfQSHeg==
X-Received: by 2002:a17:906:b286:: with SMTP id q6mr17000377ejz.120.1629397397609;
        Thu, 19 Aug 2021 11:23:17 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id c28sm1602113ejc.102.2021.08.19.11.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 11:23:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/2] arm64: dts: allwinner: a64: align operating-points table name with dtschema
Date:   Thu, 19 Aug 2021 20:23:10 +0200
Message-Id: <20210819182311.223443-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the name of operating-points node to dtschema to fix warnings like:

  arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dt.yaml:
    opp_table0: $nodename:0: 'opp_table0' does not match '^opp-table(-[a-z0-9]+)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi
index 578c37490d90..d55248bb8ddd 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi
@@ -4,7 +4,7 @@
  */
 
 / {
-	cpu0_opp_table: opp_table0 {
+	cpu0_opp_table: opp-table-0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
-- 
2.30.2

