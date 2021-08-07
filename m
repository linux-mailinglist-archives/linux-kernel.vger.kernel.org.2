Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519613E358A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 15:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhHGNbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 09:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhHGNbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 09:31:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E400DC0613CF;
        Sat,  7 Aug 2021 06:31:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso10930631wmq.3;
        Sat, 07 Aug 2021 06:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=30uracpthIuXSs44lu6RRxWBv7NJjXzBaQjU8TB5510=;
        b=BO8bcpN1CIWN0qYdxusjoibcUU67AZWWmWilv+lZwrVsDPJleQ9ekpLFEjW7YW03HZ
         gJP1goMCAonYPOfB++ZDgr0Pm2oRgiQAY4oTO3e0kFNTelCkRLn3NE1uiTARcJFWqT1H
         yEisMEZAUL3Shh1uCuzbs7P8lawCq8mWFWfkFcZJEueY6yMUsHFfs8gTAQDm4Wtbfggq
         glZAo0z7mdPSUazEbB2jDMTv6itSKqP9y5x6nW9Y/4RXde3ERHXP8xQceQfM9nKt10q9
         IIEbi5NMP8rkuuTk+akfQqNkhHHZoATtrmqcqL7qYanRVnsCx2KpEs0CDLhxPiXqxpqa
         6t3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=30uracpthIuXSs44lu6RRxWBv7NJjXzBaQjU8TB5510=;
        b=IQ1S0Wh8pH1zJWG7A/VC5O7ztZ/l4DfZVazxjyVmszHoqs0rY9i8Uhr/2p3SDwhpbZ
         ukhV6QvOA9LQDH4qcjiun4BDYoaZ/ZkrmoeIEn/PdMMXeINYlBODrKNdUfCCESL1KIZU
         /3dv7RkYmXAJ8Txy/IbIyjJgUZdNr1yh3iaryBfHZkhwKZ6qedccqHTS8F0jr48e1b1d
         0f0pXCE5noDrCXAq0epy/aVq/COqHKJHbZug4uqCT5cdq7bhGSCeQmsl8qHuv+tphoo3
         aWNLZOxdGbaEF0zp3wnsAdPZZtwH2PPSZQ8QZe329+P4k/8e9bE8PW9EzbqPdeHSaprs
         Pv2Q==
X-Gm-Message-State: AOAM531oQDKy1/OZX5IBGe9i87N2FSsr+5uoEdjYjMPLPt4x3nsmHYe3
        CCCeBumN/1zxnoOrgqkLXqMTj/Koaqhi915Y
X-Google-Smtp-Source: ABdhPJwdkY7aIdXNZw3I4FK3IgMpiEezPwawBNuDlPLqTlDrV6SKa/gC1/V+bA6Gy4eIvJ8+36kIqQ==
X-Received: by 2002:a1c:7fd3:: with SMTP id a202mr25834149wmd.150.1628343080296;
        Sat, 07 Aug 2021 06:31:20 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id x12sm13254454wrt.35.2021.08.07.06.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 06:31:20 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        phone-devel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>
Subject: [PATCH 0/2] Add support for Samsung S6D27A1 display panel
Date:   Sat,  7 Aug 2021 16:31:09 +0300
Message-Id: <20210807133111.5935-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <YQw7M7OF6OZLcLjk@ravnborg.org>
References: <YQw7M7OF6OZLcLjk@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Samsung Mobile Displays(SMD) Samsung S6D27A1 panel.
This display panel is used on Samsung mobile devices such as
Samsung Galaxy Ace 2 (GT-I8160) also known as Codina.

Markuss Broks (2):
  drm/panel: Add DT bindings for Samsung S6D27A1 display panel
  drm/panel: s6d27a1: Add driver for Samsung S6D27A1 display panel

 .../display/panel/samsung,s6d27a1.yaml        |  97 ++++++
 drivers/gpu/drm/panel/Kconfig                 |  11 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-samsung-s6d27a1.c | 323 ++++++++++++++++++
 4 files changed, 432 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6d27a1.c

-- 
2.32.0

