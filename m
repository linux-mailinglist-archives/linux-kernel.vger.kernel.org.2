Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9797730FFD6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 23:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhBDWEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 17:04:22 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:54458 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhBDWEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 17:04:22 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1l7miw-001euo-3u; Thu, 04 Feb 2021 15:03:38 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1l7miu-005DRQ-V7; Thu, 04 Feb 2021 15:03:37 -0700
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
        <871rdwocwh.fsf@x220.int.ebiederm.org>
        <CA+CK2bD9NQ=waaoi4=Ub9o9uKWaAs_ZO8LEwxB2XFhacRhnbOQ@mail.gmail.com>
Date:   Thu, 04 Feb 2021 16:02:10 -0600
In-Reply-To: <CA+CK2bD9NQ=waaoi4=Ub9o9uKWaAs_ZO8LEwxB2XFhacRhnbOQ@mail.gmail.com>
        (Pavel Tatashin's message of "Thu, 4 Feb 2021 10:23:03 -0500")
Message-ID: <87mtwjlcf1.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1l7miu-005DRQ-V7;;;mid=<87mtwjlcf1.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1967rv9jJb2i/4oj5U7tM7yOiSVLl8Fvaw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4996]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Pavel Tatashin <pasha.tatashin@soleen.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 623 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 11 (1.8%), b_tie_ro: 10 (1.6%), parse: 1.31
        (0.2%), extract_message_metadata: 14 (2.2%), get_uri_detail_list: 2.9
        (0.5%), tests_pri_-1000: 6 (1.0%), tests_pri_-950: 1.31 (0.2%),
        tests_pri_-900: 1.07 (0.2%), tests_pri_-90: 86 (13.8%), check_bayes:
        84 (13.5%), b_tokenize: 12 (1.9%), b_tok_get_all: 11 (1.8%),
        b_comp_prob: 3.5 (0.6%), b_tok_touch_all: 54 (8.6%), b_finish: 1.15
        (0.2%), tests_pri_0: 474 (76.1%), check_dkim_signature: 1.27 (0.2%),
        check_dkim_adsp: 2.4 (0.4%), poll_dns_idle: 0.60 (0.1%), tests_pri_10:
        4.1 (0.7%), tests_pri_500: 20 (3.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v11 0/6] arm64: MMU enabled kexec relocation
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Tatashin <pasha.tatashin@soleen.com> writes:

>> > I understand that having an extra set of page tables could potentially
>> > waste memory, especially if VAs are sparse, but in this case we use
>> > page tables exclusively for contiguous VA space (copy [src, src +
>> > size]). Therefore, the extra memory usage is tiny. The ratio for
>> > kernels with  4K page_size is (size of relocated memory) / 512.  A
>> > normal initrd + kernel is usually under 64M, an extra space which
>> > means ~128K for the page table. Even with a huge relocation, where
>> > initrd is ~512M the extra memory usage in the worst case is just ~1M.
>> > I really doubt we will have any problem from users because of such
>> > small overhead in comparison to the total kexec-load size.
>
> Hi Eric,
>
>>
>> Foolish question.
>
> Thank you for your e-mail, you gave some interesting insights.
>
>>
>> Does arm64 have something like 2M pages that it can use for the
>> linear map?
>
> Yes, with 4K pages arm64 as well has 2M pages, but arm64 also has a
> choice of 16K and 64K and second level pages are bigger there.

>> On x86_64 we always generate page tables, because they are necessary to
>> be in 64bit mode.  As I recall on x86_64 we always use 2M pages which
>> means for each 4K of page tables we map 1GiB of memory.   Which is very
>> tiny.
>>
>> If you do as well as x86_64 for arm64 I suspect that will be good enough
>> for people to not claim regression.
>>
>> Would a variation on the x86_64 implementation that allocates page
>> tables work for arm64?
> ...
>>
>> As long as the page table provided is a linear mapping of physical
>> memory (aka it looks like paging is disabled).  The the code that
>> relocates memory should be pretty much the same.
>>
>> My experience with other architectures suggests only a couple of
>> instructions need to be different to deal with a MMU being enabled.
>
> I think what you are proposing is similar to what James proposed. Yes,
> for a linear map relocation should be pretty much the same as we do
> relocation as with MMU disabled.
>
> Linear map still uses memory, because page tables must be outside of
> destination addresses of segments of the next kernel. Therefore, we
> must allocate a page table for the linear map. It might be a little
> smaller, but in reality the difference is small with 4K pages, and
> insignificant with 64K pages. The benefit of my approach is that the
> assembly copy loop is simpler, and allows hardware prefetching to
> work.
>
> The regular relocation loop works like this:
>
> for (entry = head; !(entry & IND_DONE); entry = *ptr++) {
>         addr = __va(entry & PAGE_MASK);
>
>         switch (entry & IND_FLAGS) {
>         case IND_DESTINATION:
>                 dest = addr;
>                 break;
>         case IND_INDIRECTION:
>                 ptr = addr;
>                 break;
>         case IND_SOURCE:
>                 copy_page(dest, addr);
>                 dest += PAGE_SIZE;
>         }
> }
>
> The entry for the next relocation page has to be always fetched, and
> therefore prefetching cannot help with the actual loop.

True.

In the common case the loop looks like:
> for (entry = head; !(entry & IND_DONE); entry = *ptr++) {
>         addr = __va(entry & PAGE_MASK);
>
>         switch (entry & IND_FLAGS) {
>         case IND_SOURCE:
>                 copy_page(dest, addr);
>                 dest += PAGE_SIZE;
>         }
> }

Which is a read of the source address followed by the copy_page.
I suspect the overhead of that loop is small enough that it swamped by
the cost of the copy_page.

If not and a better data structure can be proposed we can look at that.

> In comparison, the loop that I am proposing is like this:
>
> for (addr = head; addr < end; addr += PAGE_SIZE, dst += PAGE_SIZE)
>         copy_page(dest, addr);
>
> Here is assembly code for my loop:
>
> 1: copy_page x1, x2, x3, x4, x5, x6, x7, x8, x9, x10
>     sub x11, x11, #PAGE_SIZE
>     cbnz x11, 1b

I think you may be hiding the cost of that loop in the page table
fetches themselves.

It is possible though unlikely that a page table with huge pages
(and thus smaller page fault costs) and the original loop is actually
cheaper.

> That said, if James and you agree that linear map is the way to go
> forward, I am OK with that as well, as it is still much better than
> having no caching at all.

The big advantage of a linear map is that the kexec'd code can continue
to use it until it sets up it's own page tables.

I probably did not document it well enough but a linear map then
equivalent of not having virtual addresses at all was always my
intention for the hand-off state of kexec between kernels.

So please try the linear map.  If it is noticably slower than your
optimized page table give numbers and we can see if there is a way to
improve the generic kexec data structures.

Eric
