Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BE94207C6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 11:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhJDJFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 05:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhJDJFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 05:05:30 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA92C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 02:03:41 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so16490496edy.14
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 02:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YjTsD/0+blx8dzSzzvYPEmIwxWymL2rSsPmT9WrblMQ=;
        b=cDeVBbd8fmjR3GX4XwCizTRj0hWM50iHttru8PTyFUbxfI+Srq2N/f14A83cswDquw
         OE9TAuHD7lC8c+ic+i+yiOl6IQ6FAVHQZxmdzAY67B5j4gFWr8hZMA+WN6zXBqBp6NTN
         jgffafFQATGQHreUOq5eYQplEJ9eQJEWTkXjY37D/dAoaHfL9y81mvc9j/2KYhMfZYvq
         RdaZVd1Kr3Cd1Kg1HvlNAfRBfG/lGsC3tDKyTZS9O4kJQFviWp6aWFtCosLSaivreQ82
         eKsskutGnKtrjVhwwPVOhTRNgee+YZb0n732fTRei79zPf1IOd2rllBdb10/PIjLrgC6
         sr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YjTsD/0+blx8dzSzzvYPEmIwxWymL2rSsPmT9WrblMQ=;
        b=BHo3aS8quI1FvHw4kl+TnX1MuomuBoWJe8d2hG9xnudvr3pqGSLC6OzLExjBvFAy9S
         NHTQEU6MjpnCSQ2E2DQEFXkteSrZ1Ovhh2I5e6gzQPZEymPSi4OUbX372Ar+66yPk2Wg
         mIgJOdV2Hg90lhRWghbC1KDX+NKcCKcOfN0u4s7leq/jcc6Zd/WgfqkKulxNqJM4oxqm
         b7qlRHmmCE+2f53hwHyDgULYLHWhpg83Atw1ElibNZFCNz1+c06fkpAn10YVXZpzCQCP
         109vFtq3n3Vywfvznl2kIp12XtJjcs7O3nT+pt7l27y2N7pw1fptwXAqXGmVEf01dKOF
         8JXg==
X-Gm-Message-State: AOAM533omaGcayuMRiguVTBhVftbxkeaUoJ2a0Yx4dEBsbIgRC/o3gnw
        hkInO5wn7z+LCUOHWRSdmq2uMgfFpa+X
X-Google-Smtp-Source: ABdhPJwMBTgk+xzHhrOf7diiO6pKvFsFa+nBGQazRqVB1zzwDjDYGzDQkOsS9ibLYzZ2nicgVL/MVG58Ll6W
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:669b:5b16:60b7:a3d4])
 (user=qperret job=sendgmr) by 2002:a17:906:8281:: with SMTP id
 h1mr15169765ejx.352.1633338219898; Mon, 04 Oct 2021 02:03:39 -0700 (PDT)
Date:   Mon,  4 Oct 2021 10:03:12 +0100
Message-Id: <20211004090328.540941-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH 0/2] A couple of EL2 refcounts fixes
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This addresses a couple of issues Will has found with the refcounting of
page-tables at EL2. Patch 01 fixes a nasty bug, and probably wants to go
in -stable. Patch 02 fixes a small inconsistency which made it harder to
find refcount-related bugs at EL2.

Feedback welcome !

Thanks,
Quentin

Quentin Perret (2):
  KVM: arm64: Fix host stage-2 PGD refcount
  KVM: arm64: Report corrupted refcount at EL2

 arch/arm64/kvm/hyp/include/nvhe/gfp.h |  1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c |  6 +++++-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c  | 15 +++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.33.0.800.g4c38ced690-goog

