Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7883234AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 01:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhBXAkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 19:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbhBWXr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:47:56 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B49C0611C1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:35:30 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id g4so245037pgj.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70JCEwLX10Z8DU4ByYhqbD5Bs/NYPpdr+UeUH0EROyg=;
        b=N88XbmgPFY0tBL+nREjZof5xI3M2ZNmAG8U2gcExz3QoFVbxPON6BETexyL4v5/axT
         NMvkJeeyOx/gXRHMZKTpGuV2CrN/cYTde9bOUTYNlrOjcwrROSGin9JWiFSbNskLAG2z
         g+n7hzn5LtTJ7SWRABd+hnyBF3rWONLrJt9/7b0Re0SjI7kMF6ZyzXqUy2yKiZMcQ+uo
         Mc9wgFqCHhAppyFeuJUW0XqXLG7V0xqTJK/wGe2WhfK1rz0qK/tFwQtV4Ztf2EmJebmD
         pmDFdOS8mCjz1F3UaEbjiH85CTJSMNxEU/xeioeWcY93f5WYGMqhvmsCWH5t4dnMVGir
         LBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70JCEwLX10Z8DU4ByYhqbD5Bs/NYPpdr+UeUH0EROyg=;
        b=VtBrOm7x+ewTxp7s7dYTvpz491AWzadZllCgtk7lXRcn1eNR5OOjr3OCXwS4iKizzD
         o4XSGCIo2/U+njMckyyVbg2KP4z6vPBHIbjm1o1Vn2wNVhfYT1/61PJsqabm+QV4zjIk
         JLoLL0a08dOKWJW7ey5mo4MMGp1JThNgZmG7XFu9x8Kx6yVRkJQ2SnrxniSg7+KiAVIf
         ZcSSAbY8SuK8EJpBoxpQf0fe1V3uvwyg3HDY0mIAnJEZOAVSHnOturs4bCJ5dIODJki/
         4HwpzUk0pR5vTlBT4Yr5m7jqE3pcT88DuZKLSOMy4CC/oaHBGoAzxZXG3hqDwB6r8OjS
         +IOQ==
X-Gm-Message-State: AOAM533AQk/wQrYgxVvVw/0kmB7YdME4pHf7/8/EUiU6GjEbcq30dT62
        vMrRq3Ezd/v8AOV/fKMpC41xow==
X-Google-Smtp-Source: ABdhPJxktytv7llBIEju6a5H8h+Ul5Vrj9GmHcU8b1aSOP67/rAzaK7GrW6MDJiRmAWPqcQkjT+Qlw==
X-Received: by 2002:a63:a22:: with SMTP id 34mr23087036pgk.328.1614123329746;
        Tue, 23 Feb 2021 15:35:29 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c24sm311999pfd.11.2021.02.23.15.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 15:35:29 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        arnaud.pouliquen@st.com
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 12/16] remoteproc: Properly deal with a kernel panic when attached
Date:   Tue, 23 Feb 2021 16:35:11 -0700
Message-Id: <20210223233515.3468677-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223233515.3468677-1-mathieu.poirier@linaro.org>
References: <20210223233515.3468677-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panic handler operation of registered remote processors
should also be called when remote processors have been
attached to.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 3a4692cc5220..0dc518a24104 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2684,7 +2684,11 @@ static int rproc_panic_handler(struct notifier_block *nb, unsigned long event,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(rproc, &rproc_list, node) {
-		if (!rproc->ops->panic || rproc->state != RPROC_RUNNING)
+		if (!rproc->ops->panic)
+			continue;
+
+		if (rproc->state != RPROC_RUNNING &&
+		    rproc->state != RPROC_ATTACHED)
 			continue;
 
 		d = rproc->ops->panic(rproc);
-- 
2.25.1

