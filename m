Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EDF3396A7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhCLSd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbhCLSdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:33:19 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A521CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 10:33:18 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c76-20020a1c9a4f0000b029010c94499aedso16380489wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 10:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KgZGZquzp5af/SHw1iWV2nRB1+CRMBJEbwCFEObh3NM=;
        b=VDDL6Ua0hzlTTGNcpWRtmN8dLMeoEkJcWpgkRm31GRw96kaaG3d1T1dAs/OTOH66Xw
         LuyPcyA5pF8k8lfQUDjeldNLpZCixGyu/llbp15CPxAtswQzt9WVkXEHPaXyZY2S/L6a
         j1WwOVZaaBt8VKYHZ6tdHxZejaV7/xnI1y5zafxXCrHx7w0aTBSvxNfhsZdhgNGNMuYb
         vGmqITWHv6WkpqKx9sen3wdzB7LlTHDYy5EVKDrSOVQNIPz3XTkHFrXWYMbCjtIH/U+p
         Nk/ashmVmRW+2vI1ASl+ASsqc9KqqVF2rRRd1WaYsbtWsyF76yqKPcrXcNmgXoOLJX9a
         6Sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KgZGZquzp5af/SHw1iWV2nRB1+CRMBJEbwCFEObh3NM=;
        b=dEoODpzekOhW98z4dQcO2MEJM24+Ly2cJ6yKgYf+p5BBk0gA25bK7oW1SpSZzw6i8/
         iDzT/F+7u44UQWWkUjsIsOlNW4jpAXfX6BDSHCZptn9Qe2NnKQuENcTRJrgMDXR1Nmag
         1f80sygTGFm2rQPiad8c05DAv7iKSwLoY9F+XPhN5OYgaX9stR113bFniCNjFTmdr381
         BUt7CzcQ86pVw8yJx8bilq+nNr04S/x0BFx6JJuystZgtQTs12fuVrSam/IOOV/RWD8x
         6+a+8WGT7rj/nuFkrNEWuS/umrJLBgOICXz22+e0s+wuYMLoH8B7TTuWboD/amgM8zRA
         ZUhg==
X-Gm-Message-State: AOAM531PtggfIN0hkaZbPClO5oXYjWaFUn7lIM+JavaoClU1Ohx2kvKa
        kMpt0qgjAE5R/l7VKvU5f1s=
X-Google-Smtp-Source: ABdhPJyZ5qpiW6Y9BFniryM+5gZi/dKyEJmSWOQ4Hs/w4TJVWfbPB+O2i/a+7zMwB/rr3KQ8RQqX8g==
X-Received: by 2002:a1c:f20f:: with SMTP id s15mr14000151wmc.35.1615573997384;
        Fri, 12 Mar 2021 10:33:17 -0800 (PST)
Received: from agape.jhs ([151.57.163.80])
        by smtp.gmail.com with ESMTPSA id s18sm9821074wrr.27.2021.03.12.10.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 10:33:17 -0800 (PST)
Date:   Fri, 12 Mar 2021 19:33:13 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] staging: rtl8723bs: remove unused code blocks
Message-ID: <cover.1615572985.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set removes unused code blocks as required in TODO file:

	find and remove code blocks guarded by never set CONFIG_FOO defines

Changes in v2:
	- modified sunject lines to make them unique
	- added a patch previously excluded (removal of
	  CONFIG_PNO_SET_DEBUG code)

Fabio Aiuto (4):
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_PNO_SET_DEBUG
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_PNO_SUPPORT
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_WOWLAN
  staging: rtl8723bs: remove unused code blocks conditioned by never set
    CONFIG_TCP_CSUM_OFFLOAD_RX

 drivers/staging/rtl8723bs/core/rtw_mlme.c     |   3 -
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  |  24 +-
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  61 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  | 872 +-----------------
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c |  43 +-
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  | 253 +----
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
 26 files changed, 28 insertions(+), 1762 deletions(-)

-- 
2.20.1

