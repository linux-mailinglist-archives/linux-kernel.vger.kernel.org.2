Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1F840411A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 00:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243764AbhIHWkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 18:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbhIHWke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 18:40:34 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7EFC061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 15:39:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m9so5554473wrb.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 15:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e0e52hbkT374Hg6sqdmTeXsKZzO23MHbscpUtA4GZs4=;
        b=kHZm2ZnIp9KBzrU9oeWLhawZ84TTxg6KLyJ1ZzzJVOLlWaEWzyIf6k5m7MJAhRs6ib
         DkUkkE1qZFM/hOFO7knzDUUW5HBIcfzHu3c24jSmvSMnbpYHv5GbH3b4ompY3TQK2ip6
         4XLvtjz84qqSZprJrE+HyPmnYviMMwr0sPua2w256hXzPWQYuadMYUBE7uftB2CWknEp
         zQlgHX+41DbVE1b9z+mWrZpfAZKDPvMAwsZDC9kWBDJSRBu5vrzYY7kwzjX0Dqayh9Vi
         SaK+0+0ieQoUO9beXF+WGnvu/r3p5QVAXwL12B1KO0YvlheEL4pPi0JhgzLVi36DCyMh
         FhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e0e52hbkT374Hg6sqdmTeXsKZzO23MHbscpUtA4GZs4=;
        b=N3R8gMfrjw4KgUjtlNXXHCSrT/NYv6XtyN2NMrXSUyRMDGlVeZY6lISFycBRXOK9KZ
         DsE1y8aZWOkOAYFZtzlsr1ObUyG4J9nyLKhFR8pKGGUxTR/yPJ1uBW30qLAO9d1C7U8n
         rOAvBOH20mI2wr1GSjp1FUdmIg47Uex31mCeTdPgvgJBKn7GdYkwSKlRGA6RKvUJpNNa
         J24QebaaVlRyYhBkk2/aw/CtmAMr+yXkVdHVCF6BYrlXou2Z4qaqvunjKefm4DLFeFNV
         UN1z0NAL6Zp4ndtjqLlW+Qv2hJbcGq4cwYZRfrcOJgU5rYekVq2Mc6gmkB+aB5Po5sQ2
         9EpQ==
X-Gm-Message-State: AOAM530VMNBDC5QeVWpInEEBuKucelLoBjVv3vH0JwOZVuNhiCUI8UAg
        QUEhPkQ3nVUj9OSBnpTQQZ176yJN2JH0UQ==
X-Google-Smtp-Source: ABdhPJxRIZbXu0+CJ+dDUt1wyr3InT5QBvarlyrzRGlSgR1hrMikCX5TMGCbSsahOhsqW/ENDX6yYA==
X-Received: by 2002:a05:6000:160f:: with SMTP id u15mr608176wrb.166.1631140765034;
        Wed, 08 Sep 2021 15:39:25 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id d29sm428643wrc.6.2021.09.08.15.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 15:39:24 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/4] staging: r8188eu: remove unused functions from hal/rtl8188e_phycfg.c
Date:   Thu,  9 Sep 2021 00:38:59 +0200
Message-Id: <20210908223903.10516-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes unused functions from the file
hal/rtl8188e_phycfg.c.

Michael Straube (4):
  staging: r8188eu: remove unused PHY_GetTxPowerLevel8188E()
  staging: r8188eu: remove unused PHY_ScanOperationBackup8188E()
  staging: r8188eu: remove unused PHY_UpdateTxPowerDbm8188E()
  staging: r8188eu: remove unused rtl8192c_PHY_GetHWRegOriginalValue()

 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 185 ------------------
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  |   7 -
 2 files changed, 192 deletions(-)

-- 
2.33.0

