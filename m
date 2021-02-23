Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAB4323468
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 00:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbhBWXt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 18:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbhBWXhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:37:24 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AF8C061794
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:35:20 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 17so7537933pli.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=waytkFv28UuOXcaaNeh19CxfKAUzKWp03mnaFrOUKvo=;
        b=sufk6rE3/dXnMqzi78VzeEuWwNSyI9Jafh5/gweW9kamLR3HYQEs/qr0R2FCq+SpLV
         TUHEr6smwUpZYibTMKN+7V+oTpSBLajAf4fbj9gUmGw65vUbNqYScn9J+y3IXVaRdrlk
         o+YGaCC9XXt/0a3xDztIAps6TaKutwVtyv37jY6lnY0HlCHC6AcZ4+ivZJqp8WjfBJSc
         uJdJEQnEe6FC5u3mu4/GfQTxlCh1znYrjeWMHinbrt1vE1xJM1XfKZDN6XOCeiv5LUhi
         fHMpsUs5ArvPYM/UlxQjwiM92KTXDpbOcC4f4zRyqF3aNQP/NtJ9Y1cqQ4JK4nSO3555
         nPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=waytkFv28UuOXcaaNeh19CxfKAUzKWp03mnaFrOUKvo=;
        b=NaOoxH8wvqFS/gH0IVqCtlgscdJLgwrzlhhgdTjwwSEzA4pRQIh4q9GRZKRQqfdi0D
         3wHz2zv+x7vTzMQUhQocvrsboA9NzeRmv1fNFjd7504AZcmZLYZMjBGUBBYk0hZmebPv
         nlCxzWiiQgBS6LePc9GZXnqPW2i2+F1AOoXzME3MeByVwE0lFRHu+fFDy9ktpt/s3Cz+
         fyt31mcAFv5WcAfQ4UHlLPty9ZPhx6mEQM2wV8wkMzjUklGl3C21B6lvp2VG+j4Mp4Fl
         n3Ys+TV7ICdWzOQtXPEXTa9Ulnzwl23ulKHs2+W31lJ4+vEl/en164uHo6xMWTUPd3O9
         e/oA==
X-Gm-Message-State: AOAM533YIG9vvF9pJ0skbsqGq6oAALei5L0hxDMn3rgCwNvNhQW8QOwY
        DdZW58txpGm2VcPyygaUQaOe0A==
X-Google-Smtp-Source: ABdhPJyz53wXTScCJJHK+0zal+VXwSHeBnigEJ0IybsgF/8onQIB+fzZZu6AviRn5AHuVdwP6tT/6A==
X-Received: by 2002:a17:902:e993:b029:e4:1426:8e71 with SMTP id f19-20020a170902e993b02900e414268e71mr5806317plb.74.1614123320126;
        Tue, 23 Feb 2021 15:35:20 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c24sm311999pfd.11.2021.02.23.15.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 15:35:19 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        arnaud.pouliquen@st.com
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 03/16] remoteproc: Add new RPROC_ATTACHED state
Date:   Tue, 23 Feb 2021 16:35:02 -0700
Message-Id: <20210223233515.3468677-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223233515.3468677-1-mathieu.poirier@linaro.org>
References: <20210223233515.3468677-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new RPROC_ATTACHED state to take into account scenarios
where the remoteproc core needs to attach to a remote processor
that is booted by another entity.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_sysfs.c | 1 +
 include/linux/remoteproc.h            | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 1dbef895e65e..4b4aab0d4c4b 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -172,6 +172,7 @@ static const char * const rproc_state_string[] = {
 	[RPROC_RUNNING]		= "running",
 	[RPROC_CRASHED]		= "crashed",
 	[RPROC_DELETED]		= "deleted",
+	[RPROC_ATTACHED]	= "attached",
 	[RPROC_DETACHED]	= "detached",
 	[RPROC_LAST]		= "invalid",
 };
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index f28ee75d1005..b0a57ff73849 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -405,6 +405,8 @@ struct rproc_ops {
  * @RPROC_RUNNING:	device is up and running
  * @RPROC_CRASHED:	device has crashed; need to start recovery
  * @RPROC_DELETED:	device is deleted
+ * @RPROC_ATTACHED:	device has been booted by another entity and the core
+ *			has attached to it
  * @RPROC_DETACHED:	device has been booted by another entity and waiting
  *			for the core to attach to it
  * @RPROC_LAST:		just keep this one at the end
@@ -421,8 +423,9 @@ enum rproc_state {
 	RPROC_RUNNING	= 2,
 	RPROC_CRASHED	= 3,
 	RPROC_DELETED	= 4,
-	RPROC_DETACHED	= 5,
-	RPROC_LAST	= 6,
+	RPROC_ATTACHED	= 5,
+	RPROC_DETACHED	= 6,
+	RPROC_LAST	= 7,
 };
 
 /**
-- 
2.25.1

