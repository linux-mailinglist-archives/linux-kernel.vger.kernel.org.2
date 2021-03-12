Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FB0338C82
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCLMQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbhCLMQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:16:57 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D472C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:16:57 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id k68so17955499qke.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 04:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lKkSFyfUt4v/K1TZ3S0RPtMBMYYMM41WrxOgRZxr+i0=;
        b=gJGZNvjry+gw1+ZgyiRQ62ujkPUEFw4uDzOqg2hLxaDjdAvqKra4PKwRCgzEiVdu9k
         Wf8LlSX/3iIXYKXA1uPrYqvSsxBI0HZ3mDMoaV6UYUNLjFJcH6G64+HGPUsr8SI0iipK
         lg+6Irj5THH86N+UMxsJ/KjukjGqtq4xgSPK3rFzt2DBW5J5mEo7dIXSTvj8P6xTcqTu
         4m01AufPnzboMGl8zVMDot71KxcBkzGJunAp6KSFr+qWxAulb1h2C3d+1Au44nkqVzLs
         x5F7kOWaNacpNawAPZ4E0hEXArNVaAj3d3vJEijJ3zfvw3fF7psXOldcwIp8edAZR8mG
         pDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lKkSFyfUt4v/K1TZ3S0RPtMBMYYMM41WrxOgRZxr+i0=;
        b=tItlQ3kf/1IsMouumjSUD3l1PttHmA+1uT1qI18MQ/9tAGgD3qny5pANqraNIFjBMt
         oPG9mo2Q39VvdE69ZN1nRwJc9gnXwIWYtSXMCcSXnJOn0EUHEuVXnePymhII433PNQx/
         ZxJ+L1ORxo2w4D+Y0DQeutBgZTxUBeK7P9OTgUzkRFod8mYXydcDvJCShz+lBp/WswFd
         zYCdhncf4JIqR9TGA+nxzzQRFMYIU3Mj1N9K/jQkXeRrRExkM+BvaYh8BPoT4h4OKhJK
         y4m4mtT4SIuAQD/wI9wbwnxB9+n37+pNE4iaByf8z0P5V4sPBObZj1mCtVnrq6D1Zt1d
         Cq3g==
X-Gm-Message-State: AOAM530uzNY9M3XoWRdoNfJPhA5GwPljDaeBHrz+d1tPLyZrPU+t3Dj9
        cVs1WbOkDBwfjxbchGYlC8+wIZdqBw==
X-Google-Smtp-Source: ABdhPJyvBuVMaYATBlEOlMHkInkkY8IVbtesmiJENmvpJ0bX2KRyf5zY9q6eiq0WVw9Noi4r0ZWGaaAxyQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:d5de:d45f:f79c:cb62])
 (user=elver job=sendgmr) by 2002:a05:6214:80a:: with SMTP id
 df10mr12249434qvb.46.1615551416493; Fri, 12 Mar 2021 04:16:56 -0800 (PST)
Date:   Fri, 12 Mar 2021 13:16:53 +0100
Message-Id: <20210312121653.348518-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH mm] kfence: zero guard page after out-of-bounds access
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com, andreyknvl@google.com,
        jannh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After an out-of-bounds accesses, zero the guard page before
re-protecting in kfence_guarded_free(). On one hand this helps make the
failure mode of subsequent out-of-bounds accesses more deterministic,
but could also prevent certain information leaks.

Signed-off-by: Marco Elver <elver@google.com>
---
 mm/kfence/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 3b8ec938470a..f7106f28443d 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -371,6 +371,7 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
 
 	/* Restore page protection if there was an OOB access. */
 	if (meta->unprotected_page) {
+		memzero_explicit((void *)ALIGN_DOWN(meta->unprotected_page, PAGE_SIZE), PAGE_SIZE);
 		kfence_protect(meta->unprotected_page);
 		meta->unprotected_page = 0;
 	}
-- 
2.31.0.rc2.261.g7f71774620-goog

