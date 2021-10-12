Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2727542EBEB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbhJOIWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:22:43 -0400
Received: from ixit.cz ([94.230.151.217]:58696 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232194AbhJOIVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:21:41 -0400
Received: from newone.brmlab.cz (unknown [91.146.121.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id C17E3236BE;
        Tue, 12 Oct 2021 20:16:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1634062609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PW4syiLGNWkceasWafQ5IY74fbUGtSoyaqFdOYWkGfs=;
        b=BnH3Llg4bFCA8q7rPl0cxnN4si6jb3zGHdPLE1ckElbM1DIgTgOtRTiOuZBFuVHzHaz98I
        4asPByHHx2C8I2vXiB7ydtb4kOi3Z+nN9iHzp76t0EriG4C27k63/XkPb9HwCoJuHfCgyI
        cdh/X0L/YZaryV043FU2JDMtyJSfMxU=
From:   David Heidelberg <david@ixit.cz>
To:     Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH v2 2/4] arm64: dts: qcom: sm6350: fix typo in ecc-size property
Date:   Tue, 12 Oct 2021 20:14:58 +0200
Message-Id: <20211012181500.5309-2-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012181500.5309-1-david@ixit.cz>
References: <20211012181500.5309-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typo, default value is 0, but since we won't break backwards
compatibility (this change is still inside -rc) lets change it to 16.

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 513c27895dd5..db405a6175c0 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -344,7 +344,7 @@ ramoops: ramoops@ffc00000 {
 			record-size = <0x1000>;
 			console-size = <0x40000>;
 			ftrace-size = <0x0>;
-			cc-size = <0x0>;
+			ecc-size = <16>;
 			no-map;
 		};
 
-- 
2.33.0

