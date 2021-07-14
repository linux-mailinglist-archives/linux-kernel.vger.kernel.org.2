Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBFB3C86AF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbhGNPOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbhGNPOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:14:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDADC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:11:17 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso4124645wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XPksOXWvTkUtcqvTzVQpJTHtPXY+kFhB7qHKvutpcB0=;
        b=JG2p07c0aobB2lS4GYpnWCxwQPzu7y6gVZXOhSQMuqKjQ1LWf2siyRefgpKZ8AWl6M
         wjH6rOclkgo9fgk8O8rvAwbkP7i7JGkPshCENJ5CoTt5ek/IoWym4Gi3kYPQFcjkZu6N
         0jVGT99wHgFbIo6NlJKyUyQ9kdy6nBhrK4QQ9FGL+skc53oO0gaEpvckzY7pherxCduz
         CSJkTJzuknLZWOLjCIYftXqMAGVwBP0SN8w2cFEBRw6UoMZ2MrJdT/jYaCR2ayY8C+TS
         xZ+2aQ5OPnaM6N6aPcSwXmNNiwwyqGL1ZfBWUmyxdHxNhDE3j0cy2HmjXhYqBKMsulTE
         1WSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XPksOXWvTkUtcqvTzVQpJTHtPXY+kFhB7qHKvutpcB0=;
        b=lVIzl2hd+KS9z+hKH7A7NynXz+Xy1Jdm8ytOFaidpRvreetLqaQeaWyW8vMOidxtnK
         eiZd36boyTxM9CHrEA1a09EbERBb4DXU73dWn4KyPzgKt6LhXRcpMfgoEgxSHUWhc30y
         oWwEeUum5w7hYmwDXTFbT2TNuxDz8IlAyabMSP+Ngcmvoh4mFU+1u4v/ICB+8KLV5tIk
         6/XdX6HW/U0RqB93mF6IwX4VL0jmYm2OIp6ndVN7vZpH7quKP7pygp0sqmz/YJvs4MUD
         W6b5OZcLacM/yE7GzSoL7AiJZy5xgD58hQKalhhXK8BMgYzEAdw80NMEJ7PtNLUDud0c
         waBg==
X-Gm-Message-State: AOAM532c1GgNPhfbXFPpwNkYs9hXD/HiDxWctlodcX8Hy+ZGEIwiEABD
        gDOqli9BWRm2sjlAJX7nX0I3dCOrVvU=
X-Google-Smtp-Source: ABdhPJzQMt1B+bHckwfLgt0P/bulirlyZhkN4ZmSGmG6ut1o03bIKamnZj5vG8mWPJJGF8TJV54vQA==
X-Received: by 2002:a05:600c:8a9:: with SMTP id l41mr4775924wmp.152.1626275475909;
        Wed, 14 Jul 2021 08:11:15 -0700 (PDT)
Received: from agape ([5.171.72.142])
        by smtp.gmail.com with ESMTPSA id n23sm2257926wms.4.2021.07.14.08.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 08:11:15 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: rtl8723bs: add get_channel implementation
Date:   Wed, 14 Jul 2021 17:11:11 +0200
Message-Id: <cover.1626275102.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds cfg80211 get_channel implementation.
One of the benefits is having displayed channel info
in iw dev output.

Done some code cleaning as well.

Tested-on: Lenovo Ideapad MiiX-300-10IBY

Fabio Aiuto (3):
  staging: rtl8723bs: add get_channel cfg80211 implementation
  staging: rtl8723bs: convert IsSupportedHT to snake_case
  staging: rtl8723bs: fix camel case issue

 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  2 +-
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  2 +-
 drivers/staging/rtl8723bs/include/ieee80211.h |  2 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 53 ++++++++++++++++++-
 4 files changed, 55 insertions(+), 4 deletions(-)

-- 
2.20.1

