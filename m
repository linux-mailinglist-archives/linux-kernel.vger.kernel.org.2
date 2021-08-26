Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A253F8607
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241955AbhHZLEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241552AbhHZLEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:04:05 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E67C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 04:03:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q3so1571286plx.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 04:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3GTkuPL4UPMLgrAEYs+HYFaqq9yL68gOnVhfKgDpcS0=;
        b=uE+dlzMOnHocysgzJwV038c07k5ja66wtp88Sqz7UzU1Ffz7QSEemUzSwz3RQ6gLtk
         qVFLRmMuy2lOSbiFSOR2eym0R/detKAmVD/0Q3x97SwaIZyMjzbtZL6GBaNVvnpXZTm9
         +AaZ4P3fRtfz4HXVgvFap68Y23Fuzwgq6Hbo6kB3/NVZCSyYdTgm8HrVRRcUrdXfcDRJ
         P4WEwVE31RbNo0hQfbbRBa5NlhyOfNpVR9C79BzQqvZ5fuhsjTXEQzYsVtYKAuRTTSi8
         J0ZRQaPA51LfeIKVJUwa7L3loqp5BLIRV9ak/VOgORlf3zQ7go+dLWMEyyPlmaxWSpne
         FTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3GTkuPL4UPMLgrAEYs+HYFaqq9yL68gOnVhfKgDpcS0=;
        b=sfh1yoGj4razAcWk0lnTU/ZDu8Z5J85aUv6Pl9tAGGeyTAXWB3Aw9SiBD6T4lBb1ky
         KACkeJF1RSGfbx4/AA1V986MKb0kIOwnEYI9fIdjH99GStNuL/pko/xqBZabESqlrqRL
         anu3GtaBXP2tNUupKHTJhxeJPKewzi3m2YJ00l+ZSKI+bdylLa0rmcK1TN493YsGBXXC
         RaDlDmPFnDqK5dZT4VD2VHJXgMgeEYmL4dhlFKg5iEgLMvS7DHHQkVikgZKzFR3DL9cz
         gzxIR0EHRptcH1ePfH3yfB+L2vPttSZYTJatnY630DX5NBR5B5gCYdT6Ih0i3etZfcQr
         exZw==
X-Gm-Message-State: AOAM531SdX//FQOjqWMpIC09ZoPTkl/elS1GbJbUARhfMDzY7y+sDx3C
        MchnQuIDHbqQRTRev3pUnhVKbg==
X-Google-Smtp-Source: ABdhPJz7PjiVM/hnpM1SvmZRprpOEgYGpJHs0Z9wVbYVPP2UpuQKyIf+3eAHcmNgoNZtsCrnsCsi8A==
X-Received: by 2002:a17:90a:6a01:: with SMTP id t1mr3675857pjj.31.1629975798328;
        Thu, 26 Aug 2021 04:03:18 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id z12sm2655335pfe.79.2021.08.26.04.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 04:03:17 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v3 0/2] Add driver for BOE tv110c9m-ll3 panel
Date:   Thu, 26 Aug 2021 19:03:09 +0800
Message-Id: <20210826110311.613396-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/devicetree/bindings/display/panel/boe,tv110c9m-ll3.yaml:

Compared with v2, delete pinctrl in examples dts.

-            pinctrl-names = "default";
-            pinctrl-0 = <&vdd_reset_1800>;

yangcong (2):
  drm/panel: support for BOE tv1110c9m-ll3 wuxga dsi video mode panel
  dt-bindngs: display: panel: Add BOE tv110c9m-ll3 panel bindings

 .../display/panel/boe,tv110c9m-ll3.yaml       |   81 +
 drivers/gpu/drm/panel/Kconfig                 |   10 +
 drivers/gpu/drm/panel/Makefile                |    1 +
 drivers/gpu/drm/panel/panel-boe-tv110c9m.c    | 1303 +++++++++++++++++
 4 files changed, 1395 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv110c9m-ll3.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-boe-tv110c9m.c

-- 
2.25.1

