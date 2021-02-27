Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2654C326B8E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 05:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhB0Edn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 23:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhB0Edl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 23:33:41 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC80C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 20:33:01 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id h4so7442395pgf.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 20:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=acGrNbfX1ONJlBYzGoeWien8tX1BAEMbXbxus24dvo4=;
        b=VwhYGS10gHHtx4bHrQ+wdwiMVGIFYdndXhNbDSfz8LMNKUZDsxDS77KcBXcM48iDsf
         9Yx4pIOReijOyL27CHIKdm8BwvkfjeEYo9cDnsBzlVmT7Ox1+zJUDuXeWPtcn1d8D7dS
         NjIRO1lR9xVX6PnAd2pqMx6+nfu0y2yeWfL9J6XBE50qTOjiwP8sppW9V8NxCvMW/Pmi
         hXh3f/58KJZhyZKf7TTCoQP9cDYdD0AGueo9F6F1MhCKkTcjlvmOVTVoXGLxP+W+uXaF
         I6kOux4osK/cQG/fBojEJSHumtDiGPajb8aGeeBidUi7StBiFkkxhioNoOmFhDcAHY/O
         ImIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=acGrNbfX1ONJlBYzGoeWien8tX1BAEMbXbxus24dvo4=;
        b=D/GEVqQp5mztatGfgPPZdmWXyZOYyelg+u/Uk0AuB8vpLp3Vx0SIXvedI4AXdW7Lbm
         tIyPBkhk50khL1Mdaq3Aq+5tELqsLAPiF8xB9b8Pr6y1ynq9nC7hgFIj72Gm25iKa+0R
         70ZH5RLcsIxATplcRI2Eubz3MZppNje8yAUKCeorcepH8bkbB1tnvUUtUOWgUH1nY04U
         6lzWIKGUbIJJI/m2qujlGkJ8yJyPGxZHBlvwWnJLLdKt4IEEoprIF2dUuNvHbT9V4xqh
         DVUDbPnFRAX0gUco7T0VGoziB5cim0yeu5+I6/MvtRM/dsXaHJOeiumkJGSeGUNOpdOD
         RiMg==
X-Gm-Message-State: AOAM530m6f8hReadPLN8OKmPauP6TuZhlSjsn5/S6hRImMTUWJ12xlJ9
        hptf2LYJw28W4q+XIqQLC1rHRQ==
X-Google-Smtp-Source: ABdhPJz7f04Lrx3tfHHrsCRXLLVkuuTouZTHKhhx2qi6IMSYDexUKG5EZ6UhtonHmgDkT+l9SID3fg==
X-Received: by 2002:a63:a22:: with SMTP id 34mr5663613pgk.328.1614400380990;
        Fri, 26 Feb 2021 20:33:00 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:48ad:d4d0:f627:c01f])
        by smtp.gmail.com with ESMTPSA id v5sm10761519pfc.100.2021.02.26.20.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 20:33:00 -0800 (PST)
Date:   Fri, 26 Feb 2021 20:32:57 -0800
From:   Fangrui Song <maskray@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: vmlinux.lds.S: keep .entry.tramp.text section
Message-ID: <20210227043257.k3aernmnzsvitp7c@google.com>
References: <20210226140352.3477860-1-arnd@kernel.org>
 <202102261256.AF256702@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202102261256.AF256702@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021-02-26, Kees Cook wrote:
>On Fri, Feb 26, 2021 at 03:03:39PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> When building with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION,
>> I sometimes see an assertion
>>
>>  ld.lld: error: Entry trampoline text too big
>
>Heh, "too big" seems a weird report for having it discarded. :)
>
>Any idea on this Fangrui?
>
>( I see this is https://github.com/ClangBuiltLinux/linux/issues/1311 )

This diagnostic is from an ASSERT in arch/arm64/kernel/vmlinux.lds

   ASSERT((__entry_tramp_text_end - __entry_tramp_text_start) == (1 << 16),
    "Entry trampoline text too big")

In our case (aarch64-linux-gnu-ld or LLD, --gc-sections), all the input sections with this name
are discarded, so the output section is either absent (GNU ld) or empty (LLD).

KEEP  makes the sections GC roots, and it is appropriate to use here.


However, I worry that many other KEEP keywords in vmlinux.lds are unnecessary:
https://lore.kernel.org/linux-arm-kernel/20210226211323.arkvjnr4hifxapqu@google.com/

git log -S KEEP -- include/asm-generic/vmlinux.lds.h => there is quite a
bit unjustified usage. Sure, adding KEEP (GC root) is easy and
works around problems, but it not good for CONFIG_LD_DEAD_CODE_DATA_ELIMINATION.

Reviewed-by: Fangrui Song <maskray@google.com>

>

>>
>> This happens when any reference to the trampoline is discarded at link
>> time. Marking the section as KEEP() avoids the assertion, but I have
>> not figured out whether this is the correct solution for the underlying
>> problem.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
>As a work-around, it seems fine to me.
>
>Reviewed-by: Kees Cook <keescook@chromium.org>
>
>-Kees
>
>> ---
>>  arch/arm64/kernel/vmlinux.lds.S | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> index 926cdb597a45..c5ee9d5842db 100644
>> --- a/arch/arm64/kernel/vmlinux.lds.S
>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> @@ -96,7 +96,7 @@ jiffies = jiffies_64;
>>  #define TRAMP_TEXT					\
>>  	. = ALIGN(PAGE_SIZE);				\
>>  	__entry_tramp_text_start = .;			\
>> -	*(.entry.tramp.text)				\
>> +	KEEP(*(.entry.tramp.text))			\
>>  	. = ALIGN(PAGE_SIZE);				\
>>  	__entry_tramp_text_end = .;
>>  #else
>> --
>> 2.29.2
>>
>
>-- 
>Kees Cook
