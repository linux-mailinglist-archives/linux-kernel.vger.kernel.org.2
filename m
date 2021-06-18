Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C283AD1E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 20:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbhFRSPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 14:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbhFRSPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 14:15:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176F1C06175F;
        Fri, 18 Jun 2021 11:13:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f2so11659179wri.11;
        Fri, 18 Jun 2021 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=htjXApkhNdnP2TPogXqT3DcJXBVLwZ/N/O4uwhluccE=;
        b=P94bMjEVAhghS3e8W5TNzb5y1EnmV4DRB8X6rO4hSox87ZbVbQe8DH8tfDUeeh9Si6
         SgP02Y/+cLTYVJoFUAXvj9rkIMMeLq4Cm8ajMrRwVLi9ZX5xFxOIUfyW+ALpFzpUXnlF
         Rg8uxa0VeNtO4M3DqbOeJkJ6OF2D+CSEdh04mbsjBpJP6d0xjHVueqHKkujC0LlHXhVV
         lKdLiS9l0WVdfS9aa/qKqDN1447W5KzbGAjOd+igh9YZElxtQ31BiHGdWbrSgaVTdaQ4
         bqzcUsOiciLxvNUue4Zxzc4EEYD8OPSQGEaTt/5gAs5gbmB6uhtBZsU1P24U7/S0hmRI
         mjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=htjXApkhNdnP2TPogXqT3DcJXBVLwZ/N/O4uwhluccE=;
        b=YRdibE3L/7huVcedm0IHukUQfJn/z32sVYPePk8kKiGubtbtw1Xqa5FSQworwRTL/v
         TIMtKF/1V/J+v9QWQj/+znVFF4AJa/qKWShcuFAwgowtLmMCGHef/Fzxc2YnOuVKpnA6
         O3/ZRZeCL30CpMBMZGVbENBp5jbcjS8Xd2UXIj5aD4/Z9VlpGRO+VhoELKpPqlulbzbk
         FFWBhvSaq1a0GHMKB/QbaVKwg4Sup+097k56miEZg9bceD2YMHQopixWPZMvWfpzChBU
         y8m87C/QpQhDHtvwmAcHNZn4vrwZr1kn8CVBzc4SkjuLGEpeg8rNEpfyc3lq3q9ukoQs
         iJZA==
X-Gm-Message-State: AOAM530Z9lHM45FXvqDB0OBrOa1qWOQHVUUWN22kGvFgOcw0pIK02Cn7
        xpEW1Y7ZLF3NqaWlu37q/A==
X-Google-Smtp-Source: ABdhPJwhb8/oWvEHsp+eeJJ3vSb744SlgxAnekBNoPjdu6MG4ouNSzdrlSrWY2hLX/GtKYAMb+swTg==
X-Received: by 2002:a5d:6acc:: with SMTP id u12mr14032258wrw.414.1624039987716;
        Fri, 18 Jun 2021 11:13:07 -0700 (PDT)
Received: from localhost.localdomain (ip5b434b8b.dynamic.kabel-deutschland.de. [91.67.75.139])
        by smtp.googlemail.com with ESMTPSA id l10sm9306782wrv.82.2021.06.18.11.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:13:07 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 1/5] dt-bindings: Add doc for ROCK Pi 4 A+ and B+
Date:   Fri, 18 Jun 2021 20:12:52 +0200
Message-Id: <20210618181256.27992-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210618181256.27992-1-knaerzche@gmail.com>
References: <20210618181256.27992-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROCK Pi 4 got 2 more variants called A+ and B+.
Add the dt-bindings documentation for it.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 4a6f772c1043..e5049550bdbf 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -460,11 +460,13 @@ properties:
           - const: radxa,rock
           - const: rockchip,rk3188
 
-      - description: Radxa ROCK Pi 4A/B/C
+      - description: Radxa ROCK Pi 4A/A+/B/B+/C
         items:
           - enum:
               - radxa,rockpi4a
+              - radxa,rockpi4a-plus
               - radxa,rockpi4b
+              - radxa,rockpi4b-plus
               - radxa,rockpi4c
           - const: radxa,rockpi4
           - const: rockchip,rk3399
-- 
2.27.0

