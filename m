Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690E4352935
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 12:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbhDBKBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 06:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhDBKBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 06:01:48 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D033C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 03:01:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y6so4968618eds.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 03:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RgR6eBkPH1N3b2kMo1NenojBzQbPmoeGNNkcW0tcO3Q=;
        b=c4uiGenEROW/33JFGMviN5Yo6XpyRXGRc7txx+97Osuz3CdwfT8RiLp/LmnEzdokw+
         9m9CO0RET8dbNJ7OLJY8pol368NKOjY+XeqyKsz4lkcuV+sBip5VXWCnnHX0gI8WgJUo
         lx2Eys2jOVbeI7IBbkhtISi19z5CE5Vd2x9DMjC4RZRPpbvfY+Df1TSWTO9BpLuB50wU
         LbOvWT2PjhPJP4H9DvonCd2DHrDHrjX/NX4IC/FRJ4YQ5aDmmyXJz7Tk0pU1cIzUcfdg
         Bt33ooB21cYbG9sbXIcGOR+7ih9bREFIQz5ke8C6hHkKmbnp+xpGnap5UBrWh5cwaTPt
         y7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RgR6eBkPH1N3b2kMo1NenojBzQbPmoeGNNkcW0tcO3Q=;
        b=O51x/Q29hma6I9UqMJTR7/QFm77EkAV9i/hF2kz72vwmd8bSEa9yZiUHwklaScBYk6
         LKG3nozDsyC+QeH5kzXf8u6/h7famQuF0ejU5muAIEhkEk03dWEe/A2yXNCD5iFumijI
         uiDwpKqttKT3YBrG2AfbZlsByJeTfVqhxhuoYvBPqEPeeDVstzqFt7vVWa2h/U3GSxV1
         68js7tC5SJ2xyuf/Yq6LfAtLMOjhplbqPwpDTZ3LLuMIHWo96Un4O4a0+zEeMhbJd9a5
         fp2lVd2l4iONnBxcdoVnjC+ZW4USvRRRAV8LptmS3rCfzjm/7zBNNXLXp0rS4siKgVNO
         mD4w==
X-Gm-Message-State: AOAM533NP0Hm6HZ6u6PyDPCktsTMMSt3r5wU/6+c7C9LdDgwqU13aiaS
        +e+R+35y54MvbSfEBtYLhJM=
X-Google-Smtp-Source: ABdhPJzToUxZvFo+v9qOwXHEJQ6zBDAA4MX5SPMeisOunhDidlO0ekNdGunsfDJPkvGMUTB5T7TLoQ==
X-Received: by 2002:aa7:c71a:: with SMTP id i26mr1705111edq.281.1617357706011;
        Fri, 02 Apr 2021 03:01:46 -0700 (PDT)
Received: from agape ([5.171.72.128])
        by smtp.gmail.com with ESMTPSA id hy13sm3932350ejc.32.2021.04.02.03.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 03:01:45 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 00/16] staging: rtl8723bs: remove RT_TRACE logs in core/*
Date:   Fri,  2 Apr 2021 12:01:20 +0200
Message-Id: <cover.1617356821.git.fabioaiuto83@gmail.com>
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

Fabio Aiuto (16):
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_xmit.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_security.c
  staging: rtl8723bs: remove all RT_TRACE logs in core/rtw_eeprom.c
  staging: rtl8723bs: remove all RT_TRACE logs in core/rtw_pwrctrl.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_cmd.c
  staging: rtl8723bs: remove commented RT_TRACE calls in core/rtw_mlme.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_mlme.c
  staging: rtl8723bs: tidy up some error handling
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_mlme_ext.c
  staging: rtl8723bs: remove commented RT_TRACE calls in core/rtw_recv.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_recv.c
  staging: rtl8723bs: remove commented RT_TRACE call in
    core/rtw_ioctl_set.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_ioctl_set.c
  staging: rtl8723bs: remove all RT_TRACE logs in core/rtw_wlan_util.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_sta_mgt.c
  staging: rtl8723bs: remove RT_TRACE logs in core/rtw_ieee80211.c

 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  53 +------
 drivers/staging/rtl8723bs/core/rtw_eeprom.c   |  56 +++----
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  90 ++---------
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  79 +---------
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 124 +++------------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c |  39 +----
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |  60 +------
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 147 +-----------------
 drivers/staging/rtl8723bs/core/rtw_security.c |  41 +----
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  |  25 ---
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  26 +---
 drivers/staging/rtl8723bs/core/rtw_xmit.c     |  82 +---------
 12 files changed, 104 insertions(+), 718 deletions(-)

-- 
2.20.1

