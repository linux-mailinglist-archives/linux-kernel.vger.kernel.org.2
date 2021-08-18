Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCD93F0704
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbhHROrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239519AbhHROrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:47:40 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FCCC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:47:05 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id by4so3626662edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vNVfBtmdSEQMHS7NoA4wKiTmeDTFKx5xuSiT5cX6rdQ=;
        b=IOgQGJmbcbWP/GZ5G+/xSr0a1QHxH3JvD8MK4+fmidRvQekv/jZ5OWdHrDsfxnrhka
         jfNNFVgp5HNJoF0S4vaTSSzFq2J0XwG2/m7zkW7ugBlXiHDb+jAoZlrn6vO+Wup6CL7u
         Vpsccuwcx9PtDgiTEtupb5Y7pJ7riUYCjIvUvizYeqX7jLbNQ4rVmtE6RDcBu6K9qWdK
         0tsBe70yTbqqUcHG4zNZ02ipGLr0g7MXoK2t924OSGwtHr+yFeeMg5hmc5Prr/w3ZsNu
         6AIvk1j+S3bypYU80LiPoIWc+bw5ePxMsZvnsLdhIfeXbLgwCBcVj7wFEIoLCDv3yIOV
         mk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vNVfBtmdSEQMHS7NoA4wKiTmeDTFKx5xuSiT5cX6rdQ=;
        b=H66Y7QpcrI18xglRyg55YJ2GK+dLO7wBh32wzWpIgwjqEF+rh9SNHm4Ha5G/rcdzOd
         pSs1yydV9Eik54nVR87cpIHR8i1IirpZh58qHdevAfj5aVCidJ8jyfnqbfj4MpmIClC0
         UiJOHTkwFzcRlJO9jGp+VOPqy8TdJxCQpHxrWdRAc0+mxHkIQDySO69UABcUAPIy6Zjq
         kzTQm/mFd+2cFlczgEqaVdGD6Dn3P1qg++h9JjYnSw7QfWBZ5p1gQOX2IP2Kec0EjIHf
         zqzBj/SOaj827KHXW31tY4UCZV9U+MhWWeeVt61IT1D5dxpvhslK76+5m2NUX2Dbm2lD
         ptJQ==
X-Gm-Message-State: AOAM530BR/x9zwT7qlfIG2C2/vvtB2vDy4nVcvp4iiYUPB+6NUno7Nh8
        Jz0WnOyr84AvwHtMS54dN68=
X-Google-Smtp-Source: ABdhPJzvloc74qMfIzl/6q9qLOKDLfOuqz0NR6SdFazcCDy8tXovf3+knaR82YSJJPp7PSoOUHTn+Q==
X-Received: by 2002:aa7:d54f:: with SMTP id u15mr7976174edr.178.1629298024282;
        Wed, 18 Aug 2021 07:47:04 -0700 (PDT)
Received: from localhost.localdomain (neth7.eastcode.net. [79.143.160.90])
        by smtp.googlemail.com with ESMTPSA id x17sm2152808ejj.58.2021.08.18.07.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 07:47:03 -0700 (PDT)
From:   Nikola Pavlica <pavlica.nikola@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nikola Pavlica <pavlica.nikola@gmail.com>
Subject: [PATCH 2/3] dt-bindings: display: simple: Add Vivax TPC-9150 panel
Date:   Wed, 18 Aug 2021 16:46:47 +0200
Message-Id: <20210818144648.72665-2-pavlica.nikola@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210818144648.72665-1-pavlica.nikola@gmail.com>
References: <20210818144648.72665-1-pavlica.nikola@gmail.com>
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
index 62b0d54d87b7..d0efefa5a820 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -285,6 +285,8 @@ properties:
       - urt,umsh-8596md-11t
       - urt,umsh-8596md-19t
       - urt,umsh-8596md-20t
+        # Vivax TPC-9150 tablet 9.0" WSVGA TFT LCD panel
+      - vivax,tpc9150-panel
         # VXT 800x480 color TFT LCD panel
       - vxt,vl050-8048nt-c01
         # Winstar Display Corporation 3.5" QVGA (320x240) TFT LCD panel
-- 
2.32.0

