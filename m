Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F5239FCF4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbhFHRAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:00:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231278AbhFHQ77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:59:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C85316128A;
        Tue,  8 Jun 2021 16:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623171486;
        bh=Ja60BwzhwKaBB5iIiSXsEGAZVJfmAoDxNKFPZcXcG3I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tlP0ZO+WdQp8AVW+NfqrsB+lZ80F3LPab6qHr772OKPDFC38dIEdeO2QzkK0jVS3c
         zYqGZwwCh64jPTUTFJHODg1FMdgPVyQPG2pf6MyluRCvuEWIEpbFHD0xXw9Xjnvy46
         iJRAmoAGRWMt3y5YzGlE55u1vIU97Aq58iaaZA9cKudIz7a9jPRy5wU/6lS4di+1qP
         WPeXsf5gQxavK9KZ6S5MvzVsTj22S9QidR3XZeSRDEQGRKoP3f6LU3ZM/14kElQFyB
         LYdlQ0bTssPLY1WJjw7UJY7i16bjJ3/jVyBSogr+ldKwOexr2oRFY3fdFrh852ozk3
         5m6yOqs/c7K0Q==
Subject: Re: [PATCH v3 16/16] objtool,x86: Rewrite retpoline thunk calls
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, lma@semihalf.com,
        Guenter Roeck <groeck@google.com>,
        Juergen Gross <jgross@suse.com>, lb@semihalf.com,
        LKML <linux-kernel@vger.kernel.org>, mbenes@suse.com,
        =?UTF-8?Q?Rados=c5=82aw_Biernacki?= <rad@semihalf.com>,
        upstream@semihalf.com,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>
References: <CAFJ_xbq06nfaEWtVNLtg7XCJrQeQ9wCs4Zsoi5Y_HP3Dx0iTRA@mail.gmail.com>
 <20210604205018.2238778-1-ndesaulniers@google.com>
 <CAKwvOdmhg2tj8cKe-XitoZXGKaoOhgTsCEdVXubt+LiY9+46rw@mail.gmail.com>
 <20210604235046.w3hazgcpsg4oefex@google.com>
 <YLtUO/thYUp2wU7k@hirez.programming.kicks-ass.net>
 <CAFP8O3+ggR8N-ffsaYSMPX7s2XgrzzTQQjOgCwUe9smyos-waA@mail.gmail.com>
 <YL3RQCJGIw9835Y1@hirez.programming.kicks-ass.net>
 <YL3lQ5QdNV2qwLR/@hirez.programming.kicks-ass.net>
 <YL3q1qFO9QIRL/BA@hirez.programming.kicks-ass.net>
 <CAKwvOdkuJBwZRigeqdZGevPF9WHyrC5pBAsz6_tWdXAc-wO+1A@mail.gmail.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <e351ac97-4038-61b5-b373-63698a787fc1@kernel.org>
Date:   Tue, 8 Jun 2021 09:58:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkuJBwZRigeqdZGevPF9WHyrC5pBAsz6_tWdXAc-wO+1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/2021 1:54 PM, 'Nick Desaulniers' via Clang Built Linux wrote:
> On Mon, Jun 7, 2021 at 2:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
> 
> Thanks, the below diff resolves the linker error reported in
> https://github.com/ClangBuiltLinux/linux/issues/1388
> 
> Both readelf implementations seem happy with the results, too.
> 
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> Nathan,
> Can you please test the below diff and see if that resolves your boot
> issue reported in:
> https://github.com/ClangBuiltLinux/linux/issues/1384

Unfortunately, it does not appear to resolve that issue.

$ git log -2 --decorate=no --oneline
eea6a9d6d277 Peter's fix
614124bea77e Linux 5.13-rc5

$ strings /mnt/c/Users/natec/Linux/kernel-investigation | grep microsoft
5.13.0-rc5-microsoft-standard-WSL2-00001-geea6a9d6d277 
(nathan@archlinux-ax161) #3 SMP Tue Jun 8 09:46:19 MST 2021

My VM still never makes it to userspace.

>> ---
>>   tools/objtool/elf.c | 25 ++++++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
>> index 743c2e9d0f56..41bca1d13d8e 100644
>> --- a/tools/objtool/elf.c
>> +++ b/tools/objtool/elf.c
>> @@ -717,7 +717,7 @@ static int elf_add_string(struct elf *elf, struct section *strtab, char *str)
>>
>>   struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
>>   {
>> -       struct section *symtab;
>> +       struct section *symtab, *symtab_shndx;
>>          struct symbol *sym;
>>          Elf_Data *data;
>>          Elf_Scn *s;
>> @@ -769,6 +769,29 @@ struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
>>          symtab->len += data->d_size;
>>          symtab->changed = true;
>>
>> +       symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
>> +       if (symtab_shndx) {
>> +               s = elf_getscn(elf->elf, symtab_shndx->idx);
>> +               if (!s) {
>> +                       WARN_ELF("elf_getscn");
>> +                       return NULL;
>> +               }
>> +
>> +               data = elf_newdata(s);
>> +               if (!data) {
>> +                       WARN_ELF("elf_newdata");
>> +                       return NULL;
>> +               }
>> +
>> +               data->d_buf = &sym->sym.st_size; /* conveniently 0 */
>> +               data->d_size = sizeof(Elf32_Word);
>> +               data->d_align = 4;
>> +               data->d_type = ELF_T_WORD;
>> +
>> +               symtab_shndx->len += 4;
>> +               symtab_shndx->changed = true;
>> +       }
>> +
>>          sym->sec = find_section_by_index(elf, 0);
>>
>>          elf_add_symbol(elf, sym);
> 
> 
> The only thing that's still different is that the `file` command still
> prints "no section header."
> 
> $ find . -name \*.lto.o | xargs file | rev | cut -d , -f 1 | rev |
> sort | uniq -c
>        1  no section header
>     8377  not stripped
>        1  too many section headers (33683)
>        1  too many section headers (50758)
> $ file --version
> file-5.39
> 
> That's drivers/gpu/drm/amd/amdgpu/amdgpu.lto.o, fs/xfs/xfs.lto.o,
> drivers/gpu/drm/i915/i915.lto.o, respectively.  I'm not sure that's a
> problem, yet, and whether 9bc0bb50727c8ac69fbb33fb937431cf3518ff37 is
> even related yet; those might just be huge drivers and figured it was
> reporting somewhere in case it ever comes up again.  CONFIG_LTO
> implies -ffunction-sections -fdata-sections, and
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION explicitly sets those, too.
> 
