Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C95A3260EB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 11:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhBZKHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 05:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbhBZKE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:04:27 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FB7C06121F
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 02:02:24 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id t11so5916536pgu.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 02:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIALnHOxfqV79rmxtlQVLJ7XQLHlFw9MAesM3ioGoWo=;
        b=SkE9wICXCgToe1dlplqubNyP3Uu5GyOznpHgFFUphOPxG5wwvYBb0L5gJicXqSTLTV
         3Ac+tMUkSMIRQLMJ4lPq+6f0rjI56FUEhJU4ufbx9cBEjxf2BVXQC/r50iRbRiGR6grv
         jTlnI/hQAkqHwBQMFsyay8yLJ1cjyL6RoAdwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bIALnHOxfqV79rmxtlQVLJ7XQLHlFw9MAesM3ioGoWo=;
        b=pQW12f/W/Tm/UKsjcW1ElSa9nLFrxX8Qk+NZMGFDpya02l5peZfw5Vbpk9oSd1hqQI
         ZyYTE+1RcfxDXDXUMYdUZUYqWWY1rOhCDcy9bIvk04ryJvtoXQTLQsPXLfvjvEp2BVr7
         5vSYABs3CmhLpjpZKzaZ75sLtopZUKHJMxpVOHLviVHzIyU++whdEckuAL66GdoF4WaV
         zcmgl3BtxKi4TfwlQrAbwwbTjfGic+TMURmCnst2d6Q73nGZ0m3WeCDcdAlTsmdQ+pDA
         pPyu7xb5Nw2qEEe0EJTCm8QuwoZA6oANzvGQEFa/8X5pCEV0b8/3vb9haYP3hftL++zb
         T8cg==
X-Gm-Message-State: AOAM531wRxGUbP1GOYtgqOIJ4hflFuc/r/Bzb0vH3rZdST5vd0cfLn3l
        lq5LkJd1rfBmnKZmzCxy+VjJWA==
X-Google-Smtp-Source: ABdhPJzjj+uNB0y4UHgKTmkt+simNCrzoE6UqpjKQRM99q9y53EZRAREXkmj/1w04TJOFK+adS8shA==
X-Received: by 2002:a62:5344:0:b029:1df:c7d:3c3e with SMTP id h65-20020a6253440000b02901df0c7d3c3emr2531720pfb.11.1614333743609;
        Fri, 26 Feb 2021 02:02:23 -0800 (PST)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:5c91:233c:dd5b:b1b0])
        by smtp.gmail.com with ESMTPSA id o23sm9201565pfp.89.2021.02.26.02.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 02:02:23 -0800 (PST)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v3 08/15] dt-bindings: media: document mediatek,mt8183-vcodec-dec
Date:   Fri, 26 Feb 2021 19:01:41 +0900
Message-Id: <20210226100148.1663389-9-acourbot@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210226100148.1663389-1-acourbot@chromium.org>
References: <20210226100148.1663389-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8183's decoder is instantiated similarly to MT8173's.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 Documentation/devicetree/bindings/media/mediatek-vcodec.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
index 8217424fd4bd..30c5888bf2d6 100644
--- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
+++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
@@ -7,6 +7,7 @@ Required properties:
 - compatible : "mediatek,mt8173-vcodec-enc" for MT8173 encoder
   "mediatek,mt8183-vcodec-enc" for MT8183 encoder.
   "mediatek,mt8173-vcodec-dec" for MT8173 decoder.
+  "mediatek,mt8183-vcodec-dec" for MT8183 decoder.
 - reg : Physical base address of the video codec registers and length of
   memory mapped region.
 - interrupts : interrupt number to the cpu.
-- 
2.30.1.766.gb4fecdf3b7-goog

