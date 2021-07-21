Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AAC3D174C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhGUTI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239410AbhGUSx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 14:53:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6C7C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 12:34:32 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qa36so4878810ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 12:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xZ0ej/xlqgZRChvPE6flzxwaHipob78lAAQBtqKCFyk=;
        b=iGTLXypEwA0xgrrWmhC0QTc5++cVg7UBLLk18t7uJqEVSAWTDZk2sJtvMRo9LNzULz
         /CbbTRChxHkQOZfZFDRegnuAlTu7lCXhxvgQ2Y9OKYOMUCV0odQJQCZ+YjHis59np+qR
         goC79xS7n6BEIgLEBYtaA/Xc7Gmt4QjIjTa+0sTGr2jwSKdyMfoxs0/nTzlP7MYkLKHe
         MeZFkyzo63c/NTG47+alUDS+xKtdeacMskKamRsvY7Bpthpa55GkMhLYAvRryrOOeNH7
         /fa+tiw1iXVGnXHI8ogVsuppOhmHLmU5n9adm/Mt0P7Bwn9rUJgvT/9ZkTbHPpO2mmjL
         i93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xZ0ej/xlqgZRChvPE6flzxwaHipob78lAAQBtqKCFyk=;
        b=haBV4AH9EluTrOedV9OoW3JaWAXqVD/HUVzrswi03pLIFYXGhn/wZlEjcxydcaKc0V
         zcSAi467x25DJhKJjFWfHh+4xGik+1fBbq4Oy5Gtp35/WxYWBI5XWT5EnwQmkbuuhKl0
         w55ldrHXFf1Dm44IYhhUTzBPvJliGMl4mSMKOBsNJETfifgS4QMrVtpEyxP9Tg+pie86
         A5CbYAxQ2Ee4iP0fgCtWXS4KwPs3msbVa6HcQR2tDMThARTIMViWuyzOu9JPH67o45vq
         sxfbrSTlFTiHTRC/ojHNUGREan4rUH3yBrSSmj5r6r7+stzFcv/EQcGLGU9wtV670A/G
         oOCA==
X-Gm-Message-State: AOAM532Yg0Mzi83oZ3e0m/TN1WTZe9a4NSA8GFfP3WjnDwLZTnzIiri7
        WifHOZqGqAR1fJ4syHXWqE4=
X-Google-Smtp-Source: ABdhPJwOIBT3zOReL4o/86VvY8k3AZk1n6Bh6FKOn0tIYsBbMdHqNPYi329AFtZcpmALpY60Rbleog==
X-Received: by 2002:a17:907:961b:: with SMTP id gb27mr3488399ejc.340.1626896070700;
        Wed, 21 Jul 2021 12:34:30 -0700 (PDT)
Received: from localhost.localdomain ([176.30.239.20])
        by smtp.gmail.com with ESMTPSA id e22sm11359084edu.35.2021.07.21.12.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 12:34:30 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, zhansayabagdaulet@gmail.com,
        straube.linux@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH 0/2] staging: rtl8712: fix error handling
Date:   Wed, 21 Jul 2021 22:34:20 +0300
Message-Id: <cover.1626895918.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, rtl8712 developers and stanging maintainers!

In this patch series I rewrote error handling approach in rtl8712 driver.
Detailed description can be found in commit messages. In short:

There was strage approach to handle fw load error. For some reason fw callback
was doing clean up stuff which can lead to UAF bug. For example:


CPU0                                        CPU1
r871xu_dev_remove()
                                          rtl871x_load_fw_cb()
                                          free_netdev(netdev)

wait_for_completion(netdev_priv->compl) <- UAF, slab-out-of-bound or smth else

I've added free_netdev() call in my previous patch to this driver:
e02a3b945816 ("staging: rtl8712: fix memory leak in rtl871x_load_fw_cb") to avoid
memory leak and I believed, that this approach won't trigger anything else, but,
unfortunately, I was wrong. Syzbot found 2 bugs [1] [2] and I decided to complely
rewrite error handling in case of fw load failure. This patch series was tested
with both reproducers and did't trigger any bugs.

[1] https://syzkaller.appspot.com/bug?id=7646834b55c71c45ed85f601032daa6c23db0513
[2] https://syzkaller.appspot.com/bug?id=89c3ddb9936d3552995130298f1d2633ab9d3541


With regards,
Pavel Skripkin

Pavel Skripkin (2):
  staging: rtl8712: get rid of flush_scheduled_work
  staging: rtl8712: error handling refactoring

 drivers/staging/rtl8712/hal_init.c        | 30 ++++++++-----
 drivers/staging/rtl8712/rtl8712_led.c     |  8 ++++
 drivers/staging/rtl8712/rtl871x_led.h     |  1 +
 drivers/staging/rtl8712/rtl871x_pwrctrl.c |  8 ++++
 drivers/staging/rtl8712/rtl871x_pwrctrl.h |  1 +
 drivers/staging/rtl8712/usb_intf.c        | 51 ++++++++++-------------
 6 files changed, 61 insertions(+), 38 deletions(-)

-- 
2.32.0

