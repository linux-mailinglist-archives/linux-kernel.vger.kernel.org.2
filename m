Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA7C3FFF32
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 13:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349277AbhICLaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 07:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349210AbhICLaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 07:30:12 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66CFC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 04:29:12 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r2so5224952pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 04:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=rtm9O188bYJTXAJCaUyfIBjj0pjGNgOqheOvrJrI9tk=;
        b=IxVNcxeVisw2b4Jb/ZmKzSRvIuinCHKFycphs5w+Aj6yJFRHAqGOFbrVCh+Y25VR+F
         k0WQlnkKnpQhblp+fRYPgutaTbumeXUbQ1mZjsI+E0Np1DKhFRoyyMsqpVIM4DseDLDI
         5KXVP8wTAWSRwrhC5Sl/fe/tgspUZ9dwYfKgVIelMwUIMR9cGj2smVDaIfIWVtsHsd/E
         v2d7DmAQtyTHDuTqCjlTSoNjhMplLbdpQlPCm9jShvndnaxTtExlw86thhU3HX9XnaZU
         lXvbI7LycEQJ2zFoQ8iVKCpvpWqf6nv5FdSEwZQHIk/EH5Ge+PHVqnWyPfPK66C3e0C9
         SDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rtm9O188bYJTXAJCaUyfIBjj0pjGNgOqheOvrJrI9tk=;
        b=Uc4/cvu1ys+x+W0TzCQAUZFx/vmqBbd9qWb89UfC58FdmkMQdMvx6LySREB/e8po+w
         MkyOhmy2gWsH2ThHdQmJEKK0re8dr2c/+lNBreryjP2jFlcDlQ1mEfU92lquPyHAHzaq
         CLkhDfiFzVPlIHDaOQ2GeDrwPDNoR8csNyj6CelVx5N0jpsXQZ0o5mcj1BCai/w8Hhr9
         TYOA3nCemVKS+7/DYqpDSwbruXIdMVhf+IVGxwwwfxLjCZJeGokuEHXnA9HDIQuAs8w6
         7R2D5J6hNt2uzyzYgoany2X6R/WBAz5UEHUbf7vvH1yLj/VOELvXDeEXm4OA0citryOc
         l+7A==
X-Gm-Message-State: AOAM530XEppJbia2jLbgYEUHqdphEp2+/7zTuAiBq42GeHwy3L7rP8BD
        8bG9bWu5VpU/bl5muNpqLZaBxUup25F+1w==
X-Google-Smtp-Source: ABdhPJx0m8mPv5pwCkiMchwE3AsSUnbwumrPyuOP/z9FSE452sLf3LTmYW0yS1ceMZjD/B1EjVObtQ==
X-Received: by 2002:a63:1d5c:: with SMTP id d28mr3120432pgm.143.1630668552460;
        Fri, 03 Sep 2021 04:29:12 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j14sm5023847pjg.29.2021.09.03.04.29.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Sep 2021 04:29:12 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     nianfu.bai@unisoc.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] pstore/zone: Remove redundant check for total size
Date:   Fri,  3 Sep 2021 19:27:40 +0800
Message-Id: <1630668462-24527-1-git-send-email-zhenguo6858@gmail.com>
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

