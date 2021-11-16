Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3125453CFE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhKQAAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 19:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbhKQAAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 19:00:47 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5232C061764;
        Tue, 16 Nov 2021 15:57:49 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so3661188pja.1;
        Tue, 16 Nov 2021 15:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XUCrKyTLcq/1tv958Xe+OYnTiafzr/ke4k2ZCljxbxE=;
        b=nIpoNX2NFe0P9pQwXDCPeRm7vuJlB0nJcfZGCWg42MzZqovIesWtQ2HMg35EiIpmZD
         kaKzT90w3R1traHXPurRgUxZQ4FLu30B+9MxDP6ENK3DsZz9YqTT//JJy0ggQieIZo/n
         F2OZjlTfT1aLHOxFEsPNtsQYViAK/J+GIyGHPhM8XOoVmL58cApR8HpP1EJpma/OLOZA
         AIxoZ4vW42h6Rrj38Dl2ZgNonjWd7+d1InLkC+4ploUfnEr2gZYjQZq+/QNdr2Cgwipq
         pjX6mnFVphxCCiCjwU166lLUXMLXqMFDRCf94+OiB40ZxV8n3nOx0Qbd8Ek2AqaAcpSh
         39AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XUCrKyTLcq/1tv958Xe+OYnTiafzr/ke4k2ZCljxbxE=;
        b=H+vzuL0uKh6U+bq/ypmCt/9kFHkGT/D3zyqEgPs+/mg6+/gbr0Nui4N5bY4WrWhxX/
         p08Cijf3xzLXMQplmW66PM5Ku30kmg9Mnp2eb9qzHx2CBLy8XqqLQh0R2rCkPoE0GSXD
         4ukIQoMUeAY+EWq8AUrPXjn+4sD08T45QVKIjtykKBJMeZ3wBnCF8eMCXDTmqQ6FuJ9C
         MVk8xY0dj9n3DbACj6djNWpTBHu23B5duQCc11SShLNyXXY8RqDIIRn5jGfQ/eByheXB
         UXABq8Pz41QHvdcG1z7veL7jHJNxkTkM85kFl9zg/QLwcXa2tF/AGl7sIBROPeb/EuDv
         +xXA==
X-Gm-Message-State: AOAM532DzzvKkItZudHxZAHirvVd8LjaXistcxAER1Wq+yU2stgWSmaF
        xT4zW+q1tT/pGu1PI8o84rI=
X-Google-Smtp-Source: ABdhPJx7fvb5KT8Ue/UY6J2drUV3efeEbreHjWeTUERxIw+NKwH4x5GtwUctcnthxHO8ryXG9HbvKw==
X-Received: by 2002:a17:90a:ec05:: with SMTP id l5mr3976311pjy.68.1637107069377;
        Tue, 16 Nov 2021 15:57:49 -0800 (PST)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id c17sm2327457pgw.83.2021.11.16.15.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 15:57:49 -0800 (PST)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id CB78990095A;
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
Subject: [PATCH v2 6/6] riscv: dts: sifive unmatched: Link the tmp451 with its power supply
Date:   Tue, 16 Nov 2021 23:57:42 +0000
Message-Id: <147b278488cb66e6024fa648deacc2601e1dcbd2.1637107062.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <bb7e8e36425a2c243cfbf03a23af525499268822.1637107062.git.plr.vincent@gmail.com>
References: <bb7e8e36425a2c243cfbf03a23af525499268822.1637107062.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following probe warning:
  lm90 0-004c: Looking up vcc-supply from device tree
  lm90 0-004c: Looking up vcc-supply property in node /soc/i2c@10030000/temperature-sensor@4c failed
  lm90 0-004c: supply vcc not found, using dummy regulator

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>

--
Changes since v1:
- Remove trailing "." on subject line.
- Added a commit description.
---
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 1abad0eec02e..1a952dec74bb 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -59,6 +59,7 @@ regulator@1e {
 	temperature-sensor@4c {
 		compatible = "ti,tmp451";
 		reg = <0x4c>;
+		vcc-supply = <&vdd_bpro>;
 		interrupt-parent = <&gpio>;
 		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
 	};
-- 
2.33.1

