Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713523D8672
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 06:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbhG1EH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 00:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhG1EHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 00:07:21 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE7CC061765
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 21:07:19 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so2307523pji.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 21:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fqG4R+4qOt1ELoyg7PgFn0oDWuwuLmHhCt0oIoufOs=;
        b=leiQUpg97lA0cyhIJNpA37EZPKMHTpmtrVStYeFXvNCJ1xyRsmHlWPqKfdlCllPmjI
         mOyT4TnU4QLIXcO7Zxl1XD+VvxZAfjtgOk25vKX1d6v5xLIUJpdGVKPM86Qk//U5KjB2
         ebdk2A7Rj+dpo2AS5h/WGB4EOF4U/F72/Ppms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fqG4R+4qOt1ELoyg7PgFn0oDWuwuLmHhCt0oIoufOs=;
        b=cDOalLHHU8o7ky6fymWO/7RJJ2wpMSL1sw6N+eTk7ikVr5ExgH1rkSHKDtHcnUMWIi
         3dDAGcuol7bbTSgUC9hzlWwaPUYJwsSNBtRI+LpYakmHC7Ciy5IiUXvmbjoGv7uBClIB
         Ikw3EkNzg2wee9JcvcZy/Zp5J12pW0OsAft0CC7eYg/pVs2NMxIoBLAOO+fxMhijLugF
         FWv8zSU7lJ6/Navr1+1G2OcDX/CQ+niIDd7Ubl57xeUz1kUzEhFh7pyu4eGlBJHSN0Ur
         hH2MMhy1XLmLDQzSZx9b3YPlXqThwE/prV0AnRS9uDK9yN1OKDQsjYVWXUAnQTQjRuyn
         b7Dw==
X-Gm-Message-State: AOAM532PZ/dMygJt5FdnGbbWihdGgPaLqlGI44qR0P1yu4afbH5APipT
        DoBX/0tReA0X6+BuksQ5Ckqp7g==
X-Google-Smtp-Source: ABdhPJyDCFmwyf2fn2UI5FGK/JoEH7OH9IM47ZOeYNpro93++WTNtr6+NaqTR9oGAv3jyqKHNRGf9g==
X-Received: by 2002:a63:1614:: with SMTP id w20mr27210465pgl.198.1627445239405;
        Tue, 27 Jul 2021 21:07:19 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5176:76cc:2193:9b8f])
        by smtp.gmail.com with ESMTPSA id 6sm5536012pfg.108.2021.07.27.21.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 21:07:19 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        eizan@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] arm64: dts: mt8173: elm: Use aliases to mmc nodes
Date:   Wed, 28 Jul 2021 12:07:10 +0800
Message-Id: <20210728040710.2891955-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210728040710.2891955-1-hsinyi@chromium.org>
References: <20210728040710.2891955-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 1796164fac7e ("dt-bindings: mmc: document alias support"),
a way to specify fixed index numbers was provided. This patch use aliases
to mmc nodes so the partition name for eMMC and SD card will be consistent
across boots.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
v3->v4: change commit message based on review in v3.
---
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index 21452c51a20a8..d5a2cad39c9c7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -10,6 +10,12 @@
 #include "mt8173.dtsi"
 
 / {
+	aliases {
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		mmc2 = &mmc3;
+	};
+
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x80000000>;
-- 
2.32.0.432.gabb21c7263-goog

