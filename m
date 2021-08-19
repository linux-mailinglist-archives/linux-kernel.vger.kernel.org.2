Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84403F1E83
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhHSQ74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:59:56 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:56956
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229548AbhHSQ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:59:55 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id E0550411C9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 16:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629392357;
        bh=odiP8qNzCjQyM5ut6+4pfn5opT3C8BN5X2IXeYZ+uMg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=qUxHeUdfUp1mJk1cY4Q5crjWDI4pI8nrCrlS3qw3oTeJkyKKwUd127M1HStyo4n3F
         GHmKK+HOm1d7wgqSpCyTCvroLyyr7jL7oyTBSAPk6VHye0tjO8x+LZ4DsG5Mh6/p5t
         9ANMCucPAPk5svp9GxU0FenmoYDkGtXTf4cnLxuPuACopclM7BAKDwhvx+JFdkIwr+
         70V+q6lHxWJJXNm45muB1SyLbX+GF+senolPJcaCswbMNPFE6bQlA2f2H39JkbTRrk
         Td+2z77MUYYVXzsnOT/ANl23RVPB0bJ090VdEo4ezQWEEosauUl9n1wOAFxQ+rtFlQ
         Go3UfKf2iqeKg==
Received: by mail-ed1-f69.google.com with SMTP id p2-20020a50c9420000b02903a12bbba1ebso3124747edh.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 09:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=odiP8qNzCjQyM5ut6+4pfn5opT3C8BN5X2IXeYZ+uMg=;
        b=QkqKvuwQ1wznFFvxpYJ+ZpREEdNq2hBIqrkfCWRy2kjC5o5kf9K10f8eqpgFWeFKC/
         CUfwZLSPNpIWt31NVnGBDEKs7NkMp7PA6o4t/k8TJsFr+ziqc9ywvMThw2BJplHpbEvg
         mNyAY/+djYscVLyZZDLIZY2Rt5Br0f0uxLLeXOn3nVCfaJTxEfBAievZWajAfbEVJj3E
         KFO+etRIaU57JoTNIDdNt2E+8gHqLflBqAhbLJBj5irbOU84RQcRhYlzXcwqot46x1g6
         vwc/YD/fv7nNMON0e3z4oTSSkVnwBnFtmE+0lrDkNYZ9UY1lsqJJGCumrbw2kGioZTBY
         Fyjw==
X-Gm-Message-State: AOAM532REfpD1LVnnun8YOuDDtdNZMOosmOUmgpYq+JoErOL0drGLo9I
        IznWmeUpoVttAQM/BSPPbSToMfELHWbAbTawC1m3CcFi7LXwm3DiLDqTIeGenUW2brBNzIHln9L
        kDekqTRRbaAqG1w4W/GJSVt3YeQOdsOZ6wc/yNTAS5Q==
X-Received: by 2002:aa7:da8c:: with SMTP id q12mr17338213eds.304.1629392357454;
        Thu, 19 Aug 2021 09:59:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9NLI19XYdziHhF/9RoSTCqYZEy4vkbe0t27FhZYRkfyGlpzr7xF3AO+fMykRg6cWcoCzMyA==
X-Received: by 2002:aa7:da8c:: with SMTP id q12mr17338204eds.304.1629392357351;
        Thu, 19 Aug 2021 09:59:17 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id h8sm2023418edv.30.2021.08.19.09.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 09:59:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/5] dt-bindings: mtd: jedec,spi-nor: document issi,is25wp256
Date:   Thu, 19 Aug 2021 18:59:04 +0200
Message-Id: <20210819165908.135591-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document bindings for the issi,is25wp256 SPI NOR flash.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index ed590d7c6e37..0db64ac7dc33 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -33,6 +33,7 @@ properties:
       - items:
           - enum:
               - issi,is25lp016d
+              - issi,is25wp256
               - micron,mt25qu02g
               - mxicy,mx25r1635f
               - mxicy,mx25u6435f
-- 
2.30.2

