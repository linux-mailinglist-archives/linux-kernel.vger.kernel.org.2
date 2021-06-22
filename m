Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382433AFC24
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 06:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhFVEqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 00:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhFVEqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 00:46:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A69C061574;
        Mon, 21 Jun 2021 21:43:52 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i4so6082726plt.12;
        Mon, 21 Jun 2021 21:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=caIQJ1mUw/Qq9RPSpDxrIHGCVaQe3qBahSzrBXQocF8=;
        b=c69jBUXPH5lSnMFPSZ5QtjVkOFfoGLO8g/NWjmEelanP4ibDUGn+jSqsroEJYY/Qhs
         Y59eNY1NqkJkZT/28WGjOdpDkq0bcK2GzCeMdopf8dKGlRT+QivU2rXT5NJyMf74G+Vp
         txh4hs0fD0Om5jC2rTqswlTxrbkpgxPNmO6fklMcd5Dez4QP45awQ83ABmwIujAKQe4n
         0RNop3pp2jxZK/Iaxnp96ABBalq15M0uB0onZDNCtDYuIYaULlSXItszFz4ic4YWiJN0
         UrIgus6i5KmV73rZF5Vnt+ah9JNU1HBszWDC7sWzEGTNFm8nqZJMeopD7MgwQ0dUUE6I
         xDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=caIQJ1mUw/Qq9RPSpDxrIHGCVaQe3qBahSzrBXQocF8=;
        b=cGtAM5TrnvoxdAtoTxdQdW5pc7PrDrlYnPFsC1ytn+9+NI5Nvr/lWB8eYjkdqJSzxW
         wOgX4T0ED1FNgrU5uif7QGpA5wB+Jp6PCDJVKQys5qyULqZfZOnrhGUVwpeFqX9WYPaF
         VYecFURPEtpphnRbldTj3eUfq2s/RjO7uBQynuwH4d8C3W9RrI/66o72uwOBxDO2GMu8
         2+sS6sIXIZN6CRcNb5ym45LaEeI/2toUyv2QGVvlqReiOxZNvwHul8Pd97rsJ3nCVw4o
         aa5g55PxzO33fhEw+9V3aDAFJsbnAkcEY9xiAqYk1WgYiA6G/FeqMEoUJsnwzp7X+8GN
         4qUQ==
X-Gm-Message-State: AOAM531n4NaRbKc6RtQKa52pL36yEzXt9yJeuckXiv6CWTydvPFYrrgR
        jt/2Kg6VIvlad6gHjh/p9nA=
X-Google-Smtp-Source: ABdhPJwpqKeV1sZnIB2l/74DjTgWY6b5ubBtObEhV4nqB0CGPBqdzBr+reFoiW+7mBQeMDudq9qLIA==
X-Received: by 2002:a17:90a:66cc:: with SMTP id z12mr1940520pjl.93.1624337032080;
        Mon, 21 Jun 2021 21:43:52 -0700 (PDT)
Received: from localhost.localdomain (104.194.74.249.16clouds.com. [104.194.74.249])
        by smtp.gmail.com with ESMTPSA id v129sm8686909pfc.31.2021.06.21.21.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 21:43:51 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     khilman@baylibre.com, robh+dt@kernel.org, jbrunet@baylibre.com,
        christianshewitt@gmail.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH 2/2] arm64: dts: meson: improve gxm-khadas-vim2 wifi
Date:   Tue, 22 Jun 2021 12:43:34 +0800
Message-Id: <20210622044334.769791-2-art@khadas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210622044334.769791-1-art@khadas.com>
References: <20210622044334.769791-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve gxm-khadas-vim2 wifi performance
* change freq from 60Mhz to 100Mhz
* add cap-sd-highspeed param

100Mhz works well same as in meson-khadas-vim3.dtsi

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 18a4b7a6c5df..86bdc0baf032 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -307,7 +307,8 @@ &sd_emmc_a {
 	#size-cells = <0>;
 
 	bus-width = <4>;
-	max-frequency = <60000000>;
+	cap-sd-highspeed;
+	max-frequency = <100000000>;
 
 	non-removable;
 	disable-wp;
-- 
2.25.1

