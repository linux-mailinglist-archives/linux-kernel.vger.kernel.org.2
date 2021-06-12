Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0771B3A4C62
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 05:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhFLDVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 23:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLDVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 23:21:07 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6142C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:19:02 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id l1so3989268pgm.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iZrBmMYE0pMOpeejrZ6SD6PbgBG0c1CSAN0mNTGXUKE=;
        b=TNgcUBunGafH3meocpCHNnKt/NA0dXXg11PA8MJLnXVu2euTusqY8Y6Omd0109ghCk
         H0AgZU349VZO8eu0pOFsXQzALup4lPXVYpemz/57GnFvlV8QT+sYZytIoXvsbBfXlbTN
         UMVeOMEPggAA0zdhBz2L62mGEBBfcTnLlRksI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iZrBmMYE0pMOpeejrZ6SD6PbgBG0c1CSAN0mNTGXUKE=;
        b=rqPVLh1v+C1iTUqnxbIOQXqwwD91b3B/VMi/xXtpN+lO613bVnjjDqmQMw6IkysG+l
         1va7R4bt3mdMqu+KupzhR1wSy1YBX7BR6hWTWqspXA1EREFuLbv1qtIVC6RlUOoKvb8U
         Gw+iUy8N6EHiZDEvTEW/MhnPf7UfjupD8fez2MLMwAy78T51OeBf1R3Q6uRy6g49toza
         F09sA0IuZWJRCaQTF5K/Yt262pbOc1WTB3L4oppGOBYrIU5BAEG+489Oqa1+r46IBza1
         J9dqxIcKOorOQ6eCx7n0mLXWquvK03QNsugA0qVbIlzlgDtDgR9NUK3GxOWpVDpVYG7i
         QJgQ==
X-Gm-Message-State: AOAM5326bBiatQ0HY1lIJtH3v/CV4dqnxOdodnDGip3k/UhcjF+LJ8bU
        yferxSl7QEjW0luXfA5IuyZso9Sdtf4PyA==
X-Google-Smtp-Source: ABdhPJzXg020oCP9I7Nnr9yMMU4Dj1q2AfTjBBfaTk9JMIl35vhu5mQFfDgjlMLikbvgRNYDPfH5UA==
X-Received: by 2002:a63:f13:: with SMTP id e19mr6513263pgl.112.1623467942147;
        Fri, 11 Jun 2021 20:19:02 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:cbbc:c8a0:4601:2039])
        by smtp.gmail.com with ESMTPSA id h5sm6688519pfn.127.2021.06.11.20.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 20:19:01 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        maoguang.meng@mediatek.com, yong.wu@mediatek.com
Subject: [PATCH v5 2/3] dt-bindings: mediatek: Add mediatek,mt8183-jpgenc compatible
Date:   Sat, 12 Jun 2021 11:18:52 +0800
Message-Id: <20210612031853.3115482-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210612031853.3115482-1-hsinyi@chromium.org>
References: <20210612031853.3115482-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mediatek,mt8183-jpgenc compatible to binding document.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 .../devicetree/bindings/media/mediatek-jpeg-encoder.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
index 5e35ecfd21f1b..fcd9b829e0366 100644
--- a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
@@ -17,6 +17,7 @@ properties:
     items:
       - enum:
           - mediatek,mt2701-jpgenc
+          - mediatek,mt8183-jpgenc
       - const: mediatek,mtk-jpgenc
   reg:
     maxItems: 1
-- 
2.32.0.272.g935e593368-goog

