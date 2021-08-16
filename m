Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E68C3ED191
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 12:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbhHPKBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbhHPKAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:00:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153B3C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 03:00:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x12so22692771wrr.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 03:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tBoxvVvKIO10DrkILesFRlS9T4rPMo1Wo6Rp+HkgNL8=;
        b=mwgWYYs3jhmzNTP1frncbH6jlYFn9yJQQpdyFyVM8aZ0f2G7n5pp4gSLBu7LmbXMAQ
         3ixzhmwfkj2iqmwBLT+o4/5zI4u3u3ovhgHymcpssfM2FXx0gXlIHvDfLVj2eHu/hmwk
         a2dC4qaiCqF0Xn/iTSro0LnJ8WzaWff+BrNB/is7hg50sU237irbHGHwWGpGn1TG7i1n
         /a05fMWkl/yAgpEHhMw/j2U1LK3NtTiR1iaOXd3nqgmO9t3b68wkW6PRY8PM7zjibzrn
         s7yteN36gusb23G9BcxERhrmJmB/nv/D3BGoqLy0WX2pgVg2k8rT5BbmniGqCkE/Ge9U
         wcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tBoxvVvKIO10DrkILesFRlS9T4rPMo1Wo6Rp+HkgNL8=;
        b=bT5/cjrue5y+W969movh1+pbkm832yaE2TR1o3giRBc5sovO5Fm3cYanDcus21W26n
         7JKRAJ3CwQ12PViDc0e5zZZzYWY4kps8q8I6YqVFrWG2hlH9IEg9HB01XJR6vJWEWjsk
         BuvUkHWVOJ/aQs/2ADINkfSr1CJhTRN6qKV91EO72IDEQfk1/iNd6EJLDzMPquOop4ib
         0FMd847bwZQH72fbkCDSAtRQqdoK1LZPbh1+WOfjd+7vuylFnujvDLy9MKP8HT7Z461X
         up3VW37I62INaLIlLrE/Sj9hQVx38ic2OBZ1XUbPJLSF/udG7PqohigkT8zgLhnpK8lE
         q8ng==
X-Gm-Message-State: AOAM531il8RqDeob55ingMzTmiHNJeDm5yRoIcLFq7MTiPKx4Gw9X0eM
        mN2nT1jYwd51ljrJgGpkNznW/dZGnFEjrg==
X-Google-Smtp-Source: ABdhPJyYrhUAaACuFODtSBZtIZlyvpK9x1xyyBxkLAEbEhAK4IaQ2YxU2/fK0vVgFlBvSAk9ahkggQ==
X-Received: by 2002:adf:db07:: with SMTP id s7mr18139499wri.106.1629108018662;
        Mon, 16 Aug 2021 03:00:18 -0700 (PDT)
Received: from groot.home ([2a01:cb19:826e:8e00:92b1:d3c2:1204:85e2])
        by smtp.gmail.com with ESMTPSA id u10sm1916645wrt.14.2021.08.16.03.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 03:00:18 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH RESEND v3 2/4] dt-bindings: input: mtk-pmic-keys: add MT6358 binding definition
Date:   Mon, 16 Aug 2021 12:00:11 +0200
Message-Id: <20210816100013.100412-3-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210816100013.100412-1-mkorpershoek@baylibre.com>
References: <20210816100013.100412-1-mkorpershoek@baylibre.com>
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
2.30.2

