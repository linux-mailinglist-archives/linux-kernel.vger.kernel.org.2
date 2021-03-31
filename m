Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE41B3508EA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhCaVJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbhCaVJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:09:14 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032ABC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:09:14 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id a16so1742852plm.17
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+bpx1iaqeW64f43Q16KGFU1OSLWhWp6bSNi8pmvu8l0=;
        b=jyJf6Erx3Vr6KJglW79Mt9jpWyBfKg1VDB6pFb+pByemXvErG6JRy0FUoOJxqxgitM
         10ZFCQFLqwwLahmtcTRSEG8U5PYqEgLzB6vvamJL0TgokxBg77NuafD9FmSLUGAWlR2l
         TO1feqWom5WBJZ+PB0Jmc10dFZTo892Ejo3/q+DFMrYEMN3Z6/Zdy70xY80/PkSy5Y1i
         rfytyXljgwnj7OpY8WgeZW0p7ytlGlgDAOrcKAjZRLPVrnq/fQIfoWK/9JkQs0F4WJgh
         8E79NeK4u9cKNIpcodpfc7hxvLn3royzuTgDWLm2XMza+HJBfLwc/62q0MXM2Pka3rtc
         Sz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+bpx1iaqeW64f43Q16KGFU1OSLWhWp6bSNi8pmvu8l0=;
        b=eJ3vDd+p7taN5Yoku9/5VaZ8e45Eylb9FwUrpATKiEwunHgc7m5CMd8HqVgk+n7nb2
         J+gC1mm/NDzqOWOzcVktq+kbW4VLZff/C43oUs8Ig9nm7HdHe/Q58gO9znq/bFA+hV0m
         hYOMZwjBYq8cAHLxsyvn1fMmVB8fObZhevY3z04UMVfTYYPBM7eKKo48edgrLIQANrXj
         Mf6V+/nOi05CWdj4rUEOH9StXnuAhhaTHiPIf70cl2pV/QOEh2fBMeS07nCz1ARqRcIW
         XxI0rRaCwt+6ymVUgS2gmmDsEGfW6CabwhZnNvuYmCuPdsdQC/KYwQ7rmzbT/+BLilvb
         DKVQ==
X-Gm-Message-State: AOAM533rLHP4TEJ8tNdRCc+Fmr9LX7S/qAbta7bx2/Lv2eUhHhAnHDFY
        ebuxvd4PgdOYkUI/S5JfClqLYAGDkWSUMzTC9axF3mmiBIU/hO3rXTvOZ4owX7uWkl2IH/pVxKi
        yp3n/d1ymASopjf0IDhvTY8GExpVYYn9EU9XRkjt8DG4m55etSFZmbPFlkqzLk12cJ3/foK83
X-Google-Smtp-Source: ABdhPJwkN2GKx1FcEh1BYC9eoqZXYP0omsgJCtYeXf9CgVLacsMfVHLK0cd5Q4NDJf1CNg+xFmGUQnWibMfl
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:8026:6888:3d55:3842])
 (user=bgardon job=sendgmr) by 2002:a62:8811:0:b029:1ef:2105:3594 with SMTP id
 l17-20020a6288110000b02901ef21053594mr4789197pfd.70.1617224953241; Wed, 31
 Mar 2021 14:09:13 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:08:33 -0700
In-Reply-To: <20210331210841.3996155-1-bgardon@google.com>
Message-Id: <20210331210841.3996155-6-bgardon@google.com>
Mime-Version: 1.0
References: <20210331210841.3996155-1-bgardon@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH 05/13] KVM: x86/mmu: comment for_each_tdp_mmu_root requires
 MMU write lock
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

Currently, iterating over the list of TDP MMU roots can only be done
under the MMU write lock, but that will change in future commits. Add a
defensive comment to for_each_tdp_mmu_root noting that it must only be
used under the MMU lock in write mode. That function will not be
modified to work under the lock in read mode.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 368091adab09..365fa9f2f856 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -103,6 +103,7 @@ static inline struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
 	     tdp_mmu_next_root_valid(_kvm, _root);			\
 	     _root = tdp_mmu_next_root(_kvm, _root))
 
+/* Only safe under the MMU lock in write mode, without yielding. */
 #define for_each_tdp_mmu_root(_kvm, _root)				\
 	list_for_each_entry(_root, &_kvm->arch.tdp_mmu_roots, link)
 
-- 
2.31.0.291.g576ba9dcdaf-goog

