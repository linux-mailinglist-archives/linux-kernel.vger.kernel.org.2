Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6EA38AF27
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243297AbhETMwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241892AbhETMvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:51:08 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D2BC061350
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d11so17399186wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rju/n+tgLLGe7lvo2xTmpHWt0wLiBBFgOYcgQ5kqFFw=;
        b=fn9XorEWDy3zI2gyW4fxqhuvXTOKXDYR8MPWpHQwFhVZOy96m8xgrmaJPDln6+OlyJ
         2mnW9SZ3ZnZNd5w7wURKzBbypb9oWxbXQLRwn2Njdabto9CWT3cngBpar6y32swhB9aP
         +mWDvEr782FxityxaQEwlH9m/n/hB/zjxGvnEgQqIZ/0ffmnC+sJxPfOWaaiiVlxpiHT
         /g4lnhMw6giMbUlUOTFY2/t9j+Joz9wg5XSmtugfUP/Ix3xhv3TmbpAkEPslV/qwrAbK
         yduS5PdwFICEtXNZqUrCWRFfN3N9FbC6ChTavijKKzJvFxx6sgWtXcC2UADWkHCfgA6L
         jIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rju/n+tgLLGe7lvo2xTmpHWt0wLiBBFgOYcgQ5kqFFw=;
        b=thrSGEb51xztuzf2MWBrnnj20JkK632I7dlRD9ipwrvEuKeQhedx2pTkPz3A7dMBCH
         MUT75L0DBxrZr4G53Qz6Ama6/5apbjtmg8ZmhVM2iN0GcU6FEqqp7tnRS7lBajM1eO3e
         pAZjERFtRW5DaGBYPTdRlRRnDihAdclfaLl6PZwNpFeQZn9muBzlP70H7yogvm703iAL
         Qe7cIwrt/hKJnbliTVDxk7bSQufvsleY/HH54FZv52xed4rRLDkpkVzyRjkL9yW0w+nf
         s2FHc68Pw1EoFi0cp1OiwOBegrjMX7a3B232rfdaoxCY4G3JPpSqp4yD/CAQbtyi3oyE
         ss3A==
X-Gm-Message-State: AOAM5311Yjc+qIwFIKNk2MDxtl7dOXx28d0Ju+ucFpyznRkLopn/WG23
        2Y9poTCZpO/aVqyfJ2ra9QpTnw==
X-Google-Smtp-Source: ABdhPJwXUkda9qvuLFx20ROyWuUf3BkmUx4PzNijHm5GFasxf0b0bE8FhLUumVB/rO8GGKbxc74hQA==
X-Received: by 2002:adf:e607:: with SMTP id p7mr3966473wrm.358.1621512840866;
        Thu, 20 May 2021 05:14:00 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 61sm3393704wrm.52.2021.05.20.05.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:14:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        paulkf@microgate.com
Subject: [PATCH 05/16] char: pcmcia: synclink_cs: Fix a bunch of kernel-doc issues
Date:   Thu, 20 May 2021 13:13:36 +0100
Message-Id: <20210520121347.3467794-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121347.3467794-1-lee.jones@linaro.org>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/char/pcmcia/synclink_cs.c:4068: warning: Function parameter or member 'dev' not described in 'hdlcdev_ioctl'
 drivers/char/pcmcia/synclink_cs.c:4068: warning: Function parameter or member 'ifr' not described in 'hdlcdev_ioctl'
 drivers/char/pcmcia/synclink_cs.c:4068: warning: Function parameter or member 'cmd' not described in 'hdlcdev_ioctl'
 drivers/char/pcmcia/synclink_cs.c:4068: warning: expecting prototype for called by network layer to process IOCTL call to network device(). Prototype was for hdlcdev_ioctl() instead
 drivers/char/pcmcia/synclink_cs.c:4173: warning: Function parameter or member 'txqueue' not described in 'hdlcdev_tx_timeout'

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: paulkf@microgate.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/char/pcmcia/synclink_cs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 4a1e63911b279..b004abac61542 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -4054,11 +4054,12 @@ static int hdlcdev_close(struct net_device *dev)
 }
 
 /**
- * called by network layer to process IOCTL call to network device
+ * hdlcdev_ioctl() - called by network layer to process IOCTL call
+ *                   to network device
  *
- * dev  pointer to network device structure
- * ifr  pointer to network interface request structure
- * cmd  IOCTL command code
+ * @dev:  pointer to network device structure
+ * @ifr:  pointer to network interface request structure
+ * @cmd:  IOCTL command code
  *
  * returns 0 if success, otherwise error code
  */
@@ -4165,7 +4166,8 @@ static int hdlcdev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
  * hdlcdev_tx_timeout() - called by network layer when transmit timeout
  *                        is detected
  *
- * @dev:  pointer to network device structure
+ * @dev:      pointer to network device structure
+ * @txqueue:  unused
  */
 static void hdlcdev_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
-- 
2.31.1

