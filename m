Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D87A427F43
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 07:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhJJFgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 01:36:25 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63156 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhJJFgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 01:36:24 -0400
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 19A5YOQd033292;
        Sun, 10 Oct 2021 14:34:24 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Sun, 10 Oct 2021 14:34:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 19A5YNhv033288
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 10 Oct 2021 14:34:24 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [syzbot] WARNING in static_key_slow_try_dec (2)
To:     Sean Christopherson <seanjc@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <00000000000029c95905c9742a31@google.com>
Cc:     syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        syzbot <syzbot+9fc046ab2b0cf295a063@syzkaller.appspotmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <611efcc8-76f7-34fc-306d-412957f81093@I-love.SAKURA.ne.jp>
Date:   Sun, 10 Oct 2021 14:34:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <00000000000029c95905c9742a31@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Commit 4547700a4d190ac4 ("KVM: x86: Consolidate APIC base RESET initialization code")
changed the location to set MSR_IA32_APICBASE_ENABLE flag. And syzbot is reporting
underflow bug due to too late initialization of vcpu->arch.apic_base member. We need to
make sure that vcpu->arch.apic_base is initialized before kvm_free_lapic() is called.

kvm_vm_ioctl() {
  kvm_vm_ioctl_create_vcpu() {
    kvm_arch_vcpu_create() {
      if (something_went_wrong)
        goto fail_free_lapic;
      /* vcpu->arch.apic_base is initialized when something_went_wrong is false. */
      kvm_vcpu_reset() {
        kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event) {
          vcpu->arch.apic_base = APIC_DEFAULT_PHYS_BASE | MSR_IA32_APICBASE_ENABLE;
        }
      }
      return 0;
    fail_free_lapic:
      kvm_free_lapic() {
        /* vcpu->arch.apic_base is not yet initialized when something_went_wrong is true. */
        if (!(vcpu->arch.apic_base & MSR_IA32_APICBASE_ENABLE))
          static_branch_slow_dec_deferred(&apic_hw_disabled); // <= underflow bug.
      }
      return r;
    }
  }
}

