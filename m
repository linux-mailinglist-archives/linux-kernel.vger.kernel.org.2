Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0BA3F9820
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 12:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244814AbhH0KcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 06:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244708AbhH0KcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 06:32:08 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19778C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 03:31:19 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id d16so10580728ljq.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 03:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TYpNrmB/knH1Vk+BIVeFBAl1HiQtIN1iFGF1ImXemaw=;
        b=aLE7HlAr8gjzaiGdBIy9JDfdyN9Qj6Hkd5ij43+q34bMi7TE6YhTy0Ul8QlYLvUgTo
         FEUPRKRf53JLWAbwIEpl/mz8CfP1BFBHwPAzxXs5kFk8LZM4XyXS1V4W/AJmODfMSuSC
         t+iEExpdC9pS3xCncpm2ydmu63wT5PEkliWxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TYpNrmB/knH1Vk+BIVeFBAl1HiQtIN1iFGF1ImXemaw=;
        b=gEDYMWuU4jRPeZ+SndUNoB4++CloKplupOcR0P3qTdLYDuTMComBVZVNkJoHvfgLHf
         jzHUagnH2NA/2ADU4fTw23rIIzYSBt4pZBgWKpmPESyNzniherouB7++pny6c0Zj0o0R
         mkiVNoP9Qg7ajLHYOqfDVD53muXzboZ3AfmSE3eP3j4R7rIWkl5usVWIrZJISfIEHYUy
         mDrXAQ5wTf7MYaHiDNUPtzwdorKPx5flirZgVYFI4QCQFvX5LBdtkxkQvBKtIi17DgQA
         XO09qsubGqg1BMfTe1qGlsNiq6RfmFrZJ7JCfawlryLqYnY5BGSwE04F6u3F+FzKFVAs
         WHxQ==
X-Gm-Message-State: AOAM5327jAKN7UsVcsIDXnaCh9E47D3uyNbmWcIo9ZefHpk+OkkomFYu
        wDrb3GhOWmdYW5ZH4QkW/nsdHpRQGhCRpyFq
X-Google-Smtp-Source: ABdhPJxqwdyGhk0QBf+2cFlJdD8/M+iSnNrDpCLSlbRvv4/OgFlLEOHTb60hkov7n5eCAYePvqTeeQ==
X-Received: by 2002:a2e:8608:: with SMTP id a8mr7074412lji.224.1630060277343;
        Fri, 27 Aug 2021 03:31:17 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id a23sm638327ljb.95.2021.08.27.03.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 03:31:16 -0700 (PDT)
Subject: Re: [PATCH] Fix prctl(PR_GET_NAME) to not leak random trailing bytes
To:     Helge Deller <deller@gmx.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
References: <YSiwLuE17BwRlI/d@ls3530>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <aa0006e7-58b8-ab05-0599-5609e900ba4d@rasmusvillemoes.dk>
Date:   Fri, 27 Aug 2021 12:31:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSiwLuE17BwRlI/d@ls3530>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/2021 11.28, Helge Deller wrote:
> The prctl(PR_GET_NAME) and prctl(PR_SET_NAME) syscalls are used to set and
> retrieve the process name. Those kernel functions are currently implemented to
> always copy the full array of 16-bytes back and forth between kernel and
> userspace instead of just copying the relevant bytes of the string.
> 
> This patch changes the prctl(PR_GET_NAME) to only copy back the null-terminated
> string (with max. up to 16 chars including the trailing zero) to userspace and
> thus avoids copying and leaking random trailing chars behind the process name.
> 
> Background:
> The newest glibc testsuite includes a test which is implemented similiar to
> this:
>    prctl(PR_SET_NAME, "thread name", 0, 0, 0);
>    char buffer[16] = { 0, };
>    prctl(PR_GET_NAME, buffer, 0, 0, 0);
>    char expected[16] = "thread name";
>    fail if memcmp(buffer, expected, 16) != 0;
> 
> The compiler may put the "thread name" string given in the PR_SET_NAME call
> somewhere into memory and it's not guaranteed that trailing (up to a total of
> 16) chars behind that string has zeroes.
> As such on the parisc architecture I've seen that the buffer[] array gets
> filled on return of prctl(PR_GET_NAME) with such additional random bytes, e.g.:
>        "thread name\000@\032i\000"
>        74 68 72 65 61 64 20 6E 61 6D 65 00 40 1A 69 00
> 
> Unfortunatly the glibc testuite tests the full memory block of 16 bytes
> and fails because it expects zeroed characters behind the process name.
> 
> In addition to fix the glibc testsuite, I suggest to fix the kernel function of
> prctl(PR_GET_NAME) to just return the null-terminated process name.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: stable@vger.kernel.org
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index ef1a78f5d71c..af71412760be 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2367,7 +2367,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		break;
>  	case PR_GET_NAME:
>  		get_task_comm(comm, me);
> -		if (copy_to_user((char __user *)arg2, comm, sizeof(comm)))
> +		if (copy_to_user((char __user *)arg2, comm, strlen(comm) + 1))
>  			return -EFAULT;
>  		break;

I don't understand. get_task_comm() is

extern char *__get_task_comm(char *to, size_t len, struct task_struct *tsk);
#define get_task_comm(buf, tsk) ({                      \
        BUILD_BUG_ON(sizeof(buf) != TASK_COMM_LEN);     \
        __get_task_comm(buf, sizeof(buf), tsk);         \
})

and __get_task_comm() is

char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *tsk)
{
        task_lock(tsk);
        strncpy(buf, tsk->comm, buf_size);
        task_unlock(tsk);
        return buf;
}

so the strncpy should ensure that the caller's buffer after the string's
terminator gets zero-filled. I can see that parisc has its own
strncpy(), but I can't read that asm, so I can't see if it actually does
that mandated-by-C-standard zero-filling. It would surprise me if it
didn't (I'd expect lots of other breakage), but OTOH it is the only way
I can explain what you've seen.

[Also, the compiler most likely puts the "thread name" string literal
first into a .rodata.strX.Y section, only later to be merged into
.rodata by the linker, so anything after "thread name" I'd expect to
also be some readable string. The fact that you have a 0x1a byte in
there suggests that the garbage doesn't actually come from the original
PR_SET_NAME call, but is consistent with it being a stack leak from the
kernel. You could try running hexdump on the test binary to see if
there's any occurrence of "thread name" followed by those particular
garbage bytes.]

Rasmus
