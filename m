Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C144528F7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 05:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241662AbhKPEGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 23:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241343AbhKPEFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 23:05:01 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CB6C07C919;
        Mon, 15 Nov 2021 16:53:06 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id t21so15907628plr.6;
        Mon, 15 Nov 2021 16:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aZ5tXp1sMvrUv561doAiiCqmD/rNuSSbtkKz5FumcyA=;
        b=Fokzzr5kW5aWUlaCTKfzgxiKq8Sz0JJNct2dPr95icW0vsZJtaR2EFMTnO1oVDfMOq
         Lz6JGgFasUyOruecRwq5Aml0eaiTTg2hnH8ICBGuMMPr777ZnKVxIVX5IvluwbuK+Rxh
         IsN8tYvUeOJ/6U6qlHZicvs0HDoYKEcXWRmbJRZCLUI/NSUB23Le+8IpMm1BnErovhx0
         /LQuVgCI0ouIkBrtJacuCHdWWHdWgKrQCegBDrITIPL4TLXT0NkMQRmFyoWkFbcwxX37
         thogFTUiBYPEvVKPH9yj+GjkpWVutq8FxhlU8Uua6imHeqE6Fadf2rf4Rz5xTfSBxRVx
         MKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aZ5tXp1sMvrUv561doAiiCqmD/rNuSSbtkKz5FumcyA=;
        b=EWTdTgU4rS81mDbYySh+sbS1r6WQqGWXlt6Daw+kyk/eYHh/pURyisgtpLSXgfCzuy
         UMsy8acsFv5q5iFZF6HexXd4EkWwdNJ07A4vi9yEHKQsNnW8k9/tmDK+BDkr3+/k1bqw
         Hlpjm0wNUjmkq2uUfmIRdvteDODQ4h1z/9D4NW9VVQCp1sm0RLQw65HYuAu2p0FxLl7z
         wPl8+2Ds4Z7xkmkDomMa1yyOHAq4Or8Zip0rjVkrTPPpST7ooCPbKoGwQ4fJT4IJa7+J
         41zWiAe8PS26lGv87IL7/NYQ4Bap8X8zPQa/fqPG9cKWoOh154UqJJDsM047LugCXVdU
         M1Cw==
X-Gm-Message-State: AOAM533FrIbbVrAMpJ9zL4CeFY2CY2K+T0gBy2DsaGvA+b+cOrSh0CZC
        wlQGVhI3WS7dljOlT2E9/xM=
X-Google-Smtp-Source: ABdhPJyigJGV07hysM698lYSq2/gFNLDQaOt6dLD9KS7jPLXXnrmHTdY0gRp1kmucLGbfl6j1VlUpA==
X-Received: by 2002:a17:90a:1b45:: with SMTP id q63mr70178224pjq.135.1637023986396;
        Mon, 15 Nov 2021 16:53:06 -0800 (PST)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id b22sm12780502pge.2.2021.11.15.16.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 16:53:05 -0800 (PST)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 7D2D4900958;
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
Subject: [PATCH] riscv: dts: sifive unmatched: Expose the FU740 core supply regulator.
Date:   Tue, 16 Nov 2021 00:52:59 +0000
Message-Id: <0879c5b0c72b9bf6bf71f880def166f8804f41c7.1637023980.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincent@gmail.com>
References: <f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincent@gmail.com>
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
Note for review: this patch has one warning from checkpatch.pl:
  WARNING: DT compatible string "tps544b20" appears un-documented -- check ./Documentation/devicetree/bindings/
  #32: FILE: arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts:55:
  +               compatible = "tps544b20";
This chip is handled by the existing pmbus module, and there is indeed no
matching entry in Documentation/devicetree/bindings/hwmon/pmbus. I am not
especially knowledgeable about this chip, I only know it is used by this
board, so I am not sure I can do the best job in putting such a file
together.
If needed I can git it a try.
---
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 270360b258b7..e327831d0d48 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -51,6 +51,11 @@ &uart1 {
 &i2c0 {
 	status = "okay";
 
+	tps544b20@1e {
+		compatible = "tps544b20";
+		reg = <0x1e>;
+	};
+
 	temperature-sensor@4c {
 		compatible = "ti,tmp451";
 		reg = <0x4c>;
-- 
2.33.1

