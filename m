Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4293AD9A3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 12:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbhFSKvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 06:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbhFSKt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 06:49:58 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C04C0617AF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b3so3459379wrm.6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 03:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNOemOTras9F985BUt7jkfUSz/FQKfSLHckmy+4u2+Q=;
        b=BDBD8xtztljbm6h7TOYCBuGpI54y9JGm3EMTi0BKlhmA6/h1e71zHv1rRfadK/n0QS
         nmp3KmbtwuTItlUvX+H7b4roU14CIzp7Uf4g+xpbxt5auQbHGQbQEpA/pMLpRmFUSR7C
         9lRunf2wsBV5GKKC77Bei4aUpPwSWWtQJ5fvygtgIgTAD1+CUE7zhIYVSXSyyRvRk5To
         9LtIu3WALsEcMpkCMhoqwuF1UPSSmGy2qsG00pConutb3dO7Qq9TiCdOTg8HirtzUTGy
         0vGexY7v7eJfKZzSKES7sW+HUbwXwy7rW0qDFGUOMFuNPjVw81sccK6yD+QXNGFMOQou
         5vtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNOemOTras9F985BUt7jkfUSz/FQKfSLHckmy+4u2+Q=;
        b=M1PEfagdO5Sksq1PL6WzqQoDMF9mQrvEFM1pjS+oSTyWRJEcVCOPgXqg4FI8pH51Hk
         hNXmMJEoeJSaMhgaoTbSM6+bHRRlcqHMl0dEU9m6HPHfSrh4so4hCbDQ3gmwRQpyga0J
         m61kWyCzpyiVY3XaPE+TWuT9e89kDiNnSjKXo84y6FQsogFXWgaaJWY1ApcmAEmY8jDm
         hGshCZSyOh7NhjVmc1eWIRUxhe/1gqOB+vrYN2VncUjPgkN5jx7baeUD29RUNgs7Bnb7
         Bh2VdUaDIfsyUnDY7/ApReiWVhoPgZ887IzWNUQ+LCQel46OZrUMwcGbubcI7p8xPSu1
         WAvQ==
X-Gm-Message-State: AOAM532nz+kwWL4gmZSpcAEaKuHtdAu5WIeFps85nrf/msSB7Ik6EClH
        nDdpt5nBbT770/Vfs4FvgV1rNFuuS6RoVw==
X-Google-Smtp-Source: ABdhPJwnVchvKDG6fQg7ryPh7cdC62znzKma5Zexny4pJMdGlv202m5DRtVup+wRx1aVPECscSRRyg==
X-Received: by 2002:a5d:49ce:: with SMTP id t14mr16915770wrs.365.1624099666240;
        Sat, 19 Jun 2021 03:47:46 -0700 (PDT)
Received: from agape ([5.171.81.81])
        by smtp.gmail.com with ESMTPSA id e3sm1056119wro.26.2021.06.19.03.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 03:47:46 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 17/18] staging: rtl8723bs: fix check allowing 5Ghz settings
Date:   Sat, 19 Jun 2021 12:47:20 +0200
Message-Id: <76a466525997ca006707bc2115705995892d420e.1624099126.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624099125.git.fabioaiuto83@gmail.com>
References: <cover.1624099125.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix check allowing 5Ghz settings, only disabled and
2.4Ghz enabled states are allowed. Fix comment
accordingly.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index afefc2c8a2ac..e73fb13f8968 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2572,10 +2572,9 @@ static int rtw_dbg_port(struct net_device *dev,
 				case 0x12: /* set rx_stbc */
 				{
 					struct registry_priv *pregpriv = &padapter->registrypriv;
-					/*  0: disable, bit(0):enable 2.4g, bit(1):enable 5g, 0x3: enable both 2.4g and 5g */
-					/* default is set to enable 2.4GHZ for IOT issue with bufflao's AP at 5GHZ */
-					if (extra_arg == 0 || extra_arg == 1 ||
-					    extra_arg == 2 || extra_arg == 3)
+					/*  0: disable, bit(0):enable 2.4g */
+					/* default is set to enable 2.4GHZ */
+					if (extra_arg == 0 || extra_arg == 1)
 						pregpriv->rx_stbc = extra_arg;
 				}
 				break;
-- 
2.20.1

