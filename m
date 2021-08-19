Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764EE3F152D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 10:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbhHSI3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 04:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbhHSI3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 04:29:30 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACAAC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:28:54 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so10769414pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 01:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mlxsOtjk3EQe8tY0Dl2bnQT6hDTIci57yhrirNK4WM4=;
        b=DcTYaUhCIADfef5Gy3rock98MnXIqSctEqt74Z19ydTwBKKAObgfXU+VqkbJWSexUj
         UTyvK+IMz8cRzzM3uwazbz16bvKD7n32ApUrudfD1RSJgDl2D1mZqTXO3DkgrelKOQpi
         Q7p7fo0Gocr6RMjIRWBGHxH7n5X3GGD/oRgnQokQLV5vdeElSZOAXAwAejS+yZV1Wuu6
         jzuXl2nNACEW3vAvEv3zPucoMA7RbOAXm8H3Q6h6T/TZr7h19yaQYXiq2EdS3X2KbKDe
         T6OB6Aamb3+KKsCylj0MKNVNxv56AeVRr7bu0Gtm8ztGNmBdiX3lPUfzVZE0qSm2jDhK
         kd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mlxsOtjk3EQe8tY0Dl2bnQT6hDTIci57yhrirNK4WM4=;
        b=qs3TpxcRBJ974wmP1cUEO/6Te8UakQzfyy6WX9ZwRsNFsm9zAH5Zl90L3JXyn/TeAM
         LEK4gZ0XtrF6qebg5630YKAfteFgfuZ4YRSjZwQC36+vlzBkwfg1RmDdIdr/6tvwacc5
         v9T47IuO0gEsVsE7fk0Jmag6ez9I+SkyX+ekvMUswIBb7cjQI+9zHAk3ZfeliuBCSoox
         Mox7f9bwm+Dhd1nt9vOPtSdwufU/+fN4GDw8eJBf/5Syjg5JSX1Pq+WDdRBAgqo9h9Tz
         gDcREajElFMDOzjwcYD+PTO4PMNwRVbEVRi4WvzahZmsWGEdaqwSgFmsBGQLRL9lprSo
         BGIA==
X-Gm-Message-State: AOAM533Z3IwoPBgHKGcaiwgc0YgeXszMQTFM5K7YcEg/Rwy/lObIVBdG
        Yjzosqy+2i7rpMBmmjEX27/XKQ==
X-Google-Smtp-Source: ABdhPJywwufy1GedVPd73KbtcOOg8bcUAjKXTcyH+M8kmTO5+afM/R29vL3jzxw22vHrFl14nf8SLQ==
X-Received: by 2002:a17:902:9008:b0:12d:8258:e07c with SMTP id a8-20020a170902900800b0012d8258e07cmr11128687plp.42.1629361733810;
        Thu, 19 Aug 2021 01:28:53 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id i11sm2347220pfo.29.2021.08.19.01.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 01:28:53 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@google.com
Cc:     yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v1 0/2] drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Thu, 19 Aug 2021 16:28:41 +0800
Message-Id: <20210819082843.716986-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The auo,b101uan08.3 panel (already supported by this driver) has
a 3.3V rail that needs to be turned on. For previous users of
this panel this voltage was directly output by pmic. On a new 
user (the not-yet-upstream sc7180-trogdor-mrbland board) we need
to turn the 3.3V rail on. Add support in the driver for this.

yangcong (2):
  drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
  dt-bindings: drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail

 .../bindings/display/panel/boe,tv101wum-nl6.yaml      |  4 ++++
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c        | 11 +++++++++++
 2 files changed, 15 insertions(+)

-- 
2.25.1

