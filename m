Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5A7368CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 07:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbhDWFjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 01:39:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241012AbhDWFjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 01:39:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 019DB6115B;
        Fri, 23 Apr 2021 05:38:38 +0000 (UTC)
Subject: Re: [PATCH v4 1/2] binfmt_flat: allow not offsetting data start
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     uclinux-dev@uclinux.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <mhng-5208d0c7-acc3-48ac-823d-ffef9f1123e0@palmerdabbelt-glaptop>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <f1faaadb-8ba5-6cff-4bba-928141936040@linux-m68k.org>
Date:   Fri, 23 Apr 2021 15:38:36 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <mhng-5208d0c7-acc3-48ac-823d-ffef9f1123e0@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/4/21 2:04 pm, Palmer Dabbelt wrote:
> On Thu, 22 Apr 2021 05:00:32 PDT (-0700), Damien Le Moal wrote:
>>> On 2021/04/18 11:38, Greg Ungerer wrote:
>>>
>>>
>>> On 17/4/21 2:54 pm, Damien Le Moal wrote:
>>>> On 2021/04/17 13:52, Greg Ungerer wrote:
>>>>>
>>>>> On 17/4/21 11:10 am, Damien Le Moal wrote:
>>>>>> Commit 2217b9826246 ("binfmt_flat: revert "binfmt_flat: don't offset
>>>>>> the data start"") restored offsetting the start of the data section by
>>>>>> a number of words defined by MAX_SHARED_LIBS. As a result, since
>>>>>> MAX_SHARED_LIBS is never 0, a gap between the text and data sections
>>>>>> always exists. For architectures which cannot support a such gap
>>>>>> between the text and data sections (e.g. riscv nommu), flat binary
>>>>>> programs cannot be executed.
>>>>>>
>>>>>> To allow an architecture to request no data start offset to allow for
>>>>>> contiguous text and data sections for binaries flagged with
>>>>>> FLAT_FLAG_RAM, introduce the new config option
>>>>>> CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET. Using this new option, the
>>>>>> macro DATA_START_OFFSET_WORDS is conditionally defined in binfmt_flat.c
>>>>>> to MAX_SHARED_LIBS for architectures tolerating or needing the data
>>>>>> start offset (CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET disabled case)
>>>>>> and to 0 when CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET is enabled.
>>>>>> DATA_START_OFFSET_WORDS is used in load_flat_file() to calculate the
>>>>>> data section length and start position.
>>>>>>
>>>>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>>>>>> ---
>>>>>>    fs/Kconfig.binfmt |  3 +++
>>>>>>    fs/binfmt_flat.c  | 19 ++++++++++++++-----
>>>>>>    2 files changed, 17 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
>>>>>> index c6f1c8c1934e..06fb7a93a1bd 100644
>>>>>> --- a/fs/Kconfig.binfmt
>>>>>> +++ b/fs/Kconfig.binfmt
>>>>>> @@ -112,6 +112,9 @@ config BINFMT_FLAT_ARGVP_ENVP_ON_STACK
>>>>>>    config BINFMT_FLAT_OLD_ALWAYS_RAM
>>>>>>        bool
>>>>>> +config BINFMT_FLAT_NO_DATA_START_OFFSET
>>>>>> +    bool
>>>>>> +
>>>>>>    config BINFMT_FLAT_OLD
>>>>>>        bool "Enable support for very old legacy flat binaries"
>>>>>>        depends on BINFMT_FLAT
>>>>>> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
>>>>>> index b9c658e0548e..1dc68dfba3e0 100644
>>>>>> --- a/fs/binfmt_flat.c
>>>>>> +++ b/fs/binfmt_flat.c
>>>>>> @@ -74,6 +74,12 @@
>>>>>>    #define    MAX_SHARED_LIBS            (1)
>>>>>>    #endif
>>>>>> +#ifdef CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET
>>>>>> +#define DATA_START_OFFSET_WORDS        (0)
>>>>>> +#else
>>>>>> +#define DATA_START_OFFSET_WORDS        (MAX_SHARED_LIBS)
>>>>>> +#endif
>>>>>> +
>>>>>>    struct lib_info {
>>>>>>        struct {
>>>>>>            unsigned long start_code;        /* Start of text segment */
>>>>>> @@ -560,6 +566,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>>>>>>         * it all together.
>>>>>>         */
>>>>>>        if (!IS_ENABLED(CONFIG_MMU) && !(flags & (FLAT_FLAG_RAM|FLAT_FLAG_GZIP))) {
>>>>>> +
>>>>>
>>>>> Random white space change...
>>>>> Don't worry about re-spinning though, I will just edit this chunk out.
>>>>
>>>> Oops. Sorry about that. I should have better checked :)
>>>>
>>>>>
>>>>>
>>>>>>            /*
>>>>>>             * this should give us a ROM ptr,  but if it doesn't we don't
>>>>>>             * really care
>>>>>> @@ -576,7 +583,8 @@ static int load_flat_file(struct linux_binprm *bprm,
>>>>>>                goto err;
>>>>>>            }
>>>>>> -        len = data_len + extra + MAX_SHARED_LIBS * sizeof(unsigned long);
>>>>>> +        len = data_len + extra +
>>>>>> +            DATA_START_OFFSET_WORDS * sizeof(unsigned long);
>>>>>>            len = PAGE_ALIGN(len);
>>>>>>            realdatastart = vm_mmap(NULL, 0, len,
>>>>>>                PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, 0);
>>>>>> @@ -591,7 +599,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>>>>>>                goto err;
>>>>>>            }
>>>>>>            datapos = ALIGN(realdatastart +
>>>>>> -                MAX_SHARED_LIBS * sizeof(unsigned long),
>>>>>> +                DATA_START_OFFSET_WORDS * sizeof(unsigned long),
>>>>>>                    FLAT_DATA_ALIGN);
>>>>>>            pr_debug("Allocated data+bss+stack (%u bytes): %lx\n",
>>>>>> @@ -622,7 +630,8 @@ static int load_flat_file(struct linux_binprm *bprm,
>>>>>>            memp_size = len;
>>>>>>        } else {
>>>>>> -        len = text_len + data_len + extra + MAX_SHARED_LIBS * sizeof(u32);
>>>>>> +        len = text_len + data_len + extra +
>>>>>> +            DATA_START_OFFSET_WORDS * sizeof(u32);
>>>>>>            len = PAGE_ALIGN(len);
>>>>>>            textpos = vm_mmap(NULL, 0, len,
>>>>>>                PROT_READ | PROT_EXEC | PROT_WRITE, MAP_PRIVATE, 0);
>>>>>> @@ -638,7 +647,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>>>>>>            realdatastart = textpos + ntohl(hdr->data_start);
>>>>>>            datapos = ALIGN(realdatastart +
>>>>>> -                MAX_SHARED_LIBS * sizeof(u32),
>>>>>> +                DATA_START_OFFSET_WORDS * sizeof(u32),
>>>>>>                    FLAT_DATA_ALIGN);
>>>>>>            reloc = (__be32 __user *)
>>>>>> @@ -714,7 +723,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>>>>>>                ret = result;
>>>>>>                pr_err("Unable to read code+data+bss, errno %d\n", ret);
>>>>>>                vm_munmap(textpos, text_len + data_len + extra +
>>>>>> -                MAX_SHARED_LIBS * sizeof(u32));
>>>>>> +                  DATA_START_OFFSET_WORDS * sizeof(u32));
>>>>>>                goto err;
>>>>>>            }
>>>>>>        }
>>>>>>
>>>>>
>>>>> Thanks, otherwise looks good.
>>>>>
>>>>> Acked-by: Greg Ungerer <gerg@linux-m68k.org>
>>>>>
>>>>> I will push this into my m68knommu tree, for-next branch.
>>>>> I just carry the flat format changes in that tree now to make my life easier.
>>>>
>>>> Great. Thanks !
>>>> Are you taking both patches or should Plamer take the riscv Kconfig change
>>>> through his tree ?
>>>
>>> I am happy to take both.
>>> Palmer?
>>
>> Palmer,
>>
>> Ping !
> 
> I already Ack'd it, in the thread where we couldn't find the maintainer. Keeping these togther is fine with me, and it seems easiest.

The 2/2 patch has been applied to the m68knommu git tree, for-next branch.

Regards
Greg


