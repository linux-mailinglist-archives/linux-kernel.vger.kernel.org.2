Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579703508DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhCaVJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbhCaVJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:09:01 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1737C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:09:00 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id r18so1829793pjz.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wLumlh5Twi+XjlHspQtyQXk/t5XvCvCZtQfxC02BzcM=;
        b=XcVvRJvwhGeau31q8amFrhNk8W8SIy2xH0x+zgzIDA3DdYwUJBHv3CKmLmSVvRKCze
         LSksJUIL7SOY+dbFVf3fo4IDFoIBAr0HX+g9SitK6yFo3y17bJYRQixckb04GjwMnPeL
         WPL5vTt+3P8pDbdfg+urKM6GMzARftZpTe6FbZ4o+luN7dYO5dsboLzaV+wIjQJXlZUB
         HzVUyc/4Eio/O4Okmhb7HbGEPsWYZDjFSNt7XZ5x3IAZXh2t4CRN2FJVp7evUAAThc1C
         GUo24QwF7/F+0ku47iAqEYbxB6feoZizXOPovkRyC0EitPRCjUAiUc5EQ4Y0WzN09xQ/
         Cbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wLumlh5Twi+XjlHspQtyQXk/t5XvCvCZtQfxC02BzcM=;
        b=LPlW2Hoojf3+lXQ3iiSatFbSQJCvORBvc8XHbuK7lEAod/B4HYKQkc+HJhtazbfIuL
         VufwtBPMup6SpQOB4JNav57yOJ9Aji/p7/NFfCrk57gb5eYQMhm49+xfSoQ9ARgjg9dy
         UoIFcAm2VyaXxW12nCwA/Pk3/AhkcFL6MkyXkCV2tUWLydZ0znEEb5PGiAe5kMgUudxu
         KUFByg36CobtIPGXLpc+Oup7R3Gh1kAuePVxeU0q+24NSHW8DR2hbj7NjQeejy6uHszI
         w84SeJvF8idk1aHS2sfJQb9uBhLoHGyGGOrsThcskXWAkWhGHXirAvMdwRQNzGb90aX4
         7cTQ==
X-Gm-Message-State: AOAM530WNQG5HmW5r9TsOG+M6Z6GthDCMAwuyXEnAGxx0REDM0x47crP
        Dn52gf0Os6AK8me1p0TdYCac+LiJ81VbJEDmYZhpwILgiLeuqKxsPqO6AipJWGrGIHupRamiHj1
        fVaZECEKCX+xLXrQWCMu6dp2qX0gfN4FgtOpxZuL9Fo4G/76o+MfkNHHE6xTch0mK2ZhyED5S
X-Google-Smtp-Source: ABdhPJyWi3SISzllHSTMvnXWzcmmmiOdVrrxftg5HVbq7bPgSzl3537aes3L7GYo9c9PqTPpvuvi5UmzzfEB
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:8026:6888:3d55:3842])
 (user=bgardon job=sendgmr) by 2002:a17:90a:3ec3:: with SMTP id
 k61mr5190861pjc.125.1617224940296; Wed, 31 Mar 2021 14:09:00 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:08:28 -0700
Message-Id: <20210331210841.3996155-1-bgardon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH 00/13] More parallel operations for the TDP MMU
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the TDP MMU is able to handle page faults in parallel, it's a
relatively small change to expand to other operations. This series allows
zapping a range of GFNs, reclaiming collapsible SPTEs (when disabling
dirty logging), and enabling dirty logging to all happen under the MMU
lock in read mode.

This is partly a cleanup + rewrite of the last few patches of the parallel
page faults series. I've incorporated feedback from Sean and Paolo, but
the patches have changed so much that I'm sending this as a separate
series.

Ran kvm-unit-tests + selftests on an SMP kernel + Intel Skylake, with the
TDP MMU enabled and disabled. This series introduces no new failures or
warnings.

I know this will conflict horribly with the patches from Sean's series
which were just queued, and I'll send a v2 to fix those conflicts +
address any feedback on this v1.

Ben Gardon (13):
  KVM: x86/mmu: Re-add const qualifier in
    kvm_tdp_mmu_zap_collapsible_sptes
  KVM: x86/mmu: Move kvm_mmu_(get|put)_root to TDP MMU
  KVM: x86/mmu: use tdp_mmu_free_sp to free roots
  KVM: x86/mmu: Merge TDP MMU put and free root
  KVM: x86/mmu: comment for_each_tdp_mmu_root requires MMU write lock
  KVM: x86/mmu: Refactor yield safe root iterator
  KVM: x86/mmu: Make TDP MMU root refcount atomic
  KVM: x86/mmu: Protect the tdp_mmu_roots list with RCU
  KVM: x86/mmu: Allow zap gfn range to operate under the mmu read lock
  KVM: x86/mmu: Allow zapping collapsible SPTEs to use MMU read lock
  KVM: x86/mmu: Allow enabling / disabling dirty logging under MMU read
    lock
  KVM: x86/mmu: Fast invalidation for TDP MMU
  KVM: x86/mmu: Tear down roots in fast invalidation thread

 arch/x86/kvm/mmu/mmu.c          |  70 +++---
 arch/x86/kvm/mmu/mmu_internal.h |  27 +--
 arch/x86/kvm/mmu/tdp_mmu.c      | 383 ++++++++++++++++++++++++--------
 arch/x86/kvm/mmu/tdp_mmu.h      |  21 +-
 include/linux/kvm_host.h        |   2 +-
 5 files changed, 357 insertions(+), 146 deletions(-)

-- 
2.31.0.291.g576ba9dcdaf-goog

