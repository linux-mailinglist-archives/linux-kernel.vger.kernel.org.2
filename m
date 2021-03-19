Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A9134291B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 00:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhCSXU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 19:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhCSXUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 19:20:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F04C061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 16:20:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 6so53574595ybq.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 16:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=CvQ5tXzFvKmiPJ3XmaWouDYXr0Pnkz+oNik9wEm0aE0=;
        b=eX2PETl3TR/9qMzY1ZqSlgBlCPt71CLJcdHrJZXxvuQOxMLpvQV416RwDdItcChYKV
         1NuoDItQtRM3Fg3W3WIClKW2OfCeZE51UtfFHfyjJlGVoUfrFHcxDGCP5jb3RHF3QUDn
         CI6RfsMAeNLHote6T/FT45OgRKvGjA0hv2gLX9z7kbPc/fJcezVMM7LvQ1e1Ex7JGmtP
         PMBxRC/1/o6eeMn33BiCM1CYL0GCoSPUaM0MEXF18uNPUjiNtVm58cYkwV4uJBVd2RbK
         DGaMwM2jVhDM80NYUvZ/ilPvA/XWlvvKFGiZMwxrv47JrDTm6LXB2aUtbdTLqW7dlP9P
         D17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=CvQ5tXzFvKmiPJ3XmaWouDYXr0Pnkz+oNik9wEm0aE0=;
        b=U3ZOed8O0ZFLrMGpaRWWzm4Ymvk14/ulusNS4OinS7pk1E033c2NceXnnqJaZprtfL
         U0HUDuAndkh5M1QaPP0D/vyAUnjNLkt2JW0EEWWuw4TClyzJ7FHAQYCPKYhz5opQqM7h
         pIlowTqYuCsiSC7sy4edK5scn9bmuBJ51VGA2fQyMnP03VbO6CzwsL1FtsyBxHt6IZ9S
         GgUR+oz6lCp31vnN26GMDRP0P+eLRlFoiH8aTTzglC/AIcg28Fcq+IshSauwz2Gchwak
         Y19l7IAwtJn0GFlpfi27yHZzZfaqWzqqd4UiNyod38hbVBheP89wr9cRXUyuhs0DmTiz
         063w==
X-Gm-Message-State: AOAM533PU/1INwAFiw30Gfz3YHt1TZSHF9G1p9HOqzx37w2bUi9JFcmM
        2SxwTOA07v2gLF2XpidQ0N0Pj/2cjm4=
X-Google-Smtp-Source: ABdhPJxPApAsYFIsf405wMqKW5zAk/n920Ju9PJupoufH7Gg02Rt9dFSEEGKZlz6d2CcKwWRuTNUWc+5CDQ=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:115a:eb6e:42f6:f9d5])
 (user=seanjc job=sendgmr) by 2002:a25:ddc3:: with SMTP id u186mr9555238ybg.238.1616196011260;
 Fri, 19 Mar 2021 16:20:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 19 Mar 2021 16:20:04 -0700
Message-Id: <20210319232006.3468382-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 0/2] KVM: x86/mmu: Fix TLB flushing bugs in TDP MMU
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two bug fixes involving the TDP MMU.  Found by inspection while working on
a series to consolidate MMU notifier memslot walks across architectures,
which I'll hopefully post next week.

Patch 1 fixes a bug where KVM yields, e.g. due to lock contention, without
performing a pending TLB flush that was required from a previous root.

Patch 2 fixes a much more egregious bug where it fails to handle TDP MMU
flushes in NX huge page recovery, as well as a similar bug to patch 1
where KVM can yield without correctly handling a previously triggered
pending TLB flush.

Sean Christopherson (2):
  KVM: x86/mmu: Ensure TLBs are flushed when yielding during GFN range
    zap
  KVM: x86/mmu: Ensure TLBs are flushed when yielding during NX zapping

 arch/x86/kvm/mmu/mmu.c     | 15 ++++++++++-----
 arch/x86/kvm/mmu/tdp_mmu.c | 29 +++++++++++++++--------------
 arch/x86/kvm/mmu/tdp_mmu.h |  3 ++-
 3 files changed, 27 insertions(+), 20 deletions(-)

-- 
2.31.0.rc2.261.g7f71774620-goog

