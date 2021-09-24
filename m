Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37674168F5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 02:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243656AbhIXAfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 20:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhIXAfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 20:35:37 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351F4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 17:34:05 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pf3-20020a17090b1d8300b0019e081aa87bso6149184pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 17:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wBds1209QF1z+nVsiiM4qRmbmC7cbF+FEIw3lHoYGtU=;
        b=Kf2Vmhk/2dt9qb+/V976czb5kimbAJ60AV/FhT7PiESWhjOypVvOnbkZ3kcgopY7EG
         MZh8TlfeKuJG1xSZnGXlsF015BWEXhGvpFjkzppCCSrNgwyCYADwFtr2t9TK7Quk3Vm8
         iVt/4gT9vxnz3xJvPcDP02r0Pl8yl6PgItmD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wBds1209QF1z+nVsiiM4qRmbmC7cbF+FEIw3lHoYGtU=;
        b=X9yOWM+A/wmQSr7C/IGwJDiz2yXwntMya478ZIMlKLJN+rxpnlWHYWHQZT3iwgRA/c
         q4AiKDlYH3iChdaAKN3kLqqPz0mGGcmSTO2elku9vHpac30IqDsVLIaN5kPx66jRpLAo
         y5P/384JEG6jseVfV4/rmjFC+LjrqF1p9GShfSUECxf8q1UPsm3jkpkAJUHzOtUUuKPe
         1EAG/NHhUTbiGWWWN5O6ZwExj9nmgi2NBlQWv/boSVclpYjsGDXpUspyuSf4QYbfWt+V
         bLJM8hTw4CJAUaxXDHVuV7CGJ9j1qys12bBlh8ExO6q7KGfT8nu0QIaF2dcqdUot50/F
         vP0Q==
X-Gm-Message-State: AOAM533wo4JkQ5CMuNYf3l5C4HB5ybwEV+U7xEz6NVmuzA4oApStahZq
        S8JCCltrIfT9Rl7oD0Z0wd9+0A==
X-Google-Smtp-Source: ABdhPJyN772GEe8KfQixCUxePZ0AlT/1P8uSb37qfIbvMHownMWtbQ9SCDgYmKGc15Cbf3BX1Tp/1A==
X-Received: by 2002:a17:90b:4b82:: with SMTP id lr2mr20911175pjb.94.1632443644726;
        Thu, 23 Sep 2021 17:34:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:74de:c8b7:3a35:1063])
        by smtp.gmail.com with UTF8SMTPSA id g8sm6555217pfv.51.2021.09.23.17.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 17:34:03 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Heiko Stuebner <heiko@sntech.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 0/3] drm/panel: Proper cleanup after mipi_dsi_attach()
Date:   Thu, 23 Sep 2021 17:33:52 -0700
Message-Id: <20210924003355.2071543-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've tested a few dual-DSI panel drivers which choke if they PROBE_DEFER
at the wrong time, so I patched those up in patch 1 and 2. Patch 3 fixes
the other drivers that I couldn't test, but seem to have all the same
problem.


Brian Norris (3):
  drm/panel: kingdisplay-kd097d04: Delete panel on attach() failure
  drm/panel: innolux-p079zca: Delete panel on attach() failure
  drm/panel: Delete panel on mipi_dsi_attach() failure

 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c  |  8 +++++++-
 drivers/gpu/drm/panel/panel-innolux-p079zca.c          | 10 +++++++++-
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c         |  8 +++++++-
 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c     |  8 +++++++-
 drivers/gpu/drm/panel/panel-novatek-nt36672a.c         |  8 +++++++-
 drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c   |  8 +++++++-
 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c           |  8 +++++++-
 .../gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c   |  1 +
 drivers/gpu/drm/panel/panel-samsung-sofef00.c          |  1 +
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c        |  8 +++++++-
 10 files changed, 60 insertions(+), 8 deletions(-)

-- 
2.33.0.685.g46640cef36-goog

