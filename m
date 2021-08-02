Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2233DE000
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 21:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhHBT1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 15:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhHBT1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 15:27:41 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A1AC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 12:27:31 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id n1-20020a4ac7010000b0290262f3c22a63so4648176ooq.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 12:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1BQm57Jnk7RxHhdiWHKTgQArgujX37mKjjtMGP1o130=;
        b=G+vb9aev6LSY184BDFZYxVNXmNXlcVWkwOpBRSKc/M3hqxg6u6kuHiQhM1LlN3TJK9
         oz53kmmU/qX75D4in2VvEFiUJm1XEmruE5hSmTGQCeWCdENXpB1uhIwXBvoLdXstjGUm
         0he+RMpR6VtsfaAakQ6k0nfOe20wKEH8/Sr9N3Oo1YCtyl9Vb868VvD50KfqhzfCPcut
         IvHeu4WcI1Z5jUcHGG9aPUnl7pP4/kxV9HW8HWpUYqNzIx72RhHLWbn4l32P0bRZv+m8
         FKaINvmgZCy5BDowlxoIZ0bXVcFmvMCg11CXh9YWhMoNiJwx/RZDG5Zc0kOOGqdf+Tb8
         qWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=1BQm57Jnk7RxHhdiWHKTgQArgujX37mKjjtMGP1o130=;
        b=Ua66n8I1IbTbcaLuaOjQXW3H7Y/VNnAh8BT22rsVfYlk2djXPULmUfd+i1bhRxJeO5
         JBDXIJ02kpCAOuWQluMjoa76kW7NYyVTRu/h/6MMa+1VwXkbNu+j8uSL65Eaprju/HY6
         OvlePRFMb3LFHWCrwvu7eBCsNLdotwXufb7FjRxGmWkobw0HOC/8ayyZK5ouc1GZS2VS
         H4wLMA8A8VuT+5hLKM7lHmkOhfDUrbZEZXK6akfX8l9DjTqTjQPhbnIx4l0YYC0zT9Ox
         C3kI3yTEfWgVW1ITnji9fcU4C+GNBibxU2CHh5MCH1pGM2pZqi8MLKxaENOqe+GrJ3Ol
         uzRA==
X-Gm-Message-State: AOAM533seOZNYIyr4AabAuegvHimkA/7RmZGC7rRJlXLbGsqvfMAuMT9
        YRgbz+0Vd9Z3hFJFg6rdzpO4EqewUD8=
X-Google-Smtp-Source: ABdhPJxZ6Hotxu3ipnyKsBarFcQfa6GIgw7rHvVjdIe53vwxiMRdkQcRLS98elNn77ae51n+Frh3GQ==
X-Received: by 2002:a4a:e5c8:: with SMTP id r8mr12023694oov.65.1627932450821;
        Mon, 02 Aug 2021 12:27:30 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id i188sm1981035oih.7.2021.08.02.12.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 12:27:30 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 0/6] Clean up some extraneous wrappers and some empty routines
Date:   Mon,  2 Aug 2021 14:27:15 -0500
Message-Id: <20210802192721.23110-1-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original code created some wrappers to handle the differences between
Linux and Windows. In a Linux-only version, these can be removed.

v2 - remove some .rej files

Larry Finger (6):
  staging: r8188eu: Remove wrappers for kalloc() and kzalloc()
  staging: r8188eu: Remove wrapper around vfree
  staging: r8188eu: Remove wrappers for atomic operations
  staging: r8188eu: Remove 4 empty routines from os_sep/service.c
  staging: r8188eu: Remove all calls to _rtw_spinlock_free()
  staging: r8188eu: Remove more empty routines

 drivers/staging/r8188eu/core/rtw_ap.c         |   8 +-
 drivers/staging/r8188eu/core/rtw_br_ext.c     |   2 +-
 drivers/staging/r8188eu/core/rtw_cmd.c        |  16 +--
 drivers/staging/r8188eu/core/rtw_efuse.c      |   4 +-
 drivers/staging/r8188eu/core/rtw_mlme.c       |  15 +--
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  44 ++++----
 drivers/staging/r8188eu/core/rtw_mp.c         |   5 +-
 drivers/staging/r8188eu/core/rtw_p2p.c        |   8 +-
 drivers/staging/r8188eu/core/rtw_recv.c       |  16 +--
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  48 +-------
 drivers/staging/r8188eu/core/rtw_wlan_util.c  |   2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c       |  26 +----
 drivers/staging/r8188eu/hal/odm_interface.c   |   2 +-
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |   2 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  10 +-
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c  |   3 +-
 drivers/staging/r8188eu/hal/usb_halinit.c     |   2 +-
 drivers/staging/r8188eu/include/drv_types.h   |   2 +-
 .../staging/r8188eu/include/osdep_service.h   |  28 -----
 drivers/staging/r8188eu/include/rtw_cmd.h     |   2 +-
 .../staging/r8188eu/include/rtw_mlme_ext.h    |   2 +-
 drivers/staging/r8188eu/include/usb_ops.h     |   4 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  70 ++++++------
 drivers/staging/r8188eu/os_dep/mlme_linux.c   |   3 +-
 drivers/staging/r8188eu/os_dep/os_intfs.c     |   2 -
 .../staging/r8188eu/os_dep/osdep_service.c    | 105 +-----------------
 drivers/staging/r8188eu/os_dep/rtw_android.c  |   2 -
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  10 +-
 drivers/staging/r8188eu/os_dep/xmit_linux.c   |   2 +-
 29 files changed, 112 insertions(+), 333 deletions(-)

-- 
2.32.0

