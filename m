Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16260430BAE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 21:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344486AbhJQTMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 15:12:03 -0400
Received: from ixit.cz ([94.230.151.217]:45790 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233662AbhJQTL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 15:11:59 -0400
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 24E5F23D91;
        Sun, 17 Oct 2021 16:18:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1634480316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zaFGba8+jJoBpONrzkHvfF8TFx8vDgPazzKUj19W5Ic=;
        b=Im4NjyljSevTalvhFKtgMPLv4tOdjaS/bH0u7kGMnI6DPoF3YFyjv6Gq88r1GmGnITMgWg
        iyVmuHq7H6e8mvUttyQbc7bWVQYE/KxoFwX4fzyvPwJvkK7c0IJ1zEVWAklrPFfDvvZO1i
        8TBEZ++rmLoME8mPN78/6lsCdUgfPO4=
From:   David Heidelberg <david@ixit.cz>
To:     Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH v3 3/4] arm64: dts: qcom: sm6350: remove compatible leftover from ramoops node
Date:   Sun, 17 Oct 2021 16:16:59 +0200
Message-Id: <20211017141700.61201-3-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017141700.61201-1-david@ixit.cz>
References: <20211017141700.61201-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was leftover. No functional change.

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index db405a6175c0..961af2cdd23b 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -339,7 +339,7 @@ last_log_region: memory@ffbc0000 {
 		};
 
 		ramoops: ramoops@ffc00000 {
-			compatible = "removed-dma-pool", "ramoops";
+			compatible = "ramoops";
 			reg = <0 0xffc00000 0 0x00100000>;
 			record-size = <0x1000>;
 			console-size = <0x40000>;
-- 
2.33.0

