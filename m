Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B8D38DAD8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 12:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhEWKSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 06:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhEWKSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 06:18:08 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FD3C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 03:16:42 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d16so18411301pfn.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 03:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=31DBJJ1z58vC5ZTZzHfaaU4CsnbQ5Khf5YVhuvkNOlw=;
        b=KJPgCwMvecNuHKeDYgSNhOR65AMTHaBxZm6XCRaybnfTLim4Wr4uccBaqwh7KzpNjr
         6iCf6co+DXPndnfCWeIjvvWOSpsccWXOQ4Q3kflTaGgHvsr1lkJmTNztnwHIku2BLT7r
         q4W3k+QjouudAn7IFo07mJWmlszydPlJkIhTmtW5JDp/A95wll92BILji8ps9wsFbnqe
         V1py+TGIRM/hsuHu9n/Ud6hQp4DXT155JhSTl+b4hFnXxLfcb20vrdqH1Kz/C8zcTWXM
         hwYkv7Cw9vJVPnKVeMULGRzuvy5I+GZZ0P/myyIVXEcA5tmMuX5uwfg/wivjbyfmiWUA
         EpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=31DBJJ1z58vC5ZTZzHfaaU4CsnbQ5Khf5YVhuvkNOlw=;
        b=HORaE8eZ5IJJVMbppRkpYY5sid5rfwAhXAH73lLyStKO/z+/ILZNVLB/KTc5F1cuLp
         EkW3W2v8ZP9ySI5T6KlHIpsP+hDEyKbR//oGYcjLyaTDwK515w2F8c0FwjAChJQ12oqB
         Eag8tGVWJOG2t8M/6XhHhIbsw25P+10/LQckDxOfWv4bRyndyINqZsukVTS3eZiECnSC
         fIgQUvR8rxKPgAu2Ne3QCqFogBAF3bjvzj8gJwvCTlqSLe100xG+2j4zXdW2jXApM5Ml
         6XbeSIDeefyxCF2S+KI+5ZeSnOvczyOxY0/qocBLCokxFaanNsS0EhCuYlDZVAK5/5aH
         3kbA==
X-Gm-Message-State: AOAM532ESNuXU9cChoseZuTgSbPUT0J1uSbchPUkLW/iKCwn3G8/H7x7
        hyR7/YeZssGJMxDWM9Hsteg=
X-Google-Smtp-Source: ABdhPJzDAjQ057vD+ZMvxZDKeV/o4Nh427ZrMFPO0Ge/zO6FevJgYqyueq1Xi6uEts4nmY150BcQgQ==
X-Received: by 2002:a05:6a00:706:b029:217:9e8d:f9cc with SMTP id 6-20020a056a000706b02902179e8df9ccmr19385684pfl.1.1621765001930;
        Sun, 23 May 2021 03:16:41 -0700 (PDT)
Received: from localhost ([52.175.62.71])
        by smtp.gmail.com with ESMTPSA id v2sm683145pfn.179.2021.05.23.03.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 03:16:41 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] uprobes: Update __uprobe_register() kernel-doc comment
Date:   Sun, 23 May 2021 10:16:35 +0000
Message-Id: <20210523101635.142108-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 1cc33161a83d ("uprobes: Support SDT markers having reference
count (semaphore)") added the parameter @ref_ctr_offset.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/events/uprobes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6addc9780319..3f02850d903e 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1123,6 +1123,7 @@ EXPORT_SYMBOL_GPL(uprobe_unregister);
  * __uprobe_register - register a probe
  * @inode: the file in which the probe has to be placed.
  * @offset: offset from the start of the file.
+ * @ref_ctr_offset: reference counter offset from the start of the file.
  * @uc: information on howto handle the probe..
  *
  * Apart from the access refcount, __uprobe_register() takes a creation
-- 
2.25.1

