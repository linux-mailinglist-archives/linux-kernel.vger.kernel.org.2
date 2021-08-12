Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551283E9B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 02:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhHLAZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 20:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhHLAZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 20:25:49 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED025C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 17:25:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cf5so6656564edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 17:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CGtwjMXEH5QqVf/PuaMPCPlbM6Xuiuly2nloQLXYWxU=;
        b=VDkCydvbt3qx0iDm6nh5tklcsyQUcuEJZQsS6x8YEhCpWNj4QsLNudxCJfiuJ4sKXh
         3SiwLAR+86gV11J/VNhJgOpDiHw9vhtJOArfLNZboxyy/fY9+tCKZf7OYjmrgJZ0cYvG
         QRgja/ZsfzPItTD/mm3Sj7fkuyDFfTKGPQjctgm+m6tBXJn3iYGdQGSNGykuxXrv8TC1
         BpDal6gYvhY65FAPSRm7gX++5vHJWyUVXw28rwh9GrZElFZQ6lVRRsAd/WDjEsRH54Om
         anB3CrhTBlxAWiZ2U7xlv4YAqaBYrKrWOfwcPBL5VL9aOniztGKrKsZ7S3SO14B8PcU3
         rs0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CGtwjMXEH5QqVf/PuaMPCPlbM6Xuiuly2nloQLXYWxU=;
        b=SBikREqsgn9UXUrr1n0zJ3XThClcBiqEkD+xU+BA0DriSOmY3pq2qW3A0szTeOIWSx
         ojSvhCEzgOHBA8I1aKsSbXjLFVD0dPzSp+BZMBDLHFbkxfUxcTfMmWbRvsKcqNyCTWTj
         ENMCaK4QWhlYwRLaOGEIRNnbLF9wKP05s1UBpXleOA9YREGjQQJPhbg2ZEADXyDHW87E
         Ad+POdcKGpqSp92fpmZf6M8gV0atAdP6OX+EV3sKf0G0IPSSTTzqGJUrAKFz5HcKUl4C
         F29u4ETZgV+NKX667mv00vdloxNLOR3hq9wOhu6me50470L6VKATp7vsBBs9RGHAuhqN
         0AKA==
X-Gm-Message-State: AOAM5312zWgZnNY91Z/V18jVtTnxWJalSIgR60DdErbAr0AlMb0Ni9IP
        okEeUJv71+YRQURwdcSwuyk=
X-Google-Smtp-Source: ABdhPJwHk0TDrhlYSnm3cGo+D/URg1r46fSkj45jMILM/LeWXmQ0x8aUnKFbYY0WNySLYdm9YBZeZQ==
X-Received: by 2002:a50:afe4:: with SMTP id h91mr2022426edd.326.1628727923521;
        Wed, 11 Aug 2021 17:25:23 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id l20sm265048ejb.23.2021.08.11.17.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 17:25:23 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 0/3] staging: r8188eu: Remove 5GHz band related code
Date:   Thu, 12 Aug 2021 02:25:16 +0200
Message-Id: <20210812002519.23678-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes code only needed for 5 GHz because the r8188eu
driver is meant to work with chips that are only capable to operate on
2.4 GHz band with 14 channels.

This driver has been (quickly) tested with an ASUS USB N10 Nano, however
I think it needs some more testing by more experienced users and
programmers.

Thanks to Fabio Aiuto <fabioaiuto83@gmail.com> who gave me the
inspiration to address this work, since he made a (more extended) 
removal of 5 GHz code from rtl8723bs:
https://lore.kernel.org/linux-staging/cover.1624367071.git.fabioaiuto83@gmail.com/.

Fabio M. De Francesco (3):
  staging: r8188eu: Remove all 5GHz network types
  staging: r8188eu: Remove code related to unsupported channel
    bandwidths
  staging: r8188eu: Remove no more necessary definitions and code

 drivers/staging/r8188eu/core/rtw_ap.c         | 13 ++--------
 drivers/staging/r8188eu/core/rtw_debug.c      | 25 +------------------
 drivers/staging/r8188eu/core/rtw_ieee80211.c  | 19 +++-----------
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  |  4 +--
 drivers/staging/r8188eu/core/rtw_mlme.c       | 10 --------
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 13 +++-------
 drivers/staging/r8188eu/core/rtw_p2p.c        |  2 +-
 drivers/staging/r8188eu/core/rtw_wlan_util.c  | 15 ++---------
 drivers/staging/r8188eu/hal/odm.c             | 20 +++------------
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c |  3 ---
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  |  4 ---
 drivers/staging/r8188eu/include/ieee80211.h   | 23 ++---------------
 drivers/staging/r8188eu/include/odm.h         |  8 ------
 .../staging/r8188eu/include/rtl8188e_spec.h   |  5 ----
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  1 -
 drivers/staging/r8188eu/include/rtw_rf.h      |  3 ---
 drivers/staging/r8188eu/include/wifi.h        |  2 +-
 drivers/staging/r8188eu/include/wlan_bssdef.h |  2 +-
 18 files changed, 21 insertions(+), 151 deletions(-)

-- 
2.32.0

