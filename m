Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694A0338AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbhCLK4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbhCLKzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:55:47 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B64C061763
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:55:46 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y124-20020a1c32820000b029010c93864955so15516162wmy.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xA52xjDJnHJLgzflByk0CYC2xv7fgNWSlI8xs2AjI2I=;
        b=yBhGkoCBvWZlTxApi3aQJCnXm6iZzfXW4lQ1f6lbu63T/UR1hwscaZQgi6mFsVg64a
         oiA/rWoXUQKQGJ5nth3GW+1+N6Q9vQ+LsOSskFQvM5+FfVpyUsxa1oVrzuO7bgSsVet+
         1LCEz6xdgaUNJ0NNVGWeHhf6ln0L/JSLz2qMsYBqA3fk6Yl2JEUPxgAQyQB+GlNOero6
         ZpeDtbIKY2N+DkzL73rgHW+TRdFtjfwk7QEw69eurO+gkMsQEIQpbkTgDWbcfs1q/+t5
         Bx5XTPDeM450Q5ULCtVDlRXPeZuf8JJp9FGJSRNnul8wY2tmaHUSIYbYczvw3aGjkxBJ
         9yiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xA52xjDJnHJLgzflByk0CYC2xv7fgNWSlI8xs2AjI2I=;
        b=D1t4u6kVQ9PyPRTVst64K2kNQwnyKoq+V1QeOAzA8kK7NA8P7ad/x8OGguJY2fTFdN
         gFiXiczR6k8yYddiA7tX450Z0BBnsABjmdkT6h4TSpgAgip4kQN7C4R/FzTyY1nrOZnD
         IXB2pKrWuTPx86Nx7nK18yLBQqggSd9/U0kC3TQure9g/ruqZ5J6a6a5VkH7s14HlbO/
         NYPXcUBBmS5xTxPA0nuuWjfM1u2RN7I8VXC7Ud2MhAt2uAPv3KMj0o4+bko2o7NHa+qz
         b/rI4A+Md4M9zst+2w4w+3iUbLfoe4FiZ+O8aYTa+O56ZVQPNk3/oXPfHR5hk1jfaQA5
         lLjA==
X-Gm-Message-State: AOAM530hVxrGAq8CjimTWJLtyrhL32Fu8DetW9Y5/UT/4JKp3BUSuKGy
        yDQ8DollV4TAqpJ50AjHTffXGY7NTldbCQ==
X-Google-Smtp-Source: ABdhPJyuSwTDyvh7rCaXNW786qrIPBHDymlJenX8Hl8exjSrhayuRqjYskb8CzXmWzlIWfVNFKDDdw==
X-Received: by 2002:a1c:9a0e:: with SMTP id c14mr12656107wme.34.1615546545649;
        Fri, 12 Mar 2021 02:55:45 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id q15sm7264962wrr.58.2021.03.12.02.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:55:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org
Subject: [PATCH 10/11] block: xen-blkfront: Demote kernel-doc abuses
Date:   Fri, 12 Mar 2021 10:55:29 +0000
Message-Id: <20210312105530.2219008-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
References: <20210312105530.2219008-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/block/xen-blkfront.c:1960: warning: Function parameter or member 'dev' not described in 'blkfront_probe'
 drivers/block/xen-blkfront.c:1960: warning: Function parameter or member 'id' not described in 'blkfront_probe'
 drivers/block/xen-blkfront.c:1960: warning: expecting prototype for Allocate the basic(). Prototype was for blkfront_probe() instead
 drivers/block/xen-blkfront.c:2085: warning: Function parameter or member 'dev' not described in 'blkfront_resume'
 drivers/block/xen-blkfront.c:2085: warning: expecting prototype for or a backend(). Prototype was for blkfront_resume() instead
 drivers/block/xen-blkfront.c:2444: warning: wrong kernel-doc identifier on line:

Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "Roger Pau Monné" <roger.pau@citrix.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: xen-devel@lists.xenproject.org
Cc: linux-block@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/block/xen-blkfront.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index e1c6798889f48..e57e3cd354fb8 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1949,7 +1949,7 @@ module_param(feature_persistent, bool, 0644);
 MODULE_PARM_DESC(feature_persistent,
 		"Enables the persistent grants feature");
 
-/**
+/*
  * Entry point to this code when a new device is created.  Allocate the basic
  * structures and the ring buffer for communication with the backend, and
  * inform the backend of the appropriate details for those.  Switch to
@@ -2075,7 +2075,7 @@ static int blkif_recover(struct blkfront_info *info)
 	return 0;
 }
 
-/**
+/*
  * We are reconnecting to the backend, due to a suspend/resume, or a backend
  * driver restart.  We tear down our blkif structure and recreate it, but
  * leave the device-layer structures intact so that this is transparent to the
@@ -2440,7 +2440,7 @@ static void blkfront_connect(struct blkfront_info *info)
 	return;
 }
 
-/**
+/*
  * Callback received when the backend's state changes.
  */
 static void blkback_changed(struct xenbus_device *dev,
-- 
2.27.0

