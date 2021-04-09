Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0411C35A362
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhDIQaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhDIQaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:30:16 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8E6C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 09:30:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n2so9592460ejy.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 09:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O3vu4JiCvawgkzQRTM733t0EmK6dXnhEuYP8MQmV/cQ=;
        b=XYaZinIjzm7bKXCZvWWYr4et4NaJwkj9zBf+7IkCaB+ak+bZUgBTWbU1CSkb8mX15s
         4+uczQ4jcSv3bXbFKUV4hbS+NQV4KiFQouIwJztvQ/FI6434CmaiQQ2v+CbsoewMm02x
         lyJPTnD8tDgygvzS/6eq3A9TTyxjL8j3wMYb8+XqZ3htIyjrOol+/mp/z8NuF2xK8TNA
         VUZskotMeznEZvvs82pDZHXzrPQ7YNkhcLtvRLQyYd5t5La8qwKF57V1bfjaX1c6A6mi
         HG5dIRYa6GNJiaILTS0FxGnu8mvbs9SHbwH5sTweGCPQlLMeerESEpkhoQfgwGLt4VKS
         PlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O3vu4JiCvawgkzQRTM733t0EmK6dXnhEuYP8MQmV/cQ=;
        b=T9jzAsgNC+70nPk7r5VNYUanQIuTWmR9iMOSv9+YAfQaljPmXJdasyoYoI8uewi/p1
         0dwOrne+wh4/Vd0P4HfFuQQXaV1aSyjXSBnJZZszSLyZjnuSd/ZQa6tugoQPbqWlNyJg
         K+pKfFD5q5LEac1aIXPOAKfQmAxYuTvoJiAtCiPIuP7GYWqHXbR3glwS13Qf8/I3aBAR
         h00dL7Tvo5DNT8KXKl7TRW5GRgMJCX+hJPk5G+KA4qC15WT13TIBxnTwOCJiOCqvSeFZ
         U9gGtAVNzBd5G5yj95aNWff1QlPm1CN/Mtt/81DCcHPxPQ96jNN+D2uMXY33dj17ImXU
         tHrQ==
X-Gm-Message-State: AOAM532SfALBjCYndoYYM+gwYD0WwV7RTpQOXIhDsbSvZKB60ALkJblB
        rzSuvYdPqqqOesKIgV2WsKDCcmQ8MU6nLrNs
X-Google-Smtp-Source: ABdhPJxdZNxps2WOHBx4rLR7Gnoyvp1Go36M8pkbSwXXyld8P7FgvhWbVQgY9Mg9GZ5kqvaWqVG1fg==
X-Received: by 2002:a17:907:213a:: with SMTP id qo26mr16615247ejb.547.1617985801079;
        Fri, 09 Apr 2021 09:30:01 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id mp36sm1415095ejc.48.2021.04.09.09.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:30:00 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [Outreachy kernel] [Patch 0/3]
Date:   Fri, 09 Apr 2021 18:29:59 +0200
Message-ID: <6552860.D8CPca6BT0@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series removes camelcases, changes the type and use of a 
variable, and correct misspelled words.

Patch 1/3: staging: rtl8723bs: Remove camelcase in several files

drivers/staging/rtl8723bs/core/rtw_cmd.c       |  2 +-
drivers/staging/rtl8723bs/core/rtw_mlme.c      |  2 +-
drivers/staging/rtl8723bs/core/rtw_pwrctrl.c   | 18 +++++++++---------
drivers/staging/rtl8723bs/hal/hal_intf.c       |  2 +-
drivers/staging/rtl8723bs/hal/rtl8723b_dm.c    |  6 +++---
.../staging/rtl8723bs/hal/rtl8723b_hal_init.c  |  2 +-
drivers/staging/rtl8723bs/hal/sdio_ops.c       | 14 +++++++-------
.../staging/rtl8723bs/include/rtw_pwrctrl.h    |  2 +-
8 files changed, 24 insertions(+), 24 deletions(-)

Patch 2/3: staging: rtl8723bs: Change the type and use of a variable

drivers/staging/rtl8723bs/hal/hal_intf.c        | 2 +-
 drivers/staging/rtl8723bs/include/rtw_pwrctrl.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Patch 3/3: staging: rtl8723bs: include: Fix misspelled words in comments

.../rtl8723bs/include/Hal8192CPhyReg.h        |  8 ++---
 .../staging/rtl8723bs/include/basic_types.h   |  2 +-
 drivers/staging/rtl8723bs/include/drv_types.h |  2 +-
 drivers/staging/rtl8723bs/include/hal_com.h   |  2 +-
 .../staging/rtl8723bs/include/hal_com_reg.h   | 34 +++++++++----------
 drivers/staging/rtl8723bs/include/hal_data.h  |  2 +-
 .../staging/rtl8723bs/include/hal_pwr_seq.h   |  2 +-
 drivers/staging/rtl8723bs/include/rtw_cmd.h   |  6 ++--
 drivers/staging/rtl8723bs/include/rtw_mlme.h  | 18 +++++-----
 .../staging/rtl8723bs/include/rtw_mlme_ext.h  |  2 +-
 drivers/staging/rtl8723bs/include/rtw_mp.h    |  2 +-
 .../staging/rtl8723bs/include/rtw_pwrctrl.h   |  2 +-
 drivers/staging/rtl8723bs/include/rtw_recv.h  |  4 +--
 drivers/staging/rtl8723bs/include/rtw_xmit.h  |  2 +-
 drivers/staging/rtl8723bs/include/sta_info.h  |  2 +-
 drivers/staging/rtl8723bs/include/wifi.h      |  2 +-
 16 files changed, 46 insertions(+), 46 deletions(-)

Fabio M. De Francesco



