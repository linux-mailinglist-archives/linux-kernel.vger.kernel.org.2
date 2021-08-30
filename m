Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC54B3FB5D4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbhH3MQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236677AbhH3MQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:16:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40843C061760
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:15:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id e26so3248395wmk.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hs4ujLXWBLneOzGa1TCzzBohS5G380csWuXra6v4X9k=;
        b=f138dCjoU2KK1oL45hichGHXxfwijdZ+QEndz1G4h1yeItcZOavd6YobBpEDUVivsN
         Edzh7QYagNohzzt+pSXZjKZMJBtdn9P04+B2WX3ppwnB1JgmS82ypC0C+m4VDoBnU8RY
         NNhi9upH5rT3/07KdP6YK98Brn7ufawP0TZHqL831eTqSt1F9Yy32XLw/zIFn78IH5FP
         0QTsQ3rmyER9jepR02W1fca/+n9mPUSeuA2L0ncly6aHiqmp3yBbn7M57Th7obLzEfoY
         +A2s9XT09yvZgAsDg5krkXOmEjOkpunUcc6wUqmfKk8g/OKYktAQTxfQs3R4laitHFhf
         JhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hs4ujLXWBLneOzGa1TCzzBohS5G380csWuXra6v4X9k=;
        b=V20ztZoEXop/O43xQXPtuRMQk4PSl1FzXl5xdgXs82vx/YKWzPc9Elyrk9BMMQT56N
         AaLrVXnH5ABMAMXSzJ1ZRkg2QdYOIuNVpxQ0H2YLQulcUrn79gXhs+yEVKARJjivcNh/
         B8b+981IAbm/evE1bhZA3BKauu8P4Dmh+HIkbyLe0Dl5whTc4nRHC/tAtOcXYHcWJrEg
         fGZ2l8uuAnfqTjkbBCNOX3Pu5QsXBzPwjyFlgiFLYEqYh12cq3V9by/YtBf97dO8CQsl
         naZknU26S+ie4F+vzZLzFXMNzS4ZT+joFX3DuAFeHP0GAC0WwaSIYxgcDXafLs1e+7f2
         Ilyw==
X-Gm-Message-State: AOAM532xPmffbF5VTiL/KBT5nOVIn0BureaDM070Luzo8CVjV+I12GQh
        2RA9A7QhmfY46ESYVucUWAM=
X-Google-Smtp-Source: ABdhPJwOkqStIB1AAfPSjOxfR8NbKcz+MLvdE561z+XnC2GZTrYbF90B5neH/9tt5NbyGyPMgvNBjQ==
X-Received: by 2002:a05:600c:26c4:: with SMTP id 4mr21083766wmv.111.1630325740906;
        Mon, 30 Aug 2021 05:15:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id x11sm15492116wro.83.2021.08.30.05.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:15:40 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 0/8] staging: r8188eu: refactor rtw_macaddr_cfg()
Date:   Mon, 30 Aug 2021 14:15:00 +0200
Message-Id: <20210830121508.6411-1-straube.linux@gmail.com>
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

v1 -> v2
Fixed typo in commit message of patch 1/8.

Michael Straube (8):
  staging: r8188eu: use mac_pton() in rtw_macaddr_cfg()
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

