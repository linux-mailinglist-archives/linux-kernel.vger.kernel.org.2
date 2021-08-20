Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CB43F2861
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 10:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhHTI0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 04:26:34 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:52586
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233287AbhHTI0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:26:24 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CA27A40799
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629447410;
        bh=CAnM46WD3rUSG/zVXFycLibrCZJUMVr4dm8Wv62opn8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=C3h2fzJMMThVMtDQtqxDUhNURt2onHj3rv6AM9nc3aGf1Lo5iWsU+6xLDxNwFQ6j+
         /Edk3oap+J8YbEZzayEUQKmCOv0QQv6N8dD7UcAbBaLk6OWma8h0cQHxPmEPaT4Jpv
         xCe/yh/Zk2aEussNJHrxS6ihnmaYUbretCu/5b+OngZQgNTuFjNkeKQJ/XfRZynk6C
         yJHfKXth4dAxg5vAPN3BtKmJS5AHxXEft1nIxOoIITJDK5lSjKV8giDknNdGt3IItd
         QFXp7reNf9w+28Du9SZu5mH9Gsg9IbuTUQVT9jD/2FzV1DwSqbYxSCBUXnsR5Tv5Js
         lzpPzCZfDi8eg==
Received: by mail-ed1-f72.google.com with SMTP id x24-20020aa7dad8000000b003bed477317eso4184412eds.18
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 01:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CAnM46WD3rUSG/zVXFycLibrCZJUMVr4dm8Wv62opn8=;
        b=IC4KoBp8nOBSLLcyMaMoHEMQ5JL6r+pUvVnnbEwT5UECow93r628lPdjEX2aJ0Ozf3
         TWAbhWU1vpjTdxrTkzgrG7hPRMbfHx+dPEO9nMo7BLOUTd9Frjv68UewtTYEdeIK82mC
         1US0qm5Iy773QpkzPu3UCTirMiOUss5DiCZKTRgyjZJjAX/O7pAIh5v2UcXoTz1FFB/y
         7ofhrekDeLCbB5VP2sRrP74Eb0If8jH6FEJOz6OgTCI0n8ZDz54TRX6hDoeAas/oJ2Sq
         PARnwaLvl1U59y3YzZ3nFXXp2CtPYpgtlz2wC+wTWBAwrr8usRZB693IlHWYxTCHdjt5
         4m9Q==
X-Gm-Message-State: AOAM533JMl1lOF1EMr+GaOrd0HK5fwNpiAb+TK7YH03jpQAGiTH4W3dN
        MQOFgwfSYLjW1UaH7XXvfpGPg1w3bXVZLP9YWGtCKW8fvNGFd31XHFX7kS0WZeDggtUQmSxZCQn
        0WWoDqj+HFOoUqBmH2wjTFyqq+//4y1XaE5n6PgKeuw==
X-Received: by 2002:a17:906:ad8e:: with SMTP id la14mr11816017ejb.113.1629447409105;
        Fri, 20 Aug 2021 01:16:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvwviqEoH9UbW+nsSARGzJTvy19NqOU+gEpu6eWTsyTkkmX+RW4mWEDT0jMql+QW4qXh1vGg==
X-Received: by 2002:a17:906:ad8e:: with SMTP id la14mr11816006ejb.113.1629447408938;
        Fri, 20 Aug 2021 01:16:48 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id g16sm2457764ejw.74.2021.08.20.01.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 01:16:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/2] arm64: dts: allwinner: h5: align operating-points table name with dtschema
Date:   Fri, 20 Aug 2021 10:16:44 +0200
Message-Id: <20210820081645.83796-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the name of operating-points node to dtschema to fix warnings like:

  arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-r1s-h5.dt.yaml:
    cpu-opp-table: $nodename:0: 'cpu-opp-table' does not match '^opp-table(-[a-z0-9]+)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-cpu-opp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-cpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5-cpu-opp.dtsi
index b2657201957e..0b6914a165b0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-cpu-opp.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-cpu-opp.dtsi
@@ -2,7 +2,7 @@
 // Copyright (C) 2020 Chen-Yu Tsai <wens@csie.org>
 
 / {
-	cpu_opp_table: cpu-opp-table {
+	cpu_opp_table: opp-table-0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
-- 
2.30.2

