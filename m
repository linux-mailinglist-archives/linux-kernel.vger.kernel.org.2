Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96823730DD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 21:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhEDTgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 15:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbhEDTgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 15:36:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80BAC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 12:35:07 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d11so10635171wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 12:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ZZN5MzC4HBwyYsz5oFVkaryjGRKyHc1OurMaO1on98=;
        b=OBDSTLK6TS2hxfIMGeuoLflPHA8AXiJCws1GkQohO8FWzgiFXpnoOVA7LyH3XihoQD
         McGE73KZovVg+hDb6hHPBEfC0l+0cb+VmSfrUtYGzgfXuw1qY4PZE5LYo72G8jBrdTVT
         npV3ELRPB4dx5YS9Swt3WDJXQ0k49TZFMYvOYCXnVGcW+j8DZw6LhZPyarkTUGFQd57C
         NUh5XLFXVq/mm20Wg7lnK15Fqsv1tMSdP36pTZD/fuh6KxhKTOY/Ifk6a2eIpvqr0E8I
         lYAI3fY4WLhfxreKW3TPXuTADjnPn5FkHn+mDtHOEg80Ihe4mlHhGBfSlRVR1F6TY2CL
         2JlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZZN5MzC4HBwyYsz5oFVkaryjGRKyHc1OurMaO1on98=;
        b=ISYn0w3OYq0IyK+Tvvu3KFCAb5dB+LFIgQlTaV3IEkhjwh/fe7gmZxS7bXKrB1LsK0
         9n+2dBkKGQP8Yy/SAA0Q7gQbTyCNwEoffBjddnvkT8gxy2aYBQuEYoMKcB4/8xhiaO47
         kqtrk6BRvXnXEPHwfhX7ezb1IA8bVotFMA0f917VrMv9zlSGANXSP/BVt6+JUEvrpgoQ
         SOPEF0I+QrWjLGgXG64zbpR9xWQ/f8ssU+Vqp+kU0aKR1yOabKyHtBzUetDUUq7mk+vX
         jUIVFfadzm9qp2WgMk7bRwJ3uE7uyDg18h3J/T4LyNBGyZg+fnnck0+13PVtuDb3PCWe
         r5Zg==
X-Gm-Message-State: AOAM533tXzot5SEtynF3xu/8r99+WSxIh512XwAX8XQd4up3oIQ9Juv6
        6R7hPJfAqxTi1QoVOnDL7ls0jg==
X-Google-Smtp-Source: ABdhPJykddxppzrVNYK7b3KfPVPjx6fcuKA+9RNWbVt10xXoC/wxUepowdxvXMso5j9bqnG0wA/9lg==
X-Received: by 2002:a05:6000:1cc:: with SMTP id t12mr34157181wrx.156.1620156906534;
        Tue, 04 May 2021 12:35:06 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x8sm17072136wru.70.2021.05.04.12.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 12:35:06 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, kaloz@openwrt.org, khalasa@piap.pl,
        linusw@kernel.org, linux@armlinux.org.uk, olof@lixom.net,
        robh+dt@kernel.org, soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 3/5] dt-bindings: add vendor prefix for welltech
Date:   Tue,  4 May 2021 19:34:55 +0000
Message-Id: <20210504193457.4008384-4-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504193457.4008384-1-clabbe@baylibre.com>
References: <20210504193457.4008384-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Welltech computer Co Ld.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 71ccbe682e11..f9648b37da12 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1248,6 +1248,8 @@ patternProperties:
     description: Western Digital Corp.
   "^we,.*":
     description: Würth Elektronik GmbH.
+  "^welltech,.*":
+    description: Welltech Computer Co., Limited.
   "^wetek,.*":
     description: WeTek Electronics, limited.
   "^wexler,.*":
-- 
2.26.3

