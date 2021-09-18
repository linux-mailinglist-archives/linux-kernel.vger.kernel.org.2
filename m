Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C84410565
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238357AbhIRJ0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbhIRJ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:26:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B72C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t8so12160253wri.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BABlzt80sKLlWBbHSQ7YDi+6K9uAMurnOw2NVfaiht0=;
        b=d9su+/S6Jo6eob3J4IW1o3AJi4m7u9Du9xL22hLMPCz4gHD9q1JkfcT89j350fDGI2
         5Y07IDp1AvOW0vRZ339fcwZHIX9rgxl+R4j0QgePnY/tKdXydg91Yn8ZVnQbfstRu7z0
         9eFEer5o4OpIeGX7NTthBbMG1yh6MHhHfPXh6nGEFTIOV2vPf19WRV+B4RgeXuUvAAck
         lJLs2qLWv58KQFXcaMibV9vuhYyhtl5f6dyelgFqBhehcvBzgu5paQvCzNvl5s2m/S0x
         LuiSPsF06hbrD9vE2vJor/j9cvWCyt3AAl66yDowC+kKVbsMAdFhkPbNUewZ1O/UYmWF
         DmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BABlzt80sKLlWBbHSQ7YDi+6K9uAMurnOw2NVfaiht0=;
        b=LbPAj34S1zWCm0JVWZM7RDc0pgc/+n5fCVvx+dxGTkmvuVaWx/lLpxB3S+Io2OSfoT
         E9QmQ8BcVkSb4ObA3MP1Of8eoiEw84BheAKvO42sXvVvNA7NKK9GfCnH0bZatR2DhQKk
         Rmhp3fqjf4uPcALPA+rLF2cDPs3JjA0olgJ/h4QJ4csTGdTR7e3LfPv79rTSCHW7xDT0
         6HSMDy/BLJ/WG+aj+l8OGqXv32NV2dcpWvEk9y0dNEbPmuXD4lbkyhkYtC4XV54KH+k+
         i6+AAR/k6OeKepuGy87c45QMR+/8UUgx3XsAV2QGB3URM2edB/RJCe9C4IfwFGvSOJ+7
         QXhw==
X-Gm-Message-State: AOAM530avUX5CWS3/jNY5RTSP+ZEkjFJx3pBnLZYZCbnLaV6osP6dX0k
        kW9RP7owtJExpDPz6DZEx98JJ90Qz2tWtg==
X-Google-Smtp-Source: ABdhPJz9g0U9lTZYBWCDNfpzCyoWXZYuPjFlxUjhDgcfWCr/j6RgGIx3uuLZn6CsQvDPwtvnStWPHw==
X-Received: by 2002:a5d:5386:: with SMTP id d6mr17020413wrv.112.1631957104411;
        Sat, 18 Sep 2021 02:25:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id 5sm4233742wmb.37.2021.09.18.02.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 02:25:04 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 00/12] staging: r8188eu: remove odm_RegDefine11AC.h
Date:   Sat, 18 Sep 2021 11:24:31 +0200
Message-Id: <20210918092443.8724-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set removes macros and code that is valid only for 11ac chips and
therefore not needed/used in this driver. In the last patch we can
finally remove the odm_RegDefine11AC.h header.

Tested on x86_64 with Inter-Tech DMG-02.

v1 -> v2
Changed subject line of patch 11/12 to fix a typo.
All other patches are unchanged.

Michael Straube (12):
  staging: r8188eu: remove comments from odm_interface.h
  staging: r8188eu: remove unused macros from odm_interface.h
  staging: r8188eu: remove _ic_type from macro _cat in odm_interface.h
  staging: r8188eu: remove dead code from ODM_Write_DIG()
  staging: r8188eu: remove unnecessary if statement
  staging: r8188eu: remove more dead code from ODM_Write_DIG()
  staging: r8188eu: remove macro ODM_REG
  staging: r8188eu: remove macro ODM_BIT
  staging: r8188eu: remove unnecessary if statements
  staging: r8188eu: remove dead code from odm.c
  staging: r8188eu: remove macros ODM_IC_11{N,AC}_SERIES
  staging: r8188eu: remove header file odm_RegDefine11AC.h

 drivers/staging/r8188eu/hal/odm.c             | 224 +++++++-----------
 drivers/staging/r8188eu/include/odm.h         |   5 -
 .../r8188eu/include/odm_RegDefine11AC.h       |  29 ---
 .../staging/r8188eu/include/odm_interface.h   |  41 ----
 drivers/staging/r8188eu/include/odm_precomp.h |   1 -
 5 files changed, 82 insertions(+), 218 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/odm_RegDefine11AC.h

-- 
2.33.0

