Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0807837CD0A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 19:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245412AbhELQwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 12:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhELPwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:52:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCFCC061349
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:26:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z17so4974891wrq.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lzfTe4NYom6dNO0HLbV+l/ZlHA7iI3yej9+BU8sy+1w=;
        b=rElwDa8Lrcm2kjcdcnyk3ukxfLOTiThQgebEnFQOeXEdOe3irtXS/3EEKwl1Dh3ar0
         aEk4Ciyj4q/bNzRAT9Bx2V44WzDgOR9SkqvieE2ZpPI5Ow1Bc1clLXs8x2G6riAOZ6o+
         lGTJhX9LzXyzSyDRYOrGlm9RpGFEscdpCjuXqU+Zfa6WA1NQCuIvHUwoN3v32FJpHk+v
         hJbeeIjTIfzj9fKTf7LlwHI8l/vumbcMXQcCqYbDBaWfW6d+MeRGwKPPH9BNhfo+3Agd
         2iMUa2jqW6N/GAmy+beWKyFvJqos1gKR/nqHlQQ4WnsUBvUM4K5EjIbVCy4boq1xo82s
         B1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lzfTe4NYom6dNO0HLbV+l/ZlHA7iI3yej9+BU8sy+1w=;
        b=Aix/SfDVT/YFJVIaZZOb3vhezvgvMwFoDHjjVFdVbpjrCVjkrbCM3GgOVWsPnSNy2z
         NX2WAptjE3kX5J6we5t4tcxzoKvKsnCEx5KzLXq/6Y7832g6Wmss+Tfo/SBYWc4+GE7H
         w3yLzlqmBhcveBJMSxLrQ/8r/FcqXyXHhKRs4bjBAyFvkwQs6iPR2Ch+7gy9FEl62uck
         LM/k/pMjTyHYpP3nolDS7Fiq9amjKzHGTCqqDY5T6AJIdJK3quG2jPhpNUGar6mwLyBI
         33onwy3KACqYdztyGhXImb/KjtCjaujqcvS3F07AjRJVLsnL/ejHn4jy2F/EcyYjpURp
         fUDA==
X-Gm-Message-State: AOAM531Xb+avxVibKtVpVDfwWGlRHmQjXOmZqYkGH8OF89bxZdp9vNkq
        4QXCpQraPxSpcbv6wt4lDQhXJg==
X-Google-Smtp-Source: ABdhPJyvnIsbHX1mOtVgeTVf2klh9fpVHpl9Y27iO4L5BVcpy8cfA9oNsTK0UIGbAHxoGx7lF/DdyQ==
X-Received: by 2002:a5d:4947:: with SMTP id r7mr45639060wrs.217.1620833214636;
        Wed, 12 May 2021 08:26:54 -0700 (PDT)
Received: from mkorpershoek-XPS-13-9370.home (lfbn-tou-1-1465-169.w90-89.abo.wanadoo.fr. [90.89.34.169])
        by smtp.gmail.com with ESMTPSA id b7sm30931256wri.83.2021.05.12.08.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 08:26:54 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: input: mtk-pmic-keys: add MT6358 binding definition
Date:   Wed, 12 May 2021 17:26:47 +0200
Message-Id: <20210512152648.39961-3-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210512152648.39961-1-mkorpershoek@baylibre.com>
References: <20210512152648.39961-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding documentation of the mtk-pmic-keys for the MT6358 PMICs.

MT6358 is a little different since it used separate IRQs for the
release key (_r) event

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
index 535d92885372..9d00f2a8e13a 100644
--- a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
+++ b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
@@ -9,7 +9,10 @@ For MT6397/MT6323 MFD bindings see:
 Documentation/devicetree/bindings/mfd/mt6397.txt
 
 Required properties:
-- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
+- compatible: Should be one of:
+	- "mediatek,mt6397-keys"
+	- "mediatek,mt6323-keys"
+	- "mediatek,mt6358-keys"
 - linux,keycodes: See Documentation/devicetree/bindings/input/input.yaml
 
 Optional Properties:
-- 
2.27.0

