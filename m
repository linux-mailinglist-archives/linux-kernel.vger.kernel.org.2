Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8B3379377
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhEJQPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhEJQPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:15:21 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643C6C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:14:15 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id o21so14907093iow.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 09:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bc+/YaXdYVj2iNJOnaudg2do3DCpftO86ryOW+uvQ8k=;
        b=FG6vMMYgTNO94+ZMRrdXrHJRBI6esdsXr50/kWwXMHn0wa+JmXHKfhMtOg8crtd5ur
         N2bv7TrXiy0X4g1fQCh1Nfi3KPoKW7Lxaw0g3ucWADjE2JiLv37K7Tj4ZnDeJh+ad0xS
         aViyAmCITcKc9uEGQpsikE6/1noKWDgh+Il5p4ydcIM/eZpGPZQ5xbiep6PPC9Drnckq
         gHF3EZyqMi0M+j7D6seCMJA1uKbXEhuUsdmwg5n9OIdy7ENxmxSvNHx5ZDsYdz/YqJJ3
         ep1yc+f6kxhxwloK0i2snqMVYAI9G5amkjG+7SvwyiEQjYMPFYhdurbfygIpLbPgzw6Z
         Q6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bc+/YaXdYVj2iNJOnaudg2do3DCpftO86ryOW+uvQ8k=;
        b=V6HXH190jbx3+ygEda0GzK+2rLPGRHEHizLAh6Q8g2RcnqOAQbcHWa3aKKM9v4aETE
         iKq+q5KU92srhqRtNLD+nWNOaPqLSUJYXcLL73nfR4MmgVGMBtR0yNjlv5CQtyRXxzVx
         ee9qqHPDSI6IoWiSu5+3geu+O0niwLAuM+Vl+EwMhKaBScn0LreLUbwmGfAfpDZ+ai0X
         4CZhDNpdJcyw5QntQD7NNQjqdYZ6iRsJr/RibikmFZ+H6tSTjoeD6gIxO6WwQZpfwPz6
         W07ItPC20l5VglN21cgtCQhvuSriw9/IOSj1jJJvScELo9KZ6baQfnWQiPqSuPq5q0Rw
         G0tA==
X-Gm-Message-State: AOAM532kluJru2opM0+exNmSn0RMEDNkCPzfPl/gAoUAhp2EmJpJnSo2
        BS2/DS5+eNNXkJHOgUDUDt+FmzYWUPgec7IroZlr69jG/0s=
X-Google-Smtp-Source: ABdhPJxieX3YetvW8orAdXD48Nhce0jo3g03zx2u7DF5hKZFtlQv1wdNV/qv20T8aeuKXzh5HLXiiqGdNTERlxnr+Q8=
X-Received: by 2002:a5d:850c:: with SMTP id q12mr19059527ion.189.1620663254567;
 Mon, 10 May 2021 09:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210506184241.618958-1-bgardon@google.com> <20210506184241.618958-6-bgardon@google.com>
 <CANgfPd-eJsHRYARTa0tm4EUVQyXvdQxGQfGfj=qLi5vkLTG6pw@mail.gmail.com> <a12eaa7e-f422-d8f4-e024-492aa038a398@redhat.com>
In-Reply-To: <a12eaa7e-f422-d8f4-e024-492aa038a398@redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Mon, 10 May 2021 09:14:04 -0700
Message-ID: <CANgfPd8BNtsSwujZnk9GAfP8Xmjy7B3yHdTOnh45wbmNU_yOQw@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] KVM: x86/mmu: Add a field to control memslot rmap allocation
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 7, 2021 at 1:28 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 07/05/21 01:44, Ben Gardon wrote:
> >>   struct kvm_vm_stat {
> >> @@ -1853,4 +1859,6 @@ static inline int kvm_cpu_get_apicid(int mps_cpu)
> >>
> >>   int kvm_cpu_dirty_log_size(void);
> >>
> >> +inline bool kvm_memslots_have_rmaps(struct kvm *kvm);
> > Woops, this shouldn't be marked inline as it creates build problems
> > for the next patch with some configs.
> >
>
> Possibly stupid (or at least lazy) question: why can't it be a "normal"
> static inline function?

That was my initial approach (hence the leftover inline) but I got
some warnings about a forward declaration of struct kvm because
arch/x86/include/asm/kvm_host.h doesn't include virt/kvm/kvm_host.h.
Maybe there's a way to fix that, but I didn't want to mess with it.

>
> Paolo
>
