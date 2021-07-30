Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E968E3DBB6A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 16:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239325AbhG3OyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 10:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbhG3OyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 10:54:16 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3845C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:54:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x90so13540877ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 07:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NjK4WEz3AVk1erWrJk/Bhjdi80m8gkUV910wGJeEiO4=;
        b=Ryh/EijDu6Xx/fEpSLSwXJ6ImGC/M/pWSubB4VyuKmqEn3cV+jilQO8IXmoI3rlDdd
         WDs5L3X7YB9Q+vnc+zdri10Dn4XfuZT2aPKS4SFlADLNpCjG6eJ2EM9lGJrM9tpW4eq+
         Ufdl16psWyhSqQkdoHtIqHx/oXz+RyIN+EwaV4olxo2/PuG9XwLzOe4VY8x1WeAYCvIB
         4n0+UAghHgq2kTn3c9lSfBAGL5Aj42ooCwAC+qKJp9CEPx2kWxnXMm7OWqyeBAmkzagy
         /aPsSXkt4RZdedmg6vE9v6ntu4WLRV7C4Xc09qcGA5WMOWNpxUJFnNHxb8hT5AlYqvMD
         IZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NjK4WEz3AVk1erWrJk/Bhjdi80m8gkUV910wGJeEiO4=;
        b=His1a58gF88lAcWDU2NsnHo5F2cO9O/sQCdMAHgREqKZ3Qf2c3pK7AaIh0xvFJaSSR
         srMLnyAzbUyo0/WaWR1+FGsrIJsKN8j/LxWvPyDbf2/ltB41azPYfRj4pN18851iM4fg
         L0O9TYFQuetm08bSRR14QajLSOcGN1S7dCuaGZnD8NZlv2NUXb10HRmgdJOlECzJrpPX
         w0pGoqiEFAs6OkCB0P9lL/i6tsLIU896qZI9ftES92TECy3IzhHyigXLv4wCJUPiF89i
         dPbZIxcDQaavAQrT7s0qisuyea3ANXIb9JY+Hdc/Cx0Qyi7LV3YHsNZJzOlkO/vMyM21
         Ir2A==
X-Gm-Message-State: AOAM532ZP6+Ij/vWO3r0OM5R02xmygJar4DJrgMeelinZe7yc6NPh9Wl
        qfkAPJGg0lCTE3do/BzVcbDUwzPTPB8=
X-Google-Smtp-Source: ABdhPJzBm3OMhrr4mkBzW/9Q4Ypwxy2UnSxfLxJGY6Q2BTal6iNmZjTRWQriXSo+sI8SQS4ptr8oeg==
X-Received: by 2002:aa7:cdcc:: with SMTP id h12mr3391296edw.39.1627656850318;
        Fri, 30 Jul 2021 07:54:10 -0700 (PDT)
Received: from agape ([5.171.81.215])
        by smtp.gmail.com with ESMTPSA id r7sm808630edd.48.2021.07.30.07.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 07:54:10 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] staging: rtl8723bs: little cleanup
Date:   Fri, 30 Jul 2021 16:54:04 +0200
Message-Id: <cover.1627656773.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series does some little cleanup

Fabio Aiuto (4):
  staging: rtl8723bs: fix camel case issue in struct wlan_bssid_ex
  staging: rtl8723bs: remove unnecessary parentheses
  staging: rtl8723bs: align condition to match open parentheses
  staging: rtl8723bs: put condition parentheses at the end of a line

 drivers/staging/rtl8723bs/core/rtw_mlme.c         | 13 ++++++-------
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c     |  8 ++++----
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c    |  2 +-
 drivers/staging/rtl8723bs/include/wlan_bssdef.h   |  2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    | 12 ++++++------
 6 files changed, 19 insertions(+), 20 deletions(-)

-- 
2.20.1

