Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BDB453CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhKQAAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 19:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhKQAAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 19:00:45 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A00C061570;
        Tue, 16 Nov 2021 15:57:48 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 200so603718pga.1;
        Tue, 16 Nov 2021 15:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/zwzMgCKlV1Dn38wdj12JN6kln/RrqctqE2A6Lwr2FE=;
        b=ZysnW7EWtqkGYnKDLftVi2BN9z+BXclDtaC6OcEZIR4ipTPYCiZGxz+vs51ytOMJGS
         y5ynfxXnj+NoVKKvo0FFFFdzKLaplwCO9xdVEIdNy5XZax/Lc8Wr7o4DgKP4KKFB30qf
         wpo9HXc5jKrgxDmjpEKrWdnHrP0tRemck3qBerV62EgmhGgKBL1x2wob5gNGLvpvFf3b
         s66Et6kiY+/grIJ6nrxVNZnAtbU5MDuNfKeOOj7qfjnEJhm15tzwT3W0U8QBgzKq63Nj
         bFB64EslnTFrN+5NP4c4bsMrD/xooYnLed9juV1G2w5d9EI+RmjtGcX+rclX7tvD30dT
         GoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/zwzMgCKlV1Dn38wdj12JN6kln/RrqctqE2A6Lwr2FE=;
        b=KyrQCJTfC39VkEmcufvSWevD4pCslyUQmZG8+F+TiBRnXSryD+M2qxvUSi+N1RM7ez
         9PNXuQGcTzYW+7PqeuFFf2S5QU5QPUA4+vJrZu5N5H+gVG33w2sSPO37H1jC1nQPflfr
         l+L7piT4SjHFOjNxYNSSOq7RfXGT/GydjNxxBLJD9kKbqb894sZ08xSPjecdF88YKA2F
         c/H0/xOzSxRwVnOYWHUFPjNSwv9Wsmwx+58obv8FwkOvSyP0VMCno2qYQjmau2wjqPCR
         1OV2OdN/HS3JwTA7+6ySPITxMkxG2eKch1qTJWUZCWrMj/54xsH4p5R5hqDo4+6B6ipE
         7opA==
X-Gm-Message-State: AOAM531fjWhne9OFxeGOypwj1/6KDXaFGBvoFQkbvbm5VF7d3WUBWfVf
        ueFBCx1vTwfnW/v7pboujhc=
X-Google-Smtp-Source: ABdhPJwMuieDf+DAk+m7r28QGKlTvTljYzr9P1nwGXj+b6V4bkxiqN/+dz+stexAM8vKUuyqc43iMA==
X-Received: by 2002:a63:5257:: with SMTP id s23mr2112128pgl.473.1637107067577;
        Tue, 16 Nov 2021 15:57:47 -0800 (PST)
Received: from localhost.lan (p4899162-ipngn25301marunouchi.tokyo.ocn.ne.jp. [122.18.9.162])
        by smtp.gmail.com with ESMTPSA id il13sm3458697pjb.52.2021.11.16.15.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 15:57:46 -0800 (PST)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id BCE9A900958;
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
Subject: [PATCH v2 4/6] riscv: dts: sifive unmatched: Expose the FU740 core supply regulator
Date:   Tue, 16 Nov 2021 23:57:40 +0000
Message-Id: <f0a1ddd78f1a50a10d3cf36a18c7afcc4dfd1d41.1637107062.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <bb7e8e36425a2c243cfbf03a23af525499268822.1637107062.git.plr.vincent@gmail.com>
References: <bb7e8e36425a2c243cfbf03a23af525499268822.1637107062.git.plr.vincent@gmail.com>
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

--
Note: checkpatch.pl complains about undocumented devicetree binding,
which is fixed by:
  https://lore.kernel.org/linux-devicetree/20211116110207.68494-1-krzysztof.kozlowski@canonical.com/T/#u

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

