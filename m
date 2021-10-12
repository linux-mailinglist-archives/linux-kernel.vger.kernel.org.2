Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD3A42ED84
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 11:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbhJOJ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 05:26:45 -0400
Received: from ixit.cz ([94.230.151.217]:58762 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234769AbhJOJ0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:26:44 -0400
Received: from newone.brmlab.cz (unknown [91.146.121.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 5CDEA23D91;
        Tue, 12 Oct 2021 20:16:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1634062611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zaFGba8+jJoBpONrzkHvfF8TFx8vDgPazzKUj19W5Ic=;
        b=dm4FTiIP4VCkkZDst+GcrDB3eWYhFh4afT1ko/K+t0eymhxb7uB9orYok8AR+5qfq3gCM9
        flm91ZmVPQffiIWlcRXVvO+LmOltPkK6EzHq/Ibnjg4Qs8Jry4RAmFh6qM9Quim39DpqDa
        Kx3C575YjljdNgz+KGoVRg/g3bcJe0k=
From:   David Heidelberg <david@ixit.cz>
To:     Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH v2 3/4] arm64: dts: qcom: sm6350: remove compatible leftover from ramoops node
Date:   Tue, 12 Oct 2021 20:14:59 +0200
Message-Id: <20211012181500.5309-3-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211012181500.5309-1-david@ixit.cz>
References: <20211012181500.5309-1-david@ixit.cz>
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

