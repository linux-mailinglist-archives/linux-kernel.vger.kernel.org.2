Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC7237F6B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbhEMLaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhEMLaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:30:15 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726DAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 04:29:06 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id m37so21055907pgb.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 04:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3e5v4xpnkSIXUPVBTFRMeaXzgMFdRaxBbtf5FiuvHJU=;
        b=HyYqjMT/ljXc7hZMpSLyjtsuNGZh2jsqXON7U/nS3LDGimuUjB8l2mSo7bMMaTe4va
         llgxNKJh/PwhA1G3VjY7n+os3OmHmpeTcMq+pitxRBd1CYUHxqq0UGmfYUe/iis22ukZ
         43p4DISxlRUntQ0DX41UZJSYeuOROkKldMST//mvE9s8h08cLBwFtYW8iL0U/UeBjBJ2
         t/HP0JIwwNtYnav1RXVXfqjC5Jgy1yGqPudWNK+YRFPL8j/I2nx98ErizyPEOt/lONJW
         W067NZeE/1ffUQKOpbPmbqAJVQ970kFuONwUCuE172cfcHlTTlKZKpwpUg8n9IQ4ponI
         Szlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3e5v4xpnkSIXUPVBTFRMeaXzgMFdRaxBbtf5FiuvHJU=;
        b=ZGvYTk8C7rChzLm9EvhY3scuMTAlvJVEYcbAxGuf982QEhavDt4FjtxGmMg/1F9rqy
         F3ko8/yMVaCRqodftB11WuJg1IFs7RSrIkAC96sdgo+G2t7XiHUw95Uy/3zdECH4pGOW
         RCBVX3RJRmudSByYjUu/7Yom7cjpo/0JSc5kmEG6NeZxs5qkHSd41fdcRnicVem8Bh9K
         QF1ZKYodIFpN8i7Fgx5yrvRuu8WkCCB7o7TAgxOKO7St45kr7MW3uOIf2tjZH/wYggUU
         0Dsizo9HkSWPazZIINXr9OHDVODWdnIZ1nvNwG6FAsVuo0za/rwtFe8rDM3OvuGfJ3qg
         t0Ow==
X-Gm-Message-State: AOAM531PGqmEw/Ufh2/iUGAOlI/5MMsbnXmEvFCdYMTeYOSPgRGBJ/6V
        9uzefarewBMtZovbxY+YTT1Miw==
X-Google-Smtp-Source: ABdhPJwXoqSbmvHmhg/EtteVGv0rfE1RDmx00kvLUmrUwmX+eFBzkQTr+WU74TcyMw7apb1YlpZ54g==
X-Received: by 2002:a17:90a:bc0c:: with SMTP id w12mr4536221pjr.213.1620905345995;
        Thu, 13 May 2021 04:29:05 -0700 (PDT)
Received: from localhost.localdomain ([223.236.157.188])
        by smtp.gmail.com with ESMTPSA id p9sm6768807pjb.32.2021.05.13.04.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 04:29:05 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     daniel.thompson@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 0/2] kdb code refactoring
Date:   Thu, 13 May 2021 16:58:40 +0530
Message-Id: <20210513112842.707103-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some more kdb code refactoring related to:
- Removal of redundant kdb_register_flags().
- Simplification of kdb defcmd macro logic.

Tested with kgdbtest on arm64, doesn't show any regressions.

Changes in v3:
- Split patch into 2 for ease of review.
- Get rid of kdb_register_flags() completely via switching all user to
  register pre-allocated kdb commands.

Changes in v2:
- Define new structs: kdb_macro_t and kdb_macro_cmd_t instead of
  modifying existing kdb command struct and struct kdb_subcmd.
- Reword commit message.

Sumit Garg (2):
  kdb: Get rid of redundant kdb_register_flags()
  kdb: Simplify kdb_defcmd macro logic

 include/linux/kdb.h            |  27 ++--
 kernel/debug/kdb/kdb_main.c    | 271 +++++++++++++--------------------
 kernel/debug/kdb/kdb_private.h |  13 --
 kernel/trace/trace_kdb.c       |  12 +-
 samples/kdb/kdb_hello.c        |  20 ++-
 5 files changed, 141 insertions(+), 202 deletions(-)

-- 
2.25.1

