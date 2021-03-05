Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED0A32F6BD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 00:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhCEXpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 18:45:14 -0500
Received: from smtpcmd02102.aruba.it ([62.149.158.102]:42068 "EHLO
        smtpcmd15177.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229672AbhCEXoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 18:44:39 -0500
Received: from ubuntu.localdomain ([146.241.168.111])
        by Aruba Outgoing Smtp  with ESMTPSA
        id IK7Ql1dnx4WhhIK7ZloTI9; Sat, 06 Mar 2021 00:44:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1614987878; bh=irmXgecv/E1PrGoJ39eNHzojIebA1yNanUGrgnL0GSQ=;
        h=From:To:Subject:Date:MIME-Version;
        b=J8A24Wd404GkKf20DCrgy3lLtq+YdvSQKNOaMq18wHObVSyKc+XeByD/ecV4HuTGs
         QP9YH29WvUzeDIerz4XknHhFuwhPBY5BBRJ3Ul1bKdNtyofwAbzik6XryVSPPa+2Ne
         eAafg+bpWMG32+ykZNm6euz9XkQ4plEapgWony0sQmlxSo37gKWZVBDTjtRclibIKi
         +5ze9d+dnbh7doPpPOB0sUNJ2kL3yfGW34jii/9z0vOhtfJsVtxOZDkF3ASKFn/dqi
         tq847xVL/cTfBYZVg9c/xo8gN5A2+dH4g26du+cgczrDI5zZnEbHhWpJRCHPixLcPr
         BX3klMX5G9omA==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Daniel Palmer <daniel@0x0f.com>, allen <allen.chen@ite.com.tw>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v2 2/9] dt-bindings: display/panel: add Jenson JT60245-01
Date:   Sat,  6 Mar 2021 00:44:19 +0100
Message-Id: <20210305234427.572114-3-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305234427.572114-1-giulio.benetti@benettiengineering.com>
References: <20210305225444.GA792026@robh.at.kernel.org>
 <20210305234427.572114-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJAbOqgmHM5eQ0Jo8NDjQJ8yLhhD9mFkkqWh6pYA3XZHYKtWrkfAFJOVWcptc1ccYMeun6Mk3icaS5k0UqzugzSuvvJd1Ro7pG+tmfAbuXjT2N6n+UKe
 pi3vjUMtxHkG32FG62V1Zmt9BOqLxh6FgdgDyE9jPnkuz8DCBC0vQBs5AlzvPrLXtW/Q3qvMlzBVYHuHZv+G8KgCPJ8blZhFnbP42ZIA6mbMfXYZI10Fh3PF
 4DY8by9hFXxHSFfxvAf0Wm9yqvz3xmP3KNKyMb07SwKny5QeucrExtYr9gCIa5S/zMbuS+lfxYJES75cJhXPZ0KfNLazGMKs8IeZj9d7knt/Cn0ldJ3uiK0V
 BXXKBfMv2WGb0tTKwMLazeX4hSEUh82mka2tm+2uo/skqLZw4/VM9b6+BUEftzhrYGFikhDavwtc4Z0N0x41Tt909PqFBDblo4/iUFj4o6uMoRJefwnzeOzD
 xU9hzGD9I72VXQ4yLi0BdP2wNeccP+iqPuQUb6Umkku0KsFGvsTu8HnUMBnadS7jFgx/+HlveRzDnas//0aIZy74UDiOAKlP6CXxBnuFhkrYuPx/n/ehUFZj
 erY+8M6bnsX4ngURcGelxmv1Q+iDydIWZIbOeJkZbN+jXGOXEsEEEoWqyqIWWBSx79W/tIgqjflBmN+Vcu+jF79fqkdiR1W3DsXs7W0sY8oTVMs6n76Zk4TX
 KhjS6iZI1RorlxNTk0QYvH3lH8qPkGYvfWD/cQb7Mrmi2oxCKZk5FA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

Add DT binding for "jenson,jt60245-01".

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 62b0d54d87b7..ce41a589a3f4 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -168,6 +168,8 @@ properties:
       - innolux,n156bge-l21
         # Innolux Corporation 7.0" WSVGA (1024x600) TFT LCD panel
       - innolux,zj070na-01p
+        # Jenson Display JT60245-01 7" (800x480) TFT LCD panel
+      - jenson,jt60245-01
         # King & Display KD116N21-30NV-A010 eDP TFT LCD panel
       - kingdisplay,kd116n21-30nv-a010
         # Kaohsiung Opto-Electronics Inc. 5.7" QVGA (320 x 240) TFT LCD panel
-- 
2.25.1

