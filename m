Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC9535F35E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350815AbhDNMTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350793AbhDNMTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:19:16 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F63C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:18:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id t14-20020a05600c198eb029012eeb3edfaeso160781wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c+1jG1dzHX+50HCkskqxQLY0J0MPw/2nqF2RozJga14=;
        b=SszNMDiKKLM3hPhNqMklgKNgNfugkPmp+JsqTi6qSlYDAhuttTmnSDnsiCXe+ILUhu
         WxrjD1DKMI7Y0FL8cDhCjJSpV5HWLZBQTKRWtLBP5mhxo1ESlxV2TkuFttdKzhIhjaa9
         T8NTuEPHfcVaUqbZNrTx8X5TIE/33/+cZPXjerJ1DPauM41oQHJgkCjJd3FTrFdf/Yxg
         jUEp3uMTASNTNtyzWRtXS6oUZvfwI/eNmXn7cjKNU4R/ygSyuzCiIg4u/iEplHlLJztT
         7bKmUUIytP/Ei8kKBfl2inF7Ybwnr0Rwz+l5x9C9lx2ngfzq0CChoc+XRFsIKdDBomuD
         FhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c+1jG1dzHX+50HCkskqxQLY0J0MPw/2nqF2RozJga14=;
        b=WUg9AUbzOKrmRrlIAFnQ4FRW1fh4/x5uFSC0eMIYCgaT0LdM2BNOmKHAZMc4rCuVlQ
         EDX1K9yRwchaKSBxc8O/Ng7bHBS+r4Z3wftoq1NvJqmIXEz4gJnlpmAWDcAz3MHJ+krT
         KI91/1/7tjyXhE1l3x+2JJ0VAaBsXVRsQyjw2z49rdzeK9AOa22I1sl4U5f8dhcZlnFM
         sGZGr6HnoKMhHpCasFEoCRZ8aSFZERSSnMO50hBNsCd32DGJ1QWaZwxYvDdpqEOUbRbD
         5PsCyJipkTDByurozwiG8DyJYxUOp9spnOlsgBDXpXZcRbaqcHGQ8BsjHNFkRHxVWJLm
         SusQ==
X-Gm-Message-State: AOAM532TO6bMUATLEqCh05qJqjpKtfeKTuVAbJv+Hs8mqllMccu5/eX7
        w60QU+vf4IlS8/dB/75Thl/mtX61+xeS2A==
X-Google-Smtp-Source: ABdhPJyoRaJuOLJASJ0h2FyLCvm7tEZHyu5H1LCNmVY2l1pPoTnHP5TmU8EZMSwG4PLERU/jFUTLyA==
X-Received: by 2002:a1c:2541:: with SMTP id l62mr2745112wml.188.1618402732316;
        Wed, 14 Apr 2021 05:18:52 -0700 (PDT)
Received: from agape ([5.171.26.216])
        by smtp.gmail.com with ESMTPSA id m2sm4750602wmq.6.2021.04.14.05.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:18:52 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     julia.lawall@inria.fr, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] staging: rtl8723bs: replace DBG_871X_SEL_NL macro with netdev_dbg()
Date:   Wed, 14 Apr 2021 14:18:47 +0200
Message-Id: <cover.1618401896.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset replaces DGB_871X_SEL_NL macro with the driver
recommended log function netdev_dbg().

Here are contained the patches not accepted yet in v1.

Macro DBG_871X_SEL_NL indeed executes a raw printk call as
default behaviour. The other behaviour is doing a seq_printf()
call which never occurs.

First patch apply the following coccinelle script for macro
bulk replacement:

@@
expression sel;
expression list args;
identifier padapter;
identifier func;
@@

func(..., struct adapter *padapter, ...) {
        <...
-       DBG_871X_SEL_NL(sel, args);
+       netdev_dbg(padapter->pnetdev, args);
        ...>
}

added by hand a newline in coccinelle output.

Second patch removes DBG_871X_SEL_NL macro declaration.
Third patch removes an unused function argument after
macro replacement.

-------------------------------------------------
Changes in v2:
	- Excluded patches already accepted in v1
	- Added by hand a newline after coccinelle script
	  application
	- Dropped the patch applying newline separately

Fabio Aiuto (3):
  staging: rtl8723bs: replace DBG_871X_SEL_NL with netdev_dbg()
  staging: rtl8723bs: remove DBG_871X_SEL_NL macro declaration
  staging: rtl8723bs: remove unused argument in function

 drivers/staging/rtl8723bs/core/rtw_debug.c    | 16 +++---
 drivers/staging/rtl8723bs/core/rtw_odm.c      | 52 ++++++++++---------
 drivers/staging/rtl8723bs/hal/hal_com.c       | 31 +++++------
 drivers/staging/rtl8723bs/include/rtw_debug.h |  9 ----
 drivers/staging/rtl8723bs/include/rtw_odm.h   |  2 +-
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    |  2 +-
 6 files changed, 50 insertions(+), 62 deletions(-)

-- 
2.20.1

