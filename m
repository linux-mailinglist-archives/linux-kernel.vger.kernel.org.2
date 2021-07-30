Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DA83DC003
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 22:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhG3UsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 16:48:13 -0400
Received: from mta-09-3.privateemail.com ([68.65.122.19]:16921 "EHLO
        MTA-09-3.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhG3UsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 16:48:12 -0400
Received: from mta-09.privateemail.com (localhost [127.0.0.1])
        by mta-09.privateemail.com (Postfix) with ESMTP id AF1DB180094A;
        Fri, 30 Jul 2021 16:48:06 -0400 (EDT)
Received: from [192.168.0.46] (unknown [10.20.151.224])
        by mta-09.privateemail.com (Postfix) with ESMTPA id 14DCF18000B7;
        Fri, 30 Jul 2021 16:48:03 -0400 (EDT)
Date:   Fri, 30 Jul 2021 16:47:57 -0400
From:   Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH] KVM: const-ify all relevant uses of struct
 kvm_memory_slot
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org
Message-Id: <XFS2XQ.ZZ0IWDD0G95J@effective-light.com>
In-Reply-To: <YQReyaxp/rwypHbR@t490s>
References: <20210713023338.57108-1-someguy@effective-light.com>
        <YQReyaxp/rwypHbR@t490s>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hey Peter,

On Fri, Jul 30 2021 at 04:19:21 PM -0400, Peter Xu <peterx@redhat.com> 
wrote:
> This patch breaks kvm/queue with above issue.  Constify of 
> kvm_memory_slot
> pointer should have nothing to do with this so at least it should 
> need a
> separate patch.  At the meantime I also don't understand why memcpy() 
> here,
> which seems to be even slower..

To const-ify the slot member of struct slot_rmap_walk_iterator, we need 
to
initialize a new struct and then copy it over (otherwise we would need 
to relay
on casting again or the compiler will complain about it).


