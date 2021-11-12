Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B5044EB6C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbhKLQfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbhKLQfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:35:42 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE9BC061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:32:51 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso7178234wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DGBR4yhVEVUiH/mTvdt3pOymiiSiQAdDtYWSc9ZGrG0=;
        b=0DcN2fMUFea29aTX3A0c1UOJ28rJ35uyYIEZcr6SwdfWp6ieSpdvTH5CqkprU3lZrY
         eYvdpUrqGzBoBpfEdU/A1ubOApjD/5JKrmkCDcnJwgbwyyb7sy1t16vpec/eFbGSeGir
         jisBenr9phF219QXnHpY0pajSCIs/qmhv8fy8ARxH26LKM6Hdfj5zPy3SFRBix+In7IH
         YUAJHqMeeRV77OEf5fFIjdV7MV51jFaoc0gev6+CmWvl+wrSjaQQJwWue/ImoNlxXKJb
         slsdjzPeIrzjAk4yBd3YQR9dWBAELxyWuhPLDNZNA4Zt6P+sW80EnSDAZfKQ5ZEYIq33
         H+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DGBR4yhVEVUiH/mTvdt3pOymiiSiQAdDtYWSc9ZGrG0=;
        b=UcsZ2P1lm7LCcvXV54dbyrTfl5Oep5cIJhv7uT7HZr8SpwwD6yHly2kAO3/Szh6o3p
         ZPkyThO4e2Gjp89wu86gTNF0prg4kP5VOmhx5+lJOmvA5OAEWTP3oQNdBAizST6etNO6
         OA4bp1jdSO1AR8Fk4c4Ch5h1mTHQ/j2luAdiatvYBSlTft6AQ4QLF3FW/Pmb3JpRPQ9h
         2TfYWA5MD6d4Gq/HsnOcE0CNM/Bgb6iEW/1f7L5fbUS+65PO24wbzjCQh6qbetj8TX22
         JFIX9+h3LDCyMToxFaJVqO4AWLYTYGMbSDPnzMDsIZexVjqkz3RAyujNK6PRYw98UCp8
         Dqfw==
X-Gm-Message-State: AOAM532Qkc4jK/dOrITyS1LcYPk/UXQ6+xPiC+lSc6Ihnp/KKRWu368x
        jHZs0B4R44L20I3qd3Dbjydzng==
X-Google-Smtp-Source: ABdhPJw1tOAOTgPniZes4U598/XcPfLUpeKPB4JjYZscOvDg5o6kWwj4LaxqChWBNH9QiouZWH2+pQ==
X-Received: by 2002:a7b:ce0f:: with SMTP id m15mr17858537wmc.149.1636734770410;
        Fri, 12 Nov 2021 08:32:50 -0800 (PST)
Received: from amjad.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h15sm6253796wml.9.2021.11.12.08.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 08:32:49 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     khilman@baylibre.com
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        p.zabel@pengutronix.de, balbi@kernel.org, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v3 0/3] usb: meson: fix shared reset control use
Date:   Fri, 12 Nov 2021 17:28:24 +0100
Message-Id: <20211112162827.128319-1-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes a usb suspend warning seen on the libretech-cc by
using reset_control_rearm() call of the reset framework API. 
This call allows a reset consummer to release the reset line even when 
just triggered so that it may be triggered again by other reset
consummers.

reset_control_(de)assert() calls are called, in some meson usb drivers, 
on a shared reset line when reset_control_reset has been used. This is not
allowed by the reset framework.

Finally the meson usb drivers are updated to use this new call, which
solves the suspend issue addressed by the previous reverted 
commit 7a410953d1fb ("usb: dwc3: meson-g12a: fix shared reset control
use").

changes since v2 [0]:
- Rebased on latest master

[0]: https://lore.kernel.org/all/20201201190100.17831-1-aouledameur@baylib
re.com/

Amjad Ouled-Ameur (3):
  phy: amlogic: phy-meson-gxl-usb2: fix shared reset controller use
  usb: dwc3: meson-g12a: fix shared reset control use
  phy: amlogic: meson8b-usb2: fix shared reset control use

 drivers/phy/amlogic/phy-meson-gxl-usb2.c |  5 ++++-
 drivers/phy/amlogic/phy-meson8b-usb2.c   |  4 ++++
 drivers/usb/dwc3/dwc3-meson-g12a.c       | 17 ++++++++++++-----
 3 files changed, 20 insertions(+), 6 deletions(-)

-- 
2.25.1

