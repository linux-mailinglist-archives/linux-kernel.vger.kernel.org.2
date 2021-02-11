Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE5031972E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 00:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhBKXxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 18:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhBKXuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:50:08 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EB9C0698C8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 15:46:46 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id m2so5071853pgq.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 15:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nWH3imbAeMw4n5RIWv9Jygevt+XepgJ5nBh82nrQrzU=;
        b=OsUt7nvVzjq1BmdRnvM0Ryju3WLLiLSgarJPlpzD0x4jyGi1rgG2Dth57tK5d5PltX
         BBXdHFgDZGzqkqeVy+teyQXKuSz+TWhYZDPUuflpgghbp8lhbB/SczBEnUUtr2le14/A
         t9SW0oYT9SOAnQhh5DKGyQ5/pfmxrYxHfNOfvqVaCrNHfnkFTqHE67UoFcdOA//BhyIY
         7Kiwbjcmnf2XrZrviU0YRaG5l7ocRaXq18bMVaH1O+d0T1YoN3gRWbDEK3JsxHIyuBOI
         CD738Gw4bs+Wl05rHHJkZYYwuNjh7f8WgcWP3WT80dYw7F7lKb3uzot+dzAWgF/KIGMv
         dM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWH3imbAeMw4n5RIWv9Jygevt+XepgJ5nBh82nrQrzU=;
        b=bGKXHk4yFrc3Ef3iuFheeFoxO8QtipJEfE75Wk4qFJ3B+JB45A7Wl2pphFP3sdAvlt
         KSFPahlwpXbfwAd6mwqu2Uamil6FzKeglw+CEoLg66FZLQ6P97Z4vvLryrPMse0AHp5B
         GJ0Djuh+ONPZG8VLT2Fk2UUHmY3vs8kud3ySbPU9HAIoIws1CbP/o8MoIV+XOJmQ7b5S
         m64Ga2Ty/a6ziDYHLAy7jRhDUjepi7ZM5eAPlZqFY+e1d2QMRT+tTgFZ1+6XEpdqM56l
         u8IbAG/PcP/G/R5c4xB675XrJ6maNstM6reOPINtKJgdh2Ogsp2rbs57ugMt/nJsGmpz
         xaSg==
X-Gm-Message-State: AOAM533M2WrDUkw7cZUpbyZfW1kAAetpNVXJJR4RITpjWHcXMDkuj3Tg
        uI0ZHqHPeZMIIFqcLIZBSWOHVg==
X-Google-Smtp-Source: ABdhPJwnNYdhLS3XOt7Ib9m7KFFkeV97pBzTsT0zQw7/rCXBb3/CMFfPL7ryBJyDR8iOzqBdCpHdSw==
X-Received: by 2002:a62:187:0:b029:1da:e323:a96b with SMTP id 129-20020a6201870000b02901dae323a96bmr386865pfb.28.1613087206129;
        Thu, 11 Feb 2021 15:46:46 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id iq6sm5932740pjb.6.2021.02.11.15.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 15:46:45 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        arnaud.pouliquen@st.com
Cc:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 17/19] remoteproc: Properly deal with a start request when attached
Date:   Thu, 11 Feb 2021 16:46:25 -0700
Message-Id: <20210211234627.2669674-18-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211234627.2669674-1-mathieu.poirier@linaro.org>
References: <20210211234627.2669674-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch takes into account scenarios where a remote processor
has been attached to when receiving a "start" command from sysfs.

As with the "running" case, the command can't be carried out if the
remote processor is already in operation.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_cdev.c  | 3 ++-
 drivers/remoteproc/remoteproc_sysfs.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
index d06f8d4919c7..61541bc7d26c 100644
--- a/drivers/remoteproc/remoteproc_cdev.c
+++ b/drivers/remoteproc/remoteproc_cdev.c
@@ -32,7 +32,8 @@ static ssize_t rproc_cdev_write(struct file *filp, const char __user *buf, size_
 		return -EFAULT;
 
 	if (!strncmp(cmd, "start", len)) {
-		if (rproc->state == RPROC_RUNNING)
+		if (rproc->state == RPROC_RUNNING ||
+		    rproc->state == RPROC_ATTACHED)
 			return -EBUSY;
 
 		ret = rproc_boot(rproc);
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 3696f2ccc785..7d281cfe3e03 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -194,7 +194,8 @@ static ssize_t state_store(struct device *dev,
 	int ret = 0;
 
 	if (sysfs_streq(buf, "start")) {
-		if (rproc->state == RPROC_RUNNING)
+		if (rproc->state == RPROC_RUNNING ||
+		    rproc->state == RPROC_ATTACHED)
 			return -EBUSY;
 
 		ret = rproc_boot(rproc);
-- 
2.25.1

