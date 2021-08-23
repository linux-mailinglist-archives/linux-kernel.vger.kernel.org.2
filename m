Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5B83F4C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 16:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhHWOMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 10:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhHWOMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:12:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13923C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:12:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id h9so37374059ejs.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iDIUnkK4xbCjU6orBxqS1XAry/viIvb3oHvJd/8YwME=;
        b=VFP2IcMlNvcHRWRVqG2qnZHlLJup3EmPZMZ0q2ea2+NUPd2Ga88qzYo6tvjbcs8Bun
         XiLFtfXieRIheqS0c9JmNHvfkO9x/n655lAUOg/tWQ3wkdfQla7UNeNE6KrJFhe6e9VP
         knzpPWzwnKCxbgUXbN0XQ6xWDUZGmG+ed5fyrtfYGBG/nXfkVXscOmLrwPiuYixxlEDc
         taxWK1D/br2SzCT3ArDfWTV9y/e7vibYHWfhkX30CkszTnMo9IcuGk7M/0azAmRwGj2K
         b2eykixSg9sc/SHxOoruIG+nZE1h+KVr17q06603I012ZBN3TuMBbyXPuCbYvMWoaWVN
         N3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iDIUnkK4xbCjU6orBxqS1XAry/viIvb3oHvJd/8YwME=;
        b=HisGJzuj2du8/5C4PdZ0B436tMnjMDVyBZJU//RJNrHEpEAa7pkfhGz+LLikf3MVL5
         umJ/IlrDTaFNX+o28x+zEHH6bcHH1ZFSP91MFLV1IRUZzrf6O7PAX1PyrZgj1kVaiS93
         tKeRXS2TA9zo3vlNjgpwnyTT52EfJwsfceXTwppPGqq0HD4xvzUMEorcl0cKZPXtKo0U
         x+Vod2CinnMV+L7qvGrHwxiHnIPMPXq6nNYo2J/3iBqmroWH/tgLcPltAVXxN33/Ytr0
         fUlLLJtX8Kh2Wl256J+qVYKay/O+px4+N9OHDBOodaX47F+K3Iy6uIKrCjgt3STCdyYk
         Clzg==
X-Gm-Message-State: AOAM531IIYvufwFLMXDrA8Kv+Afr9915hLm4dTTcu27x9b4KCWPTqS3i
        klO+WsDHF1XInBe/vaV9vDxk9jGWUrg=
X-Google-Smtp-Source: ABdhPJwBPAUw/FNpMnosY1z0oIkZJsm81W5pE/n+VkJmbXmtVAvRxH2kulap4IQyUDy5lH4uGyfrOw==
X-Received: by 2002:a17:906:c252:: with SMTP id bl18mr35987014ejb.519.1629727925463;
        Mon, 23 Aug 2021 07:12:05 -0700 (PDT)
Received: from agape ([5.171.81.132])
        by smtp.gmail.com with ESMTPSA id o17sm9118706edc.58.2021.08.23.07.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 07:12:05 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] staging: rtl8723bs: remove wext code
Date:   Mon, 23 Aug 2021 16:11:58 +0200
Message-Id: <cover.1629727333.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes all wext code.
Some code cleaning is done as well.

cfg80211 wext compatibility is granted
by selecting CFG80211_WEXT in kconfig file
(so userspace programs can still use old
wext handlers).

Tested-on: Miix 300-10IBY

Fabio Aiuto (5):
  staging: rtl8723bs: remove obsolete wext support
  staging: rtl8723bs: fix code indent issues
  staging: rtl8723bs: fix logical continuation issue
  staging: rtl8723bs: remove functions notifying wext events
  staging: rtl8723bs: remove unused rtw_set_802_11_bssid() function

 drivers/staging/rtl8723bs/Kconfig             |    3 +-
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |   68 +-
 drivers/staging/rtl8723bs/include/drv_types.h |    3 -
 .../staging/rtl8723bs/include/rtw_ioctl_set.h |    1 -
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 3220 +----------------
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c |    4 -
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |    1 -
 7 files changed, 44 insertions(+), 3256 deletions(-)

-- 
2.20.1

