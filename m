Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EBC43DF01
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 12:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhJ1KiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 06:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhJ1KiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 06:38:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D00C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:35:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u18so9321591wrg.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 03:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QAaMfHwdtZJ2KjW1qioIa8NnTSpvgBhACsmEL5jElvA=;
        b=SrXsuaZwEiK6GtpGMoXABWAl6voqIoao+Yq95iMx4d1OyRMCXPtTxr0n9gAnl2oMmN
         7tBxoWyyTRWngHQuEAbaBbTi4pF2oH1CV7w+HS9q7XebDP15brABt9MDshafkqWdOaKc
         uL68FjAKJMpKT21DQOV1JAsaxynQQ9HrT2Sbs/OgBQbID89OYM90wAcNG0tA34U9/ilB
         HDPbSCNS76EFk4i5Uo4OYuRR38doXyoOZ+jp9jhAqWyvz2tZk9nSWyt6WJjefq0KX0bY
         P4ZRGRei7ZnUeL4uqh4Ro+x+lW2EAGaOq/hQ1QbdoDH+MabS5R4Pt81++glWth1ndQrn
         2RWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QAaMfHwdtZJ2KjW1qioIa8NnTSpvgBhACsmEL5jElvA=;
        b=2riJIqygV961Hp0I0LzUZ/mE+iEw0vW1jkr4wxrn08yoaiIwYLxFQ3MYklcbJ3heJx
         qwY30XW458ilDifys8O6pA5bIUVQQsL7iEkcSGS40FsN7N8Hc9vNSpmSqTz78BLzBO3i
         domXLf0m7J4YMynOttrWg1OhmxtMGjz1SP/dDFnWbdH9BS5QuAibsN6Z2LRhjTCBaGsI
         CmAIaqUH+ckjbJkGykMlXsrOWDL+xq6r5tquKHIoVjQ9Tt1uWNTlAWhUckHv1FbwFyZo
         vvq3ka6uuHg/+MRBvrETcOAcuMPhxaOUibfCQIDi1uM0+/V5tLl/svturuiuDF/Umddo
         uz9g==
X-Gm-Message-State: AOAM532pbFXtbPEd2oeeZEILXaC5N2ww3T27sVllPe463uIb9hgXxe/l
        5mgtbW62kboRsahw/yaaoSo=
X-Google-Smtp-Source: ABdhPJz4lVROD9IU3nabNtd3OztQZFuT3KaBIjHUDKsK+fNyKPQ9FdLzxPB+xAaXZNYherot8Dlc7g==
X-Received: by 2002:adf:a387:: with SMTP id l7mr4399996wrb.214.1635417350063;
        Thu, 28 Oct 2021 03:35:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id 13sm3768083wrz.38.2021.10.28.03.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 03:35:49 -0700 (PDT)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 0/7] staging: vt6655: Fix line wrapping in `RFvWriteWakeProgSyn`
Date:   Thu, 28 Oct 2021 11:35:30 +0100
Message-Id: <cover.1635415820.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is a series of small refactorings of the function
`RFvWriteWakeProgSyn`, now renamed to `rf_write_wake_prog_syn`.
The work here allowed to shorten lines marked by checkpatch.pl as
being too long by:
  * introducing two new temporary variables (`idx` and `data`)
  * rewriting a conditional to switch between two modes of
    AL7320 initialization.

In addition to this, the patch set renames the function to align it with
the kernel coding style and updates the function description.

Karolina Drobnik (7):
  staging: vt6655: Introduce `idx` temporary variable
  staging: vt6655: Use incrementation in `idx`
  staging: vt6655: Remove unused `i` increments
  staging: vt6655: Introduce `data` temporary variable
  staging: vt6655: Rewrite conditional in AL7320 initialization
  staging: vt6655: Rename `RFvWriteWakeProgSyn` function
  staging: vt6655: Update comment for `rf_write_wake_prog_syn`

 drivers/staging/vt6655/channel.c |  2 +-
 drivers/staging/vt6655/rf.c      | 41 +++++++++++++++-----------------
 drivers/staging/vt6655/rf.h      |  2 +-
 3 files changed, 21 insertions(+), 24 deletions(-)

-- 
2.30.2

