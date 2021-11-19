Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBAF45792B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 23:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbhKSW7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 17:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbhKSW67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 17:58:59 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44E0C06173E;
        Fri, 19 Nov 2021 14:55:57 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so9768988pjj.0;
        Fri, 19 Nov 2021 14:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TkFeT+O19YuAYlRK1DqrnGfsfAPgPV+33DhTteERFEk=;
        b=WU+a+R1sdUftGW3C0KIpSbX+5CC1CLh1q1bk0t2wOMXqvl80qxz3NjTh77F92U/7qp
         nNJA7m6rkVgkhI+HrJ1FwGYUBuYt6TVk0w6S/E6y0qMxsMXjAChgjDz7e2McUQzaokbt
         HfLC8GLVMj5vtrUUwgfZrzI0DL1rRMK2Fk3vFsEjPp3dJyRbZt4aWZ+22yYYe8VQhcLF
         2lWfv7rWzC+SFua/2UxDgNSiL8Adr3RYFKUWAeG/AV83xnh1S3LYTdKJP5JxcRa8FiXE
         zOg4hPJ6OmOvX0lKK9xYBX5CtwPT0Ted3q7wuXWTaZJnLeXCtp8E03UMuSJrIkEQ/6oS
         p+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TkFeT+O19YuAYlRK1DqrnGfsfAPgPV+33DhTteERFEk=;
        b=GAT9gyEWXhCVCqyL2fsrGgunf8uIqU16p/dDwCneValzMw/Xbno/ZAfSbKi8wBMF99
         N0TlqA09T7JHrSGFzG5+rpY1shtZmKkYbYaztEWmcjO6+K5hK/Qo0SPljhJLiYk1pLHc
         vcqv20VSo6obqHnSk1417jlKJ8jKE2zH0BfY+tQD/RmkDU/R2VQw10n/Amjy7xXt9ysh
         NQRNf4WllsLUTO9z1PI/Bb+gvGTDQzjReydAeLO5FlBydeKdYUYsEN6koXkcZW8hm0ut
         bpWxDIvZOYmedhBEaFxioaYP4ljTrfzWOojuHqqePmsf7f57/2cYp2ohGp9IP82ki0/m
         kDfg==
X-Gm-Message-State: AOAM532BsR0VCiZpTSMXT14XCn81trGSOzj717NOwEgflMhALSQm26jX
        zGS3ULMwpjq9NGLLf/c/Pns=
X-Google-Smtp-Source: ABdhPJzURh5oEO0gZPxIAmtArMB21liFitqJULRyvCxT+uRMVG0Fbk/v7IAO3jHI/LzAwlJBiRkOBg==
X-Received: by 2002:a17:903:22c6:b0:141:fac1:b722 with SMTP id y6-20020a17090322c600b00141fac1b722mr83226064plg.23.1637362557268;
        Fri, 19 Nov 2021 14:55:57 -0800 (PST)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id s14sm629192pfk.73.2021.11.19.14.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 14:55:56 -0800 (PST)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 3B8CB900958;
        Fri, 19 Nov 2021 22:55:55 +0000 (GMT)
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
Subject: [PATCH v3 4/6] riscv: dts: sifive unmatched: Expose the FU740 core supply regulator
Date:   Fri, 19 Nov 2021 22:55:40 +0000
Message-Id: <5ab111e71e88d545d7f03233f10b6d84ef3d6c21.1637362542.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <378c64fb868b595430b0068a9af10fdbeceb8e12.1637362542.git.plr.vincent@gmail.com>
References: <378c64fb868b595430b0068a9af10fdbeceb8e12.1637362542.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provides monitoring of core voltage and current:
tps544b20-i2c-0-1e
Adapter: i2c-ocores
vout1:       906.00 mV
temp1:        -40.0°C  (high = +125.0°C, crit = +150.0°C)
iout1:         5.06 A  (max = +20.00 A, crit max = +26.00 A)

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>

---
Note: checkpatch.pl complains about undocumented devicetree binding,
which is fixed by:
  https://lore.kernel.org/linux-devicetree/20211116110207.68494-1-krzysztof.kozlowski@canonical.com/T/#u

Changes since v2:
- Fix end-of-commit-message separator so change lists do not end up in them.
Changes since v1:
- Added missing "ti," prefix in compatible string.
- Remove trailing "." on subject line.
- Rename tree node.
---
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 270360b258b7..6e7775fdae32 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -51,6 +51,11 @@ &uart1 {
 &i2c0 {
 	status = "okay";
 
+	regulator@1e {
+		compatible = "ti,tps544b20";
+		reg = <0x1e>;
+	};
+
 	temperature-sensor@4c {
 		compatible = "ti,tmp451";
 		reg = <0x4c>;
-- 
2.33.1

