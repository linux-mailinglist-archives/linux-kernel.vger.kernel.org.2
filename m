Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E65F3FFD37
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 11:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348859AbhICJfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 05:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348830AbhICJfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 05:35:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A667C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 02:34:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n5so7274957wro.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 02:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TlzU+gYZf09GNOQjPD9zGEE2KldQYdhkiiEAVHNDEWQ=;
        b=CGrd0bqznsxP7FSWjvNvHLsTOIKLX9rjdWcB51Hi3aHyeqcgfGaWhi6tbsohSK8iOy
         v/XyaC1cpw8DyPO59KiMgYJblO2DMlztCdKjvbOICJOPuwV6TJGf3bJkfNeoqGG2XBfQ
         yAD7RBXvfzuymXZkepENmOHu8/CbvAPufp69ddn+YwxPlRvp+lRExfTKCb/QLQVU6+TU
         1BTyhelF0BrxQ9OyreGxhts/BDMkZP0qV+Z4nL7LC1gwVtYRRNkf/JZuxBpYbDxnJfo3
         dI7/w+/jY8TPoNwyrOUbdeqeHhKUOqy+eziNz3llOZgij16oHzB03592ahAl0zo7gA0B
         r4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TlzU+gYZf09GNOQjPD9zGEE2KldQYdhkiiEAVHNDEWQ=;
        b=RMYdwwokg9Xo4ctHBBQATgXKfOrOgEC8jjEXPpHaxZL0/CY4TPDlsUO1RLlhR6Fsdt
         hjljXPGuhfYMJ4xTDHLe89Ss3DIZtfXYuM7ks/T5k9fHpIwCHZL72WmLlcb/LRLVc7jI
         QaGsW3AvcJusAeq2WGN43LD/Nsn2L0OzSHg/jpXHoynZWuVLhnQYpAYTYTRWAWjrE7G3
         7gZM/fDtuyZ/xfMylUhJMv9tRc5NOYB4jY3kssJHGQopGk/TbVXemFdRHTmfh8xHo6pU
         DxHhUSviUZgsfPUG7RPQT0JpP4bj+Yf83eTIiXxgqmYrez8PqpBP12GvyR4mNSGnh2vM
         v07w==
X-Gm-Message-State: AOAM530HqGT/eEJW0Rra3kUxpDVehvVOFdwjkzDLeUT5KffzOCewd2AL
        SamCU/LrRO7fSdoq+j+6xtg=
X-Google-Smtp-Source: ABdhPJxw2lawFWbKPAftblaAweRT8AZHn1P9hUytTYRXJ7eMCErTOn3Z7Mto6ePZYIRrc6hHcTxMSQ==
X-Received: by 2002:a5d:4a08:: with SMTP id m8mr2923672wrq.263.1630661647883;
        Fri, 03 Sep 2021 02:34:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id x11sm3853060wmk.21.2021.09.03.02.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 02:34:07 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/6] staging: r8188eu: remove unused code
Date:   Fri,  3 Sep 2021 11:33:48 +0200
Message-Id: <20210903093354.12645-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes the unused header hal_ioctl_rtl.h and some unused
constants, macros and enums.

Tested with Inter-Tech DMG-02.

Michael Straube (6):
  staging: r8188eu: remove header file rtw_ioctl_rtl.h
  staging: r8188eu: remove unused defines from mp_custom_oid.h
  staging: r8188eu: remove unused enum from ieee80211.h.
  staging: r8188eu: remove unused enum rt_eeprom_type
  staging: r8188eu: remove IS_HARDWARE_TYPE_8188* macros
  staging: r8188eu: remove enum hardware_type

 drivers/staging/r8188eu/hal/rtl8188e_mp.c     |  20 +-
 drivers/staging/r8188eu/include/hal_intf.h    |  40 +--
 drivers/staging/r8188eu/include/ieee80211.h   |  28 --
 .../staging/r8188eu/include/mp_custom_oid.h   | 270 +-----------------
 .../staging/r8188eu/include/rtw_ioctl_rtl.h   |  63 ----
 .../staging/r8188eu/include/rtw_mp_ioctl.h    |   1 -
 6 files changed, 11 insertions(+), 411 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/rtw_ioctl_rtl.h

-- 
2.33.0

