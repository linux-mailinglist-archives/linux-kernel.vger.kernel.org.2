Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B3533F26B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhCQOR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhCQORT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:17:19 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79F1C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 07:17:18 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id v18so4041607qtx.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KrfxD88Ict/v6ngLTLvsT+oMLpFGTSrf7Eslq0SGM14=;
        b=a+nv8X7pyir1+SV83VwUJ4vj+AHhzDv9PQ9WnWuQqlWQwiB8a746kscytqy4ej1iuw
         eyas/id66NAzXCPbs1TSyWUPg0J1tAfqygJ563ZEyLL86DAMxCXR1eoiH5rVUm6wwKsN
         crGLP6vZayX2cQNy4hcQz8SC03UJwBdpmg407s9BSCKHMY6GoXRntodV5QOCc7JdoIdV
         zhW+OWR5QMi/4VcTh3g3DTA6Q8Q2/Z/aXggxBg1pEDZVGOiCxDLIZZoC5Se7sXzaEtjn
         pr0I3chBsy50GvwK9oKIj76iUUqJwg6uv+nTrysi6egixhFVdjdZQzkMPVQ/2bWl5qLl
         Dfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KrfxD88Ict/v6ngLTLvsT+oMLpFGTSrf7Eslq0SGM14=;
        b=XpUCxlj4Fyx1RdRsj7AphWjjfNvQWSEc8UqC6BqoJnpljY702wvQNxRPk8PweNpnTp
         8WgAmiEIo4gy49LQ9Ho7F/Jb5BlPKDyR3sKU66SL2LQA8g9bdF9NfHTQ+rNDdl5WeX89
         XXrCV4U1SdiI5URsDqbKmbk+UddmtafnWkDa8b4Cm7pPqNDw1eFmaA0fKRBt+CJhGnPW
         tXD9w76fifcKM9/t2Uc04JcbX+ZXsn5cEdx3bu99XZ/Iwz6637wYEXYsTHRgA0zYI3RV
         0Ra7utFPLMsW7tVSDjIL3UCWCbzrK+qi7TrmIHu+pVJjGR/Njc+MIyd0lJZK/PnjKsGK
         CDDA==
X-Gm-Message-State: AOAM530Ki7PrhqQnxDek6Xv7uUjeF6KsK1Y6FqdkvK9HTfW549OS1O25
        a4bAQGEnHEnJfeMRcHbH+rOOucyTznKY
X-Google-Smtp-Source: ABdhPJzkVS1O87T4WUzd78oVRcatodCw8tdcjCnylMKpUhZ05gMFuwQ7e3RhsN9PT90TU72c/bE143W9PeYp
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:ad4:472d:: with SMTP id
 l13mr5273536qvz.17.1615990637862; Wed, 17 Mar 2021 07:17:17 -0700 (PDT)
Date:   Wed, 17 Mar 2021 14:17:12 +0000
In-Reply-To: <20210315143536.214621-34-qperret@google.com>
Message-Id: <20210317141714.383046-1-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-34-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 0/2] Fixes for FWB
From:   Quentin Perret <qperret@google.com>
To:     qperret@google.com
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, android-kvm@google.com, seanjc@google.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This is an alternative solution to the KVM_PGTABLE_PROT_S2_NOFWB patch I
shared earlier (and which is a bit of a hack).

With this series we basically force FWB off for the host stage-2, even
when the CPUs support it. This is done by passing flags to the pgtable
init function, and propagating it down where needed. It's a bit more
intrusive, but cleaner conceptually.

Thoughts?

Thanks,
Quentin

Quentin Perret (2):
  KVM: arm64: Introduce KVM_PGTABLE_S2_NOFWB Stage-2 flag
  KVM: arm64: Disable FWB in host stage-2

 arch/arm64/include/asm/kvm_pgtable.h  | 19 +++++++++--
 arch/arm64/include/asm/pgtable-prot.h |  4 +--
 arch/arm64/kvm/hyp/nvhe/mem_protect.c |  6 ++--
 arch/arm64/kvm/hyp/pgtable.c          | 49 +++++++++++++++++----------
 4 files changed, 52 insertions(+), 26 deletions(-)

-- 
2.31.0.rc2.261.g7f71774620-goog

