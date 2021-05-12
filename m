Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD3A37BE2A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 15:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhELNZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 09:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhELNY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 09:24:58 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A59C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 06:23:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c22so27037136edn.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 06:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WDuOE4hxyl+w9T0BI4QiDAhIFt9uxZ9MZCrO+XA/Yd4=;
        b=FpCS/0lXHHZ7RoXBm4tdc3Xol6a6x97nIaoZIjOOI392pAoAAWT9FyYFdPfO0veqr8
         chZxLABHHcr0JSDDyomf8QNsyHBTNoIjyYMs0QIRD/neCeNETKsgUSkju2yQq/yW1lUg
         CrZhkPxTWvz9uc/xkiCesvBUBd771dp9s6MWmrqm449BkyQ2t2sLMY48pspMRcnPf56k
         8FfUtuT8gK2VuN0j978vmuUJbjbfSsW0YpK6gMlrK2JTaP2czwn/JTCfYEJMM87YsUiy
         f0ntpxPYWODv+lHVyf40ejLwSkzjnRRE4h7IK1ESoKLp2gafG9rEX8l4PqjAneVB2TqC
         Qp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WDuOE4hxyl+w9T0BI4QiDAhIFt9uxZ9MZCrO+XA/Yd4=;
        b=cmTMsqWEObhSDPYWN6ttSmFwEAHhWz+bVgI51gOeN/X4zxhv7jI5Dvl43jvXTDHI71
         zurc3J1XthNFAh4LxU4LAt+WetmTXAXIjwMzzi2bU7Y+71Uubt0BIqDF+njFIlLht7Z2
         gplkzicK4rz2CKIL0HQlFin/AKeZl1ne/5kjOPfY7JfZHCX9hI4TE/vG5QEmlHUCeJsM
         vX1kgexUzSgh+iAzflN8d9tO3BQs+O+aKZYrz/p6YsF9JrdpnIJBF0HQorKLDxVHr2ew
         ifvAfY5FGsMdBKcW/ST4OK3KMhBCVx45tajgpVQQsUwdmoFc/en8dEmyLtgo32UqITJi
         iEvg==
X-Gm-Message-State: AOAM530vjBt13ZZKl9cBiEq+PD4LWf+v/v9h9xTM6f9X2C4EzSAk3Ucj
        qOP29GXQjSaWkEUkN8ARAMo=
X-Google-Smtp-Source: ABdhPJwMeB/7DY1qX1ZEwFh6DzieWTT2XT3NqPkx2Ps8oG9ewPol1cQKIlvKELjbTchJczrjVLcFXw==
X-Received: by 2002:a05:6402:40c:: with SMTP id q12mr10713169edv.0.1620825828531;
        Wed, 12 May 2021 06:23:48 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id yw9sm2881705ejb.91.2021.05.12.06.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 06:23:48 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 0/2] Remove set but unused variables
Date:   Wed, 12 May 2021 15:23:42 +0200
Message-Id: <20210512132344.30225-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed set but unused variables from HalPhyRf_8723B.c. Patch 1/2 removes
variables detected by GCC while compiling for x86_64. Patch 2/2 removes
variables detected by the kernel test robot while building for PowerPC.

Fabio M. De Francesco (2):
  staging: rtl8723bs: hal: Remove two set but unused variables
  staging: rtl8723bs: hal: Remove set but unused variables

 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

-- 
2.31.1

