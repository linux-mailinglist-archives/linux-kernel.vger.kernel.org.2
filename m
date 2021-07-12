Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400F63C5D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 15:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbhGLNta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 09:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbhGLNt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:49:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479C4C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:46:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id me13-20020a17090b17cdb0290173bac8b9c9so2235764pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 06:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hkyO8imEL0+DUAAtvz5beSJFhYFF7552OLN4p+89W8M=;
        b=wtuJcrv79psn5e7ySL+Uc5JkU75XGINeXdYj2rN07URLOREmnYlcnk558ONCarvXgm
         hAOoRDCp533iiso1JfUQ+Au1CsVBVTaDvskwsNVrNAcACJFBKeAX9mQSIp8PWp23MqEQ
         826Q42x3fUYBYPzxxjq8GcG+HYP1mzC7XrZgpJizWuHNLZAsrBPHDoHe5Ty2ExvhJmQ/
         pwKFzNx6QG224TLCWEi+dujOqyCfuRgW3DDzQrVSrl6w7+crS6tmu5mb/MLPLLGtxXi3
         nTWg8x0pGkJOVPP3jCQWoEWdGr4TPJP1aBHBGFbf67RBkWTp15KBPA35nw6J4FmpcMKl
         GJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hkyO8imEL0+DUAAtvz5beSJFhYFF7552OLN4p+89W8M=;
        b=RPNeyEDx62dvnVVUvsJG9imVcR3TKI6UDVeTsOzw9Sq5WYsDpysumJKPgee4DFD2Sx
         MkHvQKZ89nobOsYNi5qp7rI/DSaZqjIbE7+ag3TbXHao3W8wvXQgMRLlyHo/Rwxt1pSd
         JGGsNymZ85Ht81m3YplPiPjdmeUeBeGgcpSpoyjl5jHtkEEK2BHpjSqW7FfTMyYO0Um+
         7ZytXN60HafiFYecEiMC1gfICicQRuLzSbpbTO8zscNjv/a4CQ5GrUBDCAUfgZn0AfZc
         Aqq4/dhFXpgmwjiAIyhaMNKJ5nMjVtcAPRzsdXmaq3GYpHwcL9DEefajNHgLvYQs4vfk
         u0Mg==
X-Gm-Message-State: AOAM5338leX8cBxtK77BoyH4z4mYtW68+l/L6EMJPEMiduhDRw1L0L/9
        wy9mjcy+C3X6ilwWrv2YQfUcpQ==
X-Google-Smtp-Source: ABdhPJwNZFPUeOpgzYKGNZPF3XCdDIAoMhVO0IrZ4VfxWU1YxtO57hBU+lYfP2LHLvLxklhl0dVimw==
X-Received: by 2002:a17:90a:1704:: with SMTP id z4mr14617653pjd.213.1626097600772;
        Mon, 12 Jul 2021 06:46:40 -0700 (PDT)
Received: from localhost.localdomain ([223.178.210.84])
        by smtp.gmail.com with ESMTPSA id z13sm835405pfn.94.2021.07.12.06.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 06:46:40 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     daniel.thompson@linaro.org, jason.wessel@windriver.com,
        dianders@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 0/4] kdb code refactoring
Date:   Mon, 12 Jul 2021 19:16:16 +0530
Message-Id: <20210712134620.276667-1-sumit.garg@linaro.org>
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

Changes in v5:
- Incorporated minor comments from Doug.
- Added Doug's review tag.

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
  kdb: Rename struct defcmd_set to struct kdb_macro
  kdb: Get rid of redundant kdb_register_flags()
  kdb: Simplify kdb_defcmd macro logic
  kdb: Rename members of struct kdbtab_t

 include/linux/kdb.h            |  27 +-
 kernel/debug/kdb/kdb_bp.c      |  72 ++--
 kernel/debug/kdb/kdb_main.c    | 626 +++++++++++++++------------------
 kernel/debug/kdb/kdb_private.h |  13 -
 kernel/trace/trace_kdb.c       |  12 +-
 samples/kdb/kdb_hello.c        |  20 +-
 6 files changed, 357 insertions(+), 413 deletions(-)

-- 
2.25.1

