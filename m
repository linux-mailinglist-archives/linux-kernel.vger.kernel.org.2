Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152DB3D2529
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 16:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhGVNZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 09:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbhGVNZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:25:15 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6DCC061575;
        Thu, 22 Jul 2021 07:05:49 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id h4so7491290ljo.6;
        Thu, 22 Jul 2021 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2yvd7CInVO2nkOTfuFibl5KCx2wDyhIqtzEA3PsnKs=;
        b=iGv9cBbqaurk6QU1wp3PVLgyY0KNSOovMBvrZq6jnnLKkNTjdkt4smesD6pNc5fBo3
         nt8vqGgNRJ72qlI2xbLjY2u+r63hEG/Crs9n+jQBebrSwDHvRl4Tlp6olb2vMSsr5aLE
         47+EWwBbwBGUrGW0nB2KI0Mctk+Hpnjrz7pH4oyFidatq2/VV5LNfwmSvUc2HL/ARhoi
         4cEu2I3yein+jYwXJRdrcxLM+TpFuEbaofT49WhectMycdy6ZKwcgI2+lVUfhPg9Obji
         b13myBnPFk8YUoSR1TxQ2NIOPFmV8o9jknvK2fJfssxmywDjrc88784MKEL/f04he8ks
         i3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2yvd7CInVO2nkOTfuFibl5KCx2wDyhIqtzEA3PsnKs=;
        b=JDImDIEVNwHz9j43YE1DmUmy3bfmRFWpZj4vrfQA+YVzoNjyRcBjU1/mV0MoOFr8AF
         fEa/q47H76DcpMBxLi2fP/3qm9enjVB7bTE5ybgjLA6iVyUle7g0C1I6VDusnOAsW6+t
         5mPSNQCnaYG/zjFgNN2F5Uy5FkcTe7QX63zcSKjxh5AJ0VwWBc4VSdhedf/Mp0YYcp1n
         odMqopxhPVqSqVAthhCxjbujapi3AbKgK0aWEH5n0c0VoIiPW/ueK/4+5LEO0hYDBJi9
         50yc+gaBu61aRz+huuQkZTjCGfLq69MI5d8SoWV6dCdYE4YJcmyxqDeJetiLDcLekPbz
         xyYA==
X-Gm-Message-State: AOAM532byPdTf9wWoGack3j0pmcFETchjPi8AMOPdVILcRmAnROKa8a3
        yVljtsuDFVf6QGhJfOLXl28=
X-Google-Smtp-Source: ABdhPJy2pWZsvjXrjqMiSXpK+xu2P95G6VMKEhFtj21OR8/GzxKnwAtKWHBOZ4sv3SYhQBYUUK0EBA==
X-Received: by 2002:a2e:a44a:: with SMTP id v10mr94179ljn.497.1626962748142;
        Thu, 22 Jul 2021 07:05:48 -0700 (PDT)
Received: from akaWolf-PC.. ([194.79.5.201])
        by smtp.gmail.com with ESMTPSA id p8sm190584lfu.163.2021.07.22.07.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 07:05:47 -0700 (PDT)
From:   Artjom Vejsel <akawolf0@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net, akawolf0@gmail.com
Subject: [PATCH 0/3] add Gopher 2b LCD panel
Date:   Thu, 22 Jul 2021 17:04:29 +0300
Message-Id: <20210722140432.1426173-1-akawolf0@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gopher 2b LCD panel is used in Gopher 2b handhelds.
It's simple panel with NewVision NV3047 driver,
but SPI lines are not connected.
It has no specific name, since it's unique to that handhelds.
lot name at AliExpress: 4.3 inch 40PIN TFT LCD Screen COG
NV3047 Drive IC 480(RGB)*272 No Touch 24Bit RGB Interface

Artjom Vejsel (3):
  dt-bindings: Add QiShenglong vendor prefix
  dt-bindings: Add DT bindings for QiShenglong Gopher 2b panel
  drm/panel-simple: add Gopher 2b LCD panel

 .../bindings/display/panel/panel-simple.yaml  |  2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 drivers/gpu/drm/panel/panel-simple.c          | 44 +++++++++++++++++++
 3 files changed, 48 insertions(+)

--
2.32.0
