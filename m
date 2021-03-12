Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46318338872
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhCLJSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbhCLJRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:17:33 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401B7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:17:33 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id u7so3239225qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:mime-version:date:message-id;
        bh=ECNP794vd/MqltNp2Xg1xMd6ACxG0sB1oY12VAH2vHU=;
        b=V/wWzHU1hT9jBhi9t484erOHog2VFbPMLaoOOY5XGCGy3gB169QpYK3c1TRiTRqSPf
         DPRY6eSqGSGKEDH0kjaZ0W1yw9he4LD/Yrgt7jTHNwzohT5LMgpvZa1BorugnE+xKwon
         BVqreFmioVKya2H+155oyoputkKQl0ASuftZOrYCEEgzL8ryQUfX00hwKKpnMYDjllwh
         mJqD7FYTVIYSx1q6lZdNlkmlDJBXqVaQk/7nR8KcbzLWYwX1Ae+SlTM+Jj8Iku7+Un/q
         P2fH0Ocdp4hTqcEOlNUp4I2W504psLLmSdTqZq+0XvvLvzaIaDxH+ieT7de/kiN1CHKm
         Omyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=ECNP794vd/MqltNp2Xg1xMd6ACxG0sB1oY12VAH2vHU=;
        b=XgrgSQyljR9I7oqggewPUBZebyif5b9YL3lbPY2hSK3PXENBLUxuKC4juVydVxAKU+
         77wbSLgDuwDCLUL6EhC1/ieM0uKhVnrr3S4BmXxXtMiSxCyL5+CxUO+KCTU4xfR3+lT1
         qjfIrxCYUllIJwbhm6xBsmeyoSj64K1tA3Affeq9X4EfaHbHsLSNk0RWaAxQauvZLAHB
         KPYYHtMfxkTviAKva1/qfcwEIQa9nMBYicqzZLQbHtbRVkWRDmORQbrvvH6tOGEPTNQh
         nSRKdp3MZsf2rL3xx2Dp4MNRxokjGk8M9cBt3WyrJEQAg2If4JBSMJhj3HOizIEtlkAf
         FiiQ==
X-Gm-Message-State: AOAM531VDTwj400Z+aZw8UH+/G5GTxeWURZqAXhPXLUnhvl5AK1qaM81
        QiT6Cax0h4nWJw55hxHJNMyFfw==
X-Google-Smtp-Source: ABdhPJwWaXqCxHEPAWJAT0KOTrRahWktwjM6wPwdOLs5kbgTHCi5aaryXcQLnmvBhHKA9k8sqHrKVg==
X-Received: by 2002:ac8:6892:: with SMTP id m18mr10802240qtq.5.1615540652417;
        Fri, 12 Mar 2021 01:17:32 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id t188sm3963922qke.91.2021.03.12.01.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:17:32 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: Fix sparse warnings in adreno-smmu-priv.h
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Fri, 12 Mar 2021 04:17:31 -0500
Message-ID: <160589.1615540651@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse throws 27 complaints of the form:
  CHECK   /usr/src/linux-next/drivers/gpu/drm/msm/msm_perf.c
/usr/src/linux-next/drivers/gpu/drm/msm/msm_perf.c: note: in included file (through /usr/src/linux-next/drivers/gpu/drm/msm/msm_gpu.h):
/usr/src/linux-next/include/linux/adreno-smmu-priv.h:36:33: warning: no newline at end of file

Give it the missing newline...

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu-priv.h
index a889f28afb42..977e7c3a21e6 100644
--- a/include/linux/adreno-smmu-priv.h
+++ b/include/linux/adreno-smmu-priv.h
@@ -33,4 +33,4 @@ struct adreno_smmu_priv {
     int (*set_ttbr0_cfg)(const void *cookie, const struct io_pgtable_cfg *cfg);
 };
 
-#endif /* __ADRENO_SMMU_PRIV_H */
\ No newline at end of file
+#endif /* __ADRENO_SMMU_PRIV_H */

