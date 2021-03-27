Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0474934B78F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 15:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhC0OZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 10:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhC0OYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 10:24:46 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA366C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:24:45 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j7so8401578wrd.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 07:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X4aEbSweInpMrEdY1R3L9wFkvEdj8tp2TtPXbUgDRuo=;
        b=EYT1ny/vSv5xvDQh2Fs/Wy3NcUbNzWNLQz/kjaxdrxI/lfn9oJLBMVpHe2EtiQXRdf
         tpNwez6bN/+Zh872clO0uxp5h0JsuxW/xdNx6q7NSpLicS/28kGWgu/Wl+O+ZeroNV1L
         L3sN7PSdd5HMTr08lA8TkX4q8+Awr273BM3l2LXzLJ3Xy/IJ0k3NIJukhzJSb8TFPgsk
         gjqD4gOgL4P6pDqH0W+QIZQGL4TDhzO46ocayRRz3Px3ONbZfWYT923Ob7CeRk5ePjPa
         f4UsmGMXd2glGIzKH2/3zbIHnSSXC6tWKMbc/yKwXQULGbmWD0wLITANMgLCGzozleTl
         HZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X4aEbSweInpMrEdY1R3L9wFkvEdj8tp2TtPXbUgDRuo=;
        b=FwtEGWoBKfz8LOU6lHvSg7mkA9pDiq9dMLkWU/dsom0NW+c00YLosFagYTU6h2ArF8
         SYdJBxZBXeuJmgFLfUDPAvscHfnb34bZfzNY82Y9pQjPYLxnq5AtUwfMO/0IBx4lW7uc
         z+X9ooTm/U8wSyrCunqbxgrnHcZdFKocRdhCbNsGWfx9mt3RrgDRgrxXKglTF05TQC4B
         0GbttbRmugb1Kkx/8ksH6JtAY3eAa4MFVnbjLOGnZj1WK3A8vqdlBctvn3tZp+lFEFgf
         xaTPAvnMOuUi2IfV6aI02JYrali0xrbPMlxZfC06LW9zt3YDTilyn/aeCRjoPVBWx0cz
         Cyew==
X-Gm-Message-State: AOAM5301dbUAqEfclfzAljrnKaXMsA3Pt1W6J3NL1TPco7PS51oH968w
        1qFTees0daMd0x2cAqyHdpQMekVtroqdaQ==
X-Google-Smtp-Source: ABdhPJyb7U7Thj0oDh7B2RzmzEzPhoWBt22bKnCR0FvIvqY3tQfgqmPI3LjnhHc8G6hoxlgxH8tjcA==
X-Received: by 2002:adf:f88f:: with SMTP id u15mr18558562wrp.402.1616855079067;
        Sat, 27 Mar 2021 07:24:39 -0700 (PDT)
Received: from agape ([151.46.211.242])
        by smtp.gmail.com with ESMTPSA id u3sm19441977wrt.82.2021.03.27.07.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 07:24:38 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, david.laight@aculab.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 00/20] fix checkpatch error on macros
Date:   Sat, 27 Mar 2021 15:23:59 +0100
Message-Id: <cover.1616854134.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patchset fixes, where possible, some checkpatch errors on macros.
Delete unused macros and some unused struct fields tied
to removed macros.

Changes in v2:
	- deleted unused macros
	- ignored following checkpatch issues on macro:
		* issues requiring to add parentheses to macro
		  expanding in args of a function
		* issues requiring to add parentheses to
		  very complex and unreadable macro

Fabio Aiuto (20):
  staging: rtl8723bs: remove unused macros in include/hal_com.h
  staging: rtl8723bs: put parentheses on macro with complex values in
    include/hal_com.h
  staging: rtl8723bs: added spaces around operators in a macro in
    include/hal_com.h
  staging: rtl8723bs: remove unused macros in include/hal_com_reg.h
  staging: rtl8723bs: remove unused macros in include/hal_data.h
  staging: rtl8723bs: put parentheses on macros with complex values in
    include/hal_data.h
  staging: rtl8723bs: add spaces around operators in include/hal_data.h
  staging: rtl8723bs: remove unused macros in include/hal_phy.h
  staging: rtl8723bs: put parentheses on macros with complex values in
    include/rtw_debug.h
  staging: rtl8723bs: remove unused macro in include/rtw_pwrctrl.h
  staging: rtl8723bs: remove unused field in rereg_nd_name_data struct
  staging: rtl8723bs: remove commented code line in os_dep/ioctl_linux.c
  staging: rtl8723bs: put parentheses on macros with complex values in
    include/rtw_pwrctrl.h
  staging: rtl8723bs: add spaces around operator in
    include/rtw_pwrctrl.h
  staging: rtl8723bs: remove unused macros in include/wifi.h
  staging: rtl8723bs: put parentheses on macros with complex values in
    include/wifi.h
  staging: rtl8723bs: remove macros updating unused fields in struct
    security_priv
  staging: rtl8723bs: remove unused fields in struct security_priv
  staging: rtl8723bs: include macro in a do - while loop in
    core/rtw_security.c
  staging: rtl8723bs: remove unused macros in include/drv_types.c

 drivers/staging/rtl8723bs/core/rtw_security.c | 78 ++-----------------
 drivers/staging/rtl8723bs/include/drv_types.h |  6 --
 drivers/staging/rtl8723bs/include/hal_com.h   |  6 +-
 .../staging/rtl8723bs/include/hal_com_reg.h   |  8 --
 drivers/staging/rtl8723bs/include/hal_data.h  |  9 +--
 drivers/staging/rtl8723bs/include/hal_phy.h   | 11 ---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 28 +++----
 .../staging/rtl8723bs/include/rtw_pwrctrl.h   |  7 +-
 .../staging/rtl8723bs/include/rtw_security.h  | 23 ------
 drivers/staging/rtl8723bs/include/wifi.h      | 48 ++++--------
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    |  1 -
 11 files changed, 39 insertions(+), 186 deletions(-)

-- 
2.20.1

