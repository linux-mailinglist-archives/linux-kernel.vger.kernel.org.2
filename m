Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEF33BB6E8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 07:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhGEFgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 01:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhGEFge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 01:36:34 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670B3C061764
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 22:33:58 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 21so15763327pfp.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 22:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uXyqnOeoyJ4NZkEKPJHOl4w1hXSWWEzhqLTMS9dPfWg=;
        b=Jh1hPoDFYkVXHrWRwuJ4Scju5gaiBoK7/WyLA8g3EzRjNl9LEdaK04bb2ug55bnKea
         Pi9pbq/1u5IRfMKIl5xqpWvytO1MPAGHaA2H3pzWiwJXXj19Me1P0oTsVn2TUakHXHjo
         1NxcGOQrBYmY01tKHLlVEnWcBvvxqXJrzTSz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uXyqnOeoyJ4NZkEKPJHOl4w1hXSWWEzhqLTMS9dPfWg=;
        b=SbAw1A+RfoFO+GjBy/Cl1afcuhUgO7iPcjX0/zm0kDCRvmuL42HlYGwjIA68swJn0J
         xn7wSOZl7g6pWskrzdjfmP2uI4Qea8MPxSRjLH3NL0pJoZ922HFkQnU/c2cXwYgLuQuA
         QVrdx2PPmuFbaxPnzh5cMcuNPvi4vuOLigowE1c22OpFu1UYUUv4kTmgSbnNsxAylaoK
         mBm98EXfytX8Gu01WNA2rnQplyWyYnzWvS19p5mzsVgMZ3sTb3Ljay2Lzt67dQua03WB
         6mpuKm7Nd54nt4Bfs2kasY/LKUYbVSOCcAvnWWzZ8/dwlIyrG/oeuu1XmmKNPP18/C53
         O/8A==
X-Gm-Message-State: AOAM532QuW6oRktum5CSi0LFSKUh99r2DVdAee0fDRbS6UexoEJV6PbU
        7VROad39umAXN0YEyrlTIUN+UA==
X-Google-Smtp-Source: ABdhPJzcOf6htkQbr6g+Z9QUaRVopdGl4FPYu/027dmu4bdfATz1XeYdyiDTTv2CEipoO7bU+Z03MA==
X-Received: by 2002:a63:445b:: with SMTP id t27mr13940726pgk.413.1625463238016;
        Sun, 04 Jul 2021 22:33:58 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:3fed:7130:60f:265a])
        by smtp.gmail.com with ESMTPSA id x19sm6805245pfp.115.2021.07.04.22.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 22:33:57 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 13/14] dt-bindings: media: document mediatek,mt8183-vcodec-dec
Date:   Mon,  5 Jul 2021 14:32:57 +0900
Message-Id: <20210705053258.1614177-14-acourbot@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210705053258.1614177-1-acourbot@chromium.org>
References: <20210705053258.1614177-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8183's decoder is instantiated similarly to MT8173's.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/media/mediatek-vcodec.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
index ad1321e5a22d..c44a6e6943af 100644
--- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
+++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
@@ -10,6 +10,7 @@ Required properties:
   "mediatek,mt8183-vcodec-enc" for MT8183 encoder.
   "mediatek,mt8173-vcodec-dec" for MT8173 decoder.
   "mediatek,mt8192-vcodec-enc" for MT8192 encoder.
+  "mediatek,mt8183-vcodec-dec" for MT8183 decoder.
 - reg : Physical base address of the video codec registers and length of
   memory mapped region.
 - interrupts : interrupt number to the cpu.
-- 
2.32.0.93.g670b81a890-goog

