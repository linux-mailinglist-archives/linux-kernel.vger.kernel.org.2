Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326413F47D5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 11:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbhHWJmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 05:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbhHWJl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 05:41:58 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E04C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 02:41:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id e1so2861413plt.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 02:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t8fVVskRMUhZBLLXNsTNJMFPY/9N8+jsrpYM+Bj152I=;
        b=Yamp3JjiDMsrBiCcbd5uH78fnp6QJHpzL5r1YvzpVkp1U5+z9MY//NjvwcuZzosktT
         JzcqYmKkkdDqDkZCrRnL3/UenDW/QBpo1m4Pm0DC5NLfbTv43DZbWmTKJA9wKixqCaH4
         mnLu5lynTXlkIz0eIBy5p6o8movMll4F7havg028GKA5Kx9v3XKTvofidV3TG/+0WVu6
         +FzwYTWaFgOhdMGajwdCqHRy9YM6H76AW8DY9JaNBUzVF3Gsy7z2Caz5lY1gUbqe4UfX
         NQB/IdktE+BCVoZsFsmSmbdcC3RKD3TR4iTLfhuPL0TTVIjAY/76vM7243mcXtJjMnwQ
         4fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t8fVVskRMUhZBLLXNsTNJMFPY/9N8+jsrpYM+Bj152I=;
        b=Zbzc0bNGYmMVP7+zaKn7ExTVuTVHMEza8B0vHdQOljqbferTAZXmlWOX/R4aQHKmUu
         xbPxCaVk1/gFrKbrRUQhVXbtLDkgSs+tc3xBltA16ztvvr8McDnDW7I5izjv/E5tzDCT
         Qq7jJSNCd3VmZpLiFR2kVVa6riHATldT6/SWHKDq6EIxCAhpcWTjr24ORtzKyy9loCVk
         WV/Vc3j05bcun4T1CcRjGvlds0HUWnk1XnAlNsRMijdk35V7ziFh/ZIVv61+6sMgZQCQ
         mktLlEm74XhUXRTpyevnMukDB1qNvuWaMI5xqpUUF3wmI2IXYgW+6Ts/drxmUTXu/6J2
         nqSw==
X-Gm-Message-State: AOAM530emDAguYAW2oJ0Go9IB4H5U/tT34bmp6Sdn6uv65z1644a4Nk6
        jJG6SkEdn3KCcBCEYZX9ULJrFw==
X-Google-Smtp-Source: ABdhPJz5BeZvHsIft7mQyjRWW23AxE9aMSf7VF/1zB/zBjm6pSu1V6ki6w1l3SueCXj/dXyZbG/BaQ==
X-Received: by 2002:a17:903:41c3:b0:132:2a3f:5897 with SMTP id u3-20020a17090341c300b001322a3f5897mr10180186ple.19.1629711668847;
        Mon, 23 Aug 2021 02:41:08 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id p10sm14453192pjv.39.2021.08.23.02.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 02:41:08 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v1 0/2] Add driver for BOE tv110c9m-ll3 panel
Date:   Mon, 23 Aug 2021 17:41:00 +0800
Message-Id: <20210823094102.1064716-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for BOE tv110c9m-ll3 panel is a 10.95" 1200x2000 panel.

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

