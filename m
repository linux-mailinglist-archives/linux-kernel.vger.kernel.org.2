Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E31A35E202
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241104AbhDMO5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhDMO47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:56:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C538AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:56:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id z24-20020a1cf4180000b029012463a9027fso8907610wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pgwrWrlifftIaaqyW67bp+zxPHy7WgjYbjTjOxGlaD4=;
        b=nRAW0K8gyjq8qELCQBOA1ymAfqbX1KXYxtMFG8pSfiZtINch9BYwnzFe2B46+OZwFR
         ihXVO3j9hBhj4uanuLdbeIK/sHWJkA+k4vFo53wU5dujAlVStGd7our3wygOkQCWC39z
         PGHSv2VAEurpMUzNGWoNdyXcEYfntNSCbtoHR8sUmNKxcD5JzYpR+UfZJq2DYTkfOcA0
         frsY/dHeMhueg7B5U3UtM+WYcGHb2O/3FX6dpfYsRiOQsZRQ5LLFR0PbemcyAYMN2jpU
         8yvb5zItbQajom2EnlK+V80LWyHA3wvdnwptFt0p/W40cHYF8V3YYKzWZChUdEjzggJ+
         mMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pgwrWrlifftIaaqyW67bp+zxPHy7WgjYbjTjOxGlaD4=;
        b=f1UJ8cQM5G73cooqer+Ia8TlCEHJ9wdJnRjLQ3K+POlofmMiskxQAHhP5Ug6hZs3m8
         Z5zbKGQ79Ai5/NgTFmgED90wG9hQoNTCBPzEpEMNg1lpWFDDgwlUYOSmlBpHazwokU33
         3rE/kkxzwNUPGkATV9TaOx7WQoqp5acxns7wjy3V6UN4qpl20M6bAcwn0NcHr/a0ptHX
         71dnQZD0wfteef3Ha7XnPaPQQsMUiVmPBLpjY7+AZziZMoDg2A0/1Y4lUmvi9LAh3akq
         b12+YrpWFj8RL4Rh0873/a/5Fl+IMazt8y6nboxAfDCpV17HV4QToOpIcr61yosE5uSL
         QXSg==
X-Gm-Message-State: AOAM5331ACUSHBWSmYKinO+F7LaFHUsVTT6NKQhcpToAQ//vFcd6NXFF
        N3xBOX2ebTvH4uKh/CdVb84wqNJrA9uM+A==
X-Google-Smtp-Source: ABdhPJw8PM64WQv8w90OKuCda9nWOUq1E+O8yQtQ3A5Q5ieekSubp8cvi8zJTlvcNk761/V6tacKiw==
X-Received: by 2002:a05:600c:4142:: with SMTP id h2mr386404wmm.87.1618325797327;
        Tue, 13 Apr 2021 07:56:37 -0700 (PDT)
Received: from agape ([5.171.81.171])
        by smtp.gmail.com with ESMTPSA id l9sm2470904wmq.2.2021.04.13.07.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:56:37 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     julia.lawall@inria.fr, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] staging: rtl8723bs: replace DBG_871X_SEL_NL macro with netdev_dbg()
Date:   Tue, 13 Apr 2021 16:56:28 +0200
Message-Id: <cover.1618325614.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset replaces DGB_871X_SEL_NL macro with the driver
recommended log function netdev_dbg().

Macro DBG_871X_SEL_NL indeed executes a raw printk call as
default behaviour. The other behaviour is doing a seq_printf()
call which never occurs.

First patch replace dump_drv_version with a netdev_dbg() call.
Second patch remove an unnecessary dump_drv_version() usage.
Third patch removes dump_drv_version() now unused and
        unused dump_log_level() as well
Fourth patch apply the following coccinelle script for macro
bulk replacement:

@@
expression sel;
expression list args;
identifier padapter;
identifier func;
@@

func(..., struct adapter *padapter, ...) {
	<...
-	DBG_871X_SEL_NL(sel, args);
+	netdev_dbg(padapter->pnetdev, args);
	...>
}

Fifth patch fixes a post commit checkpatch issue left
by coccinelle output.
Sixth patch removes DBG_871X_SEL_NL macro declaration.
Seventh patch removes an unused function argument after
macro replacement.

Fabio Aiuto (7):
  staging: rtl8723bs: replace dump_drv_version() usage with netdev_dbg()
  staging: rtl8723bs: remove unnecessary dump_drv_version() usage
  staging: rtl8723bs: remove two unused functions
  staging: rtl8723bs: replace DBG_871X_SEL_NL with netdev_dbg()
  staging: rtl8723bs: put a new line after ';'
  staging: rtl8723bs: remove DBG_871X_SEL_NL macro declaration
  staging: rtl8723bs: remove unused argument in function

 drivers/staging/rtl8723bs/core/rtw_debug.c    | 26 +++-------
 drivers/staging/rtl8723bs/core/rtw_odm.c      | 52 ++++++++++---------
 drivers/staging/rtl8723bs/hal/hal_com.c       | 31 +++++------
 drivers/staging/rtl8723bs/include/rtw_debug.h | 12 -----
 drivers/staging/rtl8723bs/include/rtw_odm.h   |  2 +-
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    |  4 +-
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  |  1 -
 7 files changed, 51 insertions(+), 77 deletions(-)

-- 
2.20.1

