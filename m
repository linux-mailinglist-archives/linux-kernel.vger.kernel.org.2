Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229D74528F8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 05:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbhKPEGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 23:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241357AbhKPEFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 23:05:01 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB1BC07C91B;
        Mon, 15 Nov 2021 16:53:07 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so1301959pjb.5;
        Mon, 15 Nov 2021 16:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UnxeX5SYnUNt5FPPR3XcURZ6ym6nyt/1fGq3kqylBIo=;
        b=CC3HnIyUpf6TTi09gUPg+7d9css4arcQA8It4ZEeFZ2VNEe1SZekRoEqUmB0vWAK3J
         FN3Khy8n0wXZJNdNYvG3WacASROQtnE271NnW+qqU3AzrA8XTP32o1xlHaJPCro3v8ih
         Ds3RI9/TchtvZstY9GqMtYJ3nLVg4YrYuLhNJ1n/lZ+SssTqJASpuVHB01LQLi3iDDJt
         Qh5a3tAxBkiH9g1FzXK6YFcIoZzjvmE8uba7Tkt79aGIpoeX3RKaG1w42fR5M5Q4sqOu
         yiT6AUDn/923XU3Ex+dtzHWaFzeTnmNjPt9bHh7kIbAQysFRnZfs+5HhhpUSfN1GChz7
         zeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UnxeX5SYnUNt5FPPR3XcURZ6ym6nyt/1fGq3kqylBIo=;
        b=nC217IsM7SIyAktjd0y22nCAWH7mnw0as3CDX0flemNZxx8pBvuHYRfpiy8yQZRDAA
         8xydXr9yZl0ISga7qZcMZWoMumrSsla+r92g3ifaL/4AstNB/mHwtH6ZMyPkfByYOTZO
         2DoHimIwyxu6jls7lQ6y3AB7Rqr6/OFbiZS20GrAQ6287zWpEO5tb/EL4tAswFrOeQCb
         ll6TraeMe9Zafo2kRW8YJZTSNEqvsS7eVPxbigItvUmFcjwu5e4bVyuo3jNdOk/Y25qb
         dIAILiuCxkQlmeSFfJ/9GjXn1va1PbLjui4CIARWqWUZQDsCUvKKjD5eEv1dwJN/HOvk
         XR9A==
X-Gm-Message-State: AOAM5301vBiTvoK5BT3wWGO2+vhSe50GD1RtQ9QWz/CKZDl0sITrPi9l
        Jmxun1HPyuHtQ/Cuyawz0uM=
X-Google-Smtp-Source: ABdhPJzxmzvjNq5ymfML/LjS8AmV2qUVIsZBDxqNdE4sUvDg3GLZvDShmmhsiZziWYbhiWg/XLmvwQ==
X-Received: by 2002:a17:902:d4cf:b0:141:d36c:78f6 with SMTP id o15-20020a170902d4cf00b00141d36c78f6mr40922853plg.56.1637023987574;
        Mon, 15 Nov 2021 16:53:07 -0800 (PST)
Received: from localhost.lan (p4899162-ipngn25301marunouchi.tokyo.ocn.ne.jp. [122.18.9.162])
        by smtp.gmail.com with ESMTPSA id y7sm12493381pge.44.2021.11.15.16.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 16:53:07 -0800 (PST)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 8AFA790095A;
        Tue, 16 Nov 2021 00:53:03 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Yash Shah <yash.shah@sifive.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Subject: [PATCH] riscv: dts: sifive unmatched: Link the tmp451 with its power supply.
Date:   Tue, 16 Nov 2021 00:53:01 +0000
Message-Id: <d04daf5956ad61496188c7aee3d2eb958e34d7d2.1637023980.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincent@gmail.com>
References: <f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
---
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index bd6e90288c8a..73c1e4adf650 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -59,6 +59,7 @@ tps544b20@1e {
 	temperature-sensor@4c {
 		compatible = "ti,tmp451";
 		reg = <0x4c>;
+		vcc-supply = <&vdd_bpro>;
 		interrupt-parent = <&gpio>;
 		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
 	};
-- 
2.33.1

