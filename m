Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28815379BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhEKAko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbhEKAkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:40:09 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B144C06138F
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:39:03 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q15so10289206pgg.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q3sRXTqmvNTkwzCcfbg+W/8e2QpKOzbCanuAM4oEImw=;
        b=I598oJEAvuviab8XWMvhr9ISs5W2haOF//A4qHYRX5xG7Y5prghqC7gdQt2UebPWVJ
         tKV3p2YsX+CHK++UJ77UOa4sSATvu0oqs03gB2GQ1f+zguUAd/heWbhoPoYPBj3sxfZ4
         NuQxGMDru4TK92BEXEYjnHs//ENcMIpQQAAIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q3sRXTqmvNTkwzCcfbg+W/8e2QpKOzbCanuAM4oEImw=;
        b=m3kLOtNNkoS144I62mGbhv3r8LJvzBbgjvvUBzJ0X89F2vNasG/IhBfGPlefee6Xz+
         WtDhupXhxvFJL3qbZlOaj83u5F4T7dNmA3BtytH67USirVcmm7whotEe1bxK3tb8tuj5
         ORQ1LcA+tYf0PHwVWboL496MHgGrfoi13xAbrMr8fUiDykpZm428pCAQuXfzDuVzOjVk
         V/b2NbirRBxi5gF5rl9NN0GfoEMz7ffOs7nwwb/g7fAn/saoAoerAipqu3x56Ztcab1V
         Xw3KBJSMXYUV0SuXyGwyEoz7rBDRx9v0mHA1Z6bf6ay1DQ0PBNZZKp6CsDvjVBAsshMJ
         KjvA==
X-Gm-Message-State: AOAM5339WP0Xy5ZJR3Ha1pbEteniZ5+J2iSjjGVGYXlowBQQ4fe633ej
        l2YIBUCZ1m2nbr8KCZPVLyuswQ==
X-Google-Smtp-Source: ABdhPJxfwpoiJCa9N/lAk/cJBZKWjHvzALJuKmUtcVotRupBwVK/0fy0OI3ThQ5gh0wJA+vCRC12ZQ==
X-Received: by 2002:a65:47c9:: with SMTP id f9mr28253258pgs.78.1620693542708;
        Mon, 10 May 2021 17:39:02 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:6765:417e:19fc:9756])
        by smtp.gmail.com with ESMTPSA id d26sm12142539pfq.215.2021.05.10.17.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 17:39:02 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v6 12/13] buildid: Fix kernel-doc notation
Date:   Mon, 10 May 2021 17:38:44 -0700
Message-Id: <20210511003845.2429846-13-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210511003845.2429846-1-swboyd@chromium.org>
References: <20210511003845.2429846-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel doc should use "Return:" instead of "Returns" to properly reflect
the return values.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Evan Green <evgreen@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 lib/buildid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index 8fe24d6c0925..180a1a9b3b76 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -121,7 +121,7 @@ static int get_build_id_64(const void *page_addr, unsigned char *build_id,
  * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
  * @size:     returns actual build id size in case of success
  *
- * Returns 0 on success, otherwise error (< 0).
+ * Return: 0 on success, -EINVAL otherwise
  */
 int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		   __u32 *size)
-- 
https://chromeos.dev

