Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920113DCD23
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 21:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhHATE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 15:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhHATEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 15:04:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5C3C0613D3
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 12:04:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h13so5313746wrp.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 12:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DfjmnyvOigHMUANHMbEMsJiN5Ri9Tg6fSP6QC2WmK78=;
        b=NnOEVrLpfr7+5pPgBSbvuA9Hau2yPy8OAUuOEDUu6XBy6vR59OPJsjK8eZoQIbb9sc
         bhgDckGMwD3/p8UGmUSVWTSbmb2yIMI4CSZ8ekNznwV6VXVq9a7hVcBBb3yuq20kG/jC
         wWTo6ZFOjIk8SF93vG2SmBkZkbviG59Kmjm8uSxKqrym3MlsPBRV8EB+WNn7JHqSKuvV
         4nANBa9XlI2nbLWPKp+FLXKTK+z70Xuwy2W3QmKhc3J63onwTkzsy0GiQGc5ZYGPBqGp
         IB6yD17sFaSLF4+fDTTJNBoVW6K+SWtug84Q44efCmBsJh+DfSaPzHWC9BYbIaGXJBWL
         pRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DfjmnyvOigHMUANHMbEMsJiN5Ri9Tg6fSP6QC2WmK78=;
        b=I/vbFGy+e6A55NxsvYqcn/QZizQTLqzOE8rYAUkgJnHrwKzNRB6Q7Z/PThwYQpnvaE
         s4+pNnhN9msdrr7y7Ks4fqZ5cpkqCeoCKKGvwkLX2iIULQFIxZ9KOfJINZWGm62FjCuT
         N4Yu4/v71QntbYpAqsHE0bYsuf43wqN3xhmuOcIUcQk4JhGY3kBaMBELMvMDSND9kZYx
         lDezYBizoWnrl0QGc+Yknahr0FjhXE8YxQxOLRcst+d7XP75fYNhS5FxtwmIKYdz5dv6
         If77NYdWousimP6udJIYFE5g8q1m01afTN/sPzSdjdQDzMNkRJexPPRjLGBlmkxgCVS4
         EFTA==
X-Gm-Message-State: AOAM532HyaPCUjPsJMFLQE6mt4lB+KuAB9ix1z+uqSWvAQXtoXmenML6
        7RGIhZCX6iTPnbyhr5LV1vY47ZKNwOQcn8G2
X-Google-Smtp-Source: ABdhPJyDLhOwlH1gWUNZV9DNmiKDvXWZf0pvcvw9ggvNphMEjqYMs7O6JmxJny1ZZokZuCXO5TzwUw==
X-Received: by 2002:adf:e601:: with SMTP id p1mr14323079wrm.14.1627844679933;
        Sun, 01 Aug 2021 12:04:39 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id c10sm8196026wmb.40.2021.08.01.12.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:04:38 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH 00/15] staging: r8188eu: remove core dir RT_TRACE calls
Date:   Sun,  1 Aug 2021 20:04:22 +0100
Message-Id: <20210801190437.82017-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes all RT_TRACE calls from code within the core directory.

Phillip Potter (15):
  staging: r8188eu: remove RT_TRACE calls from core/rtw_cmd.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_pwrctrl.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_wlan_util.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_ieee80211.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_io.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_ioctl_set.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_mlme.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_mlme_ext.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_mp.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_security.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_sta_mgt.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_xmit.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_led.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_mp_ioctl.c
  staging: r8188eu: remove RT_TRACE calls from core/rtw_recv.c

 drivers/staging/r8188eu/core/rtw_cmd.c        |  64 +-----
 drivers/staging/r8188eu/core/rtw_ieee80211.c  |  67 +-----
 drivers/staging/r8188eu/core/rtw_io.c         |  12 +-
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  | 217 +-----------------
 drivers/staging/r8188eu/core/rtw_led.c        |  82 +------
 drivers/staging/r8188eu/core/rtw_mlme.c       | 134 ++---------
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  40 +---
 drivers/staging/r8188eu/core/rtw_mp.c         |  10 +-
 drivers/staging/r8188eu/core/rtw_mp_ioctl.c   | 176 +-------------
 drivers/staging/r8188eu/core/rtw_pwrctrl.c    |  27 +--
 drivers/staging/r8188eu/core/rtw_recv.c       | 161 +------------
 drivers/staging/r8188eu/core/rtw_security.c   |  37 +--
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |   8 -
 drivers/staging/r8188eu/core/rtw_wlan_util.c  |  25 +-
 drivers/staging/r8188eu/core/rtw_xmit.c       |  92 +-------
 drivers/staging/r8188eu/include/rtw_mlme.h    |   2 -
 .../staging/r8188eu/include/rtw_mlme_ext.h    |   4 +-
 17 files changed, 90 insertions(+), 1068 deletions(-)

-- 
2.31.1

