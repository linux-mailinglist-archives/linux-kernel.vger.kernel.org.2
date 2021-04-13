Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC3735E103
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346278AbhDMOLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhDMOLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:11:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53269C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:10:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e7so7655969wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mkCkAJIkrOY7pAZ9reInsO74iKUOVHosiFJ4TLiQNQ8=;
        b=QT1oIyX+9iVDyxzz0ym6WeLK4T9wYQAhpg+JBOlR9g0kKFKVpAYzmLimy3RmQLgltJ
         j8hYH6IJtLVk2O3IogkWfpayVkA2iEo+4Z+QY4fiKRfugE4M1kt/m2+cXwACtFGO3EDu
         4RNgPL5hcMHWNqBbdTyO0QwwL5php5FCwvC51gcfYmwGyySHQLutPC1RuxvF6Xbpyp8A
         4RUfFMFai/EYV8I5v/IYd9hR7AKoTv5lDu4hZbz+SCnZpBoFYzAyIxqvQohrZgefAgKc
         k/PyTsRFGxvbYYaQuiBjmVE0mjIoGna4BKA4t+Q6veoDFNn+0zgXxh7lccX//YxFc/XO
         f1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mkCkAJIkrOY7pAZ9reInsO74iKUOVHosiFJ4TLiQNQ8=;
        b=eGdPCxyHYi2vbPQN0Dw0Ee7KqlK+s+P5pwqBI2MTBNUDd7PZUSNXyzq/R+6gIh7mO7
         KaYJsur29Gw38YxDobd5KYYYO4uPLMVSXTo40b5/kRz3ogvEeNc07EjwU3gSYci6fzgJ
         lH+OqfFRdmsstpxdCcpE9uLnhfugOb6tYNukhkyp932xxQz333jNqKX2OinIIlqm6YcV
         fhzPKkW5VxxpTNFICQuzN6zlunkF2eI/G8lGiStvt2OLKrMP8x+RGv4ppc4x3WavHaU5
         +S4+sS7Joz9Nf6feAXMnUuOkVsDPR5FWROaT5IH1lSupaCW1Zt+dritotBYuEjiJw+be
         r6cg==
X-Gm-Message-State: AOAM5316AHGC8b6J264Y0A7BjtRPd3P2D/sUgBvg9NUH9coQ81aQfbdv
        OOURACmpT0Rz9iweMBcTiVeuAbfCdxMR7Q==
X-Google-Smtp-Source: ABdhPJxbcd638a9JsO2Z9rbT4kJBz5lxLw+EtxwHOgcK+OPjnZc2vcw1U2EeKZtkggOIt5MNmTPruQ==
X-Received: by 2002:adf:e0d1:: with SMTP id m17mr37060834wri.90.1618323044675;
        Tue, 13 Apr 2021 07:10:44 -0700 (PDT)
Received: from agape ([5.171.81.171])
        by smtp.gmail.com with ESMTPSA id 66sm3086598wmb.36.2021.04.13.07.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:10:44 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     julia.lawall@inria.fr, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] staging: rtl8723bs: replace DBG_871X_SEL_NL macro with netdev_dbg()
Date:   Tue, 13 Apr 2021 16:10:35 +0200
Message-Id: <cover.1618322367.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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

@rule@
identifier func, context, padapter;
@@

func(void *context)
{
	...
struct adapter *padapter = context;
	...
}

@@
expression sel;
expression list args;
identifier rule.padapter;
identifier rule.func, rule.context;
@@

func(void *context)
{
	<...
-	DBG_871X_SEL_NL(sel, args);
+	netdev_dbg(padapter->pnetdev, args);
	...>
}

@@
expression sel;
expression list args;
expression get_dev;
identifier func, dev;
@@

func(...)
{
	...
	struct net_device *dev = get_dev;
	<...
-	DBG_871X_SEL_NL(sel, args);
+	netdev_dbg(dev, args);
	...>
}

@@
expression sel;
expression list args;
identifier func, dev;
@@

func(struct net_device *dev)
{
	<...
-	DBG_871X_SEL_NL(sel, args);
+	netdev_dbg(dev, args);
	...>
}

@@
expression sel;
expression list args;
identifier func, dvobj;
@@

func(struct dvobj_priv *dvobj)
{
	<...
-	DBG_871X_SEL_NL(sel, args);
+	netdev_dbg(dvobj->if1->pnetdev, args);
	...>
}

Fifth patch fixes a post commit checkpatch issue left
by coccinelle output.
Sixth patch removes DBG_871X_SEL_NL macro declaration.
Seventh patch removes an unused function argument after
macro replacement.

Fabio Aiuto (7):
  staging: rtl8723bs: replace dump_drv_version usage with netdev_*
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

