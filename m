Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DF5453CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhKQAAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 19:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhKQAAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 19:00:45 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DBFC061746;
        Tue, 16 Nov 2021 15:57:47 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id q17so550879plr.11;
        Tue, 16 Nov 2021 15:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vrbIOXmEg+gIS4wEDNBUS5d/guo/eziPZaC2mTYxZXc=;
        b=JWrZ4w7QNwVa8l2FZpPgy01wj1EYBBbDAwBRw1ZHUVQSJEAUVhd7Laz4aO1UhUJSOY
         /v2g56IJj/ybdHGNuNeh616KSX7ScKdPk4+NhebzZvlDJB+mJAOVEMk1zUV8HYhF4ozc
         2/LRBX6ZsthvqkmxwIuq0MWF9cXfyrzfohk66dvudtDYrvI9kh1Y8GGmuP402bAbFWoD
         l8if6KJYJ0nNIehrLc7UNbmoQgwDw1WUHLq+vFieDMACwjVK8A/1DXaz017T654YuSpl
         hnOffQobD248JAzLfLbRxZ3q7+ZM8aqfmF+ttkvPt1WwLqH4qTnQiUi9u7D8NEPQlUUm
         OIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vrbIOXmEg+gIS4wEDNBUS5d/guo/eziPZaC2mTYxZXc=;
        b=OCeuqCkMljU6OQ6AYLflMlcDI1zrQmWYn7SLV3+QyjAhJVM4lBc0fAmPneCqBZ7IFa
         Y9bIoF22qmJv0xBfoJwKgRhT1pZ26jBGWjJT9bVI9eX793icCaylnWHrX58XrCoEnWqX
         uqBo7tHhJ57ZmQhe6L0WdhgaXl9HbcCcuinRCVMuq9BG01DRJClNHNA05RwxhR68sWt0
         2P551MSlSnbsqCtGxDKHXEugWu5z7962rDs64juZrktdCYi92lm76KMtzrHE9Cov7Y9g
         wrJBsJKrffBh/AYm9rq4OqFX+Pofx+X2NBvXFsZYh2LTDq7kZ36+OQiQD4/zSJt4sX/g
         xrPA==
X-Gm-Message-State: AOAM531uO3cQpIHoNzFeEQH1eq28znN1hN8/35t1k9eUyJjxOHKO/0zV
        y64hw7oCl1B03zC/W5YB1r0=
X-Google-Smtp-Source: ABdhPJzmUhE6Hy6mniZz6KoEJb3wtxhjDBL/clLr9G1wQO8UmiPC+vpReQmMadnklyyhjTJymuFmeQ==
X-Received: by 2002:a17:90b:1b03:: with SMTP id nu3mr3873436pjb.47.1637107067201;
        Tue, 16 Nov 2021 15:57:47 -0800 (PST)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id o9sm10314408pfh.37.2021.11.16.15.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 15:57:46 -0800 (PST)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id A11D9900949;
        Tue, 16 Nov 2021 23:57:44 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Subject: [PATCH v2 1/6] riscv: dts: sifive unmatched: Name gpio lines
Date:   Tue, 16 Nov 2021 23:57:37 +0000
Message-Id: <bb7e8e36425a2c243cfbf03a23af525499268822.1637107062.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the pin descriptions given in the version 3 of the board schematics.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>

--
Changes since v1:
- Remove trailing "." on subject line.
---
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 4f66919215f6..305a086e5207 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -245,4 +245,8 @@ &pwm1 {
 
 &gpio {
 	status = "okay";
+	gpio-line-names = "J29.1", "PMICNTB", "PMICSHDN", "J8.1", "J8.3",
+		"PCIe_PWREN", "THERM", "UBRDG_RSTN", "PCIe_PERSTN",
+		"ULPI_RSTN", "J8.2", "UHUB_RSTN", "GEMGXL_RST", "J8.4",
+		"EN_VDD_SD", "SD_CD";
 };
-- 
2.33.1

