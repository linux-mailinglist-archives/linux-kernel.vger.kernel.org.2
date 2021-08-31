Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2C63FCBAD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240655AbhHaQnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240567AbhHaQnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:43:24 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BAAC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:42:28 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id c11-20020ac87dcb0000b0290293566e00b1so1637045qte.15
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=f12jBhwq9+r/36NoKImUDEFN+8rcbqX1M1KRePLwVzM=;
        b=k7XX6L8E3h8OOOUPT5I1QXsY0ja9hOXH9xib1TsSyFkgiC+zEr9+9+fJcwJn5CDk7F
         HthqKNLD9bHN6bCcdiHKjb11Jx1eqJPO6A+xvWVKgxiQuTTSbXIfIdU6HWYlcYUgRuGR
         4Ah3lNbn94Dzu4xQ5c/i4AN661IvE3pleqlXYNqCmIKsdlMjC+zQQA2KHD724zf7kYYi
         rgKEnOBl2uz65Nf5pM2wwn/Je1Vu6vOdJDhigMYbPBSHFai61qb79Grv6FN6KiMejmXa
         lHI+1IbylAtPhrNdhK+ef5x6Xquw/XP/r1sC9VBXHBsxpONjJoR8KyzInszFzFWXmRU6
         Y61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=f12jBhwq9+r/36NoKImUDEFN+8rcbqX1M1KRePLwVzM=;
        b=aadcQ7Cru/lj94FXT23q1lSL50RfV9HP4SjX1FshhiRNHdkOxsbB5v+Ra1Bj80FIJd
         60+HrklE86AzOWLPQIJqYEv+T8fsYfHcx/HAO57wRqy6fwPkfbODWu/Efx1UqSGGfU3s
         pYTuSuOIz+7keaBclI//6hYzNrFusSh2jrJUFCc40feHNpYyR8O3vDBJ/N9TrrDImquA
         tAGVAhooa7MXg487VomWt5NDuuFvmzoe/GnoGQynNZfVBZ3D40tC5h8PVWmEhwTalFW7
         0eIN9a++1hkDNKjtlONmKo4KPhg9hPlfT2wbaAdtyoISLaqnV6ec/8CplY9C/5j7sVHt
         227Q==
X-Gm-Message-State: AOAM532SayqEXUTqM6qBV2Kd6W1bks0XQVnpvqCjWz9J6yD87jz0Peoz
        93X3NeGHpDBQ+f7F5jGqe24wzeeZj4A=
X-Google-Smtp-Source: ABdhPJwJpm65TcqXyqkx3P+gbjLiQnm24vEdkncuu85mx+K1P0HAooOTK+aguQjwBYqG1E1oUUgR7+Ii9ac=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:ddbd:588d:571:702a])
 (user=seanjc job=sendgmr) by 2002:a05:6214:2609:: with SMTP id
 gu9mr29117556qvb.35.1630428148017; Tue, 31 Aug 2021 09:42:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 31 Aug 2021 09:42:21 -0700
Message-Id: <20210831164224.1119728-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH 0/3] KVM: x86: guest.MAXPHYADDR fix and related cleanup
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+200c08e88ae818f849ce@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a bug exposed by syzkaller where running with guest.MAXPHYADDR < 32
leads KVM injecting a garbage exception due to mishandling an illegal GPA
check when "translating" a non-nested GPA.

Clean up tangentially related code in load_pdptrs() to discourage reading
guest memory using a potentially-nested GPA.

Sean Christopherson (3):
  Revert "KVM: x86: mmu: Add guest physical address check in
    translate_gpa()"
  KVM: x86: Subsume nested GPA read helper into load_pdptrs()
  KVM: x86: Simplify retrieving the page offset when loading PDTPRs

 arch/x86/include/asm/kvm_host.h |  3 --
 arch/x86/kvm/mmu/mmu.c          |  6 ----
 arch/x86/kvm/x86.c              | 56 +++++++++++----------------------
 3 files changed, 18 insertions(+), 47 deletions(-)

-- 
2.33.0.259.gc128427fd7-goog

