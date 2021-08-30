Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258CF3FAFD9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 04:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbhH3Cju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 22:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbhH3Cjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 22:39:49 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0A1C061756
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 19:38:57 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 2so11001350pfo.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 19:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VqeRjMhmJZnvzq8NRFzwezD8T9i12vRMn3+M5Ojy160=;
        b=vBM2F2xHG2bkvPHfHeQLO6ooNyZfC1lnI89BEoY3Ui5mQZ3XPEUEfLiV27i1UNtZo0
         9kGc6ml/6sPGK3JqCKVJkJbXVMh3AxKDqZhQL6wCqVIxBBq8M5zP1gvE7HmrqmrODQt+
         ROcluGli4e3VaCMw0dVOvKfkBg1jxDcUV0Kj7ONzLdWeDVy47EvKYVPnk/SkLat7cMfY
         AExAdB7OTVDmxHc7pnaW8C6OBUttzBb0HakPIS4hb3/KpPVgWfG6a7UUfC7OX4AlWtPz
         0Kul9zhc/ctmMLzC0uzT21eYlN9y2IJlgJHv84DSvKve1uFX+UlpgHbyf1J2oxY83kE8
         O2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VqeRjMhmJZnvzq8NRFzwezD8T9i12vRMn3+M5Ojy160=;
        b=UW/xBcmSgQAALvA5/+A/jWMWTgZuWrm5jF7fLPXGELmZ3F19iERV9H4NRo6+VsjzSl
         leGAyHP5fDaR8QluqOGv4jOGE4JQXikcNSU3HwoWLyEZ807w2jnMHxmww5MpODJ/TOmv
         ew/+oqmKsisRtaUX2lmEUP8NalT6FfYIfyfNB0qYxSReVqV0r2VDSXbldIJh4ngmApfA
         bYVGXmtFt6SVFZe2X8FUTZsq6JkfXed1yJylIUp250T2eC96eT60TRK5RZLST78V5JnT
         qVSxG9HgzZf/zvgogjbdJ4o03UlI6Oh7WZ3qEbACTv/+35romihb1K0zriBM0hCfNXRE
         tbAQ==
X-Gm-Message-State: AOAM530liLMegfLot0WoHcKm1lvzfDavU9w03z6Y8xsskx2t7YH0o4fv
        14/0XS1zgZCq0JKPL6U5URP4Sw2HQLbCRA==
X-Google-Smtp-Source: ABdhPJw2x1+qhg9TcS8T6ndTpvoYCeMp8Baca9OpE+M5FQGpHd2THM2a9EOnc6WdUnCwUBBsRN/fyg==
X-Received: by 2002:a62:f90d:0:b0:3e3:5739:d075 with SMTP id o13-20020a62f90d000000b003e35739d075mr21129479pfh.19.1630291136493;
        Sun, 29 Aug 2021 19:38:56 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id g13sm906839pfi.176.2021.08.29.19.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 19:38:56 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>
Subject: [v4 0/4] drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Mon, 30 Aug 2021 10:38:45 +0800
Message-Id: <20210830023849.258839-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compared to v3, remove the "//9A" and modify boe_panel_prepare timing in 
drm/panel: boe-tv101wum-nl6
 
-       _INIT_DCS_CMD(0x5A, 0xBA),      //9A
+       _INIT_DCS_CMD(0x5A, 0xBA),
...
...
...

-       usleep_range(10000, 15000);
+       usleep_range(10000, 11000);

Update commit message.

yangcong (4):
  drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
  dt-bindings: drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
  drm/panel: support for BOE and INX video mode panel
  dt-bindngs: display: panel: Add BOE and INX panel bindings

 .../display/panel/boe,tv101wum-nl6.yaml       |   7 +
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 926 +++++++++++++++++-
 2 files changed, 930 insertions(+), 3 deletions(-)

-- 
2.25.1

