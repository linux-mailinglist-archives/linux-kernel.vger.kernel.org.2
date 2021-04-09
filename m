Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2CC359B7C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbhDIKLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbhDIKEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:04:15 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12174C0613E4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 03:01:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n2so7724550ejy.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 03:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1P+0nxbW6EE4uDKQ1rz3C7vt8pTf6WjPfY7LnFMvz7A=;
        b=PrSzaPaj/Aqr8e/n9/jDScxkeJze/483xW+Bhsci82xl3hkqLS2guyBKL/GODSl5Y9
         NVLoJig+vwk0SpWPGGSugImfaO4jadiIRFUL+SbV2B/vu3j+YQb87TYaI6NrCT/SSpeL
         EP0RgiczOOtzOb/WiqUijZYhZT9AVvB1LQKBFYU7KvX7jAuIbIj7tvjQBXv1rx7yBkMT
         el6SWmRGlFs/xPRcK09JWsnTxTwBjbCoWirLGb3z0bvV81VnNScHTNL9UwQj3Ok4tFmB
         /5//kU6e07KZFW5xYQygkJZ+Mw6RWK0uqF2n2FDNtEOsyfObffqUAyShopTc3D1rwVJP
         3C3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1P+0nxbW6EE4uDKQ1rz3C7vt8pTf6WjPfY7LnFMvz7A=;
        b=Gwfydluzw8FjGsmv/LaVnai+XzS78fqOx4dITKZ/87Fuj6lSyQEQT3gzudjmMsYnXt
         XFtnMBRxFgxszu1SKDpz772wdjeLFdcuFmKbNE06fGt51PTXFvR7Dc4vXRY3nXXsVreY
         UzrMiV4ivX194UIz5Nm5QFm4mTpprpNv+xzEorjft/b9k0wYqco8wxSOchH+8ujMORv0
         7pTUnn9xNY0uCl7Nn9jASS4Z6P6kMcF8SEaoZQjTz6IHZJEU3ArUgty3sLtwmCA/erKQ
         fp0KnmAFEpLhwnqQveQ3NYrfQDXFEu1cTuBQsg7JX+JOzJm9/sFag4IbB8NYDKYbNEyK
         w2Dg==
X-Gm-Message-State: AOAM532VHmT8c+zn34yZB/X/0h3yIVYVLQeuAvgHd7iG8GpoYuA/JdQm
        ITuIE9XDUg826WbGELeqMQcdmvqT5PM=
X-Google-Smtp-Source: ABdhPJz2jzcpJzXKElStEks8CQzOE6a2KB2Kx6fRATGpv+j33o3ops6DgY/gHBzdeK2Rw+MIrGeJBA==
X-Received: by 2002:a17:906:d15a:: with SMTP id br26mr15428852ejb.328.1617962506839;
        Fri, 09 Apr 2021 03:01:46 -0700 (PDT)
Received: from agape ([5.171.72.173])
        by smtp.gmail.com with ESMTPSA id h24sm984461ejl.9.2021.04.09.03.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 03:01:46 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 00/11] staging: rtl8723bs: remove unused variables
Date:   Fri,  9 Apr 2021 12:01:28 +0200
Message-Id: <cover.1617962215.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes some issues warned from kernel test robot in reply
to the following patch:

https://lore.kernel.org/linux-staging/56055b20bc064d7ac1e8f14bd1ed42aba6b02c36.1617802415.git.fabioaiuto83@gmail.com/

This is kernel robot output:

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/staging/rtl8723bs/core/rtw_cmd.c: In function 'rtw_cmd_thread':
>> drivers/staging/rtl8723bs/core/rtw_cmd.c:390:16: warning: variable 'cmd_start_time' set but not used [-Wunused-but-set-variable]
     390 |  unsigned long cmd_start_time;
         |                ^~~~~~~~~~~~~~
   In file included from drivers/staging/rtl8723bs/include/drv_types.h:33,
                    from drivers/staging/rtl8723bs/core/rtw_cmd.c:9:
   At top level:
   drivers/staging/rtl8723bs/include/rtw_security.h:336:28: warning: 'K' defined but not used [-Wunused-const-variable=]
     336 | static const unsigned long K[64] = {
         |                            ^
--
   drivers/staging/rtl8723bs/os_dep/ioctl_linux.c: In function 'rtw_wx_set_mlme':
   drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:1136:6: warning: variable 'reason' set but not used [-Wunused-but-set-variable]
    1136 |  u16 reason;
         |      ^~~~~~
   drivers/staging/rtl8723bs/os_dep/ioctl_linux.c: In function 'rtw_dbg_port':
>> drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2575:33: warning: variable 'preorder_ctrl' set but not used
+[-Wunused-but-set-variable]
    2575 |       struct recv_reorder_ctrl *preorder_ctrl;
         |                                 ^~~~~~~~~~~~~
   drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2601:33: warning: variable 'preorder_ctrl' set but not used
+[-Wunused-but-set-variable]
    2601 |       struct recv_reorder_ctrl *preorder_ctrl;
         |                                 ^~~~~~~~~~~~~
   At top level:
   drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:36:27: warning: 'iw_operation_mode' defined but not used [-Wunused-const-variable=]
      36 | static const char * const iw_operation_mode[] = {
         |                           ^~~~~~~~~~~~~~~~~
   In file included from drivers/staging/rtl8723bs/include/drv_types.h:33,
                    from drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:10:
   drivers/staging/rtl8723bs/include/rtw_security.h:336:28: warning: 'K' defined but not used [-Wunused-const-variable=]
     336 | static const unsigned long K[64] = {
         |                            ^

First and fourth patch remove these two issues introduced by the patch above.

Other patches fix other local issues described in kernel test robot output
and other local 'make W=1' compiler warnings.

Unnecessary code blocks are removed as well.

Fabio Aiuto (11):
  staging: rtl8723bs: remove unused variable in core/rtw_cmd.c
  staging: rtl8723bs: remove unused variable and empty for cycles left
    unused in os_dep/ioctl_linux.c
  staging: rtl8723bs: remove unused code block in os_dep/ioctl_linux.c
  staging: rtl8723bs: remove unused variables and code block left unused
    in os_dep/ioctl_linux.c
  staging: rtl8723bs: remove set but unused psta variable in
    rtw_dbg_port() in os_dep/ioctl_linux.c
  staging: rtl8723bs: remove unused variable pstapriv in rtw_dbg_port()
    in os_dep/ioctl_linux.c
  staging: rtl8723bs: remove unused cur_network variable in
    rtw_dbg_port() in os_dep/ioctl_linux.c
  staging: rtl8723bs: remove unused pmlmepriv variable in rtw_dbg_port()
    in os_dep/ioctl_linux.c
  staging: rtl8723bs: remove unused variable declaration in
    include/rtw_security.h
  staging: rtl8723bs: remove unused variable in os_dep/ioctl_linux.c
  staging: rtl8723bs: remove decl of unused static const variable in
    os_dep/ioctl_linux.c

 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  3 --
 .../staging/rtl8723bs/include/rtw_security.h  | 18 --------
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 46 -------------------
 3 files changed, 67 deletions(-)

-- 
2.20.1

