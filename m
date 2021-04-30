Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E0036F82A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 11:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhD3JyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 05:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhD3JyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 05:54:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE71C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 02:53:25 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g10so13967203edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 02:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fBSgjBNdxte1Vivu5LDpQPAo+k7uzN+EmhLuoV7VqWM=;
        b=AlFnVwHwJlRnAr3omoF9QiU4okufovYE5Hl+g7u4QX145UTL/w3pr26Xrs2z5ZG2lZ
         glzT3dq8lDAqhkwPoKumXgU7OSVmIRk7iabOwra00oW5lRN2UPawHoYFmdemtbPAEUw1
         G/w/15GXp8y6P3lavC9oc38rgopY700OqkFxop37WzJKSfKb1oOVCrqeqe+ZWVMrBoTJ
         yRjQryvDLhX+jvo2pV0W/IjphyUHPvpi5zHMLDrYHHw7HUkwkeIEeE0ItBCGoEDnc7Y9
         40i0RQpZ+CXtlxYlLLmH1SpcjZADxOMJRL26Gjrnn3EvD+hahOdMyTnplk6KznfQJr6i
         nBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fBSgjBNdxte1Vivu5LDpQPAo+k7uzN+EmhLuoV7VqWM=;
        b=gj/TnlN0rc9IgQ8b5t53Es1aYnKVqR1KP8xKRkVLBabJQp6lEsjQf5/XpNV7hJvxX5
         FyY/PskG6HgQrXSZSDaJHdl/cP0EmVmfZsaDSTwMXuDK7Zt2cBAWxkqDAN6Nso/W9Kj3
         IegzOQCkVv8TiaM4lc3Yb87lIWXLUzwMq6aEzlPQLzGaNGpEQ5ur8vWapX4F7ZUTtdvl
         ijjYiFGZnqKCddoumWmJfNzKo+fCcileH5KeSvt9laj+OAs82+fykW+4kq6+t41dZraE
         Czxio+yAwr28wPV2Tgpdn0BhjSArhlPQp/kPnI/AnXS/42vUD6BpzRb3fxTcacZ7KJmM
         x8NA==
X-Gm-Message-State: AOAM533kXQq20XC95+827dUGHEriYYd09ZC0HtLNgHbEgXEF4vxMfCAz
        2qbUy7uNnmvGi8lS9mv1lz4EZ8lgPuORpwbw
X-Google-Smtp-Source: ABdhPJwVsTcCiUv4Yaw4pi/Eb8Q0EPsYsQQo4dPZlhMQuMxgADF7Os1rkI+cs3NMKM7LYdZHBUQdqw==
X-Received: by 2002:a05:6402:6cf:: with SMTP id n15mr4723481edy.51.1619776404091;
        Fri, 30 Apr 2021 02:53:24 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id f30sm1626861ejl.62.2021.04.30.02.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 02:53:23 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v2 0/2] Remove set but unused variables
Date:   Fri, 30 Apr 2021 11:53:17 +0200
Message-Id: <20210430095319.23226-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed set but unused variables. Issue detected by gcc.

Changes from v1: As suggested by Dan Carpenter, removed no more needed
curly braces around single statement blocks (patch 2/2).

Fabio M. De Francesco (2):
  staging: rtl8723bs: hal: Remove set but unused variables
  staging: rtl8723bs: core: Remove set but unused variable

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c     | 9 +++------
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 5 -----
 2 files changed, 3 insertions(+), 11 deletions(-)

-- 
2.31.1

