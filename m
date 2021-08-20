Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C243F285E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 10:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhHTI00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 04:26:26 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:52568
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232606AbhHTI0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:26:19 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 402314079E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629447362;
        bh=3UQWNblXhGmwplCJxI6/0HyVmLBIiw1OIUPl736Eq4o=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=WdKau21fJlUhec93wnG9BYkJzLOBvlC9hHVXWtV2dbYSZ0oPxO0P7u5oPRqduk7IT
         teYOtWYKnPug364onubBZKEeqh68LJJmjnxhRkxo9cX0mF80yLbQBqrEb8Dq3FNA/m
         colS2OXoEfoQ9bMP3551YzExyaazjtrbtx7ljjJHBAVLTjBKMbbumWqP6nqfgsPLXJ
         8VJuelBmy1F+RqdTo9Ozxgq/mqFjb28nvvb0wax2zcTUhbkC4Qw3xhpGx/s4wyd99d
         EMi3QI98yHHQ8hHFZfW4BufUH1N0z0npjDeZ0xR6i+dx9dI5bKM0e8A9Ml9Xpvvaht
         qOkIQU8CzbEsg==
Received: by mail-ed1-f71.google.com with SMTP id a23-20020a50ff170000b02903b85a16b672so4170559edu.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 01:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3UQWNblXhGmwplCJxI6/0HyVmLBIiw1OIUPl736Eq4o=;
        b=LEXCwoqvM8B3TTQEM6nwQVBx3ILS2K0qEl/RrysMXH+X+gWbG0CUrwH1s2aPa6T2MH
         mpKkVlnUBqZAdZVEh2C95iOZ6AzSnQcrK+lXJR9r2mUprG+/gk88o51UnTMSWwYALMAu
         GKMzIjcJHUYY5qedXssdzqIijb6qq/FssqBpXeP69Xo2J9k/nX7k8UIyArRqMD/zPXaO
         WxSK64WLyEJiElUkr+9dM4bNF6r8hQ1Jwl4nxB94Y6RW/smq4Nd0FWV2sr8PKnlY388Q
         L6zdZvjlcKh7U2LoXNk0MX/e5GHHzqI7ebZxqsjxhjucD63xts2BfE7O5QCAq+bmrb7u
         uU2g==
X-Gm-Message-State: AOAM530BuCet0AxxwQOWPeV9f/ycNEyT0I8yO4Ys7Dh3THy1NseriLs2
        kuWG5Q3FnNwrzWKqFEYdUXd51+XCQdRgajvCtigKi+mehZpGp4pfbqdYWCNPW7MvJqasGZcGY+o
        zbwdzy8WGt9tXLiptVKz89R2Y8QWe3C6q5xwNMNYYuQ==
X-Received: by 2002:a17:906:d1d6:: with SMTP id bs22mr19877853ejb.554.1629447361161;
        Fri, 20 Aug 2021 01:16:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy71GytYu/kvw9bjdai2qOvlorr9R3nut2imsPB4iLBk6GmVn1capiHINS5rMIFvYZ11fehpA==
X-Received: by 2002:a17:906:d1d6:: with SMTP id bs22mr19877840ejb.554.1629447360968;
        Fri, 20 Aug 2021 01:16:00 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id m18sm3153704edr.18.2021.08.20.01.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 01:16:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] arm64: dts: freescale: imx8mq-librem5:  align operating-points table name with dtschema
Date:   Fri, 20 Aug 2021 10:15:57 +0200
Message-Id: <20210820081557.83603-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the name of operating-points node to dtschema to fix warnings like:

  ddrc-opp-table: $nodename:0: 'ddrc-opp-table' does not match '^opp-table(-[a-z0-9]+)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 460ef0d86540..3f7524400a63 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -225,7 +225,7 @@ &A53_3 {
 &ddrc {
 	operating-points-v2 = <&ddrc_opp_table>;
 
-	ddrc_opp_table: ddrc-opp-table {
+	ddrc_opp_table: opp-table {
 		compatible = "operating-points-v2";
 
 		opp-25M {
-- 
2.30.2

