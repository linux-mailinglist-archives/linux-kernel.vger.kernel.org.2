Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A393264D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 16:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhBZPjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 10:39:53 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:59482 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhBZPju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 10:39:50 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lFfCV-000SD1-1a; Fri, 26 Feb 2021 08:38:43 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lFfCU-000gGq-17; Fri, 26 Feb 2021 08:38:42 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     chenzhou <chenzhou10@huawei.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <rppt@kernel.org>, <dyoung@redhat.com>,
        <will@kernel.org>, <nsaenzjulienne@suse.de>, <corbet@lwn.net>,
        <John.P.donnelly@oracle.com>, <prabhakar.pkin@gmail.com>,
        <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <james.morse@arm.com>, <xiexiuqi@huawei.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
        <20210130071025.65258-2-chenzhou10@huawei.com>
        <20210224141939.GA28965@arm.com>
        <20210225072426.GH3553@MiWiFi-R3L-srv>
        <121fa1e6-f1a3-d47f-bb1d-baaacf96fddc@huawei.com>
Date:   Fri, 26 Feb 2021 09:38:37 -0600
In-Reply-To: <121fa1e6-f1a3-d47f-bb1d-baaacf96fddc@huawei.com> (chenzhou's
        message of "Fri, 26 Feb 2021 14:45:25 +0800")
Message-ID: <m14khykfeq.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lFfCU-000gGq-17;;;mid=<m14khykfeq.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19FonAfyXHc11Z6qU3W8XfsdQm1v4+5X8w=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1917]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;chenzhou <chenzhou10@huawei.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 502 ms - load_scoreonly_sql: 0.12 (0.0%),
        signal_user_changed: 13 (2.6%), b_tie_ro: 11 (2.2%), parse: 1.68
        (0.3%), extract_message_metadata: 20 (4.0%), get_uri_detail_list: 3.2
        (0.6%), tests_pri_-1000: 8 (1.6%), tests_pri_-950: 1.80 (0.4%),
        tests_pri_-900: 1.49 (0.3%), tests_pri_-90: 101 (20.1%), check_bayes:
        98 (19.6%), b_tokenize: 13 (2.6%), b_tok_get_all: 10 (1.9%),
        b_comp_prob: 4.1 (0.8%), b_tok_touch_all: 68 (13.5%), b_finish: 1.09
        (0.2%), tests_pri_0: 330 (65.9%), check_dkim_signature: 0.78 (0.2%),
        check_dkim_adsp: 2.6 (0.5%), poll_dns_idle: 0.57 (0.1%), tests_pri_10:
        4.2 (0.8%), tests_pri_500: 15 (3.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v14 01/11] x86: kdump: replace the hard-coded alignment with macro CRASH_ALIGN
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

chenzhou <chenzhou10@huawei.com> writes:

> On 2021/2/25 15:25, Baoquan He wrote:
>> On 02/24/21 at 02:19pm, Catalin Marinas wrote:
>>> On Sat, Jan 30, 2021 at 03:10:15PM +0800, Chen Zhou wrote:
>>>> Move CRASH_ALIGN to header asm/kexec.h for later use. Besides, the
>>>> alignment of crash kernel regions in x86 is 16M(CRASH_ALIGN), but
>>>> function reserve_crashkernel() also used 1M alignment. So just
>>>> replace hard-coded alignment 1M with macro CRASH_ALIGN.
>>> [...]
>>>> @@ -510,7 +507,7 @@ static void __init reserve_crashkernel(void)
>>>>  	} else {
>>>>  		unsigned long long start;
>>>>  
>>>> -		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
>>>> +		start = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, crash_base,
>>>>  						  crash_base + crash_size);
>>>>  		if (start != crash_base) {
>>>>  			pr_info("crashkernel reservation failed - memory is in use.\n");
>>> There is a small functional change here for x86. Prior to this patch,
>>> crash_base passed by the user on the command line is allowed to be 1MB
>>> aligned. With this patch, such reservation will fail.
>>>
>>> Is the current behaviour a bug in the current x86 code or it does allow
>>> 1MB-aligned reservations?
>> Hmm, you are right. Here we should keep 1MB alignment as is because
>> users specify the address and size, their intention should be respected.
>> The 1MB alignment for fixed memory region reservation was introduced in
>> below commit, but it doesn't tell what is Eric's request at that time, I
>> guess it meant respecting users' specifying.


> I think we could make the alignment unified. Why is the alignment system reserved and
> user specified different? Besides, there is no document about the 1MB alignment.
> How about adding the alignment size(16MB) in doc  if user specified
> start address as arm64 does.

Looking at what the code is doing.  Attempting to reserve a crash region
at the location the user specified.  Adding unnecessary alignment
constraints is totally broken. 

I am not even certain enforcing a 1MB alignment makes sense.  I suspect
it was added so that we don't accidentally reserve low memory on x86.
Frankly I am not even certain that makes sense.

Now in practice there might be an argument for 2MB alignment that goes
with huge page sizes on x86.  But until someone finds that there are
actual problems with 1MB alignment I would not touch it.

The proper response to something that isn't documented and confusing is
not to arbitrarily change it and risk breaking users.  Especially in
this case where it is clear that adding additional alignment is total
nonsense.  The proper response to something that isn't clear and
documented is to dig in and document it, or to leave it alone and let it
be the next persons problem.

In this case there is no reason for changing this bit of code.
All CRASH_ALIGN is about is a default alignment when none is specified.
It is not a functional requirement but just something so that things
come out nicely.


Eric
