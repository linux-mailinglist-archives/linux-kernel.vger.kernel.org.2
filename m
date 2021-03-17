Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3433E79E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCQD2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhCQD15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:27:57 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FD3C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 20:27:57 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id 94so498657qtc.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 20:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z6YHn7PgxLzL3I3VK9F08ynewYnQsR6Oz4SywKd9CQk=;
        b=amm8W4VaU3LOO+9GLaoDjrBPIyRKThbqaUEyZmUKyD6tkxPDZeNvmpJc0nBTE9VuKw
         osc9h8zsQrqC/sMnA6HEy1EBXf4CFe4MhssSWxXL9NEF+SEQ2fPJAOaE9iXMkOX6NmWD
         BZSyw72AHbHsL7x7HNwFJRoli6kcGxAFAez4jfww32U3iM5X+MYc7t6ioF3v2k+pGhSK
         WiquRAc1rDrGkTaC0stn0iuhm5bSsNZBTXSkdDD0rlKzelQFthjc4kTKvlv1g3iwEDlJ
         vrCE7XvU0SkQ3FZgKTQIdkQNe9kY72FiOMQKCMvoTqigf3rlt0kzXmwEV7m0+V0Xa166
         WG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z6YHn7PgxLzL3I3VK9F08ynewYnQsR6Oz4SywKd9CQk=;
        b=bnCIkJUvh+k3jzbC2NrJD5XoHsJKa02IlnT44OdKtfFFJEbs/p1rKfV9gtDKFqJH0K
         jgxzlCE96Qku8o1sH3XJ7ylZeYAqxh0WDmSGjmfYLPjoQvgMqS1JcT9RmpYSTGJAXGft
         /SNfWeGBV2ChOFqsxBXGv7K5eYnxTte9yOMOuQmP8ayV9s2VHZnV2kqtovSMAtWULOsX
         MP5Kwd6l6U1Cf364Ht1po+mHTZGOFRMfarg+jbzqziJ8RJx0eSnNiaVbtHcKHsYFhNlI
         v+SuBbB0BFTUYlkdnPhHQFCmqOWQiRo877l1uAxyqvBiyPVMdk/1y59S6jUbWBcLsCCV
         DexQ==
X-Gm-Message-State: AOAM530GJgwo+2DQPjrZs8wmsN9bG0uZtl178VpI9lPCEbf71sMc0kc+
        k0F4l5kcNsJhWfhyF0ym9Q0=
X-Google-Smtp-Source: ABdhPJxb2CzeI8NbChzHL/1YNjM5ovnWqCFxdejghF5ctyxEDbuzJ2cC/aUtWbi5JKONSeg1itkJtg==
X-Received: by 2002:ac8:5396:: with SMTP id x22mr2060159qtp.200.1615951676051;
        Tue, 16 Mar 2021 20:27:56 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.5])
        by smtp.gmail.com with ESMTPSA id c5sm16949857qkg.105.2021.03.16.20.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 20:27:55 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] kernel: Fix a typo in the file up.c
Date:   Wed, 17 Mar 2021 08:57:32 +0530
Message-Id: <20210317032732.3260835-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/condtions/conditions/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Adding Andrew in the to list, becasue this file has no maintainer attached

 kernel/up.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/up.c b/kernel/up.c
index c6f323dcd45b..1b9b135e77dd 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -67,7 +67,7 @@ EXPORT_SYMBOL(on_each_cpu_mask);

 /*
  * Preemption is disabled here to make sure the cond_func is called under the
- * same condtions in UP and SMP.
+ * same conditions in UP and SMP.
  */
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 			   void *info, bool wait, const struct cpumask *mask)
--
2.30.2

