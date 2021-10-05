Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B38422193
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhJEJD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbhJEJDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:03:54 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF87C061745
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 02:02:03 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id z10-20020ac83e0a000000b002a732692afaso7111752qtf.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 02:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YjTsD/0+blx8dzSzzvYPEmIwxWymL2rSsPmT9WrblMQ=;
        b=Oni8vTpzdoAguLL9g/0bTNlxG6eqPKNXR7hlH2QVhmPG/MSICPVMmjIkLRMVoFZsak
         qu7HwsUXwfWdDGja/pJ6rr0gubuHFEcEDOhT1sEUrKFT0YEeebrwEK01Eukybn0GEJ7t
         Un/N37PDtmLGAevXkQx9RIeDEMjoS/Rb6BKBU4YVPFU/ad/YLq/KXkFDoCP+IObdA6h4
         kfqOcbJ1Axh78XlOffdWVzqd2+p5AV42WHmazyMlMQLbiNF3gOWDEbO9ZaI5Y5tsmZct
         qU/XyCEcLAj+ar44gtcChNSpXGDU2wR5b0HWyYCQDMIYY+/le0bK+7smskmSqoCjAFra
         8DDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YjTsD/0+blx8dzSzzvYPEmIwxWymL2rSsPmT9WrblMQ=;
        b=7RYIoHkOn1XFuL1THVM4TWuOWBctZ15sMcA5zxo6jo/qt3+VheppjmDu0HoK1V75Lh
         sgZ6S+Y5f7DXfD1UP9uQP25uVtJi3VDUbjppK1aRPkIC/nOBO9JUeZKjeSfaYRO8J2mE
         Kq9s3crnjLsfVOF3HDRwdI7iWm4kYTyfRSLDsvzMYsVPTklsMu/yvaz0dh3fwmIK0Pzo
         BDPtlvErSCy06ZwO9CQyqujyh6xvoIu6YZb5fghlDuhICxvv81iyCYpcvyNn5Or3RCf7
         Cg2iMcF7bjspzZpZt0XlduuAQtHhG+aY8UAOZ4uOF8PTWD5C0W1ISjSbaRAHQsOF5gkx
         /7rg==
X-Gm-Message-State: AOAM533xFcXs8Ms/QctRec2NI8AxjlmEg2L5mYOjPqgofv5VqHVQ/YU2
        de9yGsHDqLEplkgxau2xZ85Z647pJtjj
X-Google-Smtp-Source: ABdhPJzdJwotAoaBB3EtyGIAZNxFrytEsAJXsOE9DPlOSjQixLdLb9VSyUZ6rGK2FOH7gAKnzLzBgNvtbGus
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:5700:9128:3106:b389])
 (user=qperret job=sendgmr) by 2002:ad4:4629:: with SMTP id
 x9mr26087544qvv.58.1633424522389; Tue, 05 Oct 2021 02:02:02 -0700 (PDT)
Date:   Tue,  5 Oct 2021 10:01:37 +0100
Message-Id: <20211005090155.734578-1-qperret@google.com>
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

