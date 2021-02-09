Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359B6315C48
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbhBJBbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbhBIXRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 18:17:24 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5089AC06178C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 15:16:44 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id h26so99627lfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 15:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IyDueHXwV0Wu9+6+4EGBNKpLkrryr5DDx6f4YfCFEJ8=;
        b=CMuXOTJ2j2qI+lJ/t6aVtACWY19tkHvQXX24rDR5C7IK9QS+JeVG9LNvRY1exKieVn
         GbfgKAEd7GUTOfSZLUC9cO4ij3IDbTp3gYz21bf52oNgX67sDznao2XhejYhnb8JpWZq
         /Z/4Cc3+sJBTYpKKdb8KLBkvTJaDEqEUnpJxDTDBEtxP8+Em6yuibrED3z5ylF9lVQd9
         uHPmx2sOuzgHBNQ7UdeD6a1AnAp8U2+P9phX5nVCrWmmYrZ/hLQgxb6BWoz/PPKj2h9j
         tqwrbKKyUcJxfrLwm0ZoOlvJ1Jj1bb6N++w26s9YSdIy7D9iES5N4tLeF4JcWvQrVU+A
         I9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IyDueHXwV0Wu9+6+4EGBNKpLkrryr5DDx6f4YfCFEJ8=;
        b=GIiY71GXNlXEQhxslGq6v9yrPmYeOkfHwtbm/zAA+9V5S1SAOmi2kLCS//QK1EqozD
         HJ1yNEeIj9DtfAq+hY4S4Az+0KL9NUX+jQs8dtXzXRkGQtuPwEmdJpAPwo/wZSZcO1sQ
         smLe1XbD0eo7konKG1aJ2WZhLPrnWCtT1L8f46YzID3fhvOCafUKsxcwtgHO6djN5DZY
         pfxTglmyq+EQsev5heDw0WVBJjr+EpIyEdy19ghe9gR6OvWFChsgIKDDJDw69VEL+f54
         7DJDmteBiy+I9vl70MoO6ArPULWX3PWfvvYHX72KpA70P9UxD+zQ8dVz/1zksQKbMNid
         0hsA==
X-Gm-Message-State: AOAM53259EsN/ypkiuhUwtDrQLyfWqmpSa+2+PGS4bQVgscU5Fdf8pEL
        m3Q5JKUh2HuWKgsJSgr0MSQ=
X-Google-Smtp-Source: ABdhPJw6QFqq5fKVXm/4dTxmpJXGJROSO2ikqzZVTP5akaD2zmuZ4vqCEmhHM34qbb1q6dp80KYUDA==
X-Received: by 2002:a19:431e:: with SMTP id q30mr132105lfa.558.1612912602733;
        Tue, 09 Feb 2021 15:16:42 -0800 (PST)
Received: from [192.168.31.34] (109-252-130-105.dynamic.spd-mgts.ru. [109.252.130.105])
        by smtp.gmail.com with ESMTPSA id n9sm1038011lfi.298.2021.02.09.15.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 15:16:41 -0800 (PST)
Subject: Re: [PATCH] ubsan: Require GCC-8+ or Clang to use UBSAN
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        dvyukov@google.com, keescook@chromium.org
References: <590998aa9cc50f431343f76cae72b2abf8ac1fdd.1608699683.git.jpoimboe@redhat.com>
 <20210104151317.GR3021@hirez.programming.kicks-ass.net>
 <YAAj9aAcPsV9I6UL@hirez.programming.kicks-ass.net>
 <e291008b-6b4d-9da4-1353-0762bc68e8ea@virtuozzo.com>
 <20210118175337.rnh2b6vdnqw3ue63@treble>
 <20210209182423.te43h3mmhtvwi2d7@treble>
From:   Andrey Rybainin <ryabinin.a.a@gmail.com>
Message-ID: <e47d2395-8b54-bbb4-a3fb-e428c99edf22@gmail.com>
Date:   Wed, 10 Feb 2021 02:17:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210209182423.te43h3mmhtvwi2d7@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/21 9:24 PM, Josh Poimboeuf wrote:
> On Mon, Jan 18, 2021 at 11:53:37AM -0600, Josh Poimboeuf wrote:
>> On Thu, Jan 14, 2021 at 02:09:28PM +0300, Andrey Ryabinin wrote:
>>>
>>>
>>> On 1/14/21 1:59 PM, Peter Zijlstra wrote:
>>>> On Mon, Jan 04, 2021 at 04:13:17PM +0100, Peter Zijlstra wrote:
>>>>> On Tue, Dec 22, 2020 at 11:04:54PM -0600, Josh Poimboeuf wrote:
>>>>>> GCC 7 has a known bug where UBSAN ignores '-fwrapv' and generates false
>>>>>> signed-overflow-UB warnings.  The type mismatch between 'i' and
>>>>>> 'nr_segs' in copy_compat_iovec_from_user() is causing such a warning,
>>>>>> which also happens to violate uaccess rules:
>>>>>>
>>>>>>   lib/iov_iter.o: warning: objtool: iovec_from_user()+0x22d: call to __ubsan_handle_add_overflow() with UACCESS enabled
>>>>>>
>>>>>> Fix it by making the variable types match.
>>>>>>
>>>>>> This is similar to a previous commit:
>>>>>>
>>>>>>   29da93fea3ea ("mm/uaccess: Use 'unsigned long' to placate UBSAN warnings on older GCC versions")
>>>>>
>>>>> Maybe it's time we make UBSAN builds depend on GCC-8+ ?
>>>>
>>>> ---
>>>> Subject: ubsan: Require GCC-8+ or Clang to use UBSAN
>>>>
>>>> Just like how we require GCC-8.2 for KASAN due to compiler bugs, require
>>>> a sane version of GCC for UBSAN.
>>>>
>>>> Specifically, before GCC-8 UBSAN doesn't respect -fwrapv and thinks
>>>> signed arithmetic is buggered.
>>>>
>>>
>>> Actually removing CONFIG_UBSAN_SIGNED_OVERFLOW would give us the same
>>> effect without restricting GCC versions.
>>
>> Is that preferable?  Always happy to remove code, just need some
>> justification behind it.
> 
> Andrey,
> 
> Is Peter's patch acceptable or do you want to do something else?
> 

I do prefer to just remove the code, I'll send the patch shortly.
