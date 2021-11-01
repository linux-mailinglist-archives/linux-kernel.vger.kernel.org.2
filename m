Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16619442273
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhKAVS2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 1 Nov 2021 17:18:28 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:60078 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhKAVS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:18:27 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:35836)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mheek-007Fck-MN; Mon, 01 Nov 2021 15:15:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:34714 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mheej-00B5mV-HN; Mon, 01 Nov 2021 15:15:50 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     Liao Chang <liaochang1@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Kossifidis <mick@ics.forth.gr>, jszhang@kernel.org,
        guoren@linux.alibaba.com, Pekka Enberg <penberg@kernel.org>,
        sunnanyong@huawei.com, wangkefeng.wang@huawei.com,
        changbin.du@intel.com, Alex Ghiti <alex@ghiti.fr>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
References: <20211030031832.165457-1-liaochang1@huawei.com>
        <20211030031832.165457-3-liaochang1@huawei.com>
        <87ee83goju.fsf@disp2133>
        <CAJ+HfNjaBQrBtOuMvTccbb2K-Ua=T1eZk0+70hp0_aOAc83A-Q@mail.gmail.com>
Date:   Mon, 01 Nov 2021 16:15:42 -0500
In-Reply-To: <CAJ+HfNjaBQrBtOuMvTccbb2K-Ua=T1eZk0+70hp0_aOAc83A-Q@mail.gmail.com>
        (=?utf-8?Q?=22Bj=C3=B6rn_T=C3=B6pel=22's?= message of "Sun, 31 Oct 2021
 12:14:33 +0100")
Message-ID: <87a6inbmrl.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1mheej-00B5mV-HN;;;mid=<87a6inbmrl.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18DBOf1ufm8A1FhY1m4kqu+CrD7jATo5Fs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMNoVowels,XM_B_SpammyWords,XM_B_Unicode
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4361]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?*;Bj=c3=b6rn T=c3=b6pel <bjorn.topel@gmail.com>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 566 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 13 (2.3%), b_tie_ro: 11 (2.0%), parse: 0.93
        (0.2%), extract_message_metadata: 14 (2.5%), get_uri_detail_list: 1.10
        (0.2%), tests_pri_-1000: 15 (2.6%), tests_pri_-950: 1.42 (0.3%),
        tests_pri_-900: 1.20 (0.2%), tests_pri_-90: 104 (18.4%), check_bayes:
        101 (17.8%), b_tokenize: 6 (1.1%), b_tok_get_all: 9 (1.5%),
        b_comp_prob: 2.5 (0.4%), b_tok_touch_all: 78 (13.7%), b_finish: 1.56
        (0.3%), tests_pri_0: 402 (71.0%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 5 (0.9%), poll_dns_idle: 0.68 (0.1%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 9 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3] RISC-V: use memcpy for kexec_file mode
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Björn Töpel <bjorn.topel@gmail.com> writes:

> On Sat, 30 Oct 2021 at 05:51, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Liao Chang <liaochang1@huawei.com> writes:
>>
>> > The pointer to buffer loading kernel binaries is in kernel space for
>> > kexec_fil mode, When copy_from_user copies data from pointer to a block
>> > of memory, it checkes that the pointer is in the user space range, on
>> > RISCV-V that is:
>> >
>> > static inline bool __access_ok(unsigned long addr, unsigned long size)
>> > {
>> >       return size <= TASK_SIZE && addr <= TASK_SIZE - size;
>> > }
>> >
>> > and TASK_SIZE is 0x4000000000 for 64-bits, which now causes
>> > copy_from_user to reject the access of the field 'buf' of struct
>> > kexec_segment that is in range [CONFIG_PAGE_OFFSET - VMALLOC_SIZE,
>> > CONFIG_PAGE_OFFSET), is invalid user space pointer.
>> >
>> > This patch fixes this issue by skipping access_ok(), use mempcy() instead.
>>
>> I am a bit confused.
>>
>> Why is machine_kexec ever calling copy_from_user?  That seems wrong in
>> all cases.
>>
>
> It's not machine_kexec -- it's machine_kexec_prepare, which pulls out
> the FDT from the image. It looks like MIPS does it similarly.
>
> (Caveat: I might be confused as well! ;-))

True it is machine_kexec_prepare.  But still.  copy_from_user does not
belong in there.  It is not passed a userspace pointer.

This looks more like a case for kmap to read a table from the firmware.

Even if it someone made sense it definitely does not make sense to
make it a conditional copy_from_user.  That way lies madness.

The entire change is a smell that there is some abstraction that is
going wrong, and that abstraction needs to get fixed.

Eric

