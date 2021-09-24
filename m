Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E507416E67
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 11:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245068AbhIXJCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 05:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244842AbhIXJCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:02:31 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E4EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 02:00:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so9128690pjc.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 02:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=rtm9O188bYJTXAJCaUyfIBjj0pjGNgOqheOvrJrI9tk=;
        b=lvFYrZVbZlp1bN6RnInTm6ziEKqq7ItFMIuBdQHvJRgFfwWGaYL34rTEhPXsaq/2yR
         l2PpX6T9NZ87mJkBGaYiON+HMugZByd8+AO7wyznB3RT92HI4w123r0HvC+1Urx+Twaz
         maiIGA5Uod5omyFqqPffL2x2AInN6xPdojjgc3J1AHkNPTK8TqDBYhP9A+A62KJEgKF6
         byGoUi43LEflQEYUXtreH7qU2hLTcVynSTIcpkqyExVKdPTo2c7LIO5IT1be4aD0wjO2
         e/FaaoZWCuloH/OERMBxPR2NxXYWo7PnCjwyEbzRLNfiosFXKV1jLjojHyeFPezngMyl
         uUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rtm9O188bYJTXAJCaUyfIBjj0pjGNgOqheOvrJrI9tk=;
        b=We3i100JYzarX9tROlN595wf7GatIeQsXhH37gerTDoKfsAvT/AZ7M5U8AEEDw3ls7
         INJ1Q4c8HN2r9xTjTORL30EYa4pqNOx2tGqfjjkX2x4GK3aBsFixjlnyGidbxnvCWphC
         kQl7mgnm+ho6wPLjyt13CrV+1v3oX2LY6Bp6mKpdi+e951/4CwQiraUhkHC0lLK0Zf8g
         fR0/CofhzLSsMABD7yHxyyfw/2CCYkngIBw0uZPW768Oi9b6ICIfHUMOqqq2TEX2kOjY
         MX7C8u8sw9ewUUpF1XNgR33PquJs06J6D3zkBCnhVe35FLVLVU1OLoiTqRsZRscl79q6
         +syA==
X-Gm-Message-State: AOAM530dwNIYU0iw87hHJDE+H0eu82xfcGRYUnkQsUkSY7xMTFFz84Pe
        ZpnYASes2SMxcq1zbebsi3M=
X-Google-Smtp-Source: ABdhPJzKrPpJLobuDwW7KJS1Z8LKF9HCXbVcRKUGWNpmmsxHY4w+FG8NeXcf8TXg3Rxb3PnxNjMDog==
X-Received: by 2002:a17:902:8494:b0:13b:9365:6f12 with SMTP id c20-20020a170902849400b0013b93656f12mr7962131plo.19.1632474057985;
        Fri, 24 Sep 2021 02:00:57 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b142sm8501848pfb.17.2021.09.24.02.00.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Sep 2021 02:00:57 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     nianfu.bai@unisoc.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] pstore/zone: Remove redundant check for total size
Date:   Fri, 24 Sep 2021 16:59:20 +0800
Message-Id: <1632473962-29686-1-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

The macro check_size contains 4096 size check for total size.

check_size(total_size, 4096)

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 fs/pstore/zone.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 7c8f8fe..93a770c 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -1295,10 +1295,6 @@ int register_pstore_zone(struct pstore_zone_info *info)
 	int err = -EINVAL;
 	struct psz_context *cxt = &pstore_zone_cxt;
 
-	if (info->total_size < 4096) {
-		pr_warn("total_size must be >= 4096\n");
-		return -EINVAL;
-	}
 	if (info->total_size > SZ_128M) {
 		pr_warn("capping size to 128MiB\n");
 		info->total_size = SZ_128M;
-- 
1.9.1

