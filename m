Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B8C3DC205
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbhGaAjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbhGaAjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:39:46 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB2DC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:39:40 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h14so13338844wrx.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vh1nEK9Y0sBT4f+P3UkKqMBsF6s5dMGivHhoys5ZwWk=;
        b=qJoIxDLJyksjqZ0eCbU2ThAXz+qa4fBMMjWQ8bBXPYQUUJsiwlhmhivbX9nL8Njig7
         yj18hfLXUhGccuTxG/lrPJPNxwzgWiArme8O4CwGvKqYx5mLFgfEmedeZP89MVqG8a0A
         xd3XzLHkVzy+kl4gGn4VO7xqtGmgBz4mDfE2jPNmad6FWxDqcPtFQ5p2PGktd7pxi3U0
         j8Yzh2ZVlyu6keGewoYgZAX+sjRXcG97p2YoU5EvtRt78IK1Rd4Kz6ffk4OUev8NB8Ci
         uzuHpUvc/g53ZkYN2JzlHivZLCG+je6Ps4r0ksVz8EtBddOZBGrQ02aY7WKNJ/m28Jns
         FBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vh1nEK9Y0sBT4f+P3UkKqMBsF6s5dMGivHhoys5ZwWk=;
        b=sE+OioWCQNDlh/JKlCdLGJpXLnecx5Tn6vhO4+UFSv0k4sMCdM9NPQ1BRPzo9g+6+l
         +YryYywuKbzonY/IzkSB/DStEyAVAvLZMVNb4ClrmwOkoqaf45ux+Et6v1AlanSh16Hr
         GIpMWKWw9YKEyHOvT0Ny+9JZPLypX/4YFb3WNT983T0wrd53V4mLt/cBf1+nVa8vtP+9
         hS1lcp3zrSpvHzJxylG6v+6cQ3MQKsUSRf5xRZFh1p/vX65QhtQXFNgZ0YQUZsi7aAWF
         M02KKWhPiCrOjgBdqhleCEiGxhtYz9g1Gbovd1X1o8oyxIbic743JTNYD2RYQBwNK52B
         E9DQ==
X-Gm-Message-State: AOAM531UVEiahIbNDHjzIrxMRLNUWlhZGp5x07l1TTWVsgTB7i9dT/1o
        pH6peDkJSmG7ziNnSXElBJOqEQ==
X-Google-Smtp-Source: ABdhPJwx0JhT1NShoCWJPPfYGk0/DymIBK/CsKk/Wdp0JquM5lZm2likVJWKORqL7JofamWdXQ3ckw==
X-Received: by 2002:adf:e94b:: with SMTP id m11mr5623246wrn.339.1627691979426;
        Fri, 30 Jul 2021 17:39:39 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id g138sm3829614wmg.32.2021.07.30.17.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 17:39:38 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/14 resent] staging: r8188eu: remove include/odm_debug.h
Date:   Sat, 31 Jul 2021 01:39:23 +0100
Message-Id: <20210731003937.68615-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series removes include/odm_debug.h, after first going through
and removing all uses of various macros within it and chipping away
until it is no longer used. Removing all of this code significantly
reduces the size of the driver by many hundreds of lines of code, and
is a good idea due to the fact that none of the code follows best
practice and none of it uses proper kernel internals for debugging.

I resent the series with the subject corrected on this cover to make it
clearer.

Phillip Potter (14):
  staging: r8188eu: remove ODM_PRINT_ADDR macro definition
  staging: r8188eu: remove ODM_dbg_* macro definitions
  staging: r8188eu: remove ODM_RT_ASSERT macro definition and caller
  staging: r8188eu: remove ODM_RT_TRACE_F macro definition
  staging: r8188eu: remove ASSERT ifndef and macro definition
  staging: r8188eu: remove ODM_RT_TRACE calls from
    hal/Hal8188ERateAdaptive.c
  staging: r8188eu: remove ODM_RT_TRACE calls from hal/HalPhyRf_8188e.c
  staging: r8188eu: remove ODM_RT_TRACE calls from hal/odm_HWConfig.c
  staging: r8188eu: remove ODM_RT_TRACE calls from hal/odm_RTL8188E.c
  staging: r8188eu: remove ODM_RT_TRACE calls from
    hal/odm_RegConfig8188E.c
  staging: r8188eu: remove ODM_RT_TRACE calls from hal/odm.c
  staging: r8188eu: remove ODM_RT_TRACE macro definition
  staging: r8188eu: remove DbgPrint and RT_PRINTK macro definitions
  staging: r8188eu: remove include/odm_debug.h

 drivers/staging/r8188eu/core/rtw_xmit.c       |   1 -
 .../r8188eu/hal/Hal8188ERateAdaptive.c        |  99 +-------
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  | 228 +-----------------
 drivers/staging/r8188eu/hal/odm.c             | 199 ++-------------
 drivers/staging/r8188eu/hal/odm_HWConfig.c    |   6 -
 drivers/staging/r8188eu/hal/odm_RTL8188E.c    |  38 +--
 .../staging/r8188eu/hal/odm_RegConfig8188E.c  |  29 +--
 drivers/staging/r8188eu/hal/odm_debug.c       |   7 -
 drivers/staging/r8188eu/hal/rtl8188e_dm.c     |   1 -
 drivers/staging/r8188eu/hal/usb_halinit.c     |  23 --
 drivers/staging/r8188eu/include/hal_intf.h    |   2 -
 drivers/staging/r8188eu/include/odm.h         |   4 -
 drivers/staging/r8188eu/include/odm_debug.h   | 126 ----------
 drivers/staging/r8188eu/include/odm_precomp.h |   4 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c  |  27 ---
 15 files changed, 35 insertions(+), 759 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/odm_debug.h

-- 
2.31.1

