Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D1C428CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbhJKMPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 08:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbhJKMPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 08:15:14 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0F2C061745
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 05:13:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id d9so43082173edh.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 05:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8QAyrhTrBX3oe1+/VClxZ5AaJhmcVFw1Cwl8ifw9smU=;
        b=tImhJNsru22/TVHDHuPzdBW1T7oS3gmN0lt83xz7aFspW3nEHO7FtXcM0z2CgwtJWB
         3X2woQ9IRKRYo6PxlVGPD/n/fIEZCjXeco1V0mSOg/bWWznBBbxSFQprA7v4/Er4dkd7
         LNhUuHY5Q1F6erW+27SyjVCdCIE2phcEVwXt/vj11jwjk7BmfZz3VFxWBHt8y08ZBkvS
         6CmOS4sNDMbRi+39GFcRQvtaz5lFYQ+qWwdFhlTF1lxDYGkO9gFlr5lGF4+dJatOzo5U
         58oR8iruLJtdkjlI3wPrVsUZ9B6sE+q8rLTY99pxNtYBEs8d+62qEmgLCMaMGbd2bJbs
         3skQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8QAyrhTrBX3oe1+/VClxZ5AaJhmcVFw1Cwl8ifw9smU=;
        b=JP6T95gxcOCGt4+N1KvIpgY/cIpg1jg+9Bfsauuo/2VwysUfMkWJI2Q00khLTjdFB+
         up+bm2EmMNkdLAbHQei9++WYOlFDQCFaBgF/couJWaAes847/kDmIW6mitQo9sVnJ2PV
         E3GJxzSN29qbpMBjYraWBDaN2D0/wBMkfC4J2UfvPVdvDMlOSsY73IV7/I1XK6cJup1P
         7/+e/A/V+h10Eeti+UAORkAW8LFPop5jGTODOsxpJDK86OumgNcQHdrL4AYmxQLnohLL
         Dy7+s1sPWEraGD6S6LDubjnaLr9dzoNds5CUmWr6Jq9hgIEYqbS/aFggf0e6yF+fZPP/
         PSYA==
X-Gm-Message-State: AOAM533MhOBJNrGDdwjqcz5aSejwl6U2Kgwxaj7jaaCH4+Cis1BAF4z0
        W5y9cqUqePdLqIEUV9hxaxOYaQ==
X-Google-Smtp-Source: ABdhPJxUGpue1l3aTxORVT+cJ5FR+C4iB9F3E1K3sWxYPYBf71dhBrfZsXjCcsW94sMy/X7EyGlxZg==
X-Received: by 2002:a50:cf86:: with SMTP id h6mr40794246edk.104.1633954392430;
        Mon, 11 Oct 2021 05:13:12 -0700 (PDT)
Received: from localhost.localdomain (ip5b403997.dynamic.kabel-deutschland.de. [91.64.57.151])
        by smtp.gmail.com with ESMTPSA id f12sm617783edx.90.2021.10.11.05.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 05:13:12 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     robert.foss@linaro.org, todor.too@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] media: camss: Remove unused static function
Date:   Mon, 11 Oct 2021 14:13:01 +0200
Message-Id: <20211011121301.421410-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vfe_reg_clr() is not used in camss-vfe-170.c, and can be removed.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe-170.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-170.c b/drivers/media/platform/qcom/camss/camss-vfe-170.c
index 5c083d70d495..f524af712a84 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-170.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-170.c
@@ -191,13 +191,6 @@ static u32 vfe_hw_version(struct vfe_device *vfe)
 	return hw_version;
 }
 
-static inline void vfe_reg_clr(struct vfe_device *vfe, u32 reg, u32 clr_bits)
-{
-	u32 bits = readl_relaxed(vfe->base + reg);
-
-	writel_relaxed(bits & ~clr_bits, vfe->base + reg);
-}
-
 static inline void vfe_reg_set(struct vfe_device *vfe, u32 reg, u32 set_bits)
 {
 	u32 bits = readl_relaxed(vfe->base + reg);
-- 
2.30.2

