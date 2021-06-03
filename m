Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D100539AC14
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 22:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhFCUya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 16:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCUy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 16:54:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEF77613E4;
        Thu,  3 Jun 2021 20:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622753564;
        bh=poyg+QOFSNWZCGQMRbuV8/enr7w/SVzVB1S71DFF67I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RF/U5abLoEU7j2fjkhjcovkGWiLnIdKBrXySQm5c6hH90j7IDHy9R5QN8VLEIAxJg
         IuiA8TYCg+WP5Iy5cryCc6YilyI7vw8+EprLDM8StxMa7aRVs3qJ5b9xAT765sNvuI
         wCpXmWM9GHgGDvgZ9DiYA7r85nwPo2TihOjVBgyQrApUd6agS6QVPdMgLt+pdrrPfw
         sZQvVzMkYVV1nVNVSJ9shKjnF1wv4bT5OnXs7YTRkgjS3fKvc1oTp9qKt+MwSfcaCh
         vWJjXkCIoQ2a9FKfoLYT6PJWxGIae5OgyzOOv05a4UdbRLGz/FIOzQzOu/Dm+o35ZA
         CKaG5xuDz8hDQ==
Subject: Re: [PATCH v2 1/1] pgo: Fix allocate_node() v2
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bill Wendling <morbo@google.com>
References: <20210603133853.5383-1-jarmo.tiitto@gmail.com>
 <CAKwvOd=ygrySyMkJuGwyG7OPCOrTagcFn02RfEKANvhhuZJdOA@mail.gmail.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <f06200fd-4ce5-e976-20ec-d2ea9d734b3c@kernel.org>
Date:   Thu, 3 Jun 2021 13:52:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAKwvOd=ygrySyMkJuGwyG7OPCOrTagcFn02RfEKANvhhuZJdOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/2021 1:50 PM, Nick Desaulniers wrote:
> On Thu, Jun 3, 2021 at 6:41 AM Jarmo Tiitto <jarmo.tiitto@gmail.com> wrote:
>>
>> Based on Kees and others feedback here is v2 patch
>> that clarifies why the current checks in allocate_node()
>> are flawed. I did fair amount of KGDB time on it.
> 
> Kees can probably cut it when merging, but the above paragraph might
> be better "below the fold" below next time (doesn't necessitate a v3).
> 
>>
>> When clang instrumentation eventually calls allocate_node()
>> the struct llvm_prf_data *p argument tells us from what section
>> we should reserve the vnode: It either points into vmlinux's
>> core __llvm_prf_data section or some loaded module's
>> __llvm_prf_data section.
>>
>> But since we don't have access to corresponding
>> __llvm_prf_vnds section(s) for any module, the function
>> should return just NULL and ignore any profiling attempts
>> from modules for now.
>>
>> Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
>> ---
> 
> ^ ie. here. If you put text between the `---` and the diffstat, git
> just discards it when applying. It's a good way to hide commentary
> just meant for reviewers when sending a patch.
> 
> 
>>   kernel/pgo/instrument.c | 21 ++++++++++++---------
>>   1 file changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
>> index 0e07ee1b17d9..afe9982b07a3 100644
>> --- a/kernel/pgo/instrument.c
>> +++ b/kernel/pgo/instrument.c
>> @@ -23,6 +23,7 @@
>>   #include <linux/export.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/types.h>
>> +#include <asm-generic/sections.h>
>>   #include "pgo.h"
>>
>>   /*
>> @@ -55,17 +56,19 @@ void prf_unlock(unsigned long flags)
>>   static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data *p,
>>                                                   u32 index, u64 value)
>>   {
>> -       if (&__llvm_prf_vnds_start[current_node + 1] >= __llvm_prf_vnds_end)
>> -               return NULL; /* Out of nodes */
>> -
>> -       current_node++;
>> -
>> -       /* Make sure the node is entirely within the section */
>> -       if (&__llvm_prf_vnds_start[current_node] >= __llvm_prf_vnds_end ||
>> -           &__llvm_prf_vnds_start[current_node + 1] > __llvm_prf_vnds_end)
>> +       const int max_vnds = prf_vnds_count();
> 
> Sorry, where was prf_vnds_count() defined? I don't see it in
> linux-next, but I'm also not sure which tree has
> 5d0cda65918279ada060417c5fecb7e86ccb3def.

It is generated via the __DEFINE_PRF_SIZE macro in kernel/pgo/pgo.h.

>> +       /* Check that p is within vmlinux __llvm_prf_data section.
>> +        * If not, don't allocate since we can't handle modules yet.
>> +        */
>> +       if (!memory_contains(__llvm_prf_data_start,
>> +               __llvm_prf_data_end, p, sizeof(*p)))
>>                  return NULL;
>>
>> -       return &__llvm_prf_vnds_start[current_node];
>> +       if (WARN_ON_ONCE(current_node >= max_vnds))
>> +               return NULL; /* Out of nodes */
>> +
>> +       /* reserve vnode for vmlinux */
>> +       return &__llvm_prf_vnds_start[current_node++];
>>   }
>>
>>   /*
>>
>> base-commit: 5d0cda65918279ada060417c5fecb7e86ccb3def
>> --
>> 2.31.1
>>
> 
> 
> --
> Thanks,
> ~Nick Desaulniers
> 

