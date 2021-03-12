Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3973385CC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhCLGYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhCLGYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:24:47 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C3FC061574;
        Thu, 11 Mar 2021 22:24:46 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id q204so1147078pfq.10;
        Thu, 11 Mar 2021 22:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SYdrQ24/4v3uJHKlu6wjCzOv/6QqD5AM/KsNyKqxTg4=;
        b=UYMwAAPYv7H136+Rhso+ej56Yja02jS0XTUEvEqGQlFGg9CTfYfdLVGBxIqJS0jeAL
         q08J5YpCHY+IzJHX+RzfTDCDn5AKnUdPuheXGNYpb5/1jYhGgy8Jc4BJxNbiZtxoUU/O
         gAqGzjle3h0cP7bq4/zL4pw79LOIXRWoAyAr8MvFEwOwMD7aHLqTxIwFApoQ308VlGo8
         gJoWed8mC9hyuNIBH4o6w9OMGEyiaydygkW7+lZ1UZSnC7f8w88cKE38Id2FIiMRy+CA
         AMERDgrR/QtT+qCJvqdHjZyicaO1DqwdK1RvU5EH+dhSCpU3HjOtKVofRJAd4vXFLGTo
         8vFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SYdrQ24/4v3uJHKlu6wjCzOv/6QqD5AM/KsNyKqxTg4=;
        b=NrUOthDnjzusXoPA23PC3QNWOcZR1J7jFEK5FVkGoeLS+0etAmnen4NHxARz95s9Ps
         rQvgg9YzSlL0jYJBR8P2cZwYbryLMomUFlZD2niAzSxgPZyZg3JycD/WD0zIKhZ8nnNb
         fzFC+hcgRsyiLqo7ejmKyeEdLBLMZM95LXat9wAn4UcNnbYiVaCLs5GsMhKpu5H6+rIO
         qgDG5fOaQuvQmKZXFeqDpvxVEZ4GYnVsu8Z3PsPCWEVGEqhC9WL9BqUTJ0t1XGKRNdUf
         nbMCe0SP569iBAve2+KaoBGUCYebcQI6kWK5OkgjzD2FsYg5v3Sv/xxf9UMAvh3Z+z5I
         J/PA==
X-Gm-Message-State: AOAM533kvuCEhY3KZYaePSlus+/BSFusvZ/7n+qoY3QwqBDIlWVMTWtG
        XzmzrkWOu8Z0S3/3uJl5djU=
X-Google-Smtp-Source: ABdhPJwvKrIVsZZ1IluVeJdz38oYuu6rGttLYx860TPP5L/6l7Q1pDS5DqI/pjhZhkPQB+moHNxblA==
X-Received: by 2002:a63:5952:: with SMTP id j18mr10621393pgm.397.1615530286516;
        Thu, 11 Mar 2021 22:24:46 -0800 (PST)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id h6sm4048406pfb.157.2021.03.11.22.24.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 22:24:46 -0800 (PST)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, alexandre.torgue@foss.st.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v2 2/8] dt-bindings: arm: stm32: Add compatible strings for ART-PI board
Date:   Fri, 12 Mar 2021 14:24:28 +0800
Message-Id: <1615530274-31422-3-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615530274-31422-1-git-send-email-dillon.minfei@gmail.com>
References: <1615530274-31422-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Art-pi based on stm32h750xbh6, with following resources:

-8MiB QSPI flash
-16MiB SPI flash
-32MiB SDRAM
-AP6212 wifi, bt, fm

detail information can be found at:
https://art-pi.gitee.io/website/

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
v2: no changes

 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index e7525a3395e5..306e7551ad39 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -53,6 +53,10 @@ properties:
           - const: st,stm32h743
       - items:
           - enum:
+              - st,stm32h750i-art-pi
+          - const: st,stm32h750
+      - items:
+          - enum:
               - shiratech,stm32mp157a-iot-box # IoT Box
               - shiratech,stm32mp157a-stinger96 # Stinger96
               - st,stm32mp157c-ed1
-- 
2.7.4

