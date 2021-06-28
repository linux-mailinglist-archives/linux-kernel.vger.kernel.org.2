Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7C53B6AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 00:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbhF1WSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 18:18:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233557AbhF1WSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 18:18:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 738AA61CA2;
        Mon, 28 Jun 2021 22:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624918579;
        bh=EHZD/cw3xtMv8qxsRH+4HQFEaUaHWQKBSbOzxqtRxSw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AEZvXZO1KzdpZYRfvLK023ION4LaSe1xGHA+RaKqh5gOvSiZ62iA0pYuAGR5wA9dI
         /X2JCcHf+CSs5U9gHVqUVzZKFqGr31yC+pnoYOh6RfokB8x/mppzo/n1YAeMrOIAyC
         qDwSQEce3lnQjdRu5tNUnTeR6uSbJJEsK6ae8VThPelQjTDGmIIiLbpfpiLz/Zd/lN
         bIL6+fduBvEMvFApb32lv+wA4LLNclYfkf++vWa6FeLzHVYTmDWZwu1yFQO3/NL9wQ
         9dcKT+SR9NZESDHubS8UtLZFFlp8xgsixpLEPUUmoy58pCeaIbdCW9ySif3ShDCR1b
         PNZNaI5Bw1bvQ==
Subject: Re: [PATCH v3] kallsyms: strip LTO suffixes from static functions
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>, "KE . LI" <like1@oppo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <a970613b-014f-be76-e342-4a51e792b56d@kernel.org>
 <20210628203109.2501792-1-ndesaulniers@google.com>
 <YNo8+PWPu5ssAcau@archlinux-ax161>
 <CAKwvOdks4o8A1o7Q49Pa43ZyY5Zh6+s-u67FL-fp=16FP-Y7yw@mail.gmail.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <08a2e179-3f5f-639e-946f-54cd07ae12fa@kernel.org>
Date:   Mon, 28 Jun 2021 15:16:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdks4o8A1o7Q49Pa43ZyY5Zh6+s-u67FL-fp=16FP-Y7yw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/2021 3:01 PM, Nick Desaulniers wrote:
> On Mon, Jun 28, 2021 at 2:20 PM Nathan Chancellor <nathan@kernel.org> wrote:
>>
>> On Mon, Jun 28, 2021 at 01:31:06PM -0700, Nick Desaulniers wrote:
>>> Similar to:
>>> commit 8b8e6b5d3b01 ("kallsyms: strip ThinLTO hashes from static
>>> functions")
>>>
>>> It's very common for compilers to modify the symbol name for static
>>> functions as part of optimizing transformations. That makes hooking
>>> static functions (that weren't inlined or DCE'd) with kprobes difficult.
>>>
>>> LLVM has yet another name mangling scheme used by thin LTO.  Strip off
>>> these suffixes so that we can continue to hook such static functions.
>>>
>>> Reported-by: KE.LI(Lieke) <like1@oppo.com>
>>> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>>> ---
>>> Changes v2 -> V3:
>>> * Un-nest preprocessor checks, as per Nathan.
>>>
>>> Changes v1 -> v2:
>>> * Both mangling schemes can occur for thinLTO + CFI, this new scheme can
>>>    also occur for thinLTO without CFI. Split cleanup_symbol_name() into
>>>    two function calls.
>>> * Drop KE.LI's tested by tag.
>>> * Do not carry Fangrui's Reviewed by tag.
>>> * Drop the inline keyword; it is meaningless.
>>>   kernel/kallsyms.c | 32 +++++++++++++++++++++++++++++---
>>>   1 file changed, 29 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
>>> index 4067564ec59f..143c69e7e75d 100644
>>> --- a/kernel/kallsyms.c
>>> +++ b/kernel/kallsyms.c
>>> @@ -171,6 +171,26 @@ static unsigned long kallsyms_sym_address(int idx)
>>>        return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
>>>   }
>>>
>>> +#ifdef CONFIG_LTO_CLANG_THIN
>>> +/*
>>> + * LLVM appends a suffix for local variables that must be promoted to global
>>> + * scope as part of thin LTO. foo() becomes foo.llvm.974640843467629774. This
>>> + * can break hooking of static functions with kprobes.
>>> + */
>>> +static bool cleanup_symbol_name_thinlto(char *s)
>>> +{
>>> +     char *res;
>>> +
>>> +     res = strstr(s, ".llvm.");
>>> +     if (res)
>>> +             *res = '\0';
>>> +
>>> +     return res != NULL;
>>> +}
>>> +#else
>>> +static bool cleanup_symbol_name_thinlto(char *s) { return false; }
>>> +#endif /* CONFIG_LTO_CLANG_THIN */
>>> +
>>>   #if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
>>>   /*
>>>    * LLVM appends a hash to static function names when ThinLTO and CFI are
>>> @@ -178,7 +198,7 @@ static unsigned long kallsyms_sym_address(int idx)
>>>    * This causes confusion and potentially breaks user space tools, so we
>>>    * strip the suffix from expanded symbol names.
>>>    */
>>> -static inline bool cleanup_symbol_name(char *s)
>>> +static bool cleanup_symbol_name_thinlto_cfi(char *s)
>>>   {
>>>        char *res;
>>>
>>> @@ -189,8 +209,14 @@ static inline bool cleanup_symbol_name(char *s)
>>>        return res != NULL;
>>>   }
>>>   #else
>>> -static inline bool cleanup_symbol_name(char *s) { return false; }
>>> -#endif
>>> +static bool cleanup_symbol_name_thinlto_cfi(char *s) { return false; }
>>> +#endif /* CONFIG_CFI_CLANG && CONFIG_LTO_CLANG_THIN */
>>> +
>>> +static bool cleanup_symbol_name(char *s)
>>> +{
>>> +     return cleanup_symbol_name_thinlto(s) &&
>>> +             cleanup_symbol_name_thinlto_cfi(s);
>>> +}
>>>
>>>   /* Lookup the address for this symbol. Returns 0 if not found. */
>>>   unsigned long kallsyms_lookup_name(const char *name)
>>> --
>>> 2.32.0.93.g670b81a890-goog
>>>
>>
>> Is there any reason that we cannot eliminate the stubs and combine the
>> functions, or am I missing something? Completely untested diff.
>>
>> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
>> index c851ca0ed357..014b59ad68a3 100644
>> --- a/kernel/kallsyms.c
>> +++ b/kernel/kallsyms.c
>> @@ -161,26 +161,36 @@ static unsigned long kallsyms_sym_address(int idx)
>>          return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
>>   }
>>
>> -#if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
>> -/*
>> - * LLVM appends a hash to static function names when ThinLTO and CFI are
>> - * both enabled, i.e. foo() becomes foo$707af9a22804d33c81801f27dcfe489b.
>> - * This causes confusion and potentially breaks user space tools, so we
>> - * strip the suffix from expanded symbol names.
>> - */
>> -static inline bool cleanup_symbol_name(char *s)
>> +static inline bool cleanup_symbol_name_thinlto(char *s)
> 
> Drop inline while touching this line.

Sure.

>>   {
>>          char *res;
>>
>> -       res = strrchr(s, '$');
>> +       if (!IS_ENABLED(CONFIG_LTO_CLANG_THIN))
>> +               return false;
>> +
>> +       /*
>> +        * LLVM appends a suffix for local variables that must be promoted to global
>> +        * scope as part of ThinLTO. foo() becomes foo.llvm.974640843467629774. This
>> +        * can break hooking of static functions with kprobes.
>> +        */
>> +       res = strstr(s, ".llvm.");
>>          if (res)
>>                  *res = '\0';
> 
> Sure, this is nicer though within the true block we should `return
> true;` early rather than additionally check the $ mangling, I suppose.

I am not sure I follow? Are you talking about moving this into an else 
block in the if statement below this?

This should probably be two separate patches, with the first one 
eliminating the stub, dropping the inline, and renaming the function 
then the second patch do what this one does but I do not have a strong 
opinion.

I do not mind if you take ownership of this diff, with or without 
attribution.

>>
>> +       /*
>> +        * LLVM appends a hash to static function names when ThinLTO and CFI are
>> +        * both enabled, i.e. foo() becomes foo$707af9a22804d33c81801f27dcfe489b.
>> +        * This causes confusion and potentially breaks user space tools, so we
>> +        * strip the suffix from expanded symbol names.
>> +        */
>> +       if (IS_ENABLED(CONFIG_CFI_CLANG)) {
>> +               res = strrchr(s, '$');
>> +               if (res)
>> +                       *res = '\0';
>> +       }
>> +
>>          return res != NULL;
>>   }
>> -#else
>> -static inline bool cleanup_symbol_name(char *s) { return false; }
>> -#endif
>>
>>   /* Lookup the address for this symbol. Returns 0 if not found. */
>>   unsigned long kallsyms_lookup_name(const char *name)
>> @@ -195,7 +205,7 @@ unsigned long kallsyms_lookup_name(const char *name)
>>                  if (strcmp(namebuf, name) == 0)
>>                          return kallsyms_sym_address(i);
>>
>> -               if (cleanup_symbol_name(namebuf) && strcmp(namebuf, name) == 0)
>> +               if (cleanup_symbol_name_thinlto(namebuf) && strcmp(namebuf, name) == 0)
>>                          return kallsyms_sym_address(i);
>>          }
>>          return module_kallsyms_lookup_name(name);
> 
> 
> 
