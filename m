Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AB6457933
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 23:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhKSW7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 17:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbhKSW7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 17:59:02 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7607C061574;
        Fri, 19 Nov 2021 14:55:59 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso9974120pjo.3;
        Fri, 19 Nov 2021 14:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3BXgwHgh3BDP05DRd5pJFiIUkk6+CLM31HGyYQMwJeY=;
        b=Frx4VYaifZTS407fnv9NG7briSWAEXoIsCXA9ENvCEqMaX0ZTMhazuAkaxifJxxgVx
         vm7xLygR5mqdhHbiGVD8wViQpplby8ewlZI135LLHGmw2RNBt5+WsUXEFfIaoqA9aScT
         e/NweSQjKMky1du7UAowfrUd6p6KuqddMwTkLWgEpgK1RdDowsI8tIp1fh99Zs92iWnP
         2VhTd9PMH6VVAtEZca2CH2hF/HSwSngnIjSaf3iWTjmlMpVrvEvwAu6jE/2L+f629FQ2
         ldfcL74m+rPEqnUU/BLsNZUGNPyIYyVFL0lkDAchfYK6vFlSB2Ib7q3aZl/lJB6nwYF2
         /jJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3BXgwHgh3BDP05DRd5pJFiIUkk6+CLM31HGyYQMwJeY=;
        b=6Tu6nVp1VG/4dNvinjIUik4cKJC8Hd0gqfp3k12udZEr2g1b5jYlYssmQ3Ota50jPH
         FF0i4k3m1jfC/wO2GJ3z/h3p5KBKTBVNxJiZ+KPf4EDcQ7WSTotomsVi0FW3Ip3uovJX
         15lV9OkkpWHM+zwoRyn21qO07CfaH1/3aCJ7tVd+MJLn0QdGP/YN/Uuu0Ex0JXZljZzI
         n0a7s4PjNdcUNJVCCs+RO4qG+q2ghd3RfJ+syBwdCiDMv98HoSop33raz9CVjzyleH4w
         2k7dzTSMj0hvw5VzNeiAhb6sv5+XtKfkeoibLzG09+E6/WEHoBivoqtLJY56N2llk12m
         nxgg==
X-Gm-Message-State: AOAM5331LgU1s1EbySdhtKhmfX+oMRm6+5GdIHWY24nLzuCTtJjLCaZY
        xljGlfVKrqu5xIPcuwpEDTM=
X-Google-Smtp-Source: ABdhPJw+3CUVUTeqDwOdVHAf6zdS5P4LubnNUoQnigVZtPY3y0YVcdgQXTlfSEZnf6ypStU1028gWw==
X-Received: by 2002:a17:902:c202:b0:142:2441:aa25 with SMTP id 2-20020a170902c20200b001422441aa25mr81386651pll.68.1637362559338;
        Fri, 19 Nov 2021 14:55:59 -0800 (PST)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id s16sm672553pfu.109.2021.11.19.14.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 14:55:59 -0800 (PST)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 4C93290095A;
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
Subject: [PATCH v3 6/6] riscv: dts: sifive unmatched: Link the tmp451 with its power supply
Date:   Fri, 19 Nov 2021 22:55:42 +0000
Message-Id: <ab42d60d325249d805d99db1c3981dd1fe9422eb.1637362542.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <378c64fb868b595430b0068a9af10fdbeceb8e12.1637362542.git.plr.vincent@gmail.com>
References: <378c64fb868b595430b0068a9af10fdbeceb8e12.1637362542.git.plr.vincent@gmail.com>
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

---
Changes since v2:
- Fix end-of-commit-message separator so change lists do not end up in them.
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

