Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C133A407C2F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 09:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhILHal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 03:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhILHaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 03:30:39 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8F7C061574;
        Sun, 12 Sep 2021 00:29:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t18so9467058wrb.0;
        Sun, 12 Sep 2021 00:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q4RL0sqYDQpryks2hL9tjkn/HeWDVonzaaoKuLG05Vk=;
        b=kV0FwxCcUZPNv2Sxt7roikRo7jM6LiDDicK3Z0IAjf9ahaa9/SsZpSS8lIFmdFQajj
         xka8kYlyccXLabLzhnOcQpIkfve3AA3L8dWk2RWcgt5adAy0pj39oLYYKbM4ik0cORKQ
         gDo8aB3rA1Ybkd1MEzEZkvW3EEpn74O9kzlJZ7IFsEb3rdwWmHyV1f+slsZ7XL4kKLKF
         Iqiyt6FtmRE+ceskzSZw3X7zXHetZ1wrpc/tL8ZSYHUqhuVzYn59JWOyPxMpmknxroPZ
         2SXDjJDrbkMjDhXHJ8zYH0dDKDvNPGmXJ28LFJFjPcQ37iXo3y0E+PnaCbMsqkYsTqlk
         9ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q4RL0sqYDQpryks2hL9tjkn/HeWDVonzaaoKuLG05Vk=;
        b=2a+sJbd/qCMGhSM2bHrb748j6UbkHiV4gPuFqt5WjrEaBseM4bHmHQUBz/OGUH0vuc
         B/IHRM2RomFLTiODxWOQu8uKrnxuBo8I6gtWGAFHg9XJsBdJYuO4r3Ud+b4Rd69WrD4n
         MOFh1KKgfzPa6eVzwEfGfJnB9lwkeXfWF2EKzkgwGQhthvxqzUYjh/Q6bud7+97+om32
         EmbtbydHX32tWO9GpmBHXh3OB2jQyCXBC0RcRYtLe1YMQ2p8avLod3LH8vIEx5eRG3jb
         3bMdTI699TCkuzmAP5vliZ/RyPSbkVJOCGo1x43YboIC34+jgq7IyLq+aJRwolbQiTQ5
         viEg==
X-Gm-Message-State: AOAM530j8XUYGb3c7wOSmnOXqEjjaHhsrCqL5ypzXPiuI8TZDjO7rHgB
        N4AkKy9fBERbsY667OkWE9I=
X-Google-Smtp-Source: ABdhPJyzGL9pJtzMKYuimQOy8clVHIFsJ1uTW6/YaQEONAIxa49BkFdACyZzJGio4nTTzUBvHyzDNw==
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr3890013wrw.14.1631431763798;
        Sun, 12 Sep 2021 00:29:23 -0700 (PDT)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id t18sm3584889wrp.97.2021.09.12.00.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 00:29:23 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 1/2] dt-bindings: sound: sun4i-i2s: add Allwinner R40 I2S compatible
Date:   Sun, 12 Sep 2021 09:29:13 +0200
Message-Id: <20210912072914.398419-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210912072914.398419-1-jernej.skrabec@gmail.com>
References: <20210912072914.398419-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner R40 has 3 I2S controllers, compatible to those, found in H3.

Add R40/H3 compatible pair to DT bindings.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml     | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
index 39b66e9ce3e3..7d48ea094c66 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
@@ -20,6 +20,9 @@ properties:
       - const: allwinner,sun6i-a31-i2s
       - const: allwinner,sun8i-a83t-i2s
       - const: allwinner,sun8i-h3-i2s
+      - items:
+          - const: allwinner,sun8i-r40-i2s
+          - const: allwinner,sun8i-h3-i2s
       - items:
           - const: allwinner,sun8i-v3-i2s
           - const: allwinner,sun8i-h3-i2s
-- 
2.33.0

