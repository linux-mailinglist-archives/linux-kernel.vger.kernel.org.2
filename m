Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804EF3A72E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhFOASs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:18:48 -0400
Received: from mail-qv1-f42.google.com ([209.85.219.42]:42603 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhFOASm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:18:42 -0400
Received: by mail-qv1-f42.google.com with SMTP id c10so18697635qvo.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NSe1dIiMkHxq7ZxaxRds/VGsrj/KR3PHOGLO+qaPsX0=;
        b=rDDmLToAXLTvKPVLPNnyWSl/civZKD0PJPyazJy3beyLhg9r/FIXSJ9naY8/12s5Dl
         pkTzky5YdX/YOKWxx2mQLpdSJ+VxI9ckwEuoTiAHJS20NVUzxzAwVLO8jMLtxH9dQeUn
         2dhuM2m2ME+tRD8kxnzDgjoUil+JHrHUidRQAu8LFECgw6vAaXFDDuxjpPO1b6171OcW
         M5O1ibUI8E2HOsPJ1eOZqtqg9GuxxzhrGohcbh6yRH6N33I6WiW7pQkYLgZUEBLscYiR
         zOIB1ERUGmGxCQIQEdkrM2HnHcI1EtWxwgnN6GBU60egPsT8pqfgq4QxxYIZ0En+Tjop
         xrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NSe1dIiMkHxq7ZxaxRds/VGsrj/KR3PHOGLO+qaPsX0=;
        b=eXk/gJwzm4jrjGcRXB1mqmz6T090JIZDoYaNzmyD6n+C5UKjkEGZUm14It8WSJ3t8w
         tOxRmsAF9u3Qxk1FmKV8Nvi+A0dCFknQ9gIvkrPxW4Am/T7MIxc0ZrSNY10LzuKpAjkz
         f2WYtpiLXQReqUjQ6PlI0YdM5LvdrFhm1ZDW448X3bb/5+7aq4OJ5wV648pMj+x48vUL
         +tI8gwoC3nLUgpQIikUMxeX1zwsm73aaHnv0Ybg4VoU3IJXaKGgCVhBlMIa6yNCFwRcz
         xHH6gXbMbLIkpf297ENqGUH7yw07HCBW3ZNvMr3VwrpXpTLlqgZiX4aQKNqwDG8I/EEQ
         wEMA==
X-Gm-Message-State: AOAM5321Ex/otYAzJnI6xauiBlfKQnnrxQW2BTWiRrIgnSMaLL0Vw5XQ
        SC83w4R3wyGPWmj5XxAVxdrowg==
X-Google-Smtp-Source: ABdhPJwvPFKgY0cS85OzDl6k0uULlZH5/Qxty2B2jM6+Xi68Zpy0YPg1fPiG5hG9TjqjdBY9rLOdxA==
X-Received: by 2002:ad4:5426:: with SMTP id g6mr1415381qvt.47.1623716123664;
        Mon, 14 Jun 2021 17:15:23 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:15:22 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 00/28] staging: rtl8188eu: remove DBG_88E callers and macro
Date:   Tue, 15 Jun 2021 01:14:39 +0100
Message-Id: <20210615001507.1171-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series removes DBG_88E calls from all places in the driver,
and then removes the DBG_88E macro definition itself. It also takes two
prior patches where I convered DBG_88E calls into netdev_dbg calls, and
removes these calls too.

It cleans up subsuently unused local variables along the way, removes an
unused static function too, and also contains a reissue of my previous
patch to remove core/rtw_debug.c which is entirely unused by the driver
and thus is dead code.

Phillip Potter (28):
  staging: rtl8188eu: remove all DBG_88E calls from core/rtw_efuse.c
  staging: rtl8188eu: remove all DBG_88E calls from core/rtw_xmit.c
  staging: rtl8188eu: remove all DBG_88E calls from core/rtw_mlme_ext.c
  staging: rtl8188eu: remove all DBG_88E calls from core/rtw_wlan_util.c
  staging: rtl8188eu: remove all DBG_88E calls from core/rtw_ap.c
  staging: rtl8188eu: remove all DBG_88E calls from core/rtw_pwrctrl.c
  staging: rtl8188eu: remove all DBG_88E calls from core/rtw_ieee80211.c
  staging: rtl8188eu: remove all DBG_88E calls from core/rtw_security.c
  staging: rtl8188eu: remove all DBG_88E calls from core/rtw_ioctl_set.c
  staging: rtl8188eu: remove all DBG_88E calls from core/rtw_mlme.c
  staging: rtl8188eu: remove all DBG_88E calls from os_dep/ioctl_linux.c
  staging: rtl8188eu: remove all DBG_88E calls from os_dep/usb_intf.c
  staging: rtl8188eu: remove all DBG_88E calls from os_dep/os_intfs.c
  staging: rtl8188eu: remove all DBG_88E calls from os_dep/mlme_linux.c
  staging: rtl8188eu: remove all DBG_88E calls from os_dep/xmit_linux.c
  staging: rtl8188eu: remove all DBG_88E calls from os_dep/rtw_android.c
  staging: rtl8188eu: remove all DBG_88E calls from hal/hal_intf.c
  staging: rtl8188eu: remove all DBG_88E calls from hal/rtl8188e_cmd.c
  staging: rtl8188eu: remove all DBG_88E calls from hal/pwrseqcmd.c
  staging: rtl8188eu: remove all DBG_88E calls from
    hal/rtl8188e_hal_init.c
  staging: rtl8188eu: remove all DBG_88E calls from hal/rtl8188e_xmit.c
  staging: rtl8188eu: remove all DBG_88E calls from hal/usb_halinit.c
  staging: rtl8188eu: remove all DBG_88E calls from hal/rtl8188eu_recv.c
  staging: rtl8188eu: remove all DBG_88E calls from hal/rtl8188eu_xmit.c
  staging: rtl8188eu: remove converted netdev_dbg calls from
    core/rtw_recv.c
  staging: rtl8188eu: remove converted netdev_dbg calls from
    core/rtw_sta_mgt.c
  staging: rtl8188eu: remove core/rtw_debug.c
  staging: rtl8188eu: remove DBG_88E macro definition

 drivers/staging/rtl8188eu/Makefile            |   1 -
 drivers/staging/rtl8188eu/core/rtw_ap.c       |  78 +-----
 drivers/staging/rtl8188eu/core/rtw_debug.c    | 187 -------------
 drivers/staging/rtl8188eu/core/rtw_efuse.c    |  15 +-
 .../staging/rtl8188eu/core/rtw_ieee80211.c    |  38 +--
 .../staging/rtl8188eu/core/rtw_ioctl_set.c    |   8 -
 drivers/staging/rtl8188eu/core/rtw_mlme.c     |  54 +---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 262 ++----------------
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c  |  40 +--
 drivers/staging/rtl8188eu/core/rtw_recv.c     |  66 +----
 drivers/staging/rtl8188eu/core/rtw_security.c |   2 -
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c  |   9 -
 .../staging/rtl8188eu/core/rtw_wlan_util.c    |  80 ++----
 drivers/staging/rtl8188eu/core/rtw_xmit.c     |  40 +--
 drivers/staging/rtl8188eu/hal/hal_intf.c      |   3 -
 drivers/staging/rtl8188eu/hal/pwrseqcmd.c     |   4 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c  |  42 +--
 .../staging/rtl8188eu/hal/rtl8188e_hal_init.c |  45 +--
 drivers/staging/rtl8188eu/hal/rtl8188e_xmit.c |  15 -
 .../staging/rtl8188eu/hal/rtl8188eu_recv.c    |   8 -
 .../staging/rtl8188eu/hal/rtl8188eu_xmit.c    |   5 -
 drivers/staging/rtl8188eu/hal/usb_halinit.c   |  51 +---
 drivers/staging/rtl8188eu/include/rtw_debug.h |  31 ---
 .../staging/rtl8188eu/os_dep/ioctl_linux.c    | 144 +---------
 drivers/staging/rtl8188eu/os_dep/mlme_linux.c |   4 -
 drivers/staging/rtl8188eu/os_dep/os_intfs.c   |  26 --
 .../staging/rtl8188eu/os_dep/rtw_android.c    |  15 +-
 drivers/staging/rtl8188eu/os_dep/usb_intf.c   |   1 -
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c |   8 +-
 29 files changed, 86 insertions(+), 1196 deletions(-)
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_debug.c

-- 
2.30.2

