Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9405331C46B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 00:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBOXf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 18:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhBOXfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 18:35:25 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0FAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 15:34:44 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n4so8060799wrx.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 15:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Su0VWDUALWOYKIFRR4UFS8nL8GDpUruFpVifim76/bc=;
        b=wxqoiKHjqNnMS6ujl47+8uq+EQCZ2O498CHKdiPU827HSaqf4nxm7bcNntVziqrCeR
         SA7+lVmKlQTUYuTjDjxtgFfOYhnGPilx6a/R/oTjRxNiOSElJEMWM1vxFCCoWPdbFMfp
         PVul6IvZA2HsshDttn8uXGF/SpwO3Rb1fp5EtbA0eiyEM/JDBgb20NZjIkXUxfPKx/jJ
         RkMRvNLYnsu7lnx7BhiWL3vf2YxcHKEt08n3Ov6fJpbsQTSovS7anv8rNZIO67hsjCyS
         DgD5EGgoXJIFnpigX7nfDHcga9cTzMzX97PfESIMolXVoe0zsxbsXIzMDZbqRgXNueUk
         S+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Su0VWDUALWOYKIFRR4UFS8nL8GDpUruFpVifim76/bc=;
        b=EB++UVNuzMH7gMX5wImqo7Omz/PFu8vCraMDLr7bxcFJj6acBpR89Pnv613JEadQ2D
         yWC6x2Lt7q8aaYtQcLKrxwzHKSVbAMqIaFnDzeDIiMoQNqRx84gbaa/93t1M/ahYmFdu
         Z/RfX2POuF9mS8SNw6dbsfwMf/NRrMZjjcg3NccMiHLTu9C2EHrDZiLBcYc7jxOSFS0C
         KVMIYZoZIUv/lv5CbO7jynArRHN8uZF+MUvId0xpcawv4aC4VC6Dr20yGJTDVzWudG5N
         exe/TAwndBYd7PGZ7IXtJKwjjsg04KNcYDV8NptciMT4jcEmmY8eu+DajJhQRQ+CtXjx
         mmRw==
X-Gm-Message-State: AOAM532OFNcuwSjxmGTuHGLxwi8wtlq/EUS7PEq9+P8Sh0YeTK3OwzNe
        sLhZ5FKmT9rrMktK/qyBKY9aFA==
X-Google-Smtp-Source: ABdhPJwp0hYc6/z38TJ2McI0u8B8N2Fwi9DKBzc2ibQ6K55jwrivQwDdYiuuIZXLOSWMy094mWxndQ==
X-Received: by 2002:adf:fd89:: with SMTP id d9mr21235242wrr.255.1613432083036;
        Mon, 15 Feb 2021 15:34:43 -0800 (PST)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id y16sm21691445wrw.46.2021.02.15.15.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 15:34:42 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     ross.schm.dev@gmail.com, matthew.v.deangelis@gmail.com,
        pterjan@google.com, vkor@vkten.in, amarjargal16@gmail.com,
        foxhlchen@gmail.com, insafonov@gmail.com, yujian.wu1@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] staging: rtl8723bs: remove DBG_COUNTER
Date:   Mon, 15 Feb 2021 23:34:34 +0000
Message-Id: <20210215233440.80617-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set removes all calls of the DBG_COUNTER macro from the
driver, as the macro only increments the relevant values, which are
never then used anywhere else. It then removes the DBG_COUNTER macro
definition itself.

In addition, it removes rx_logs/tx_logs/int_logs struct definitions from
the codebase as well. These are inside a CONFIG_DBG_COUNTER preprocessor
ifdef, and the only thing that was using them was the aforementioned
DBG_COUNTER calls.

Removing this code goes some way towards cleaning up this driver, and is
therefore worth doing.

Phillip Potter (6):
  staging: rtl8723bs: remove DBG_COUNTER calls from os_dep/recv_linux.c
  staging: rtl8723bs: remove DBG_COUNTER calls from os_dep/xmit_linux.c
  staging: rtl8723bs: remove DBG_COUNTER calls from core/rtw_xmit.c
  staging: rtl8723bs: remove DBG_COUNTER calls from core/rtw_recv.c
  staging: rtl8723bs: remove DBG_COUNTER definition from rtw_debug.h
  staging: rtl8723bs: remove rx_logs/tx_logs/int_logs from drv_types.h

 drivers/staging/rtl8723bs/core/rtw_recv.c     |  44 +-----
 drivers/staging/rtl8723bs/core/rtw_xmit.c     |  44 +-----
 drivers/staging/rtl8723bs/include/drv_types.h | 131 ------------------
 drivers/staging/rtl8723bs/include/rtw_debug.h |   6 -
 drivers/staging/rtl8723bs/os_dep/recv_linux.c |  15 +-
 drivers/staging/rtl8723bs/os_dep/xmit_linux.c |  17 +--
 6 files changed, 10 insertions(+), 247 deletions(-)

-- 
2.29.2

