Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE52136F683
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhD3HpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhD3HpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:00 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F40C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:12 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c22so17864700edn.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iaLBLpH1bRJTkz16FdRyEIFEY11hvtpkxH7HSb/2I3Y=;
        b=ufIAW6qRw+IA2RpZfT2f3DQvRlscC2HVXeXgI2PO6Y9ze/bpdPAuY+nIzmbtUHQF2t
         XAh+JJaO1Sov75y8DTHaRh5jToN3YU7r1Utja7muGzQj2+DhFU5h6IDcdEvcxqy2G327
         j13M1nGP1K/rH37mvisDi3X0/xN3TaSNMXJHxnmpWNTMdp9h31vtpUmD47a7SQ9W8EQz
         7uzcznl4T/sxmUI+UW+pHYuiiGwv/JTnR1MAppbt3n+ip0gd9mkrHCPDkzRW3wf2FAkn
         VbirTK2UbMG/EsKEFV24SkdLeBDVpwngJt+od5vTTpM6q8JuhuYd9wv8nnYQTPrtOzJ2
         iEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iaLBLpH1bRJTkz16FdRyEIFEY11hvtpkxH7HSb/2I3Y=;
        b=J5/M459kkb3Lz3UyR6tBa7Y3SRB1a5bGPCoq64Zn+SfXvuW+KyWZiCzqYe//5/FV6L
         P+/B0/vmhcrKi3k0EU1HKnKDmchaV+2GgFDfqtyh1zJRyiaAA+ja0fzIhIctxZEtW7qf
         mLAxvm607CqSkCIt5tzXhdxC1xf6U+8vySdYRSJGIOnJMGZrAne9BNDysJ2OnrqCxRdr
         ZMT2v9FVTEVERvTTZ6+xoqzxX9csJxO1uNCwAsGPU/AC+1u2lrpweiMlwnjOx2Pu8Lh8
         KDEoMXjX1ez7jGabPYEfQ4Yg9M0/vdCV2C92mDaBZRIzV8iFXO/REUzEq/gY+LK9ouNG
         pv4g==
X-Gm-Message-State: AOAM533G42ZtCHA7OePSdeguWf7myPny7/bSPZiOJFApF/YpSYz/9Fy/
        qwQnVxxEhxO6G01kdQHerMS9go+htWXp/A==
X-Google-Smtp-Source: ABdhPJxYe9GTHG+HnO9RLlPtInwomwT/e/wwWc73hRW5at5cmZx2BA9foZUkHidBXUhmhXM3XW62EQ==
X-Received: by 2002:a05:6402:5113:: with SMTP id m19mr4249524edd.78.1619768651339;
        Fri, 30 Apr 2021 00:44:11 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id bu8sm671926edb.77.2021.04.30.00.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:10 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/43] staging: rtl8723bs: remove empty .c source file
Date:   Fri, 30 Apr 2021 09:43:22 +0200
Message-Id: <64216680513f7876ea26bf95481c2ef35d7cf60a.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty .c source file

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_PathDiv.c | 9 ---------
 1 file changed, 9 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_PathDiv.c

diff --git a/drivers/staging/rtl8723bs/hal/odm_PathDiv.c b/drivers/staging/rtl8723bs/hal/odm_PathDiv.c
deleted file mode 100644
index 1a2e367bb306..000000000000
--- a/drivers/staging/rtl8723bs/hal/odm_PathDiv.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-
-#include "odm_precomp.h"
-
-- 
2.20.1

