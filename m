Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5D2453CFB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhKQAAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 19:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhKQAAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 19:00:45 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0778C061766;
        Tue, 16 Nov 2021 15:57:47 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z6so897331pfe.7;
        Tue, 16 Nov 2021 15:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lKn8U3vTkXK9ZBlzMtXDj+YHFGEgluUXaeDmujmDJDU=;
        b=MYBFr2IrCPsxtOescR/u9V3YhA8hvrw9TEvKwsfslqq26VneO16fyXkQ7r768npAbc
         gXRFft8rJ3RsXRpQn13tG40SKUJN+ZC/1JTp7ue4elz23wfeRFnj362LccsFIQ1J7Vam
         cTO80DFxGb22J5ciIRt7W7a1eqWaUePV6bUwX3kBy9pF8Ej1wff4hlNqCYcT5yt1GY24
         wfkJWbjeUrTbmREkEOm3qYwFPV7wJJxrAzErEBx8YUwLW4O/esKNlzDcQ1EMWi4iy7nO
         j/KjduD/0D0W5em1Les0P157nYMPT5LINhKkhgok3T2H5gP4gzprtM3FHp87LD/Gl9gf
         KOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKn8U3vTkXK9ZBlzMtXDj+YHFGEgluUXaeDmujmDJDU=;
        b=NaYQWw0BiicoNHS3xqmoy9oDS3HnJD7eRAd7C7iL4vlBUm6wEUh9i1s35Dm4grsTmD
         KaxhkJ1iptgFTpgYuWlqMPTUqXB7dGl70E/qdPoOW41LLHwcQ2fJ5X3ZrUEYg8ZEVvKP
         8C+3p3DjFD/yXmTx4LIHzHk8WMCv+Wa6MW+l0oR1U3o2igsgA6ipH/vONd9bLPMntP7R
         NsMWdCxHS83iElHbnIJFrjDw8BhlRH6qpQgSNRTr+DkaxNYyFjdLMTJ93V2zX8bYLKQX
         KSjNWRNjLmmwKHMJgZJ9jb1WeH001LycdTAbN8lb34y6/SZAAQPno4cEiqE5hT03NnAB
         BAaw==
X-Gm-Message-State: AOAM533oPBT1zYx0cBF9g9hUlWI2FKN+DZB5HZWK/8howN2baFFgEGHJ
        wj2vrjI7qufo72EoTyVslLk=
X-Google-Smtp-Source: ABdhPJzjR/I+yZIEQg5XCsv58hcLYy2yU8CB0QdQdk/mWraFZCmiLWi/R/xzqlIXqFS3+BRz//FSqA==
X-Received: by 2002:a62:1d09:0:b0:4a2:82d7:17a5 with SMTP id d9-20020a621d09000000b004a282d717a5mr32135027pfd.64.1637107067442;
        Tue, 16 Nov 2021 15:57:47 -0800 (PST)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id b10sm21210389pfl.200.2021.11.16.15.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 15:57:46 -0800 (PST)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id AF508900956;
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
Subject: [PATCH v2 2/6] riscv: dts: sifive unmatched: Expose the board ID eeprom
Date:   Tue, 16 Nov 2021 23:57:38 +0000
Message-Id: <be05f8604f72634fc21286623266a85fc12eae70.1637107062.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <bb7e8e36425a2c243cfbf03a23af525499268822.1637107062.git.plr.vincent@gmail.com>
References: <bb7e8e36425a2c243cfbf03a23af525499268822.1637107062.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark it as read-only as it is factory-programmed with identifying
information, and no executable nor configuration:
- eth MAC address
- board model (PCB version, BoM version)
- board serial number
Accidental modification would cause misidentification which could brick
the board, so marking read-only seem like both a safe and non-constraining
choice.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>

--
Changes since v1:
- Remove trailing "." on subject line.
---
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 305a086e5207..cf8937708829 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -58,6 +58,16 @@ temperature-sensor@4c {
 		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
 	};
 
+	eeprom@54 {
+		compatible = "microchip,24c02", "atmel,24c02";
+		reg = <0x54>;
+		vcc-supply = <&vdd_bpro>;
+		label = "board-id";
+		pagesize = <16>;
+		read-only;
+		size = <256>;
+	};
+
 	pmic@58 {
 		compatible = "dlg,da9063";
 		reg = <0x58>;
-- 
2.33.1

