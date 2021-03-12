Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5430C33934D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhCLQZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbhCLQZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:25:15 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC90EC061763
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:25:13 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id v14so9270547pgq.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NN7h66rSqKzczqrKUwACdy1DE0E9dT7gEJY334oVOV4=;
        b=DoxVu73kjDBB6G+GqFJuZWjDsELYStjGVY6plUBqlVW8SEESXd4UJfYhxlcENxplnE
         1xJ85jHSD+DESiciZ/whQ0v9aVsTsCxif+CUVhw+6qZFG+jZR077sQ2MC6+yzs8jYm31
         ceCUx/8XDTX9SftcjKYiPXuiIVKRII7oLCTjseZm5RvRVH4ZjhMNt8pl4Jox7SvI5Szv
         VZl1Qd3JBAMUkeeVCDFmYTofk0/nZ9zoYFwvlg2AxNilu/b0S5DrSjpUHHDxYYL9SRO8
         ACKowoV+UgnPTI3nFETwbDA6ejSXNodP39T2sI31UwvblMk4PXFPZdssJYX+pYx8/oAg
         t7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NN7h66rSqKzczqrKUwACdy1DE0E9dT7gEJY334oVOV4=;
        b=Y5iOnLfWdDEYtffwKnGN6xADtbvo0sgTUcaAolTcp9Q6Gg0nS3plBfC9R/hdejc4Cl
         e8UOkOUZN+TxNPCh5mmYG6ZBfPVQD5swTYBVthEqt6sKmpP8peepSOoY7Cw+CT7KIdXt
         pKoFR20BubY+R9JT4L0dOyiv+yWvsPbB038mfkL3Gg4W+FyPGRpjcQw1T7K9t/38dcZH
         auCiyb938iqFFyNONF8Gz63eLuVDuDMGcOrYSligs7x51DBrXJUB6SeKWdBumeLgXx5W
         seKWiMFdzvEy0r1NDuUUynqMa3QU78o7yyuunKPjG7oCNwAgwj6L0fLr+TGMQhT8gmTk
         tgUg==
X-Gm-Message-State: AOAM531F+cnOVOALi3SfR2J83zsRYb1r2DK3LNIl72QJyCwKTYo2IlFL
        ugMn0ssVbeCWYkruYdZENriewg==
X-Google-Smtp-Source: ABdhPJzPJ7a7B2gKd7mX/cHBrA1bcydfqcm9yX2BF56Hal2O0TDosxxZI3SuKPX6uNk5f41tojh1pQ==
X-Received: by 2002:a63:db57:: with SMTP id x23mr12394765pgi.432.1615566313341;
        Fri, 12 Mar 2021 08:25:13 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e8sm5899599pgb.35.2021.03.12.08.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 08:25:13 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 16/17] remoteproc: Properly deal with a detach request when attached
Date:   Fri, 12 Mar 2021 09:24:52 -0700
Message-Id: <20210312162453.1234145-17-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
References: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the capability to detach a remote processor
that has been attached to by the remoteproc core.  For that to happen
a rproc::ops::detach() operation needs to be available.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_cdev.c  | 5 +++++
 drivers/remoteproc/remoteproc_sysfs.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
index 0249d8f6c3f8..2db494816d5f 100644
--- a/drivers/remoteproc/remoteproc_cdev.c
+++ b/drivers/remoteproc/remoteproc_cdev.c
@@ -43,6 +43,11 @@ static ssize_t rproc_cdev_write(struct file *filp, const char __user *buf, size_
 			return -EINVAL;
 
 		rproc_shutdown(rproc);
+	} else if (!strncmp(cmd, "detach", len)) {
+		if (rproc->state != RPROC_ATTACHED)
+			return -EINVAL;
+
+		ret = rproc_detach(rproc);
 	} else {
 		dev_err(&rproc->dev, "Unrecognized option\n");
 		ret = -EINVAL;
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 09eb700c5e7e..ad3dd208024c 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -207,6 +207,11 @@ static ssize_t state_store(struct device *dev,
 			return -EINVAL;
 
 		rproc_shutdown(rproc);
+	} else if (sysfs_streq(buf, "detach")) {
+		if (rproc->state != RPROC_ATTACHED)
+			return -EINVAL;
+
+		ret = rproc_detach(rproc);
 	} else {
 		dev_err(&rproc->dev, "Unrecognised option: %s\n", buf);
 		ret = -EINVAL;
-- 
2.25.1

