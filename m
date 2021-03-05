Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFCB32E394
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 09:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhCEIX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 03:23:26 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:28265 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229693AbhCEIXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 03:23:05 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DsLMp3HQjz9twsB;
        Fri,  5 Mar 2021 09:23:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id kZwaV1QlYV6g; Fri,  5 Mar 2021 09:23:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DsLMp21cgz9tws9;
        Fri,  5 Mar 2021 09:23:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 499B18B78B;
        Fri,  5 Mar 2021 09:23:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0Bg31oR211ZU; Fri,  5 Mar 2021 09:23:03 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8075A8B791;
        Fri,  5 Mar 2021 09:23:02 +0100 (CET)
Subject: Re: [RFC PATCH v1] powerpc: Enable KFENCE for PPC32
To:     Marco Elver <elver@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Alexander Potapenko <glider@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>
References: <CANpmjNPGj4C2rr2FbSD+FC-GnWUvJrtdLyX5TYpJE_Um8CGu1Q@mail.gmail.com>
 <08a96c5d-4ae7-03b4-208f-956226dee6bb@csgroup.eu>
 <CANpmjNPYEmLtQEu5G=zJLUzOBaGoqNKwLyipDCxvytdKDKb7mg@mail.gmail.com>
 <ad61cb3a-2b4a-3754-5761-832a1dd0c34e@csgroup.eu>
 <CANpmjNOnVzei7frKcMzMHxaDXh5NvTA-Wpa29C2YC1GUxyKfhQ@mail.gmail.com>
 <f036c53d-7e81-763c-47f4-6024c6c5f058@csgroup.eu>
 <CANpmjNMn_CUrgeSqBgiKx4+J8a+XcxkaLPWoDMUvUEXk8+-jxg@mail.gmail.com>
 <7270e1cc-bb6b-99ee-0043-08a027b8d83a@csgroup.eu>
 <YEDXJ5JNkgvDFehc@elver.google.com> <874khqry78.fsf@mpe.ellerman.id.au>
 <YEHiq1ALdPn2crvP@elver.google.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <f6e47f4f-6953-6584-f023-8b9c22d6974e@csgroup.eu>
Date:   Fri, 5 Mar 2021 09:23:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YEHiq1ALdPn2crvP@elver.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 05/03/2021 à 08:50, Marco Elver a écrit :
> On Fri, Mar 05, 2021 at 04:01PM +1100, Michael Ellerman wrote:
>> Marco Elver <elver@google.com> writes:
>>> On Thu, Mar 04, 2021 at 12:48PM +0100, Christophe Leroy wrote:
>>>> Le 04/03/2021 à 12:31, Marco Elver a écrit :
>>>>> On Thu, 4 Mar 2021 at 12:23, Christophe Leroy
>>>>> <christophe.leroy@csgroup.eu> wrote:
>>>>>> Le 03/03/2021 à 11:56, Marco Elver a écrit :
>>>>>>>
>>>>>>> Somewhat tangentially, I also note that e.g. show_regs(regs) (which
>>>>>>> was printed along the KFENCE report above) didn't include the top
>>>>>>> frame in the "Call Trace", so this assumption is definitely not
>>>>>>> isolated to KFENCE.
>>>>>>>
>>>>>>
>>>>>> Now, I have tested PPC64 (with the patch I sent yesterday to modify save_stack_trace_regs()
>>>>>> applied), and I get many failures. Any idea ?
>>>>>>
>>>>>> [   17.653751][   T58] ==================================================================
>>>>>> [   17.654379][   T58] BUG: KFENCE: invalid free in .kfence_guarded_free+0x2e4/0x530
>>>>>> [   17.654379][   T58]
>>>>>> [   17.654831][   T58] Invalid free of 0xc00000003c9c0000 (in kfence-#77):
>>>>>> [   17.655358][   T58]  .kfence_guarded_free+0x2e4/0x530
>>>>>> [   17.655775][   T58]  .__slab_free+0x320/0x5a0
>>>>>> [   17.656039][   T58]  .test_double_free+0xe0/0x198
>>>>>> [   17.656308][   T58]  .kunit_try_run_case+0x80/0x110
>>>>>> [   17.656523][   T58]  .kunit_generic_run_threadfn_adapter+0x38/0x50
>>>>>> [   17.657161][   T58]  .kthread+0x18c/0x1a0
>>>>>> [   17.659148][   T58]  .ret_from_kernel_thread+0x58/0x70
>>>>>> [   17.659869][   T58]
>>> [...]
>>>>>
>>>>> Looks like something is prepending '.' to function names. We expect
>>>>> the function name to appear as-is, e.g. "kfence_guarded_free",
>>>>> "test_double_free", etc.
>>>>>
>>>>> Is there something special on ppc64, where the '.' is some convention?
>>>>>
>>>>
>>>> I think so, see https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi.html#FUNC-DES
>>>>
>>>> Also see commit https://github.com/linuxppc/linux/commit/02424d896
>>>
>>> Thanks -- could you try the below patch? You'll need to define
>>> ARCH_FUNC_PREFIX accordingly.
>>>
>>> We think, since there are only very few architectures that add a prefix,
>>> requiring <asm/kfence.h> to define something like ARCH_FUNC_PREFIX is
>>> the simplest option. Let me know if this works for you.
>>>
>>> There an alternative option, which is to dynamically figure out the
>>> prefix, but if this simpler option is fine with you, we'd prefer it.
>>
>> We have rediscovered this problem in basically every tracing / debugging
>> feature added in the last 20 years :)
>>
>> I think the simplest solution is the one tools/perf/util/symbol.c uses,
>> which is to just skip a leading '.'.
>>
>> Does that work?
>>
>> diff --git a/mm/kfence/report.c b/mm/kfence/report.c
>> index ab83d5a59bb1..67b49dc54b38 100644
>> --- a/mm/kfence/report.c
>> +++ b/mm/kfence/report.c
>> @@ -67,6 +67,9 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
>>   	for (skipnr = 0; skipnr < num_entries; skipnr++) {
>>   		int len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skipnr]);
>>   
>> +		if (buf[0] == '.')
>> +			buf++;
>> +
> 
> Unfortunately this does not work, since buf is an array. We'd need an
> offset, and it should be determined outside the loop. I had a solution
> like this, but it turned out quite complex (see below). And since most
> architectures do not require this, decided that the safest option is to
> use the macro approach with ARCH_FUNC_PREFIX, for which Christophe
> already prepared a patch and tested:
> https://lore.kernel.org/linux-mm/20210304144000.1148590-1-elver@google.com/
> https://lkml.kernel.org/r/afaec81a551ef15345cb7d7563b3fac3d7041c3a.1614868445.git.christophe.leroy@csgroup.eu
> 
> Since KFENCE requires <asm/kfence.h> anyway, we'd prefer this approach
> (vs.  dynamically detecting).
> 
> Thanks,
> -- Marco
> 

What about

diff --git a/mm/kfence/report.c b/mm/kfence/report.c
index 519f037720f5..5e196625fb34 100644
--- a/mm/kfence/report.c
+++ b/mm/kfence/report.c
@@ -43,7 +43,7 @@ static void seq_con_printf(struct seq_file *seq, const char *fmt, ...)
  static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries,
  			    const enum kfence_error_type *type)
  {
-	char buf[64];
+	char _buf[64];
  	int skipnr, fallback = 0;

  	if (type) {
@@ -65,7 +65,11 @@ static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries
  	}

  	for (skipnr = 0; skipnr < num_entries; skipnr++) {
-		int len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skipnr]);
+		char *buf = _buf;
+		int len = scnprintf(_buf, sizeof(_buf), "%ps", (void *)stack_entries[skipnr]);
+
+		if (_buf[0] == '.')
+			buf++, len--;

  		if (str_has_prefix(buf, "kfence_") || str_has_prefix(buf, "__kfence_") ||
  		    !strncmp(buf, "__slab_free", len)) {
---

Christophe
