Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB163E1B72
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241394AbhHEShn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241380AbhHEShl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:37:41 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B84AC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 11:37:26 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id x15-20020a05683000cfb02904d1f8b9db81so6104010oto.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 11:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0+AYqAU56uuLxdBlSQMIoaHuTENUKbjs7q2AhKp/GAA=;
        b=H+cnN1lGZC3Lqpoq1JPvwfrhBKJ/H/+h2VuRiT8kwaa6oCMkf1FCdI9oa/1kZ1otSi
         z8YkvP/SZlU8tsV09PzOIqUbM834fCN+0KzGtZj9O+xTow2InaHQD/UJvljl+O5uMU57
         lSKo7VuYQvdijSxULPkvK/SfGbw6rnxoeQcjxg2KkjLPpfgAnwLCDnwrwPBCQAW/TQXO
         JAPgv5q4PBn6Seny1fWQ1kzVCSC1ZqgHCDEFjkzz1sIG9Sz5bL/s/1/LrrQWcLzIkAds
         VlBPIUzrXojPnprnMK71+EnKIQTLYvcuLyOGOX+9gu8PIA43KTticdIu6ty6Xzpt8Q1F
         zZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=0+AYqAU56uuLxdBlSQMIoaHuTENUKbjs7q2AhKp/GAA=;
        b=NYkcFRQ8Kiksf44PPAHXHm/iGUlpyotX3mWWNg4MWXthfEv8NVYCGx7hd5zBukxZmK
         07t0H2dRedwOYKnJhOiPek0OzQhwPKYIQLSiRqUBNTzjXYp/RI4H3oeghNnF6ocDX+6c
         8fIiDXHI5uh4Lu0wvLmCK5yKTHq5vvieoKrVmrQD+s9kGb+2tW/VKAj+a9Jxl4Stp/45
         8hnzvEmpq+D6QBmvFiwFbot0azqRjQLV+f5SkMWPKJlGVquHS0z/Fu6q3uVHmJlq3bBm
         DcaqxLKKQCZVT4VocwUv2BYmOUN/ncOfMrBuTiknSitSb4CAzWwn3t/aXQYBzyPJQK8Z
         G2hw==
X-Gm-Message-State: AOAM533h96pbYxzg/q/B9lmg2Cb6cfRRxIhRDMIzidVOpa9tAL4nR+s1
        zcC4qx71OcXksL1M305mclgv247Kwdg=
X-Google-Smtp-Source: ABdhPJya9L60z9ML0olRmv1xTCXD9anpu2Of2vMLzjnixwpRJpO3YarSeAPBjs59rdK6G0elN1OLgQ==
X-Received: by 2002:a9d:1917:: with SMTP id j23mr4754987ota.201.1628188645651;
        Thu, 05 Aug 2021 11:37:25 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com. [2603:8090:2005:39b3::1016])
        by smtp.gmail.com with ESMTPSA id q32sm1156726oiw.37.2021.08.05.11.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 11:37:25 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 0/5] Do more cleanups
Date:   Thu,  5 Aug 2021 13:37:12 -0500
Message-Id: <20210805183717.23007-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This collection consists of the previous patches that needed to be
refactored plus the correct way to remove rtw_buf_free().

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>


Larry Finger (5):
  staging: r8188eu: Remove wrappers for kalloc() and kzalloc()
  staging: r8188eu: Remove wrapper around vfree
  staging: r8188eu: Remove all calls to _rtw_spinlock_free()
  staging: r8188eu: Remove more empty routines
  staging: r8188eu: Remove rtw_buf_free()

 drivers/staging/r8188eu/core/rtw_ap.c         |  8 +--
 drivers/staging/r8188eu/core/rtw_br_ext.c     |  2 +-
 drivers/staging/r8188eu/core/rtw_cmd.c        | 14 ++--
 drivers/staging/r8188eu/core/rtw_efuse.c      |  4 +-
 drivers/staging/r8188eu/core/rtw_mlme.c       | 19 ++---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 39 +++++------
 drivers/staging/r8188eu/core/rtw_mp.c         |  5 +-
 drivers/staging/r8188eu/core/rtw_p2p.c        |  8 +--
 drivers/staging/r8188eu/core/rtw_recv.c       | 16 +----
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    | 48 +------------
 drivers/staging/r8188eu/core/rtw_wlan_util.c  |  2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c       | 26 ++-----
 drivers/staging/r8188eu/hal/odm_interface.c   |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  2 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 10 +--
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  |  3 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     |  2 +-
 .../staging/r8188eu/include/osdep_service.h   | 10 ---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  | 70 +++++++++----------
 drivers/staging/r8188eu/os_dep/mlme_linux.c   |  3 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c     |  2 -
 .../staging/r8188eu/os_dep/osdep_service.c    | 46 ++----------
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  6 +-
 drivers/staging/r8188eu/os_dep/xmit_linux.c   |  2 +-
 24 files changed, 105 insertions(+), 244 deletions(-)

-- 
2.32.0

