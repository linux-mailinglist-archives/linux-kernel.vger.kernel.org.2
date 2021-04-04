Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44680353851
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 16:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhDDOKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 10:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhDDOJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 10:09:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23208C061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 07:09:52 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b9so895710wrs.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 07:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TcLF+WCv0M4wIqTfEUJhCyuPrAeNDbmNX5DkS26TIY8=;
        b=Vgz3KZa9eMWbWMRoa9HkH6mx86HoCm6NjAVUjwqUlOkgm3fcGAYrC3JWUbKqyP3LWk
         7wZg/nwIBbA8ef9o+XzxBiDsQY+50tHemJh+/wTcaUDjtjTIr6MDtf+RyUCS3xeIWGP5
         oL0JanyLiqXKgfUmYZF+mIrTnK3DzyDNaEWlGJIWPNTYLqEtC/J7M2RFCCT/EiJjndcT
         sWq4Pdm6AQzHRW789FzzYAITBJ1dYk0DdS/lE1WilOwIsSfgjDRfHrFGLQf1f01nwNV7
         SGaIpsIuLHDOihPrqAwRkLY48tZExvT0AlrL0nneBofEANazlf40ak0oSEKQ6ZqCYyLk
         IuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TcLF+WCv0M4wIqTfEUJhCyuPrAeNDbmNX5DkS26TIY8=;
        b=geYmp5QZ5d/ducYbATf7FAfPJEfZSjiYUo+hMvAU+YJibFoduNRBmPqzdKCPN2i82m
         ddRSLcVwvJlCvm/StIQpG0J74i+jYRhdGqt6Zvlc4ltqhbMicxfYYRunVNtJgsGFr/ke
         C4aASJZfASMHYHMVVDAI39Vy4OBCSgN2YKulUAngwwqO90BOP+hspccJtCuyvEyKlCfE
         1tcFoBjBZreuhV6feJzjyfEdpRWVZmMPyHxJAdUZ1f0t2JSa1tnhHYHN1TudjHX8Qoz9
         qpl8pfaUYMMrtZaeDvGL9UIEIwUirkdPbCqkqqWjVF+0mCcwPlz/fs2aykCC+v+oiTnC
         bBng==
X-Gm-Message-State: AOAM530fBa4+kYhzy0qUXk8B+WczAW5c6zKVN8zx56HRxejf9L7p2AWe
        IW3qL6AtN/YvmYuLqqtV9gM=
X-Google-Smtp-Source: ABdhPJy1RATGo/LYhD1xiVQyUD4S++zSSES6oN8H0nwoHiiljngyMvSAmRZY/QT2U7l7OvN5XWo1Aw==
X-Received: by 2002:a5d:4751:: with SMTP id o17mr12818998wrs.219.1617545390898;
        Sun, 04 Apr 2021 07:09:50 -0700 (PDT)
Received: from agape ([5.171.81.112])
        by smtp.gmail.com with ESMTPSA id z17sm12320797wrv.59.2021.04.04.07.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 07:09:50 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v4 00/30] staging: rtl8723bs: remove RT_TRACE logs in core/*
Date:   Sun,  4 Apr 2021 16:09:16 +0200
Message-Id: <cover.1617545239.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes all RT_TRACE usages in core/ files.

This is the first of a series aimed at removing RT_TRACE macro.

The whole private tracing system is not tied to a configuration
symbol and the default behaviour is _trace nothing_. It's verbose
and relies on a private log level tracing doomed to be
removed.

-------------------------------
Changes in v4:
	- completed checkpatch fix in if condition
	- fix reference in Suggested-by: tag
 
Changes in v3:
        - written better changelog in single patches

Changes in v2:
        - isolate checkpatch fixes in separate patches
        - removed two if conditions in core/rtw_wlan_util.c


Fabio Aiuto (30):
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_xmit.c
  staging: rtl8723bs: fix condition in if statement in core/rtw_xmit.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_security.c
  staging: rtl8723bs: fix line exceed warning in core/rtw_security.c
  staging: rtl8723bs: fix spaces around operator issues in
    core/rtw_security.c
  staging: rtl8723bs: remove all RT_TRACE logs in core/rtw_eeprom.c
  staging: rtl8723bs: fix error prone if conditions in core/rtw_eeprom.c
  staging: rtl8723bs: remove all RT_TRACE logs in core/rtw_pwrctrl.c
  staging: rtl8723bs: fix logical continuation issue in
    core/rtw_pwrctrl.c
  staging: rtl8723bs: remove unnecessary parentheses in if-condition in
    core/rtw_pwrctrl.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_cmd.c
  staging: rtl8723bs: fix null check conditions in core/rtw_cmd.c
  staging: rtl8723bs: remove unnecessary parentheses in if condition in
    core/rtw_cmd.c
  staging: rtl8723bs: remove commented RT_TRACE calls in core/rtw_mlme.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_mlme.c
  staging: rtl8723bs: tidy up some error handling in core/rtw_mlme.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_mlme_ext.c
  staging: rtl8723bs: remove commented RT_TRACE calls in core/rtw_recv.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_recv.c
  staging: rtl8723bs: added spaces around operator in core/rtw_recv.c
  staging: rtl8723bs: split long line in core/rtw_recv.c
  staging: rtl8723bs: remove unnecessary parentheses in core/rtw_recv.c
  staging: rtl8723bs: fix comparison in if condition in core/rtw_recv.c
  staging: rtl8723bs: remove commented RT_TRACE call in
    core/rtw_ioctl_set.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_ioctl_set.c
  staging: rtl8723bs: place constant on the right side of the test in
    core/rtw_ioctl_set.c
  staging: rtl8723bs: remove all RT_TRACE logs in core/rtw_wlan_util.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_sta_mgt.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_ieee80211.c
  staging: rtl8723bs: add spaces around operators in
    core/rtw_ieee80211.c

 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  53 +------
 drivers/staging/rtl8723bs/core/rtw_eeprom.c   |  56 +++----
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  90 ++---------
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  79 +---------
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 124 +++------------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  39 +----
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |  56 +------
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 147 +-----------------
 drivers/staging/rtl8723bs/core/rtw_security.c |  41 +----
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  |  25 ---
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  24 +--
 drivers/staging/rtl8723bs/core/rtw_xmit.c     |  82 +---------
 12 files changed, 101 insertions(+), 715 deletions(-)

-- 
2.20.1

