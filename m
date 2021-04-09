Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363E735A38A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhDIQjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDIQjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:39:47 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38999C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 09:39:34 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z1so7288597edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MeVCMSWpDbGHYzheWdu+Y717xanF98ksnqPfJAYkw1M=;
        b=XPDFVuIxP0211a+q0DgzOzr7FRJbb7qGyrMux5F9IVWsm0zBRIB5GsMhp0ef5ACmfl
         fbfLIDbngewfHiVw3tEUza5NDpDRw7XB/p5OO9ZrnO9I2M549MUxjWwI8wH+YFTbiXY5
         AIxtid5ZQeU7iFjI70/WiIoaQHIxzrgqu2oP9DdnErUXTSQN2i3hUWqqrx2RqFQST4rq
         hb83RLjbL4HYCiMVyWI1GJILnonyvuoAWMUAAJhDLQP+Ad5BsojszOZVZkhD6Mkf2IYv
         8r99CSm6BBv7msF1uj9zEP7SHgpg0msw5uot1f3erCf13OIlcIg6y3HgEpsBzS/GlRiZ
         32Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MeVCMSWpDbGHYzheWdu+Y717xanF98ksnqPfJAYkw1M=;
        b=c09mbWo/T/wU2KM9hH14rqSi1c/bdX6JU6OJ4lebXeW5dl/Glvk+eJmBMMlfpZDayp
         It9R3MZ4tIJ/F/ikDLpGknqepNHWpsQKgeLE016U7R+vvbKLIJrfHeYWJvTBJ8qFXjey
         912WXxK8VRim4GXYE8vivsAbu9BCDQ1kn+3qoizrTxMy2iPgQmJnr4OLnagD00mrWu7b
         kotx1abuSs/jMKT04f6buiObUaRXFuNFQGDS3vuQK3ok2wzW0ikarCE5NVwsY8WDQfWR
         DeUcB0WKdXRmyz8csMp+cNm/fX+FNle15zn6haXcgBSalBw48B1y5IqomYywOUQ45ywc
         GdkA==
X-Gm-Message-State: AOAM532zgzAGINrT3DgHmyMmGaNYdwYmL7q+3b/w7Vw9XQwini1Lkamq
        W5NrrQKjzi+OzesheUyKrI4=
X-Google-Smtp-Source: ABdhPJynu8aTlMARiTomzAzpoFC+mZi83vqf+MR6nXNS7W4lkctKXtEKEa3ahsE960GUsvT76fGbGA==
X-Received: by 2002:aa7:ca04:: with SMTP id y4mr8266748eds.72.1617986373012;
        Fri, 09 Apr 2021 09:39:33 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id q2sm1474051eje.24.2021.04.09.09.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:39:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [Outreachy kernel] [Resend Patch 0/3] staging: rtl8723bs: Patchset for rtl8723bs
Date:   Fri, 09 Apr 2021 18:39:31 +0200
Message-ID: <3311077.CXPNp9SFPB@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series removes camelcase, changes the type and use of a 
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






