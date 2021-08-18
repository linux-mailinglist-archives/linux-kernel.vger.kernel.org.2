Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D06A3F0708
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbhHROrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239629AbhHROrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:47:43 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EFEC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:47:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id bo19so3525931edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=icsU2c4V7+U87qo1ckZmLrJ2sA4CpW/juiJiyR0EYQw=;
        b=H2nEEL9iAcu2bnwpcjo6Mdr4TgkXA/9QqMtfJmxcmUorajIrrx04PJdHlaY1mXVoQJ
         a2nZqCrMTRnagWFtxNqfsbuJvYzn2x37+Ilzi9BzFLvegYymkhEuIrlzuMgWe6V+Bwgh
         vBiDdDTbUgJ5PX57E3Tzl/pJJNVIY3pytq/G/MW0nZc+W5/qsKFlRo0ENDaWOFl6VAcD
         FhJFtzPRkVBL39IMSDZC/6Ts+Kqr6EvjPhu/+x1Dj70XMWYH7ObIBNb2ddnKcKnLXMPZ
         6H29wEsZ6CN4de8RBcqP3ixralaJ/5MwSJ/z4wSuVJu3Zy+aRgWqlKvGE/YkKzV93F6r
         kPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=icsU2c4V7+U87qo1ckZmLrJ2sA4CpW/juiJiyR0EYQw=;
        b=fRc9KSgPMMXuD2odf9eWudZN7V+DD2AD3U/3/YN+2RS4tQitH/FYfUjvmDDB23eejn
         onFe3n7J7tvMb5G5rE8+HuD6tLHpOKHO6WtFd1boR1cgQw0Dk9yJMs8LzqW1qlsF2oA4
         eCEyEQCvZSN0bgedj06L5no8oFuSDBekw9AiwMaUMfZdJITmgXaZsmwH0QJqRb6lWFe7
         YTMJeYsXXyFiQsi0L05OmrBdWFrMeYpIBH/3l/LuXP9pcbDWF/6BrB+Li0DJpK9zPhgh
         P2zVx7lZuNFHYtwpx4rqe2HUHaEKQSLnqptqBz02rpjjGpovptzZ3roBm0qPOE1K/crK
         m0kw==
X-Gm-Message-State: AOAM5337+Phpe3AnOiIWjgTvmLj2GrowXTdaHSXZ7wII+eP4JNxMLn2L
        ogGEuzknqu2svtnTzMnTrrA=
X-Google-Smtp-Source: ABdhPJwM6xuEDtGMvk/m6OHHby1b74xL4bKzdUKxbakaO5bNUGtTJ4tBP98RfyG/vDG4sxVhN2Pddg==
X-Received: by 2002:aa7:d04c:: with SMTP id n12mr10646382edo.342.1629298026898;
        Wed, 18 Aug 2021 07:47:06 -0700 (PDT)
Received: from localhost.localdomain (neth7.eastcode.net. [79.143.160.90])
        by smtp.googlemail.com with ESMTPSA id x17sm2152808ejj.58.2021.08.18.07.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 07:47:06 -0700 (PDT)
From:   Nikola Pavlica <pavlica.nikola@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nikola Pavlica <pavlica.nikola@gmail.com>
Subject: [PATCH 3/3] dt-bindings: add vendor prefix for Vivax
Date:   Wed, 18 Aug 2021 16:46:48 +0200
Message-Id: <20210818144648.72665-3-pavlica.nikola@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818144648.72665-1-pavlica.nikola@gmail.com>
References: <20210818144648.72665-1-pavlica.nikola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for the Vivax brand by M SAN Grupa d.o.o.

Source (in Croatian): https://www.vivax.com/hr/o-nama.aspx

Signed-off-by: Nikola Pavlica <pavlica.nikola@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f6064d84a424..c234c392538d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1206,6 +1206,8 @@ patternProperties:
     description: Vitesse Semiconductor Corporation
   "^vivante,.*":
     description: Vivante Corporation
+  "^vivax,.*":
+    description: Vivax brand by M SAN Grupa d.o.o.
   "^vocore,.*":
     description: VoCore Studio
   "^voipac,.*":
-- 
2.32.0

