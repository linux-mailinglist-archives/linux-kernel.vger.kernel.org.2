Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8275D3FAFDD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 04:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhH3CkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 22:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbhH3Cj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 22:39:59 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE92C061756
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 19:39:06 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id r13so10611796pff.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 19:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xXGxvZeRy11wrq81EuFsuIuGp1cxXAYLGS+zZfcIkQ8=;
        b=hnG4AjOcYMuAsoxoKXmEO/E1z2aFhz7sb7Sn1GJWao4nnj3gNZ4Grs3f5UvPsejL7H
         ibg/AKwYyFapmCGEm6aoD0W4eBXKJaUx/1xIyzpHT/BNcyAiLOF4/i8uHIU2vlGluT+l
         z4Sk90+6iv+Pah0mtGlDwcz1GXdp4kj1ToUB0urdPHXboGedGPLYiA6nEQZR+Nd+taN+
         mbZucipvw6kDvKJjCV6ZhlN7jIjIc7AlZvjaZLpm4cy9VW1pF5ETRuCqdsP01Iq5ia34
         E2LXb0HJ9vkk0sY7KBsnc3t4KWqOblVnFS94MR43WLCMUaiv5IKZp/mVqloQKEx1sCii
         SRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xXGxvZeRy11wrq81EuFsuIuGp1cxXAYLGS+zZfcIkQ8=;
        b=nEt90zONdR/2aNyY6Y83LWZiLlopJCDZZ8hCaqhJth6zqY6QwmxYn1mQk1KJs6ulJT
         je/UKg3ACv55AqY1aJ3zSQylzzZBfyzvidiN9/K46hjIF3Za++TF03xR5KEH0GhDuJv8
         awhwbzit4rJXY+Qo6CoiC4fecXmPI2fDQvYWW48nnT9HV5T2/ShId7BJmlcvcsFrFD1j
         cWMIYKm6jZZkJ6zO3xKL7k99zRf64Dq8UparP/SX/d0vNPaETXdWIWX0FqC9X+Fa7V4N
         CyTQ8zue8zGc3Ya9TnoJC8lwj0Ub4wg2/9vxIpEYUAxvRbKXqSxLk3SJW5xBOKxX6yqS
         GMBA==
X-Gm-Message-State: AOAM532/9FfxX9mKcBXCB/tKIOpUuZg8EMgutsRN6mqpuvOB5kN3s+Kn
        hrTiGea/rn0C2NasLomksVuz9Q==
X-Google-Smtp-Source: ABdhPJziqFO9RqYOhlv7NxeqTzepoB696kqSKaI64e48ycgEgclCcfq8PvrDdH9Hjs9nf78MtUc0oQ==
X-Received: by 2002:a65:5c83:: with SMTP id a3mr19952951pgt.287.1630291146237;
        Sun, 29 Aug 2021 19:39:06 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id g13sm906839pfi.176.2021.08.29.19.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 19:39:06 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [v4 2/4] dt-bindings: drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Mon, 30 Aug 2021 10:38:47 +0800
Message-Id: <20210830023849.258839-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210830023849.258839-1-yangcong5@huaqin.corp-partner.google.com>
References: <20210830023849.258839-1-yangcong5@huaqin.corp-partner.google.com>
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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

