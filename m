Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412813F1E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhHSRAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:00:06 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:57096
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231464AbhHSRAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:00:01 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 35360411D3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 16:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629392364;
        bh=z1RQh6TbDCdHTYWqenSZoV+dbCUcnrr2PV0XynCVMNM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=dfcRDwGQJOYfgEMdu/YSMlD56hOeXFieYa93cLS/bkazxm0UfEu842grcNQCm35B8
         SNdwvrz1HIEsimIwvNA+dbc5kbUNVXYKy9+IsjvdzL6bYUldmVCuZY7x8qC6LmQlMb
         WT1fJY3MqNgrFNpYPC8qIZ1CXEG6sQRJP0DqvtHXEZQfhYIevRe4H9H69o43Lm0Vch
         CfE3I0bls5BM9ldVjJjLN9jrA6YpTST0kSKSIJJQvLTIbGBk9L6pQIZJdWCHO+aJEh
         7FjlEy1Aitm0f4gjhSY1nycuouNt3+Z4KvjhOsENzv/ar9n7fU3JSZ6s25svXJJY23
         hsHx9Y9/XoFQg==
Received: by mail-ej1-f72.google.com with SMTP id lf30-20020a170907175e00b005bc47d01a39so2475643ejc.16
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 09:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z1RQh6TbDCdHTYWqenSZoV+dbCUcnrr2PV0XynCVMNM=;
        b=caxSwyBejbgJ6FyBOk3wdjv6Fd+bBIaLqThG3g1mgTH/o27CNQ39vdvAJ8ieuQjcSH
         Ti4D5ZzBOqUDRbEsSVOOsAYNlMulvhCQqeHljJtOQJ9cowIQ0XAv7p4eNB2NjEZQ1xJe
         oNHwqDHIAe8Dr5U5Kx5eLCzqi/FcjYt1ZqGjqaJwn621B/0Vyl/iM5NJui7g1ywigMhd
         tLb+e4Myd8rRzhb2OM+0XQBEuT4OeA6PpVSekCpwQ4uy9rchLTRxSADhYQA+FV7PpYHz
         jx9wOJsSdfh5eL2wCrFGbG8DDTscYEd/jiEfUYMAgJErrym3kUe16HXQJFhjuJTbZ+m1
         q9CA==
X-Gm-Message-State: AOAM531Rv89RoWz+EUesYTG4brEKqVmFf+BsTq6puX0/8i5YGqf/kszA
        5XBsLosxrUzwP1Cq/Z21Nw851/mYoitQPtfWbEBqDY/ODdInILgKa4b869VZOHvZcgqSnjT07Jj
        HCFZr4aELq/VaVJ00vMDhoguvsfWicwc8eebIGE7iYg==
X-Received: by 2002:a17:906:4c89:: with SMTP id q9mr16811905eju.118.1629392363974;
        Thu, 19 Aug 2021 09:59:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwN/cjF/lAeY/btLW56iOgt8LTWAswf2EwA7y38kwFtmqm0X0IiH2XLz30C8VuHrDQfV3G+tA==
X-Received: by 2002:a17:906:4c89:: with SMTP id q9mr16811892eju.118.1629392363864;
        Thu, 19 Aug 2021 09:59:23 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id h8sm2023418edv.30.2021.08.19.09.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 09:59:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 5/5] riscv: dts: sifive: add missing compatible for plic
Date:   Thu, 19 Aug 2021 18:59:08 +0200
Message-Id: <20210819165908.135591-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210819165908.135591-1-krzysztof.kozlowski@canonical.com>
References: <20210819165908.135591-1-krzysztof.kozlowski@canonical.com>
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

