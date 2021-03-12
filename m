Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710143399C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 23:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbhCLWmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 17:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbhCLWlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 17:41:45 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16595C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 14:41:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id f81so30710694yba.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 14:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n62ZXlNKUIkGTReX7MmHBLgk3X3V3EW5NpQWFJzdSTA=;
        b=aLhrSS1Nwvx9iyYPtCrZODRxYwey1++byvUcw++hpshNbVmJZNuPtkU03Ivn2MSqSM
         i9DHhM9UrfLrgDuo1iG0QurKd4840oIfLU2RUiHBBON466AdyqgYuiVLYRQpAV9YWW3a
         kPmUaAclUxQrux4076L0Rqb4gifdSJjoqaAfpkSs4TvG8xAzKmvy8ta00HkHRwrmntTU
         /G6huvVMhPVt4T3BFYEirBWr+vfK6JRK4R8yCng22cvOBvKEyQyzJE4OLHf6j/z+ypEF
         V/2ZaMhlburbGEpg2rdl7cPzOZmvJqHNDUOtPUcEFSlOYDxC7QoFmvPxPUM+acQEveUQ
         yr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n62ZXlNKUIkGTReX7MmHBLgk3X3V3EW5NpQWFJzdSTA=;
        b=p26pNLpOU1ViG9bVlVt0IylfiXNdgiI4vvPUfOnsPc5rP7w6MgSa6ybwb0G3Uc6hoV
         3s+O7eeYIFiXBvIx3tTeviGt0pw5Xh7Bgp9bkoqZ1YqHe6fo/SFj5yCFbQJhVYfVO5ds
         O/eNaJfN9+RnQ6JpEmJDsgYH1/475A26sYWHxOevKiZVGz3YsDeIGGhcnZ5w1kfUOeK6
         zEUHQdcPuC3BtEWj27EePvXO/hWwRAKgub2iGhr1XBFaxKNgnBHquvLkTHsjuDCuUnk4
         BTbZ+QohEyexF30QiahLeeJCJv/v5B278u8OMC0Sgg7Vm4RgEhAcWyGXEytZ3S7H8hCI
         NohQ==
X-Gm-Message-State: AOAM531edXB7rzJbgQ+GgkT7InPC09IAQ+Z2HBHZCkbepNXdgxu6/H5e
        k7ZvobFbr5vytTLDQjhG53jTI64VF69+iijZsxM=
X-Google-Smtp-Source: ABdhPJz2oQ+G7JS6YVQOmBxyT6jWmv/C/U+k0ZBL3BYwO1mGCg63BYC9R9xmgOxmF0f6pY48IRqUxfdfdpuqe0c4dGw=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f1f4:3252:5898:ad84])
 (user=ndesaulniers job=sendgmr) by 2002:a25:6189:: with SMTP id
 v131mr20618833ybb.481.1615588904059; Fri, 12 Mar 2021 14:41:44 -0800 (PST)
Date:   Fri, 12 Mar 2021 14:41:30 -0800
In-Reply-To: <20210312220518.rz6cjh33bkwaumzz@archlinux-ax161>
Message-Id: <20210312224132.3413602-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210312220518.rz6cjh33bkwaumzz@archlinux-ax161>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 0/2] gcov fixes for clang-11
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLVM changed the expected function signatures for llvm_gcda_start_file()
and llvm_gcda_emit_function() in the clang-11 release. Users of clang-11
or newer may have noticed their kernels failing to boot due to a panic
when enabling CONFIG_GCOV_KERNEL=y +CONFIG_GCOV_PROFILE_ALL=y.  Fix up
the function signatures so calling these functions doesn't panic the
kernel.

The first patch should allow us to backport it to stable; the second
drops support for older toolchains.

Link: https://reviews.llvm.org/rGcdd683b516d147925212724b09ec6fb792a40041
Link: https://reviews.llvm.org/rG13a633b438b6500ecad9e4f936ebadf3411d0f44

Nick Desaulniers (2):
  gcov: fix clang-11+ support
  gcov: clang: drop support for clang-10 and older

 kernel/gcov/Kconfig |  1 +
 kernel/gcov/clang.c | 32 ++++++++------------------------
 2 files changed, 9 insertions(+), 24 deletions(-)


base-commit: f78d76e72a4671ea52d12752d92077788b4f5d50
-- 
2.31.0.rc2.261.g7f71774620-goog

