Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162B243565D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 01:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhJTXTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 19:19:24 -0400
Received: from ixit.cz ([94.230.151.217]:58360 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231341AbhJTXTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 19:19:23 -0400
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 94411236BE;
        Thu, 21 Oct 2021 01:17:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1634771826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=997v4bghoI2OwZJOdMtQH10QCmvL+vjH9bUCFTSkQXU=;
        b=vrtBpxB8fdof2H90vp1/UQ3IHSJ2NehNBvsM4Szb8jiBPXEwJN0am0ZaMwHqX43I41IEJs
        dFqovI5BC0J4f/IS3tDMR/5b+4l+nqFdhQMnlh3QHpICdGGP8A0Ha/E3LrJ9t6uSTRT449
        64L2RkiuJSnF3qwcN3tcLMA/fzCw894=
From:   David Heidelberg <david@ixit.cz>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm-smmu: Add compatible for the SDX55 SoC
Date:   Thu, 21 Oct 2021 01:17:00 +0200
Message-Id: <20211020231701.278846-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing compatible for the SDX55 SoC.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 03f2b2d4db30..5ccf0025ffa9 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -37,6 +37,7 @@ properties:
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sdm845-smmu-500
+              - qcom,sdx55-smmu-500
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
               - qcom,sm8350-smmu-500
-- 
2.33.0

