Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C59C3DC36C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 06:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbhGaEzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 00:55:49 -0400
Received: from mta-10-4.privateemail.com ([198.54.122.62]:10185 "EHLO
        MTA-10-4.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhGaEzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 00:55:48 -0400
X-Greylist: delayed 84635 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Jul 2021 00:55:48 EDT
Received: from mta-10.privateemail.com (localhost [127.0.0.1])
        by mta-10.privateemail.com (Postfix) with ESMTP id C24E218000A5;
        Sat, 31 Jul 2021 00:55:41 -0400 (EDT)
Received: from [192.168.0.46] (unknown [10.20.151.205])
        by mta-10.privateemail.com (Postfix) with ESMTPA id 06E7618000A4;
        Sat, 31 Jul 2021 00:55:38 -0400 (EDT)
Date:   Sat, 31 Jul 2021 00:55:32 -0400
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
Message-Id: <K0F3XQ.PUWYFZOU1LO23@effective-light.com>
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



On Fri, Jul 30 2021 at 04:19:21 PM -0400, Peter Xu <peterx@redhat.com> 
wrote:
> separate patch.  At the meantime I also don't understand why memcpy() 
> here,
> which seems to be even slower..

Alright, I've now had a chance to compare the object code generated 
before
my patch is applied, with what is generated after it is applied and the
same object code is generated for arch/x86/kvm/mmu/mmu.c in both cases 
(at
least when compiling with clang, however I suspect other optimizing
compilers would behave similarly).


