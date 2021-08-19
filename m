Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295B43F1638
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 11:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbhHSJbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 05:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237620AbhHSJbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:31:46 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F51BC061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 02:31:10 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 17so5324363pgp.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 02:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9pbcm30VIAQ9iEVPI1FIF1aW9JXXtwoO9LwunNGqeRE=;
        b=09wWrvfK30WNG/7F1VMP3BxxZS57XFx1OQJ3Z5tyEKf/2aGPGNK1ZUeoZ7V4747zjs
         YcElFnDz1sOUZ2OPk1l+/A8FQGuiTqJ6c+vJhkBaKF9Y6oVOXHteAmYZEFDx/RwmMNBQ
         27IKr2c5DcqXyC2xrcJ2Njg13TnEd5ZM16NBMTB4H5dNHSEKBWzh2Vkx613wPfGCHo8b
         4apARhzg2/el3xDydPwDRMLKQNRt5D+8RBL1Ig9UkiYmqN8XjQfBNtMz7kaUYoaTm89K
         TK0wI4PNuCHGGKM/TR8JN+t4jOXyQm3jp30lX44dbK6MDP2kfpLIsapqeqvNvtzJwWOQ
         EzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9pbcm30VIAQ9iEVPI1FIF1aW9JXXtwoO9LwunNGqeRE=;
        b=ntFzM2/Eao31cP59rOpHpz0BdwWyrdmLxXHCGMGGhGMRlPuhq3rGOBD4GzMFqjEeYR
         rBLFm3deWjPbs0qAl5GxGC8NpsL6o/RrGVqrLz137ZTarq8B1POZGNat62136T0gx1Ym
         zUP1F4zjEhjpU8dSXjKbwc2IcFl6fNPjlpD/VBLWQIJLO+0llB//eakwLSLslA4b/gEX
         Czmn7bIz4wiy+unSyBn1WdUoIgZcd09z7SMeEyXYD9QMVTsDiifz3jp/a7Ho9AsrcjZ6
         HG5FqGvgu4eR4fQVV4UZJBdU46ZTVGEDcTjx/pndpdS6R2n/KviBkrCt2pibCb5f4trQ
         eiCA==
X-Gm-Message-State: AOAM530e9cDAIxyGw1AwN8wfx9abmoIkvrAsx393Fix0vIEim9q55nC2
        qcIerbIlnDtIgEYeoSTXbiMaMQ==
X-Google-Smtp-Source: ABdhPJxvHLPZaCGYPXAAhDOgP3myf1MA4MpJ0X3o6vpff47Q/EKx61qtG7O67f06yUVso0qKhNbQ8g==
X-Received: by 2002:a63:b91d:: with SMTP id z29mr13182689pge.436.1629365470105;
        Thu, 19 Aug 2021 02:31:10 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id 11sm2601031pfl.41.2021.08.19.02.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 02:31:09 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v1 2/2] dt-bindings: drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Thu, 19 Aug 2021 17:29:43 +0800
Message-Id: <20210819092943.719433-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210819092943.719433-1-yangcong5@huaqin.corp-partner.google.com>
References: <20210819092943.719433-1-yangcong5@huaqin.corp-partner.google.com>
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

