Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96F833A758
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 19:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhCNSMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 14:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbhCNSML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 14:12:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30B5C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 11:12:10 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so1341837wma.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 11:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SYAbB9XrQfsURJ4pHZt6jSpiz+XrWOVC6B16BC7Az3E=;
        b=CPw0waUPUxTTA2v7BYebc42Sp9zi+3eZpIhLJvzVWfOeVzSVjdQU89pOGceOkGO7Zy
         FhlHGK3An2H6Bvna7PFmEVLUtX1czAjnWCKUDBWus2m+njgEX/S/edaPpbDW2Ai+p6GS
         S33cHHbWkHPC7G36DrKqZUdNzWxOIrXgcp2wJe3wNDpTSZznay2BXyfaCQqGzsSzP/Ub
         Dc8SceXByapmvdARIBBelLiRXAGhFelzaB6ml8VmEw3imAuvyY9Gjl378mD/htojsZlB
         GWcGfWBeHkG0XnqIrbPbWtA28f8Yy83IilgLRvsjTNMq++io0cl9v213VGn7OZA1QjHs
         Clgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SYAbB9XrQfsURJ4pHZt6jSpiz+XrWOVC6B16BC7Az3E=;
        b=Z1GMg2Thahdeuo3k0VC/gxLBPCcgPnVu54CKf8HKl3zWFB8+A74tFdoDXqYtbX222o
         cirgEGwd2IJqgblH5qYGGNmllwfV9lMQddw0XrBy4BB3UZqeTkyc1TPCd2qoFXFxJYTX
         aTiDUO3nO1tY9qWrafHVp75UsqGrWcPDvu2nYmhnYNBnQHFGHm/rOSeCru7WvvJxjq3y
         z8bvWpKA/BfPp1nL9q7N8HY626gp2bSzlyoSjPhuFuTDi7KpnfKfzODpYvTLTdGDM5te
         T4yeMVJOQ5eDbxpTxDJctVFajlWJ/ty7nquIoYNeRNDV/pC+K4j7jwXB3eLbNhfYOe8L
         iGsw==
X-Gm-Message-State: AOAM531CrL32fmRvpj7osTVPO2o+nL7dfQPKIs/G0Ku5LyDyX97JpWUi
        jyW2fDRU2BsBKtPUnWMOew7eV8uOetep4w==
X-Google-Smtp-Source: ABdhPJx/mYM8jvNC+wUJ+EtT6juW0035mjOUQlEU+BR37tzR6MHP2psPqVIgwKZiduAW/zideFpEKg==
X-Received: by 2002:a1c:df8a:: with SMTP id w132mr22504509wmg.53.1615745529550;
        Sun, 14 Mar 2021 11:12:09 -0700 (PDT)
Received: from agape.jhs (an-19-176-195.service.infuturo.it. [151.19.176.195])
        by smtp.gmail.com with ESMTPSA id j13sm15872736wrt.29.2021.03.14.11.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 11:12:09 -0700 (PDT)
Date:   Sun, 14 Mar 2021 19:12:06 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] staging: rtl8723bs: remove unused code blocks
Message-ID: <cover.1615744948.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set removes unused code clocks as required in TODO file:

	find and remove code blocks guarded by never set CONFIG_FOO defines

Changes in v3:
	- rebase of remaining conflicting patches

Changes in v2:
	- modified subject lines to make them unique
	- added a patch previously excluded (removal of
	  CONFIG_PNO_SET_DEBUG code) 

Fabio Aiuto (2):
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_PNO_SUPPORT
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_WOWLAN

 drivers/staging/rtl8723bs/core/rtw_mlme.c     |   3 -
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |  24 +-
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  61 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  | 825 +-----------------
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  43 +-
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  | 248 +-----
 drivers/staging/rtl8723bs/hal/sdio_ops.c      |   4 +-
 drivers/staging/rtl8723bs/include/autoconf.h  |   3 -
 drivers/staging/rtl8723bs/include/drv_types.h |   5 -
 .../rtl8723bs/include/drv_types_sdio.h        |   2 +-
 .../staging/rtl8723bs/include/hal_com_h2c.h   |  88 +-
 drivers/staging/rtl8723bs/include/hal_intf.h  |   5 -
 .../staging/rtl8723bs/include/rtl8723b_cmd.h  |   4 +-
 .../staging/rtl8723bs/include/rtl8723b_hal.h  |  17 -
 .../staging/rtl8723bs/include/rtl8723b_spec.h |  10 -
 drivers/staging/rtl8723bs/include/rtw_mp.h    |   3 -
 .../staging/rtl8723bs/include/rtw_pwrctrl.h   |  62 --
 .../staging/rtl8723bs/include/rtw_security.h  |   3 -
 drivers/staging/rtl8723bs/include/sdio_ops.h  |   8 +-
 drivers/staging/rtl8723bs/include/sta_info.h  |   5 -
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  56 --
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    |   3 -
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   | 238 +----
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  |   5 -
 24 files changed, 29 insertions(+), 1696 deletions(-)

-- 
2.20.1

