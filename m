Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94017436348
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhJUNr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 09:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhJUNr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:47:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5FDC0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:45:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so622352pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 06:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XtPHFQm3Gx9OKSk223OIG1zPCPHU2yhr3Gzd+GkMp4Y=;
        b=iSq35zcccVlkAf+ROcAmanV9praZzQYoXHbQI0udTe/yEEjuqBnhBUWzbiuWK+WFG2
         AB0hdkyMhW+/V5OksQCLkgo3zLzfxTgXLceJiGavfPrTbKDQLDL1Fie93QRDdrCTmsmA
         5RkmV79E67tcPiFtxa+OP3zK3G5mPFz9BlzmOGdO6U9M+TaPQrPwV2pKbbD3q35hOnIc
         tWbTxu9PZDkBE3rUFqhDVQ2Lqg7nppqpWCQr2zRFtwVCwR9AakxBNBvAgi5rjpruZisI
         sIyTR2gIhlP6gwuXgWO0h8t8V50pJw2NhK3Rm3RBnGg1SN3KbrTlJokgnsVGL8RyWZ5d
         YtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XtPHFQm3Gx9OKSk223OIG1zPCPHU2yhr3Gzd+GkMp4Y=;
        b=AuS0xVUv8nnuVvwkFRhut9ss59xSQYtIkuOgUi/JGya0AcmMyPmagKw4nOpDaGZnLG
         B/SoHgwuqhHKl/L0qC+2GztgR/BsBFMrxsGXAbxm87wesio/EJrEMT/+S8qtC7xD6y8e
         oYsUQPWU6/wURAtXV5slv5x/JUuWj2YkK5m9o3qgiLDyfAk2uhrGP9yrKZJlI/UQFyan
         VPHwjj2BfWCxEXnqIw+G1jXce0Wrtm6NySki/SPzOcPkis8N7gnLz3srDXAsS87k6y39
         CGyQhRlEBenmQEiTC173K1zP7Ebd2zze7i1Cft39s+OOWMXKOKdy4l9QAtM1bksjkQsS
         mxdg==
X-Gm-Message-State: AOAM530ndbEBJPpP9p9ujNV/DsyU0T8hF9q5oM9XpvBEamSX/ln4hKVr
        iilfGhR0Xe0ZPd1nhoo5nMDz0g==
X-Google-Smtp-Source: ABdhPJzdrQHCy1u8xHpxg/F/zz71e4fBRbDCwoKYJ9sgYMHLjpXNIm0R8UxBXVL8KTeFkQ2j0hAj2w==
X-Received: by 2002:a17:90a:fca:: with SMTP id 68mr1148819pjz.77.1634823941410;
        Thu, 21 Oct 2021 06:45:41 -0700 (PDT)
Received: from localhost ([103.127.241.129])
        by smtp.gmail.com with ESMTPSA id z24sm6373840pfr.141.2021.10.21.06.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 06:45:40 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [RFCv1 0/4] arm64: Use static key for PID in CONTEXTIDR
Date:   Thu, 21 Oct 2021 21:45:26 +0800
Message-Id: <20211021134530.206216-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel provides configuration PID_IN_CONTEXTIDR so we can save PID into
system register contextidr_el{1|2}.  This means developer must build
kernel with this config, otherwise, the feature is disabled and cannot
be used by hardware tracing modules (Like Arm CoreSight, SPE, etc) on
the fly.

Suggested by Stephane Eranian, this patch series introduces static key
for PID in CONTEXTIDR.  If the config PID_IN_CONTEXTIDR is selected when
build kernel, then the static key will be set as true and kernel will
always trace PID into CONTEXTIDR, so we can keep the same semantics for
PID_IN_CONTEXTIDR before and after applying this patch series.

If the config PID_IN_CONTEXTIDR is not selected, the kernel modules
still can invoke the pair functions contextidr_enable() and
contextidr_disable() to dynamically enable and disable PID tracing in
the profiling flow.  As result, Arm SPE is the first consumer to use
static key.

When I review Arm CoreSight driver, I found it misses to check root PID
namespace for its register setting.  So it would use a dedicate patch
series to firstly correct namespace checking and then apply static key
for PID tracing.  For this reason, this patch set doesn't contain Arm
CoreSight related enhancement.

We also need to provide arm32 variant to use static key for PID in
CONTEXTIDR.  I'd like to send out this patch series firstly for comment,
in case this approach is not accepted by maintainer.  If we can conclude
this is the right thing to do, I will supplement arm32 support in next
spin.

This patch set has been verified on Hisilicon D06 board with Arm SPE
driver.

I tested the performance for using static key, the result doesn't
show regression.  In the testing, I used the command 'perf bench sched
messaging -t -g 20 -l 1000' to measure the scheduling latency for 4
different modes:

    'dis': Disable kernel configuration PID_IN_CONTEXTIDR.
    'enb': Enable kernel configuration PID_IN_CONTEXTIDR.
    'true': Set static key to 'TRUE'
    'false': Set static key to 'FALSE' (so don't store PID into CONTEXTIDR)

The testing iterates for 5 loops for every configuration, and get the
run time (in seconds):

          dis      enb     true     false
    ---+--------+--------+--------+-------
    #1   26.568 | 26.786 | 26.056 | 26.197
    #2   26.442 | 26.457 | 26.458 | 26.846
    #3   26.719 | 26.701 | 27.119 | 26.281
    #4   26.448 | 27.595 | 26.953 | 27.043
    #5   27.017 | 27.263 | 26.638 | 26.933
    ---+--------+--------+--------+-------
    avg. 26.638 | 26.960 | 26.644 | 26.66
    ---+--------+--------+--------+-------
    delta pct.  | 1.21%  | 0.02%  | 0.08%


Leo Yan (4):
  arm64: Use static key for tracing PID in CONTEXTIDR
  arm64: entry: Always apply workaround for contextidr_el1
  arm64: Introduce functions for controlling PID tracing
  perf: arm_spe: Dynamically switch PID tracing to contextidr

 arch/arm64/include/asm/mmu_context.h | 14 +++++++++++++-
 arch/arm64/kernel/entry.S            |  4 ----
 arch/arm64/kernel/process.c          | 11 +++++++++++
 drivers/perf/arm_spe_pmu.c           | 13 ++++++++++++-
 4 files changed, 36 insertions(+), 6 deletions(-)

-- 
2.25.1

