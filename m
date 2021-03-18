Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7223408C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhCRP0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhCRP0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:26:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C25AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:26:32 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id 61so5955640wrm.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iJ20k2nsi7wytUeT8FCZKrmbGkKdU/RgkQ+a0TC7OQE=;
        b=G0s7Kqy7VkWSxBXMj91ohjkHUF0EOeMEmbX5KxkbHelbGRXr2XoEZPHDZWkwWcPmJI
         6V2iJIumNKC8ldX4rTkf0N30YDl61NJ0dpXawTBctpPjt549DzpPtKdYUNEYFvkCyHN7
         eKptIzsqkrDF5MUlGTTxp8SJNRksS6WYyt3olIlVEsSwsmOVCyU0PCc8ohwxRBvgSWcy
         +fTF3qN/oQZToYf/Xg7JTbJPFNNRISMGDQ8ouZvd+4nnvj8Vzw29GxEKhjOsjvYjakVR
         Pihef+3ZZoWBuS5d49LHDN4U+Sh57X19R9ruuDLcnkKDokO68K/yWAqb52Pdd8xoo5JJ
         H/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJ20k2nsi7wytUeT8FCZKrmbGkKdU/RgkQ+a0TC7OQE=;
        b=bW2p8d3FlCJnslh5CXQjQ+XDuv1IUFrftjbIiPYlAF7cz6bsj4iUEmNuH5bYZFYbxv
         M8MTzRyUbCCK3XvLBA3aXDNY0CHF1UQSrZtsMYI7ogQmWkKU6xU5eUGBRStj5u1be/g/
         +oG2pI0BJm27qtVXVkx7npjV/sLez1BCyj5I1yVGHStmCSBDZTsydAgNdpUoUvvsNFNf
         TaUBVRAJwRWspR6yC9FUQ4UCZP7gsOBnjp3e/z7V8gtRozauIJa3LKKmKu6aKpegmPPj
         g1Iak+Zi4UyC9Ir06oktv2+8NEv0AVbdRs0cH7nuL6fWGdKomXS5hdt8H2FQzNm9WBjh
         xTSg==
X-Gm-Message-State: AOAM53345/Hx3c77MA8a9CdQEBLesz8FzpamUlYUY3CxfObjUIBcVHya
        TGhft+mSR3Px25BRxKQnrXc=
X-Google-Smtp-Source: ABdhPJxf9HS2e+hvUtN2MaOnIe+5QyeCgZQItldzx95yjF97R6SGf4VjiVhdkBQA/VhuAkMisFVvrQ==
X-Received: by 2002:adf:e809:: with SMTP id o9mr10519749wrm.110.1616081191146;
        Thu, 18 Mar 2021 08:26:31 -0700 (PDT)
Received: from agape ([151.46.162.59])
        by smtp.gmail.com with ESMTPSA id x11sm2606850wmi.3.2021.03.18.08.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:26:30 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 00/15] remove unnecessary logging
Date:   Thu, 18 Mar 2021 16:25:55 +0100
Message-Id: <20210318152610.16758-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <YFMb+7jjmj7Oty8B@kroah.com>
References: <YFMb+7jjmj7Oty8B@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnsecessary loggings warned by checkpatch

Fabio Aiuto (15):
  staging: rtl8723bs: remove unnecessary logging in core/rtw_ap.c
  staging: rtl8723bs: remove unnecessary logging in core/rtw_mlme.c
  staging: rtl8723bs: remove unnecessary logging in core/rtw_mlme_ext.c
  staging: rtl8723bs: remove unnecessary logging in core/rtw_pwrctrl.c
  staging: rtl8723bs: remove unnecessary logging in core/rtw_wlan_util.c
  staging: rtl8723bs: remove unnecessary logging in hal/HalBtcOutSrc.h
  staging: rtl8723bs: remove unnecessary logging in hal/hal_com_phycfg.c
  staging: rtl8723bs: remove unnecessary logging in hal/odm.c
  staging: rtl8723bs: remove unnecessary logging in hal/odm_debug.h
  staging: rtl8723bs: remove unnecessary logging in hal/rtl8723b_cmd.c
  staging: rtl8723bs: remove unnecessary logging in
    hal/rtl8723b_hal_init.c
  staging: rtl8723bs: remove unnecessary logging in
    os_dep/ioctl_cfg80211.c
  staging: rtl8723bs: remove unnecessary logging in os_dep/ioctl_linux.c
  staging: rtl8723bs: remove unnecessary logging in os_dep/os_intfs.c
  staging: rtl8723bs: remove unnecessary logging in os_dep/wifi_regd.c

 drivers/staging/rtl8723bs/core/rtw_ap.c       | 26 --------------
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |  6 +---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 36 +------------------
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |  5 ---
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  2 --
 drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h  |  8 -----
 .../staging/rtl8723bs/hal/hal_com_phycfg.c    |  4 ---
 drivers/staging/rtl8723bs/hal/odm.c           |  2 --
 drivers/staging/rtl8723bs/hal/odm_debug.h     |  2 --
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  | 13 -------
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  4 ---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 14 --------
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    |  9 -----
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |  7 ----
 drivers/staging/rtl8723bs/os_dep/wifi_regd.c  |  2 --
 15 files changed, 2 insertions(+), 138 deletions(-)

-- 
2.20.1

