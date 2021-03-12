Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5D43392AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhCLQFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhCLQEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:04:49 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7496C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:04:48 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so15497313wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=911lViraCeCDDonFvbzk1PwdqXX0VvPPRGufvR8lLF0=;
        b=QcJXRZzwbcFRo2C3M118l/xt1FxW9ZJIe0QGGDZLtp+Dx11+vxFcHotuO+3Trk6+U7
         f8soVjwWLNjN460qKl29lDQL+YsXCCu6gVHMNozpKVAvrqzKOsf6AKYu+5PrJdHKifz+
         V+MMuVpauHFRH6O/DT+7FIkpQC5gzHvwruD6P8PkcUvGtpzr+tfGHqM0UCa5MZqRBKCj
         FITwigGk/XCp5MTm2KpuyEjwqWf1UmlKY3sgxphZDj3ZVseGaEKXFd262kt3pHylD3o7
         Jdf+rO9leZraclB0oiUf4FgCRiVdxXsQ/LfXooRGUg2aMaayCp7R7A3UMGZ+LCu/bCtI
         z+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=911lViraCeCDDonFvbzk1PwdqXX0VvPPRGufvR8lLF0=;
        b=F1HDf7UhgPBwr0p+qn0GL59f8SHUHmcM0KLDFDdN+X8pK4DfWQOj9qsjnm4ihNkX5c
         O2bm2ZNxrpJtASwAPz2jZkQWXmCphz4wgcvdtS4AOLr5txF4/WhUFGcwaA0zpRB9+WaM
         WZiclmd0ucCKAfNIbxwBDNv2wyjXEphX0aEU8uEFEA8dt5AEV0jOwMEQ9f7ZQkpDvbfO
         fZ0PS1qcoS8bK0JKB1jksCrbqfv+g7B9kNmRvw+VamMLhvbG4F+16/cKk2LxQD+1eg3V
         5kuXGGGISkE5DVMq6pyB8r7s3ppdXhHv3670Fy4kjYA6oqRqOB10/he0l75D9z7d+2g4
         turA==
X-Gm-Message-State: AOAM532kiGurMbxKNEWNyEMnFrIJIspLYOr/cAaDIJ+KxvcNiFIi12Ad
        OfwP9okduLqGByI7P5f6zlFv/ovkq7uR9g==
X-Google-Smtp-Source: ABdhPJysRBNqoa7MBuhgUe3qBVFQXqrPwqRjtSF4MHU26ACWQAn97uaMpH/uy4k6XnJzWsPMhb8rvw==
X-Received: by 2002:a1c:541a:: with SMTP id i26mr13414317wmb.75.1615565087273;
        Fri, 12 Mar 2021 08:04:47 -0800 (PST)
Received: from agape.jhs ([5.171.80.73])
        by smtp.gmail.com with ESMTPSA id 4sm2728852wma.0.2021.03.12.08.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 08:04:47 -0800 (PST)
Date:   Fri, 12 Mar 2021 17:04:43 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] staging: rtl8723bs: remove unused code blocks
Message-ID: <cover.1615561446.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set removes unused code blocks as required in 
TODO file:

	find and remove code blocks guarded by never set CONFIG_FOO defines

Fabio Aiuto (3):
  staging: rtl8723bs: remove unused code blocks
  staging: rtl8723bs: remove unused code blocks
  staging: rtl8723bs: remove unused code blocks

 drivers/staging/rtl8723bs/core/rtw_mlme.c     |   3 -
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |  24 +-
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  61 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  | 824 +-----------------
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
 drivers/staging/rtl8723bs/include/rtw_recv.h  |   5 -
 .../staging/rtl8723bs/include/rtw_security.h  |   3 -
 drivers/staging/rtl8723bs/include/sdio_ops.h  |   8 +-
 drivers/staging/rtl8723bs/include/sta_info.h  |   5 -
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  56 --
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    |   3 -
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   | 238 +----
 drivers/staging/rtl8723bs/os_dep/recv_linux.c |   8 -
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  |   5 -
 26 files changed, 28 insertions(+), 1709 deletions(-)

-- 
2.20.1

