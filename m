Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332603509F4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 00:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhCaWHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 18:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbhCaWHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 18:07:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90933C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:07:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c8so21100145wrq.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 15:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IE0NHC+B7WM4oHnzUAb/T162fdB57ZZtfDzZlQLPsWQ=;
        b=cESdP8es/GN0f1lVMQaBFDBcGDJ1lIamwN/O691MvzEUjqi2bufaO1gaOoS9Ynbacy
         3ul0+Hxi8sOyKWS02Z9WdRpc5G7DWiB8YlJJhe+qYfNebwhioubnM7IoYjjqnac70G+1
         zYQqyMfCxQNMy197l6PyY/s3HHCXKFwZfjt8z+WL/Iz1yTNVyn1R5ZjosSHF42udHtyh
         ANaXWn7yk7CAMCxaUvbdw36u6WTd6IYqS7qYzDV7FiBNr7v8WyuvWyLFc33FBA7Mq76Z
         x5V+xN03fl1rqTHLaq6kW5uX+Q9V/HuoH+kIAfE+u+4SVXPV7r8JM9r5g+1Vpty6MP05
         073w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IE0NHC+B7WM4oHnzUAb/T162fdB57ZZtfDzZlQLPsWQ=;
        b=jTG4vVotokQ8eZvE/KsWOtS1dVqJ0ULfl55KYEfOExN24bbrbpKJjDVAq4pc5qkzSm
         T/hI/vhWgwaS2Vnkj0cH4KnRTefxVgf+7V822AAYs2xbuITbF30Hln02dX9h6a3qa1fq
         B6JlBCIFbxLrM7HT9mU1YwVwGu7v0ZMTJEVCH61qdZRAlAhEIZt0xHAmM9sLhdSa6GTS
         +kc6X2+i+BG0xj+yezHqM0t6hJOsigauoMlEFL+IGW2/+Cw/yExRF360LphqjmReAj+/
         r2cLOhfz9lLH+T7nWi3CXEyqm62gphEPGg3jGBYtd8u6wtCc2LRjxsy12/tKcj+In7hR
         SV9Q==
X-Gm-Message-State: AOAM532SBiLU48ybLw1QExUXQubFCuISKRNauCuDqP/SBVA2qeLKkxqj
        MOrhh8bUIv5eLOBFhwviS0cLZw==
X-Google-Smtp-Source: ABdhPJwe16krazFRt0g3sMEwwwsGfIoOhECLnObZ2z9hz7fYHOcZNZ8Te7ytCOBcbZm4yzZrB0Drsw==
X-Received: by 2002:adf:cd81:: with SMTP id q1mr6066166wrj.125.1617228441230;
        Wed, 31 Mar 2021 15:07:21 -0700 (PDT)
Received: from localhost.localdomain (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id g9sm6531654wrp.14.2021.03.31.15.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 15:07:20 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     mchehab+huawei@kernel.org
Cc:     daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] zero-fill colormap in drivers/video/fbdev/core/fbcmap.c
Date:   Wed, 31 Mar 2021 23:07:19 +0100
Message-Id: <20210331220719.1499743-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kzalloc() rather than kmalloc() for the dynamically allocated parts
of the colormap in fb_alloc_cmap_gfp, to prevent a leak of random kernel
data to userspace under certain circumstances.

Fixes a KMSAN-found infoleak bug reported by syzbot at:
https://syzkaller.appspot.com/bug?id=741578659feabd108ad9e06696f0c1f2e69c4b6e

Reported-by: syzbot+47fa9c9c648b765305b9@syzkaller.appspotmail.com
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/video/fbdev/core/fbcmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcmap.c b/drivers/video/fbdev/core/fbcmap.c
index 757d5c3f620b..ff09e57f3c38 100644
--- a/drivers/video/fbdev/core/fbcmap.c
+++ b/drivers/video/fbdev/core/fbcmap.c
@@ -101,17 +101,17 @@ int fb_alloc_cmap_gfp(struct fb_cmap *cmap, int len, int transp, gfp_t flags)
 		if (!len)
 			return 0;
 
-		cmap->red = kmalloc(size, flags);
+		cmap->red = kzalloc(size, flags);
 		if (!cmap->red)
 			goto fail;
-		cmap->green = kmalloc(size, flags);
+		cmap->green = kzalloc(size, flags);
 		if (!cmap->green)
 			goto fail;
-		cmap->blue = kmalloc(size, flags);
+		cmap->blue = kzalloc(size, flags);
 		if (!cmap->blue)
 			goto fail;
 		if (transp) {
-			cmap->transp = kmalloc(size, flags);
+			cmap->transp = kzalloc(size, flags);
 			if (!cmap->transp)
 				goto fail;
 		} else {
-- 
2.30.2

