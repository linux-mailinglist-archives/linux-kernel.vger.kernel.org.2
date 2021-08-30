Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0031C3FB583
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbhH3MFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbhH3MF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:05:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DD2C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:04:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v10so22097194wrd.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0TkptHSvoyjCQEisDx9uEyo0ZmIqb3gk+9GGlP5MHlM=;
        b=i+kjTY2N8tJPsbKc6Led8NFV5ziB6zvieZn+TlOtdg9yR/c0riXLO91TzscPgxqdin
         OXgI2sEiR0MDPRccP/h8WJ1zalnN8jJx71B7OidOeKyVjYnIGg/eyp9I9d32f94CPHeg
         8bDFq7CTh+FD4ETCgon78Fy0NgGGYlE2Y8URshST9xCjiyIwR1uXpdVPwZ3swCzhVxQd
         m1RMDe+nY84j7BZ0XOdYLRAY4pCySruQrDEowx/Ipsuiz3nwAdE1whbWdEYkyJPV8BAe
         KSyrQjt7rIFL8++8wRZOTIEr64Cb4dtv7u0sr5MyB3j72jbgirZDYAukrRJkZ+th3E5d
         5Nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0TkptHSvoyjCQEisDx9uEyo0ZmIqb3gk+9GGlP5MHlM=;
        b=CIXCE3NB1iREwna22ISijVZSjGm/rX4foc+yxiXdxpELygrE1hBafvgshXmGArXLra
         slwnkw3nLvxd2a06MQfVMdITpH9fKfMkMVMUuw9rtssGNSRpvknAuM61nSrtrc5pJreb
         ygYkze7O7miKsxZxQWzm+Av9KqI3avEGzMZtwnhUsTiYtzefRn54Nzp0oVQWghTeHLI2
         xGk0k2uTwN/67DK1lIEN9Ay91nRsaQr9D38RHyB9LgIjm38L2bKQlYsPlAkNwfvrvVAW
         /dZww/ajl87k1uwibiW5aIMn0/LjGFRPtdYp7IeG5cYoyGyMXrfAt4V2/8LpcDkbp28p
         BgUQ==
X-Gm-Message-State: AOAM531DNEORt01WbvFZxxuW1ccNwVNMkLdvd2Nvy0DmDej3PjT2TFhO
        ImMh3Ebz+Jn6gkz5SNmNNZA=
X-Google-Smtp-Source: ABdhPJyumtCqQ7rtPQ4iaxfHgjuS49AAfjb54Enay087+RlBwzs7gUWHUuyeLgfa6YbbSpAQWqp7xw==
X-Received: by 2002:adf:de09:: with SMTP id b9mr24931868wrm.314.1630325073759;
        Mon, 30 Aug 2021 05:04:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id f18sm13184195wmc.6.2021.08.30.05.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:04:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/8] staging: r8188eu: refactor rtw_macaddr_cfg()
Date:   Mon, 30 Aug 2021 14:04:12 +0200
Message-Id: <20210830120420.5287-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series refactors rtw_macaddr_cfg().
- use mac_pton() instead of custom approach
- use *_ether_addr() functions to copy the mac address
  and check if it is a broadcast or zero address
- assign random default mac address instead of fixed one
- clean up minor style issues

Michael Straube (8):
  staging: r8188eu use mac_pton() in rtw_macaddr_cfg()
  staging: r8188eu: ensure mac address buffer is properly aligned
  staging: r8188eu: use ETH_ALEN
  staging: r8188eu: use is_*_ether_addr() in rtw_macaddr_cfg()
  staging: r8188eu: use random default mac address
  staging: r8188eu: use ether_addr_copy() in rtw_macaddr_cfg()
  staging: r8188eu: add missing blank line after declarations
  staging: r8188eu: remove unnecessary parentheses

 drivers/staging/r8188eu/core/rtw_ieee80211.c | 33 +++++++-------------
 drivers/staging/r8188eu/include/rtw_eeprom.h |  2 +-
 2 files changed, 12 insertions(+), 23 deletions(-)

-- 
2.33.0

