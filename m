Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949F941FE09
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 22:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbhJBUbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 16:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbhJBUbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 16:31:20 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767C0C061714;
        Sat,  2 Oct 2021 13:29:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g8so48203576edt.7;
        Sat, 02 Oct 2021 13:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9pxbaCe1jXd8PJ4n/lIgwYwRQ4fCdc6uEhCTsMiImNw=;
        b=cognP8IWO0Em4WyQUSXxBGBF/EP7BlFzqXdahoScz0mEHdq1e5zNTDzPkqdYYeLIJs
         THgf5K+aenscavkgU0obRVmlCzuv8WUemaNF6u47BM+cwl0O2Z8brE0l9Zt6dneb2w5g
         yunAINyGuSTTfK5vjEQR2DuBjyaDSKnTmhFWcy8zMx1EKbEWIspnXVbxPMd1tvbgA4Zi
         RkuJDZjq3gX1dmMIof4E7OXpeuThU26F5f8blyvPWrpG6vnu6odPitz0ckIBj7z1YKll
         +lsmfJhOL+AJnEWUzdzP16QzCFqohrVpNGsCkdZFKevCULP8fr7fckdoh/gw6hGFFPKy
         kNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9pxbaCe1jXd8PJ4n/lIgwYwRQ4fCdc6uEhCTsMiImNw=;
        b=xg1FcNtxFVlOPdWL5X3yBw/V7eWqWglHREruTGrHmWwpsf0PaNzItlFD9wMo0ftT8E
         oGMo06+FjLm3+P3oKa1UgLk8ye11GDA8f0FwKLCNVzvZMknfvf2RflM+nf297JaCbaWW
         cngyxJhKe+ElT8YiUFavcB9hwixP1MXlfxvkI9+wgn4+m/NFHfmoheAyDx73DyakpQD/
         ilpZ7jdd/aUkFzpuW1gugKediuRMaI3tw0H/mtciyEdl8Qo4+XTH7RTWoPCF0TnpBeVD
         gx+2ZTPatccOtAmoqiCxnHxRS1DuWbLUngpBVm5qeMtuBjnCisruVkvvnQXRY3+AlPOf
         gVWA==
X-Gm-Message-State: AOAM531SXzTfrnw6bFUSJ3PR32acSP3ZL9paIAOMN3DhpkzN2X7r5+B/
        6DKrhg9qFmaTs/l+vwvp3i7R4iOgcXB+iw==
X-Google-Smtp-Source: ABdhPJwOW/INGC5vvgKa8+gZmqo37WLJWF2bpA1fFk4Jsg1ZtMEemXapHioR9+s8hHZVvsFlZL419g==
X-Received: by 2002:a17:906:1290:: with SMTP id k16mr6291388ejb.566.1633206572841;
        Sat, 02 Oct 2021 13:29:32 -0700 (PDT)
Received: from localhost.localdomain ([213.91.86.150])
        by smtp.gmail.com with ESMTPSA id v13sm4546771ejh.62.2021.10.02.13.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 13:29:32 -0700 (PDT)
From:   Nikola Pavlica <pavlica.nikola@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nikola Pavlica <pavlica.nikola@gmail.com>
Subject: [PATCH 2/2] dt-bindings: display: simple: Add Vivax TPC-9150 panel
Date:   Sat,  2 Oct 2021 22:29:05 +0200
Message-Id: <20211002202905.509437-2-pavlica.nikola@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211002202905.509437-1-pavlica.nikola@gmail.com>
References: <20211002202905.509437-1-pavlica.nikola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This tablet display is unique and hence must be added to documentation.
Unfortunately, it's real make and number is not known due to obscure and
missing documentation and lack of writing on the display assembly
itself.

So the natural alternative that came to mind is to name the panel after
the device that contained it (an Android tablet). Hopefully that isn't
an issue.

I can confirm that the parameters that I've obtained are correct since
they came from a dump of the original Android OS.

Signed-off-by: Nikola Pavlica <pavlica.nikola@gmail.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 335776c45..1bea31fd9 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -309,6 +309,8 @@ properties:
       - urt,umsh-8596md-11t
       - urt,umsh-8596md-19t
       - urt,umsh-8596md-20t
+        # Vivax TPC-9150 tablet 9.0" WSVGA TFT LCD panel
+      - vivax,tpc9150-panel
         # VXT 800x480 color TFT LCD panel
       - vxt,vl050-8048nt-c01
         # Winstar Display Corporation 3.5" QVGA (320x240) TFT LCD panel
-- 
2.33.0

