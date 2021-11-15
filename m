Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08934502E5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbhKOK7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhKOK7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:59:21 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5C5C061202
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:56:19 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso15400796wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZnKAulS/vIGrw+3FjdDPJBScIMVfc4pnUettjnr0PVs=;
        b=ggSYQtrTCDS/DratDv0dlBLFwAj9deVBsJWmMVZx6J92cEBlai4w4a/zYhbFWA2mV7
         uki7MxwwBNgiaZPFSnfikq5WhBk+c2PKjirTU2uHLU/zCBm+ZQVB+kauVivYQHIUBEDL
         PTYvpQlN7CBNt5/eJUX9auOTh45dlvEmdMzZ1nt2Mw37zVbv0N/UjrxY3ELQgLgNUYyb
         N5QMBT7cjmJq3QhJkZ1cgo7m2IqW6ByUVIx0gLa6AZ9cORiCqguX4cOYsYN68VuiYXXB
         65AriatapML1EuSHgsQoa4D0jLEai2o4Ue+vYibUy+GsC8tbRInfbjP7yMk3yMXT1Iac
         lx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZnKAulS/vIGrw+3FjdDPJBScIMVfc4pnUettjnr0PVs=;
        b=Pkwv+S/MOea3SkiMPh45+xCRX+So4ZFIGciqHNSFPhCz/hM6VHShSf6CbayUL+F6XU
         y+rqOawlUXaQspcy0ZInEpLam5R7+xc8TrXoklPJUffADsQeUHYIUtgFTda5/mhC0Piv
         Xdj01hoy24x2ppjHM9PN0rgO6xn+o36ahVb2iesjItWemswBCt1CTIjSEOfY0tal/08N
         etMcjfy++/IiI21BV4emaSvgIKDIhJbI2WtBI4U5UgbB6d/i86hcxDAe68NqyDv0xKA+
         jXGe7sgF8Mk7iqKLGdmChUL3MS4Mz5pTzTUs1b7kUWk48EXxssTM19V+Gn0mfsTvrNgn
         sMqw==
X-Gm-Message-State: AOAM5319bSrAZE+44Ay6dTrPnVAcOCRJboAjqBzzjjGQ5DzQiY8Z4H5M
        /Cmx/OCL7r/PBa3JHF/2i94=
X-Google-Smtp-Source: ABdhPJw1JuoENwuS1D5LEAiKPlSODt9xNMfu0jvXwp4q101mH6KBfQIHJsfpjCOa9V0dQI1yjhuAzA==
X-Received: by 2002:a05:600c:22cb:: with SMTP id 11mr41309165wmg.181.1636973778280;
        Mon, 15 Nov 2021 02:56:18 -0800 (PST)
Received: from localhost.localdomain ([2a01:4b00:f411:e700:e085:8cb7:7bf6:5d62])
        by smtp.gmail.com with ESMTPSA id d1sm13516532wrz.92.2021.11.15.02.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 02:56:17 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v3 0/8] staging: vt6655: Fix line wrapping in `RFvWriteWakeProgSyn`
Date:   Mon, 15 Nov 2021 10:55:41 +0000
Message-Id: <cover.1636729147.git.karolinadrobnik@gmail.com>
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
  * introducing two new temporary variables (`idx` and `init_table`)
  * rewriting a conditional to switch between two modes of
    AL7320 initialization.

In addition to this, the patch set renames the function to align it with
the kernel coding style, updates the function description and removes two
unnecessary conditionals checking if the value of `init_count` is lower than
a predefined value.


Changes in v3:
  * add a patch for removing the type cast as a first change, suggested by
    Dan Carpenter <dan.carpenter@oracle.com> 
  * merge two patches (using incrementation in `idx` and cleanup) into one,
    partially implementing Dan's suggestion

Changes in v2:
  * drop "staging: vt6655: Introduce `data` temporary variable" patch, suggested
    by Julia Lawall <julia.lawall@inria.fr> 
  * amend "staging: vt6655: Rewrite conditional in AL7320 initialization" patch
    to use indexing and `init_table` temporary variable
  * add two new patches to remove unnecessary checks for init count, suggested
    by Mike Rapoport <mike.rapoport@gmail.com>:
      - "staging: vt6655: Delete bogus check for `init_count` in AL2230"
      - "staging: vt6655: Delete bogus check for `init_count` in AL7230"

Karolina Drobnik (8):
  staging: vt6655: Remove unnecessary type casts
  staging: vt6655: Introduce `idx` variable
  staging: vt6655: Use incrementation in `idx`
  staging: vt6655: Rewrite conditional in AL7320 initialization
  staging: vt6655: Rename `RFvWriteWakeProgSyn` function
  staging: vt6655: Update comment for `rf_write_wake_prog_syn`
  staging: vt6655: Delete bogus check for `init_count` in AL2230
  staging: vt6655: Delete bogus check for `init_count` in AL7230

 drivers/staging/vt6655/channel.c |  2 +-
 drivers/staging/vt6655/rf.c      | 44 +++++++++++++-------------------
 drivers/staging/vt6655/rf.h      |  2 +-
 3 files changed, 20 insertions(+), 28 deletions(-)

-- 
2.30.2

