Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD3D3C226E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhGIKq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhGIKqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:46:25 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698F4C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 03:43:42 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id p17so4262415plf.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 03:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e2xtCVXf4qFyJO09lCUbN2X8PkUmLUwY+9c820BNHvM=;
        b=mD/5FkGeY8CC+sRbePxQr3O7Qe3khAYm+b1XWsKJAAB2bWOVa481+u5P9oPGhnb+zf
         LYREjSnrGtQclutvHcpOSgUo7/RjpZCxDzjHm/WCKGwZlkHc7yqvhvHZ4VgDnFxd8idG
         kodE5ChALW+5jILMqQqcoI84DsDJVq9arPjIA4gAxald74TIq7+9Oj8+2UBiAGoPJ0TU
         Hz6cmVGba1BfLpQNQ9i6ucdhXJkXqmrm0R+jkPRXYSTHz8CMIVMppSeysEl/De8sQXPA
         duc3HUAqpPS3oFXqFni+FT8x4FDL8CvZgS3EA6D1lDCyk7Be594fkK2rlpuRDJdKfi9t
         XBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e2xtCVXf4qFyJO09lCUbN2X8PkUmLUwY+9c820BNHvM=;
        b=bG0/D4XGtp2C/ttVrqTVONCfRxEuLzCnKdEV6voX0zJS7H+9uj5HbvvuvTZLXhgwO4
         VPzIDPhZjRNnS57A2k19d1Y7+czJxRGNXvwH4dgJzax1lSwUTI/KZoGARy3fMxYAosAq
         C1ZJ23H1cSTyt9OPRok2n+sXmuQDakpo96LewvFu2x6o7ByjVeg0jXyOu+2EZxJA0x7n
         IPGJaBViS31wNmLU8VW6S7Q5f65df2qXQax0FhZvs1rubyST3eBZe7FLn6pQvxjDzEjk
         FVj4euPwbQkwQWknY/Nk3xkgPmIxJchtGTLTaJekGflIXE9Dk4k+QwPGuedheB2UQTaq
         6V+g==
X-Gm-Message-State: AOAM532V7QQLMr9Tqtcujcve3CC6iDWtw5P/bPTG8FdChg5MP68FgVCa
        JTRYikFdvSqijqPU01rUsZETuA==
X-Google-Smtp-Source: ABdhPJz+XsbromyvKZFDZvlwaF5UYmGcijoRhGNPzYLjV+CAP2c9o7lavKGRM7A8pKg/aw2plRsc6A==
X-Received: by 2002:a17:903:22c4:b029:129:8878:f872 with SMTP id y4-20020a17090322c4b02901298878f872mr23264090plg.74.1625827421831;
        Fri, 09 Jul 2021 03:43:41 -0700 (PDT)
Received: from localhost.localdomain ([223.178.210.84])
        by smtp.gmail.com with ESMTPSA id 1sm17479pfv.138.2021.07.09.03.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 03:43:39 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     daniel.thompson@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 0/4] kdb code refactoring
Date:   Fri,  9 Jul 2021 16:13:16 +0530
Message-Id: <20210709104320.101568-1-sumit.garg@linaro.org>
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

Changes in v4:
- Split rename of "defcmd_set" to "kdb_macro" as a separate patch.
- Incorporated misc. comments from Doug.
- Added a patch that removes redundant prefix "cmd_" from name of
  members of struct kdbtab_t.

Changes in v3:
- Split patch into 2 for ease of review.
- Get rid of kdb_register_flags() completely via switching all user to
  register pre-allocated kdb commands.

Changes in v2:
- Define new structs: kdb_macro_t and kdb_macro_cmd_t instead of
  modifying existing kdb command struct and struct kdb_subcmd.
- Reword commit message.

Sumit Garg (4):
  kdb: Rename struct defcmd_set to struct kdb_macro_t
  kdb: Get rid of redundant kdb_register_flags()
  kdb: Simplify kdb_defcmd macro logic
  kdb: Rename members of struct kdbtab_t

 include/linux/kdb.h            |  27 +-
 kernel/debug/kdb/kdb_bp.c      |  72 ++--
 kernel/debug/kdb/kdb_main.c    | 628 +++++++++++++++------------------
 kernel/debug/kdb/kdb_private.h |  13 -
 kernel/trace/trace_kdb.c       |  12 +-
 samples/kdb/kdb_hello.c        |  20 +-
 6 files changed, 359 insertions(+), 413 deletions(-)

-- 
2.25.1

