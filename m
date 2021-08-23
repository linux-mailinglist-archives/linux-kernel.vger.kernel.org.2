Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CB23F4A13
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbhHWLwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbhHWLwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:52:14 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45289C061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:51:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so1613053pjt.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tvKsmbaciKPF6OJQp+Jz6my20ifBtNKlhOi0gn+GEfw=;
        b=AUkDAh4oH7KblX9b/0RzNTOlSUvYksN0Ajzo1oW7jxcqnUlAeBsdNIU8tpUIerjn8/
         Bb0WDMBV7A2YhfPM9ixQ9wN/fWIiUoLpW2P+0t4NYKAvoQbK2u1yxPi3Jy3qNj7HYzZC
         qNIYk/J7VftRBTaTTvMJqPbeFjH6kVq/OFKevqlCV0REc8jqxCbHOTkQ4uGPpRNXky2B
         OOUV2liBS2W7P6rf5EUjv3hHemzXAHLT0p75BmGDSSkD5alVQxY5ikjxQXzfPje8sSBM
         6N2rx199++3BwXCamspviyIQkMCBbfePBtyFQwKz2X49Di6qeYJqMLwkYMl4lgiLmSLA
         o5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tvKsmbaciKPF6OJQp+Jz6my20ifBtNKlhOi0gn+GEfw=;
        b=mm2/a/6aMLkULka2XFnqufmTEWOgtEUXC3CxUIl05ASfoCGmyyx3AvKrsh+TgRS8Dd
         xhf8YaoCbT523JAB2iOvFSpha7e6bSRMItSd5Dw+Wdhd8bzKsBo6TPpkpQ0x78zK4H9d
         bclyMyPwG0lCviGiQE/xwCZ8mrFH/b5T5oj4URqQDIeY/7OIbLxow5CnaEgIMLVx2Zqa
         W5SCItKu1PTQrWuUUDCPo3Pj+0HxIZJwfoB/fIY3o71w12Lb9Z/wvwes5W1hYTDcbFTe
         XI8v0QpZ90hqA9+teTygkeUWKK1vMAlmQRGBnmfohepcHZhgFhIUXVU70VO26V3tohAl
         kikQ==
X-Gm-Message-State: AOAM530T+ZyO3K2FvdsHWBpIYrmNfnx0uEni34GGz01M50oO9bgQubY7
        9JP7fPGDFKtkl5G8h2LCQlVBpg==
X-Google-Smtp-Source: ABdhPJxZDFTnrHgyjazzbqpcPk1WuHlLBOLj87xdIyvkWV3fHn8cWZ7+1lfagT0uFvNFeG74/a2HrA==
X-Received: by 2002:a17:90b:a48:: with SMTP id gw8mr3269218pjb.145.1629719491839;
        Mon, 23 Aug 2021 04:51:31 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id z19sm15985426pfn.94.2021.08.23.04.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:51:31 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v2 0/2] Add driver for BOE tv110c9m-ll3 panel
Date:   Mon, 23 Aug 2021 19:51:23 +0800
Message-Id: <20210823115125.1070257-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/devicetree/bindings/display/panel/boe,tv110c9m-ll3.yaml:

Compared with v1, add a space in the required list.

yangcong (2):
  drm/panel: support for BOE tv1110c9m-ll3 wuxga dsi video mode panel
  dt-bindngs: display: panel: Add BOE tv110c9m-ll3 panel bindings

 .../display/panel/boe,tv110c9m-ll3.yaml       |   83 ++
 drivers/gpu/drm/panel/Kconfig                 |   10 +
 drivers/gpu/drm/panel/Makefile                |    1 +
 drivers/gpu/drm/panel/panel-boe-tv110c9m.c    | 1303 +++++++++++++++++
 4 files changed, 1397 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,tv110c9m-ll3.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-boe-tv110c9m.c

-- 
2.25.1

