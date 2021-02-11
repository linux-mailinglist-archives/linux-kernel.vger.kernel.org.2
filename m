Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EBA3196C1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 00:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhBKXid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 18:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhBKXi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:38:28 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791BEC061756
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 15:37:48 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id d3so10629746lfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 15:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PQt3LtjMxlLrDBFlFs74GefgM1f05/4UnGbrnfvm1XM=;
        b=ZvDwYGn8v/+dLjoO7L81ILFaDoWFVlqy9aOiY1lJH4XgHN8bBb4xAC1EGU5h1cQsA3
         9QyfySwzEvv+UTkLIjD/CRmJgEMJmBmWPFOfz1HlYzj8LDys/Mev47SoWAO9KlAPyAe+
         f+QS9bjOL9yNmxVIYljq00V+946ezqmY8c1gfRWNCDJTuxL8LSwHh/cLfHvoVQSsjLtT
         01wNPTMj+HBpNqiYbiz+u4YeEt1vREIM5HiQdIB0EF+XrYxhIyiGIpexWilQDzXs/xYM
         R+8f13gm0mthhtshOszwiPWarEBn5jhoHlRfxBrKz8VzUQOa9Sz2mNXTwS5rp2YuX/zE
         PCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PQt3LtjMxlLrDBFlFs74GefgM1f05/4UnGbrnfvm1XM=;
        b=unFVk25W9tNnMK7js7E9IZgqJHQZ8Kp69oibD+tQ9YCZhxnA8xUk6Q3FBfmX8teRtm
         nVKO73o4fl73+GwjL/ssNXQtXERLnw7biRbYfepMDaDtlCC95ZJjcn4A55bzYIJbMASf
         zuznZNk8tlCvycRjLykzk6BjIi3ziPIcNP/eSkLKfA9RNjgDJQNddIE1gfSWrnXH0P/I
         pLvGwg77UlnJqixz9P6fqOd7bt+Kvs+n/X3c56L73hIbOS6dxINTOcNH2r8k3B2Q6Vq7
         cEhuR2411H+31dbhz3e6QQxbW15CPWOybuVsQ6mAhirz9Y0s688D/gpUeZYu/yYGmFVb
         pPrw==
X-Gm-Message-State: AOAM530eOw1RDWdYsBIsdNAwmzEpPnaf3tdYiII8RhScE9KTKJNyjKvN
        U+A4ID56ONVmadIuLNWmAZAUAw==
X-Google-Smtp-Source: ABdhPJwjJlO4cbTnzNsRlUdHOJbTv1s8fCVOH2aV11htDPn2H1Y5QZ0qdo18qqoCuMygcevixcdP/g==
X-Received: by 2002:ac2:5f16:: with SMTP id 22mr173573lfq.207.1613086666766;
        Thu, 11 Feb 2021 15:37:46 -0800 (PST)
Received: from localhost.localdomain ([188.162.64.15])
        by smtp.gmail.com with ESMTPSA id b14sm763607lji.120.2021.02.11.15.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 15:37:46 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>, stable@vger.kernel.org
Subject: [PATCH] misc: fastrpc: restrict user apps from sending kernel RPC messages
Date:   Fri, 12 Feb 2021 02:37:44 +0300
Message-Id: <20210211233744.3348384-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Verify that user applications are not using the kernel RPC message
handle to restrict them from directly attaching to guest OS on the
remote subsystem. This is a port of CVE-2019-2308 fix.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Jonathan Marek <jonathan@marek.ca>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/misc/fastrpc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 815d01f785df..e7f3a22fdaa3 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -948,6 +948,11 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (!fl->cctx->rpdev)
 		return -EPIPE;
 
+	if (handle == FASTRPC_INIT_HANDLE && !kernel) {
+		dev_warn(fl->sctx->dev, "user app trying to send a kernel RPC message (%d)\n",  handle);
+		return -EPERM;
+	}
+
 	ctx = fastrpc_context_alloc(fl, kernel, sc, args);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
-- 
2.30.0

