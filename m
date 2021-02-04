Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A5830E937
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 02:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbhBDBNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 20:13:31 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:42742 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbhBDBN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 20:13:28 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1l7TCH-00HaRD-Fw; Wed, 03 Feb 2021 18:12:37 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1l7TCF-00073d-Uu; Wed, 03 Feb 2021 18:12:37 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     James Morse <james.morse@arm.com>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
References: <20210127172706.617195-1-pasha.tatashin@soleen.com>
        <a8a72826-0a27-de9b-bfb7-be8286cd61fe@arm.com>
        <CA+CK2bBSJaL9Hn_LBy78ccaCt7=r9cSaEqUVemRVmKg6cwpLnQ@mail.gmail.com>
Date:   Wed, 03 Feb 2021 19:11:10 -0600
In-Reply-To: <CA+CK2bBSJaL9Hn_LBy78ccaCt7=r9cSaEqUVemRVmKg6cwpLnQ@mail.gmail.com>
        (Pavel Tatashin's message of "Mon, 1 Feb 2021 14:59:32 -0500")
Message-ID: <871rdwocwh.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1l7TCF-00073d-Uu;;;mid=<871rdwocwh.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/H3GQsbkkidM/07G3PfRtl+Gsvs9j3tys=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XM_Multi_Part_URI
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 XM_Multi_Part_URI URI: Long-Multi-Part URIs
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Pavel Tatashin <pasha.tatashin@soleen.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 814 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.9 (0.5%), b_tie_ro: 2.8 (0.3%), parse: 0.77
        (0.1%), extract_message_metadata: 13 (1.6%), get_uri_detail_list: 3.1
        (0.4%), tests_pri_-1000: 5 (0.7%), tests_pri_-950: 1.08 (0.1%),
        tests_pri_-900: 0.91 (0.1%), tests_pri_-90: 327 (40.2%), check_bayes:
        312 (38.3%), b_tokenize: 11 (1.3%), b_tok_get_all: 13 (1.5%),
        b_comp_prob: 2.9 (0.4%), b_tok_touch_all: 282 (34.6%), b_finish: 0.89
        (0.1%), tests_pri_0: 452 (55.6%), check_dkim_signature: 0.42 (0.1%),
        check_dkim_adsp: 2.4 (0.3%), poll_dns_idle: 1.06 (0.1%), tests_pri_10:
        1.74 (0.2%), tests_pri_500: 5 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v11 0/6] arm64: MMU enabled kexec relocation
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Tatashin <pasha.tatashin@soleen.com> writes:

> Hi James,
>
>> The problem I see with this is rewriting the relocation code. It needs to work whether the
>> machine has enough memory to enable the MMU during kexec, or not.
>>
>> In off-list mail to Pavel I proposed an alternative implementation here:
>> https://gitlab.arm.com/linux-arm/linux-jm/-/tree/kexec+mmu/v0
>>
>> By using a copy of the linear map, and passing the phys_to_virt offset into
>> arm64_relocate_new_kernel() its possible to use the same code when we fail to allocate the
>> page tables, and run with the MMU off as it does today.
>> I'm convinced someone will crawl out of the woodwork screaming 'regression' if we
>> substantially increase the amount of memory needed to kexec at all.
>>
>> From that discussion: this didn't meet Pavel's timing needs.
>> If you depend on having all the src/dst pages lined up in a single line, it sounds like
>> you've over-tuned this to depend on the CPU's streaming mode. What causes the CPU to
>> start/stop that stuff is very implementation specific (and firmware configurable).
>> I don't think we should let this rule out systems that can kexec today, but don't have
>> enough extra memory for the page tables.
>> Having two copies of the relocation code is obviously a bad idea.
>
> I understand that having an extra set of page tables could potentially
> waste memory, especially if VAs are sparse, but in this case we use
> page tables exclusively for contiguous VA space (copy [src, src +
> size]). Therefore, the extra memory usage is tiny. The ratio for
> kernels with  4K page_size is (size of relocated memory) / 512.  A
> normal initrd + kernel is usually under 64M, an extra space which
> means ~128K for the page table. Even with a huge relocation, where
> initrd is ~512M the extra memory usage in the worst case is just ~1M.
> I really doubt we will have any problem from users because of such
> small overhead in comparison to the total kexec-load size.

Foolish question.

Does arm64 have something like 2M pages that it can use for the
linear map?

On x86_64 we always generate page tables, because they are necessary to
be in 64bit mode.  As I recall on x86_64 we always use 2M pages which
means for each 4K of page tables we map 1GiB of memory.   Which is very
tiny.

If you do as well as x86_64 for arm64 I suspect that will be good enough
for people to not claim regression.

Would a variation on the x86_64 implementation that allocates page
tables work for arm64?

>> (as before: ) Instead of trying to make the relocations run quickly, can we reduce them?
>> This would benefit other architectures too.
>
> This was exactly my first approach [1] where I tried to pre-reserve
> memory similar to how it is done for a crash kernel, but I was asked
> to go away [2] as this is an ARM64 specific problem, where current
> relocation performance is prohibitively slow. I have tested on x86,
> and it does not suffer from this problem, relocation performance is
> just as fast as with MMU enabled ARM64.
>
>>
>> Can the kexec core code allocate higher order pages, instead of doing everything page at
>> at time?
>
> Yes, however, failures during kexec-load due to failure to coalesce
> huge pages can add extra hassle to users, and therefore this should be
> only an optimization with fallback to base pages.
>
>>
>> If you have a crash kernel reservation, can we use that to eliminate the relocations
>> completely?
>> (I think this suggestion has been lost in translation each time I make it.
>> I mean like this:
>> https://gitlab.arm.com/linux-arm/linux-jm/-/tree/kexec/kexec_in_crashk/v0
>> Runes to test it:
>> | sudo ./kexec -p -u
>> | sudo cat /proc/iomem | grep Crash
>> |  b0200000-f01fffff : Crash kernel
>> | sudo ./kexec --mem-min=0xb0200000 --mem-max=0xf01ffffff -l ~/Image --reuse-cmdline
>>
>> I bet its even faster!)
>
> There is a problem with this approach. While, with kexec_load() call
> it is possible to specify physical destinations for each segment, with
> kexec_file_load() it is not possible. The secure systems that do IMA
> checks during kexec load require kexec_file_load(), and we cannot
> ahead of time specify destinations for these segments (at least
> without substantially changing common kexec code which is not going to
> happen as this arm64 specific problem).


>> I think 'as fast as possible' and 'memory constrained' are mutually exclusive
>> requirements. We need to make the page tables optional with a single implementation.

In my experience the slowdown with disabling a cpus cache (which
apparently happens on arm64 when the MMU is disabled) is freakishly
huge.

Enabling the cache shouldn't be 'as fast as possible' but simply
disengaging the parking brake.

> In my opinion having two different types of relocations will only add
> extra corner cases, confusion about different performance, and bugs.
> It is better to have two types: 1. crash kernel type without
> relocation, 2. fast relocation where MMU is enabled.
>
> [1] https://lore.kernel.org/lkml/20190709182014.16052-1-pasha.tatashin@soleen.com
> [2] https://lore.kernel.org/lkml/20190710065953.GA4744@localhost.localdomain/

As long as the page table provided is a linear mapping of physical
memory (aka it looks like paging is disabled).  The the code that
relocates memory should be pretty much the same.

My experience with other architectures suggests only a couple of
instructions need to be different to deal with a MMU being enabled.

Eric

