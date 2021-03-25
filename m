Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DAC349C85
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 23:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhCYWpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 18:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbhCYWo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 18:44:59 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197FDC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 15:44:59 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id v3so3297951pgq.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 15:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=i1A3B1VA5Zv5sBwoUoS9WZiP910FQdZZhnQVANdwB9c=;
        b=IicXkfu18EISqV5ydhu56kRQMXqHpoRlop4C6BcDh/WNhGYMdJzZ/j9kZAfuPT4BQ/
         npjBX182kJUDvhCs3A14H6ZmbO6bikVoZBMzyFhHP3JHmK2ypCwwuYKXo48N26dOflJz
         sF9QIO5+3JINV4A5ZlwLXVEoUJCE0XxMhc7Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=i1A3B1VA5Zv5sBwoUoS9WZiP910FQdZZhnQVANdwB9c=;
        b=glC0DbWMcYwnKn9WseV6QIgHX1e8Rf3PPTvlgoHp88kab36rVxHHuvlh0RMoyLMKRH
         g0pZ+Nvb5wJJrh7Y+p6679mvwpfbFJCRep3B187qT97rH6OWEwdMjxJqeWsaqXr0kMH+
         BX9kmK+7PANVTUT4lZ9kXEElxYG1gmqOa+xJ2cxNiv9ef7WLVadx0VUOpQ7F80yXHvcH
         AqzRiDrNx9G5qrcjU2vEqLnczcBX8z5M+l/eBTKL/JM/RL7zsrfAOXpDYeWyiBMPck18
         MEVWsOkad4IdAxwH+4ceka/MIoNix/YzWtfLU2b9xjrgbyOWP6reuA350dLWDYVgKoWc
         UNRw==
X-Gm-Message-State: AOAM5339EQ1HUdAxDL0AYyfycjOCVJOWnKve44TGcxlFugwnHgNIynqX
        ohZV6H0amq4TmkBc+LkTtvuiXA==
X-Google-Smtp-Source: ABdhPJzl6JZCX5R+lL7U/Se0bnk4N2jLloez48zhqiROs1PEF9zolxztpZkiesZDt5uQTPGMyTaL1w==
X-Received: by 2002:a17:902:da81:b029:e5:de44:af5b with SMTP id j1-20020a170902da81b02900e5de44af5bmr12069109plx.27.1616712298559;
        Thu, 25 Mar 2021 15:44:58 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-5199-f2bf-3cbb-22e6.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:5199:f2bf:3cbb:22e6])
        by smtp.gmail.com with ESMTPSA id o20sm4304026pjs.2.2021.03.25.15.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 15:44:58 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 07/15] powerpc/uaccess: Call might_fault() inconditionaly
In-Reply-To: <874kgykgfk.fsf@dja-thinkpad.axtens.net>
References: <cover.1615398265.git.christophe.leroy@csgroup.eu> <e0a980a4dc7a2551183dd5cb30f46eafdbee390c.1615398265.git.christophe.leroy@csgroup.eu> <874kgykgfk.fsf@dja-thinkpad.axtens.net>
Date:   Fri, 26 Mar 2021 09:44:54 +1100
Message-ID: <871rc2kg49.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Axtens <dja@axtens.net> writes:

> Hi Christophe,
>
>> Commit 6bfd93c32a50 ("powerpc: Fix incorrect might_sleep in
>> __get_user/__put_user on kernel addresses") added a check to not call
>> might_sleep() on kernel addresses. This was to enable the use of
>> __get_user() in the alignment exception handler for any address.
>>
>> Then commit 95156f0051cb ("lockdep, mm: fix might_fault() annotation")
>> added a check of the address space in might_fault(), based on
>> set_fs() logic. But this didn't solve the powerpc alignment exception
>> case as it didn't call set_fs(KERNEL_DS).
>>
>> Nowadays, set_fs() is gone, previous patch fixed the alignment
>> exception handler and __get_user/__put_user are not supposed to be
>> used anymore to read kernel memory.
>>
>> Therefore the is_kernel_addr() check has become useless and can be
>> removed.
>
> While I agree that __get_user/__put_user should not be used on kernel
> memory, I'm not sure that we have covered every case where they might be
> used on kernel memory yet. I did a git grep for __get_user - there are
> several callers in arch/powerpc and it looks like at least lib/sstep.c
> might be using __get_user to read kernel memory while single-stepping.
>
> I am not sure if might_sleep has got logic to cover the powerpc case -
> it uses uaccess_kernel, but we don't supply a definition for that on
> powerpc, so if we do end up calling __get_user on a kernel address, I
> think we might now throw a warning. (Unless we are saved by
> pagefault_disabled()?)

Ah, I just re-read some of my earlier emails and was reminded that yes,
if we are calling __get/put, we must have disabled page faults.

So yes, this is good.

>
> (But I haven't tested this yet, so it's possible I misunderstood
> something.)
>
> Do you expect any consequences if we've missed a case where
> __(get|put)_user is called on a kernel address because it hasn't been
> converted to use better helpers yet?
>
> Kind regards,
> Daniel
>
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>  arch/powerpc/include/asm/uaccess.h | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
>> index eaa828a6a419..c4bbc64758a0 100644
>> --- a/arch/powerpc/include/asm/uaccess.h
>> +++ b/arch/powerpc/include/asm/uaccess.h
>> @@ -77,8 +77,7 @@ __pu_failed:							\
>>  	__typeof__(*(ptr)) __pu_val = (x);			\
>>  	__typeof__(size) __pu_size = (size);			\
>>  								\
>> -	if (!is_kernel_addr((unsigned long)__pu_addr))		\
>> -		might_fault();					\
>> +	might_fault();						\
>>  	__chk_user_ptr(__pu_addr);				\
>>  	__put_user_size(__pu_val, __pu_addr, __pu_size, __pu_err);	\
>>  								\
>> @@ -238,12 +237,12 @@ do {								\
>>  	__typeof__(size) __gu_size = (size);			\
>>  								\
>>  	__chk_user_ptr(__gu_addr);				\
>> -	if (do_allow && !is_kernel_addr((unsigned long)__gu_addr)) \
>> +	if (do_allow) {								\
>>  		might_fault();					\
>> -	if (do_allow)								\
>>  		__get_user_size(__gu_val, __gu_addr, __gu_size, __gu_err);	\
>> -	else									\
>> +	} else {									\
>>  		__get_user_size_allowed(__gu_val, __gu_addr, __gu_size, __gu_err); \
>> +	}									\

One microscopic nit: these changes throw the '\'s further out of
alignment.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel

>>  	(x) = (__typeof__(*(ptr)))__gu_val;			\
>>  								\
>>  	__gu_err;						\
>> -- 
>> 2.25.0
