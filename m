Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA61141FE08
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 22:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhJBUbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 16:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJBUbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 16:31:19 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD3BC061714;
        Sat,  2 Oct 2021 13:29:33 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id p13so19855879edw.0;
        Sat, 02 Oct 2021 13:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vt8iMexHSdD7KbcYDMZcdIIcyzlp3dp1Lof2sQDbqO0=;
        b=M/mzD4/EMeKIOCfJBivq3S4lbawIgHIBp794vss/bPAb9x734BRVXuFVVeunx7Mjqg
         SwWoQjrRlTaP9IJYmIHXkBYFII7A9IkH978/b1/pcib6WdMOduW6c1qa5WO55h8jdwVH
         VLoNIQKXDhTi2fQZ21UBda9RGzZgw3tZj52LQGReC1EgoQwBW+VRwJRv3+Vduh6s+w4b
         c2QjkVyj1iOE7jPLpNKKbbJOADgLas6420+39W/+vI6oCrzBiC8N9cFcYJcB16FeRchX
         rc4iNDyh/6apEp0c8+AtBzE6lEM2bOfxQjCwLSIFgphSyHxNxOfgq4xVtjO4Ryw9/AgL
         uOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vt8iMexHSdD7KbcYDMZcdIIcyzlp3dp1Lof2sQDbqO0=;
        b=gkvNX9BMwQmy4lV/F0ELq4d8iSgIR7fZaW9bYQBkp9Q/8TKFC+Ek3W8weRDAgYp5Hb
         g+ITMvzLhU/OAqGQXHLPibNi26XOvLfAvALrXSVbOJWPnixhhzeQzYHX5OAcb6UdJSwu
         huztH2KoNDnDCStfc9VcnEIGQbVzgtV2HzQIVjkOuy9nlf3OJzIJobAntEhPz+ZZ/1Tf
         UrW3neDfmE4tJePQaMNCXGgF5eVfNwLi+6Ie3SAiQ1cTdujEFJ546hoZshLsjasFWk8+
         c00yv1cgJfj1mdl1haVrX8pe3tiSjEGnbrnXtLbXU4PMydLzgyvL2axeOnr1ZleSAv7y
         EO1A==
X-Gm-Message-State: AOAM532TkgZhdaEwvqIrQfzWmlYwkGaKyG/nQPkoF/CZ8rCETr97aSO2
        FjJJGKV6AjVmzs0Cfk/UrdhPSHQxxMbkFA==
X-Google-Smtp-Source: ABdhPJy0d8P8w3XvIbR9dgUeoowMYVdxVx6bZnqiPHejidI5ELd5zXNysiRwgmiPD7bkyV4B9le5KA==
X-Received: by 2002:a17:906:ad5:: with SMTP id z21mr6255743ejf.109.1633206571868;
        Sat, 02 Oct 2021 13:29:31 -0700 (PDT)
Received: from localhost.localdomain ([213.91.86.150])
        by smtp.gmail.com with ESMTPSA id v13sm4546771ejh.62.2021.10.02.13.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 13:29:31 -0700 (PDT)
From:   Nikola Pavlica <pavlica.nikola@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nikola Pavlica <pavlica.nikola@gmail.com>
Subject: [PATCH 1/2] dt-bindings: add vendor prefix for Vivax
Date:   Sat,  2 Oct 2021 22:29:04 +0200
Message-Id: <20211002202905.509437-1-pavlica.nikola@gmail.com>
X-Mailer: git-send-email 2.33.0
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
index a867f7102..1a7d9ca02 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1264,6 +1264,8 @@ patternProperties:
     description: Vitesse Semiconductor Corporation
   "^vivante,.*":
     description: Vivante Corporation
+  "^vivax,.*":
+    description: Vivax brand by M SAN Grupa d.o.o.
   "^vocore,.*":
     description: VoCore Studio
   "^voipac,.*":
-- 
2.33.0

