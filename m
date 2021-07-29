Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13023DAACA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 20:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhG2SMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 14:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhG2SMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 14:12:15 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A147AC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 11:12:12 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id a14so6848629ila.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=9sdevUXdH+N3MKgpmyJ0uuYWzaLPK/wTSy/wLrHVjl8=;
        b=LrBlLDFK9SjAKAIlpsdqQuLi27/nzz0Htshch9Ud+UGin+RPIjolujKY+S2k5M7VFJ
         uEZno8mjctrUSlMaxJdUPyAaqVFhl++DggUTqgLqDRmmTNP2OuMUNO90KCosjdQRPwfN
         XJ2L4DGs/GetU7KUF7nRTuH2+MBYhBoogL2h2jy7ZypP03cdUZzYMExzFZnapi9zptdS
         JhJ71O9rbbrAJXc+zG6UeK4+wSxjVVjlXwXZRJ/zPE0YzsgBCOu3gWaxddkkuP3Xl/e+
         lOTX0Y61nHnqkQUNCtlxIjfyDzxBEvomF8Fzkr/cnGs65JjAGO6sBMRlmlhYgn9MUXBM
         b55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9sdevUXdH+N3MKgpmyJ0uuYWzaLPK/wTSy/wLrHVjl8=;
        b=D2zf3VfLYSkO9Gs6sJWd5DQZs3r25wQRA2MLwDhwNrrvomCtV8TdI0B+NxsRZJxDU3
         dhNKTcHdP2QxTpeb62ARtz9PBEirJopT347XoiaWD2hyn9TH0aUiv8m6PuLnclYREi05
         Zprrtl9hrlE2s68O1sDWCQC+MHrBXxyOK9ZtXG38vPIsE0J53fF4Psx1cPrf1eS6xoID
         bZIvj/S0rF2oWnLOFFW1LvJlTfooDGN5SzQaIJwGxy2GmVsxwGjal3AT8Q+m+BxnO0mb
         K0Typulme/a3RbiWbfwmvRYJvXFbA2QtW+O10KG8im7tOgEoU0yDQHGPNSptrGxHdr4/
         +pZg==
X-Gm-Message-State: AOAM530SxqYHytXhmJ1XLtSPRdjA8ymH44rnx7Io6eKU8BO3fkoAX9le
        s4IBJvIBRmSNnX7lzZYRtmQ=
X-Google-Smtp-Source: ABdhPJwBBLYzIuCuR89jLr3eHp4+lZIMPFZKNgT6IQ2uyWoCBdtrwJv3TXGGgxcL1FFYHLZeESDYLw==
X-Received: by 2002:a92:c5c2:: with SMTP id s2mr4665254ilt.180.1627582331952;
        Thu, 29 Jul 2021 11:12:11 -0700 (PDT)
Received: from Agam.localdomain ([2601:402:4500:9270::5e36])
        by smtp.gmail.com with ESMTPSA id q10sm2893988ion.3.2021.07.29.11.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:12:11 -0700 (PDT)
Date:   Thu, 29 Jul 2021 14:12:08 -0400
From:   Agam Kohli <agamkohli9@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Agam Kohli <agamkohli9@gmail.com>
Subject: [PATCH] Staging: rt18712: hal_init: removed filename from beginning
 comment block
Message-ID: <YQLveNI2UrnpeeAt@Agam.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue

Signed-off-by: Agam Kohli <agamkohli9@gmail.com>
---
 drivers/staging/rtl8712/hal_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712/hal_init.c
index 22974277afa0..dc138fe7d2de 100644
--- a/drivers/staging/rtl8712/hal_init.c
+++ b/drivers/staging/rtl8712/hal_init.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /******************************************************************************
- * hal_init.c
  *
  * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
  * Linux device driver for RTL8192SU
-- 
2.32.0

