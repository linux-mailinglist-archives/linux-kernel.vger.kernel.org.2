Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBB8352E48
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbhDBRaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbhDBRaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:30:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89128C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:30:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i18so1835448wrm.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ChukAgyIAoQk1LO+4qNX5K1wu+PHky9QeikL6imXhtQ=;
        b=g3Us10mDAT6sbSAHZE1ZhkEp8xvdyLWEwfCkbojEJMbFIfRcsyy1VYpeDs5p0r23BD
         nNTFrCIvnt0jTJ0ozbSj2Q8oL0sAZzYQEXNu9j9x1tKCzqRqDtuhBhDoraIg0jdqMdNv
         1o0kVaEa4PulOqlu0qnLwV+yBRa3Tn0J48lGufAAUXealhOquqd/MpBqAAx+D7RpUhMH
         FOF3ZYunfT5/roLFGjfFonPra8dv2kxQ5pIA0kRv9tQZGIqj8cv8h1riKWC78PuCSTdp
         hh9rjFntrhsXgyQjrfvdAbzSvpSwDUmB1U6M6xd2HhFhqrfnjIE5VFC6XvZiky6yeR/9
         sNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ChukAgyIAoQk1LO+4qNX5K1wu+PHky9QeikL6imXhtQ=;
        b=gxMK+D+IrYIpWinZXl2Lig0+3SFnTjjFwX8oaPvm2ezAnn6h4bTQB1mTypfPWr6V91
         55LWDLCOYsemrx0untokXbibbIxtNIkUBG1mOQY21DdRMjgYtQpHIXSuWeW0DADfh8nA
         zt3093fLrIUAdgHkEOtDBORuHtI87KRaGKG/Dn4IMPMKa+0LAia2f9ZDBSmFH1wF8KMx
         /IXkQYAWtvmciP5spHBwbMnBvCGAwbTj7EaHkxHFLIVQrMGpo75Sf+lWe/rpfQC4DP2F
         UzbIhlcqwc3IuDzTGonoTRrvbS7HFn7627lflGXpoFfdhD1mveqWjy3hT6bxEC9VXFJb
         rZ5Q==
X-Gm-Message-State: AOAM533ihb/2wP4KVUh+8vyTavtrQ4upuy9vsg/7TH5uKiLF8J4VgJ94
        z7vXvp+KvdvWfToGSOGT5ME=
X-Google-Smtp-Source: ABdhPJyOojNBlXBMhZ1xkAx7t/YmJcJpdV9wmpt0Q7n0p1Z+fhEhbQF8g7lDHNXuGekpkcSpiAkfsA==
X-Received: by 2002:a05:6000:147:: with SMTP id r7mr16452644wrx.25.1617384617294;
        Fri, 02 Apr 2021 10:30:17 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id z7sm3464431wrt.6.2021.04.02.10.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:30:16 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 00/30] staging: rtl8723bs: remove RT_TRACE logs in core/*
Date:   Fri,  2 Apr 2021 19:29:42 +0200
Message-Id: <cover.1617384172.git.fabioaiuto83@gmail.com>
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

Changes in v2:
	- isolate checkpatch fixes in separate patches
	- removed two if conditions in core/rtw_wlan_util.c

Fabio Aiuto (30):
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_xmit.c
  staging: rtl8723bs: fix condition in if statement
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_security.c
  staging: rtl8723bs: fix line exceed warning
  staging: rtl8723bs: fix spaces around operator issues
  staging: rtl8723bs: remove all RT_TRACE logs in core/rtw_eeprom.c
  staging: rtl8723bs: fix error prone if conditions
  staging: rtl8723bs: remove all RT_TRACE logs in core/rtw_pwrctrl.c
  staging: rtl8723bs: fix logical continuation issue
  staging: rtl8723bs: remove unnecessary parentheses in if-condition
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_cmd.c
  staging: rtl8723bs: fix null check conditions
  staging: rtl8723bs: remove unnecessary parentheses in if condition
  staging: rtl8723bs: remove commented RT_TRACE calls in core/rtw_mlme.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_mlme.c
  staging: rtl8723bs: tidy up some error handling
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_mlme_ext.c
  staging: rtl8723bs: remove commented RT_TRACE calls in core/rtw_recv.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_recv.c
  staging: rtl8723bs: added spaces around operator
  staging: rtl8723bs: split long line
  staging: rtl8723bs: remove unnecessary parentheses
  staging: rtl8723bs: fix comparison in if condition
  staging: rtl8723bs: remove commented RT_TRACE call in
    core/rtw_ioctl_set.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_ioctl_set.c
  staging: rtl8723bs: place constant on the right side of the test
  staging: rtl8723bs: remove all RT_TRACE logs in core/rtw_wlan_util.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_sta_mgt.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_ieee80211.c
  staging: rtl8723bs: add spaces around operators

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

