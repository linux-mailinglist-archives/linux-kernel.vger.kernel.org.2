Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D1D447B03
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 08:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbhKHHa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 02:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237803AbhKHHaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 02:30:12 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E91DC061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 23:27:28 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id r5so15220450pls.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 23:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibYrUCEgRz+O3z6IkyViyid6MIl4jLdozYXY2+QDyOA=;
        b=fy07Qb7pT9ElWRyx03B312jMf6QHNCa4Vijfldspvv5k+zwF/dKBSLRiqNlZsYIUJL
         nytoQ4+fQ2BF1OEx7jSjroL1eScHyRBRgGwcfauVt23wg1+PCsAPEeIKmUWDN1yF/b7U
         ycOlSQNXV3XOtm87QOk7hN3y2RMkb1yKwHJN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibYrUCEgRz+O3z6IkyViyid6MIl4jLdozYXY2+QDyOA=;
        b=vH/DAgZbRqQilr9+yfRHQuFqlpc7MPHFDBq+pPKbE9xnvrBRhkKiEgzuarn3vStGjA
         etMEbf+1mtBo+4MMTxSTO0ixKKls5p6G40IU5UbwoniTgCSVu0Z6OY/aq5Evjbb/2EjT
         wq4HKadegFOruxT1ezj24U56QDKXvyYR1r+3e89115kG42bBijlpmKZYMbQraRD8MCbp
         CHgaTqX0YDonFFvW02PnEc0JNnoVL3XwwOuUXSBn1OM/bVqf7Br1653jZ4+YmB4wKTk7
         jFrFbzIOc5eVJ8a6YRZygEvEedqZbJTByG0VHeiSEY/aVjJtXnd3l23OdHwGgO1W4jKq
         o7jw==
X-Gm-Message-State: AOAM531Aq7Ijnq3VfGnaTBfU6AZQI8g+v2Lj0/ep7Rla+mcxdSq18GgD
        Ns1/YJL2sOQ8+qLfP0lK8OGT/w==
X-Google-Smtp-Source: ABdhPJyqETo/x1CeHyP4wBfcZNndWs4Br0LOvBzLjoY6GJIiry6n2e/xFv3Txt1JYc89hseVrLIqcw==
X-Received: by 2002:a17:902:ce8c:b0:141:d411:7e25 with SMTP id f12-20020a170902ce8c00b00141d4117e25mr54720970plg.85.1636356448062;
        Sun, 07 Nov 2021 23:27:28 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:5f03:6a9b:24e8:3a2e])
        by smtp.gmail.com with ESMTPSA id e8sm11684972pgn.46.2021.11.07.23.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 23:27:27 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] dt-bindings: arm64: dts: mediatek: Add sku22 for mt8183 kakadu board
Date:   Mon,  8 Nov 2021 15:27:11 +0800
Message-Id: <20211108072711.1628566-7-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
In-Reply-To: <20211108072711.1628566-1-hsinyi@chromium.org>
References: <20211108072711.1628566-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sku22 which uses different audio codec than previous kakadu board.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 99e7f8e294cd03..da5f9ecc1a9b37 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -161,8 +161,11 @@ properties:
           - const: mediatek,mt8183
       - description: Google Kakadu (ASUS Chromebook Detachable CM3)
         items:
-          - const: google,kakadu-rev3
-          - const: google,kakadu-rev2
+          - enum:
+              - google,kakadu-rev2
+              - google,kakadu-rev2-sku22
+              - google,kakadu-rev3
+              - google,kakadu-rev3-sku22
           - const: google,kakadu
           - const: mediatek,mt8183
       - description: Google Kappa (HP Chromebook 11a)
-- 
2.34.0.rc0.344.g81b53c2807-goog

