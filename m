Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CB33F26DC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 08:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbhHTGeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 02:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238538AbhHTGee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 02:34:34 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A8AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:33:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so8736722pje.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 23:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l5UjOdchXs6TvxgAlQ1PtdmA7+D4r3Icdkw2qZVkuTU=;
        b=bTuZUZG2L023gJdqS/6c2NsYteGNsl9DpgJy9cEKZSgBK3ciqceHtp+TCGQzXnqHha
         TQCCoYEdT3V3+Gr1ejZU8RfAoNXn6ijo2UmUBzbv27O8EJ5wVN2J9aY44SL6QvhNFwjn
         cNXQ7caJT172iQ/JDpoq4NZFyZ0ZCgYq3qYnbw/GaGmiu3I19DRqak9yfrW9kaPiSH1Z
         1sFA7WRfJvQmIhzGiV1aUm9NuV1aTAX4+HEXQ+meK4fRmBM8ddVpK4toJsecpCUQR3vF
         RTL9ildAL8RHP6iIMY3cmFTTKh1Wae5w6iz4pPQggstfL6z9KPJtJBdKUUgPgzaxi8rS
         R4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l5UjOdchXs6TvxgAlQ1PtdmA7+D4r3Icdkw2qZVkuTU=;
        b=lNF5ew3dAzN1hPGhrT/YwgRZGktenoT9neyG9NF5zVrnQdBoCSPNBOfeEn7p45QwnK
         QPKgqLPD7HagCV4SYWZlQ1/SSTSKRzCmu3EbO2opBSabVyAA6euYnkD5z04n0VHg7Zy9
         tADTf5hwoklFPe3uBEgMiAIBJRtlfpJ1W08mmmTGcOk2t/ZtWSbFxuYrIzBCbMBaHo2X
         DR9KFE8wGlgzocgaL3W+xCBt8/oav8M/YTTOePFgExnXuSLDqdovZ9y35U7rpuG1aL1r
         Wjp9txuvT00QeFcyhtMCBWneUuwOybkmQtAV7i7rdHQLKnuQivFF4+DKILWzNTamUGYR
         Fepw==
X-Gm-Message-State: AOAM533Poo3fd2r+vIRcok1J/z9u19b/ivAOTewCl3TmYvaBt0KK2Z8f
        qFre4jzCiq0nQVY+VrqfGvcx4Q==
X-Google-Smtp-Source: ABdhPJxcfJeJTAnFweCv0/oxrTDnDiLD/9R6V2Ea7CuYTrnttJqAItOzfFKmmq6j+RJkk0hAGkXpVQ==
X-Received: by 2002:a17:90a:ee91:: with SMTP id i17mr3018612pjz.67.1629441234921;
        Thu, 19 Aug 2021 23:33:54 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id a10sm5612160pfn.48.2021.08.19.23.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 23:33:54 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v2 2/2] dt-bindings: drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Fri, 20 Aug 2021 14:33:37 +0800
Message-Id: <20210820063337.44580-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210820063337.44580-1-yangcong5@huaqin.corp-partner.google.com>
References: <20210819124844.12424-1-yangcong5@huaqin.corp-partner.google.com>
 <20210820063337.44580-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The auo,b101uan08.3 panel (already supported by this driver) has
a 3.3V rail that needs to be turned on. For previous users of
this panel this voltage was directly output by pmic. On a new
user (the not-yet-upstream sc7180-trogdor-mrbland board) we need
to turn the 3.3V rail on.

Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
---
 .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
index 38bc1d1b511e..a7091ae0f791 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
@@ -36,6 +36,9 @@ properties:
   pp1800-supply:
     description: core voltage supply
 
+  pp3300-supply:
+    description: core voltage supply
+
   avdd-supply:
     description: phandle of the regulator that provides positive voltage
 
-- 
2.25.1

