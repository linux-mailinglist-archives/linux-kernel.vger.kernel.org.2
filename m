Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5863F0EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 01:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbhHRXtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 19:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbhHRXtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 19:49:32 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894C5C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:48:56 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x10so6049659wrt.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pwyfaAFBG7iF6Ne2wRkdGUfEMQvIBJdIimvJvjzDTvs=;
        b=lmgx4Z4x6WxFk09qXEzPSyExDLZpd8BFeun/m2tpV8JuAAwFF3vrs7kcsm0e4T249X
         GabXevNSule3ap36OXGmcQOZi4izl4CXz+10Bp4Nv7AtrOSSTmAMIJprxiWJI7cczjry
         ihFObI83BdH371MSHxVfQGADn16c8687GD/5OzRRNslazvuoljz4cW+3MzUkm0UlltrJ
         4fg9EaOlLjpqD0wp1qsSMIn9OLu/J5CuOj6T7xX5HeKydqUpMWGEfTnBmH5x263O8NEe
         MvtRZlvafbUN+/Gg+doyCLLu8j9Wrv03o7BzYqOh6FpRcee01BN2XHzu17VdehyohFO9
         Nf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pwyfaAFBG7iF6Ne2wRkdGUfEMQvIBJdIimvJvjzDTvs=;
        b=c/ige7+mFV2PU44sGBlemzO3ppidm8UQGr+qVXgzXLiUqjIKNH42a3qxGs4jj2Zm6d
         03bPAb8lLik3MCmMRnneSCwj95Tf039TuIS/bmcDZvbGwAQe4Lkb8R5uJR+YmJfGq2+J
         7BMLz18bwGLvW8TMk1/7fRETzr8ZeL4bqA69yTOVd4taIbEyKjAV5e+saVnMgN/zVu6r
         6uem2Z/VhfixMs/XHuQrsa2PmSqCcCmuNormVPaAvcCBkb3nXRgrWlvEeLv60P4oP15E
         yhqHVwl4YB9Q5CuyPBXle+2OfbeZXQquXf0tzVotUNDTRaCgnD+o3fVd1R5raOFmS2ji
         d90Q==
X-Gm-Message-State: AOAM532L87R4MIDCNFpggP/nUkjuS41F2oflb9xgWHZUOmF2zMxyDcaf
        o3dboKDOyVqy8NJR8snvQVyJr8q4mk9waFFy
X-Google-Smtp-Source: ABdhPJxv5E6+j8K8oDVVmmAefegysXo+i6oHXbIT9pUMt27wG2HDkY/F82oScr0oTlpG2S46TEZZpg==
X-Received: by 2002:adf:d4c7:: with SMTP id w7mr74386wrk.301.1629330535225;
        Wed, 18 Aug 2021 16:48:55 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id z8sm1205916wrt.77.2021.08.18.16.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 16:48:54 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net
Subject: [PATCH 0/7] staging: r8188eu: memory allocation cleanup series
Date:   Thu, 19 Aug 2021 00:48:46 +0100
Message-Id: <20210818234853.208448-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series does some cleanup on the memory allocation paths within the
driver, by converting all callers of rtw_vmalloc and rtw_zvmalloc to use
vmalloc and vzalloc respectively, and then removing the functions and
associated declarations and macro definitions. It also removes an unused
macro (rtw_update_mem_stat) and its associated flags.

Phillip Potter (7):
  staging: r8188eu: convert only rtw_vmalloc call to vmalloc
  staging: r8188eu: remove rtw_vmalloc preprocessor definition
  staging: r8188eu: remove function _rtw_vmalloc
  staging: r8188eu: convert all rtw_zvmalloc calls to vzalloc calls
  staging: r8188eu: remove rtw_zvmalloc preprocessor definition
  staging: r8188eu: remove function _rtw_zvmalloc
  staging: r8188eu: remove rtw_update_mem_stat macro and associated
    flags

 drivers/staging/r8188eu/core/rtw_mlme.c       |  4 ++--
 drivers/staging/r8188eu/core/rtw_mp.c         |  2 +-
 drivers/staging/r8188eu/core/rtw_recv.c       |  2 +-
 drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c       |  8 +++----
 drivers/staging/r8188eu/hal/odm_interface.c   |  2 +-
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  2 +-
 .../staging/r8188eu/include/osdep_service.h   | 24 -------------------
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  2 +-
 .../staging/r8188eu/os_dep/osdep_service.c    | 18 +-------------
 drivers/staging/r8188eu/os_dep/usb_intf.c     |  2 +-
 11 files changed, 14 insertions(+), 54 deletions(-)

-- 
2.31.1

