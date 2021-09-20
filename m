Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8295641153D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239130AbhITNF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:05:58 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33420
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239068AbhITNFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:05:45 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BBE973F226
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632143057;
        bh=KyQicLYMcvTUsuouhObsDgwfTY/CvChfVjl2/JZq64I=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=hDvX46djM7ZMcjesVpGssaknlbsN/pSpc9/S3qva4wVbVWgkZob5bGjGMAnfTDwE0
         1Q7YYQol2vEsvBlgUtvTFfSk8VxqYAMsFeWEwQ6fx1mdBXbj2C9PMzCmnNA6yf9CI5
         fuIgzME6zhZe56eEY64iVZRkTQT9HabhCuNeQF8h61TcejRqMfnSfxbbwK49OaPewy
         nUAD4gO29nYIYrdRiVs9QOVoCIvJGK8kDtdn4GitNp1lyN//QuYPBHkCz/PInY2USd
         97K2PL+qLuiwHjniH/c3dkkqhiR7IB0AdZKRSn0g4Yf6ASnv13j6scpjfkMHcQaUfs
         xnkKPNu6FklGA==
Received: by mail-wr1-f71.google.com with SMTP id c15-20020a5d4ccf000000b0015dff622f39so6006066wrt.21
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KyQicLYMcvTUsuouhObsDgwfTY/CvChfVjl2/JZq64I=;
        b=K9cpCkpSn9GN3RNCDPFUPNcqNIdxdT6JDH5dOpZAiKJj2lf/GVeYwypZYTfjsjVr9Q
         wrUv1x3agz4rrTCDnl9UoM1i5Ii8QftLQV1wd9bYItFR4LZbglmXmVkQmdmbbA+QMoNh
         jbPo/vDTjO/8agfnnE1Gp312GclvYNBysqSRD/IzURZ5HU6jHXIC+xDjjsEzFWJej/wv
         LvcjAvodYNMgZ70HvDTeai7UZQlbXK6Q55UjR8SH4AOxHVOnNGBv4zeykGb7X9+iTK2b
         AhOEOn+puhAjcGEbjKrYEVST4iKWGQAyhjQldpmas1n+POzS+kX3c0gFv2Lsb49NP7F3
         hwBg==
X-Gm-Message-State: AOAM533QbeFoWjAVDaQtBEyjwu+L7eA5+yxJ3OWbfYfDjObOdDInJme3
        4uyUo5KDolouLvRhKy0n8yFnRD/eZgBEAKlQ+fIlWN+zBJpGFKW/ndxTkCc44SHs5A1dqe53UOX
        o1cHAJ6+pnp7tbwjbRt5/xmlWRyH+AX5Li7KifJVBFA==
X-Received: by 2002:a1c:28b:: with SMTP id 133mr24133069wmc.14.1632143057508;
        Mon, 20 Sep 2021 06:04:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypg5QGxpLH5N2pakMgq9jvpjRG8kkva5Tcgev2sXz+0gx7PhG+53e0/fOPWDZYp26XzyqyLA==
X-Received: by 2002:a1c:28b:: with SMTP id 133mr24133048wmc.14.1632143057361;
        Mon, 20 Sep 2021 06:04:17 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id 25sm22965108wmo.9.2021.09.20.06.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 06:04:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 5/5] riscv: dts: sifive: add missing compatible for plic
Date:   Mon, 20 Sep 2021 15:04:12 +0200
Message-Id: <20210920130412.145231-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920130248.145058-1-krzysztof.kozlowski@canonical.com>
References: <20210920130248.145058-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add proper compatible for Platform-Level Interrupt Controller to silence
dtbs_check warnings:

  interrupt-controller@c000000: compatible: ['sifive,plic-1.0.0'] is too short

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. None
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 7db861053483..0655b5c4201d 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -141,7 +141,7 @@ soc {
 		ranges;
 		plic0: interrupt-controller@c000000 {
 			#interrupt-cells = <1>;
-			compatible = "sifive,plic-1.0.0";
+			compatible = "sifive,fu540-c000-plic", "sifive,plic-1.0.0";
 			reg = <0x0 0xc000000 0x0 0x4000000>;
 			riscv,ndev = <53>;
 			interrupt-controller;
-- 
2.30.2

