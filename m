Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1901B3F19BB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 14:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbhHSMt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 08:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239655AbhHSMty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 08:49:54 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53870C0613A4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 05:49:02 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r2so5794980pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 05:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9pbcm30VIAQ9iEVPI1FIF1aW9JXXtwoO9LwunNGqeRE=;
        b=a6k/F0Z/K2Jl7CkO7kBktGuWWCXt7rkr2NhCDeEDXRjFzhEb0OpnJUer51cO0UHFl5
         jVakqurFu4rDni51cyLHB2H8zhFL5dWvO26WzjHD37Q1DKoHqMnx+Zc0Qnk6xvs5S8/l
         ThA/NjszYqDIl/gnx2+31ggSJ/qWVQN0SaAH+UfEUkLMx8mkl70sSnyePULSdzOcvjD9
         qK1TLNdSGng9KQmWz91soyrowNQ01S8JAe3VJk2fh3cON23mlAT+xzLpdAaX7IwWGSus
         uCdnibQy54t0XiuWVWwS63lJk4amYumDvp3ECwW8OnFgjUWCwVUq76tzY0gP9FesgsoA
         nteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9pbcm30VIAQ9iEVPI1FIF1aW9JXXtwoO9LwunNGqeRE=;
        b=Zjv8g6bpGFtYCtQ3C4czSyIhlH1CI5j9G6jzMhDh5RQ7rOXVA0PC5QLdkhZ5EjfFxO
         OF24ZyvBz4l35LjpTrMexNtC65OTZGwJ9IfqbJ0JLmLtwiNkHenynwyr2yrkEBlVSdbh
         mB8NZOmF1iXKjyPtDuqbnlO+ws9B+dSpdWDqaVmKwCzk0mhe1zJKB1xHCTbHkqhizDW2
         xl7EuFnniIOKEcD+dT0pdZ9cnVneOq6smaRJ336wwAvOrQ9K/4mKxTWTTIfg3LCG0Rp4
         ZdcgHLuvp71tjiDoCeiU8q/dI+4jIl7G6VnQB4FcA8PsFWQqzIAXSpDKS5GOHH7SGhBL
         WmzQ==
X-Gm-Message-State: AOAM5324p1XMFpbR4kKRxtd/ieF1fV/qBsg40+aiASGQONAoJjpnSkx6
        oji0HrjuX5UqjEwo4H8W3thltA==
X-Google-Smtp-Source: ABdhPJxpfrBfNwm2FhmeMSM0WiRMBL1j+8rUqW2MLnsuuFOBMJFsJLlk4jUG3fXS6aqyj90qjmCarw==
X-Received: by 2002:a62:b615:0:b029:3e0:20c3:181c with SMTP id j21-20020a62b6150000b02903e020c3181cmr14526760pff.62.1629377341899;
        Thu, 19 Aug 2021 05:49:01 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id c11sm3137210pji.24.2021.08.19.05.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 05:49:01 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v1 2/2] dt-bindings: drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Thu, 19 Aug 2021 20:48:44 +0800
Message-Id: <20210819124844.12424-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210819124844.12424-1-yangcong5@huaqin.corp-partner.google.com>
References: <20210819124844.12424-1-yangcong5@huaqin.corp-partner.google.com>
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
 .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml   | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
index 38bc1d1b511e..e45de7a4360e 100644
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
 
@@ -52,6 +55,7 @@ required:
   - reg
   - enable-gpios
   - pp1800-supply
+  - pp3300-supply
   - avdd-supply
   - avee-supply
 
-- 
2.25.1

