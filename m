Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96CD3D5868
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 13:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhGZKjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 06:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbhGZKjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 06:39:19 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A930FC061764
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 04:19:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so19210439pja.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 04:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vcy/qtkkiK7UjSfWP1fK7FSTP1jeUYmZqbE4rjgeDZo=;
        b=nxXu/cb7lqQ0xcne5Q9FiIRI/FlMMkHZgMvc7pXPxsxGrUsf4h387Mip2jlFjfFIvW
         xNZn9vlDYcjAPdyAXdftKFBKzCrc6PZl8Bomt9x6uCBFDCKDKxwk3TzYsX3cvh/qtXNk
         IZ5HOy3NAbaGyGLoCs8C4IvMc3N0o//ne6k9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vcy/qtkkiK7UjSfWP1fK7FSTP1jeUYmZqbE4rjgeDZo=;
        b=fUiTD3ItY4AdWLeueWN3dQxoPbsJUWW+vU3wjkiHX7YA1bjwD90ZB7Rv88ivixy5kd
         PIgC0W/D9baXycrjIDCmm1E0RvVWzWsRfZez9Gz+aQMxtBylsfX/4HSE71BHDCDff1hH
         SPa60N/Idd5lFauifuHhyzUu+IQiUs56M4NCoCFJ4Lh+9BHgCabujGIe5tAjitTX5llC
         qQnHmHPA+Sq4BL+qGg2kmORerLJgrqKfp7iFDrBwdOWUvHdlS47qlUWKV1SR7NHB+uZX
         qr0gIRQ1w3hOvPaxjWsmTxCmtGdl28o9VIgVHNzo01a/GjaEgfpYWQpcgS7l+HWd6AEw
         hM8g==
X-Gm-Message-State: AOAM530DCRXIzO/2mkYe7MgRkWLAF4fVmycuBtr+nbZoEITNGCSjzGDq
        +VYIDiN22OY8ErzrkdlK46i/KQ==
X-Google-Smtp-Source: ABdhPJx8aNBhyrJBVcN6CEdp0jeeHRROLel4R3XbbG0babm5xfUipZKyTH6KacoIEaVqh5+UOe67ug==
X-Received: by 2002:a63:e841:: with SMTP id a1mr17876872pgk.197.1627298386871;
        Mon, 26 Jul 2021 04:19:46 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1b02:54ad:f521:5496])
        by smtp.gmail.com with ESMTPSA id b10sm42070578pfi.122.2021.07.26.04.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 04:19:46 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pinctrl: mt8195: Use real world values for drive-strength arguments
Date:   Mon, 26 Jul 2021 19:19:41 +0800
Message-Id: <20210726111941.1447057-1-wenst@chromium.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original binding submission for MT8195 pinctrl described the
possible drive strength values in micro-amps in its description, but
then proceeded to list register values in its device tree binding
constraints.

However, the macros used with the Mediatek pinctrl bindings directly
specify the drive strength in micro-amps, instead of hardware register
values. The current driver implementation in Linux does convert the
value from micro-amps to hardware register values. This implementation
is also used with MT7622 and MT8183, which use real world values in
their device trees.

Given the above, it was likely an oversight to use the raw register
values in the binding. Correct the values in the binding. Also drop
the description since the binding combined with its parent,
pinctrl/pincfg.yaml, the binding is now self-describing.

Fixes: 7f7663899d94 ("dt-bindings: pinctrl: mt8195: add pinctrl file and binding document")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../devicetree/bindings/pinctrl/pinctrl-mt8195.yaml          | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
index 2f12ec59eee5..e17a399e0904 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
@@ -80,10 +80,7 @@ patternProperties:
           as macros in dt-bindings/pinctrl/<soc>-pinfunc.h directly.
 
       drive-strength:
-        description: |
-          It can support some arguments which is from 0 to 7. It can only support
-          2/4/6/8/10/12/14/16mA in mt8195.
-        enum: [0, 1, 2, 3, 4, 5, 6, 7]
+        enum: [2, 4, 6, 8, 10, 12, 14, 16]
 
       bias-pull-down: true
 
-- 
2.32.0.432.gabb21c7263-goog

