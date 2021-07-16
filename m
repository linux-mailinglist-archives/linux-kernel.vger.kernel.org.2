Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D55F3CBF2C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 00:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbhGPWUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 18:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbhGPWUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 18:20:48 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E15AC061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 15:17:52 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id h2so14891228edt.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 15:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dm6ejJdRZDZlW/WyYTU8xmsjcdEmtRJOpLiC3zeIiIw=;
        b=FAy2r80ZKuhx/oEbG8GQJGgjsdA8xD4521tzi//j53N2HFzgcbewEq8378tlfULuG2
         /Y1SNhkg5i073oRr2H74aFCMMQ7eQQvDUV5gvNTcKnEXIu11sOrF7I8Fhzns3bIDXBac
         565WxfqItqBoKO7rbPhkuKo+SVs64e0OFIiA/hP+xAmIiO5ucPO1wdMzJNVUYzyk8mnP
         3QdFSOWQqK2zRL0Pru4kNRA7hSvg1qKa3E8GqrsO47RF/qxqXGO3dPPjX/jUMExJBaO3
         l+mO0cFCoTU0awv2klx6QHFdq2QbgfKoZ+OQmWvia4f+6GllYatuqsVJGBcf18L6KPsW
         Q7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dm6ejJdRZDZlW/WyYTU8xmsjcdEmtRJOpLiC3zeIiIw=;
        b=ojlY8/v3GV2KDSl+X+fAkUwhReZSja9x8JctHsZd3JEdwiRaboRhFrTypcaWu7IFp8
         obiDo1vLuW6EDRsLnADe+aS2tK26R+mK73HgM1PeJuie/xcVIwEQGZGCe7G0sGMRRq1l
         oELDGTr2/3frQwlUiMd2LgGfabKxxAaiWRt/r/uNQSuZfO3A60IGf3uaEKCsDeCSplvV
         Wppy0mDNm3+QCSqzko2nHh/jVsE3rC/I3Qg/vr6Eg2y+62Bw6ztOTTkwdY7ppHY/HHdT
         VHPwF5aJyJUVgVJ+tiVsspdfcdiy0zMGie3sQfw+omQ3crZomun33D5BxAUqXESFBf/y
         iSUA==
X-Gm-Message-State: AOAM532ILtOTGEOjwY7r18GT6H+CYrACI9Uw/WQlqN8BslQuykTvlEDX
        PDQIVHZccKBDnmi5WR3I+EhAPg==
X-Google-Smtp-Source: ABdhPJwpH0+MNHgerJ9Bnms1z6WdDO8V2eqxQq+GOk5dbXtaTHI9VcRbfawAfJ3Po/FR8jnTVJmm4w==
X-Received: by 2002:aa7:d991:: with SMTP id u17mr17380344eds.240.1626473871216;
        Fri, 16 Jul 2021 15:17:51 -0700 (PDT)
Received: from localhost.localdomain (dh207-98-239.xnet.hr. [88.207.98.239])
        by smtp.googlemail.com with ESMTPSA id f22sm4242634edr.16.2021.07.16.15.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 15:17:50 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/2] dt-bindings: gpio: tn48m: document TN4810M support
Date:   Sat, 17 Jul 2021 00:17:44 +0200
Message-Id: <20210716221744.5445-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210716221744.5445-1-robert.marko@sartura.hr>
References: <20210716221744.5445-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delta TN4810M expands the existing TN48M drivers, so lets
document the new compatibles.

Note that this patch depends on the following series:
https://patchwork.ozlabs.org/project/linux-gpio/list/?series=247538

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml b/Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
index aca646aecb12..d729c5dbed65 100644
--- a/Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
@@ -24,6 +24,10 @@ properties:
       - delta,tn48m-gpio-sfp-tx-disable
       - delta,tn48m-gpio-sfp-present
       - delta,tn48m-gpio-sfp-los
+      - delta,tn4810m-gpio-sfp-tx-disable
+      - delta,tn4810m-gpio-sfp-tx-fault
+      - delta,tn4810m-gpio-sfp-present
+      - delta,tn4810m-gpio-sfp-los
 
   reg:
     maxItems: 1
-- 
2.31.1

