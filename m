Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4697A4310CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 08:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhJRGra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 02:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhJRGr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 02:47:28 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDC5C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 23:45:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v20so10521683plo.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 23:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=DMgduQp/zctdpl9lhlJhxC+AafmDlkmeR4lQyrVCvzo=;
        b=x6Y7c7k3AJYf36wkRA5SCf7htdnB2MWJ9QSVU//V2tRmYIUGDbjUNDPzFHs9/NG2oM
         zZ8xVHXauaMicyUFZdKu9PswlyuLU9QXCwqptXo3KLTidDqalgbnjhkepyjRi78k80wj
         vNK4QxxhHLv7hZL1LPFsdtSH+jEfRj9NpYtFk5E1KJ5O9cPdSgFKezbgUH7MZ0J3TvwA
         vuuc/sXGt6lmK7KCDQ+5oDjEsX0nUAoZpTPPA07lg48+y/OtbzV+VJeIvX98+9xZa/ys
         xqJVwsstLX93bnMkVXT8rUTdMmNjQUB+ZaVyTqbt4uFO/vF/uF3ItpVNuiXqNvyKox4j
         tlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=DMgduQp/zctdpl9lhlJhxC+AafmDlkmeR4lQyrVCvzo=;
        b=I4fYjS/VA1te8v8yqlesr1HibjS+d9S3gxP7T1exg5arqm8JWG0LpCcUh85KB/qajq
         ZwohI7gaY7499O7UK5K/xiWYBrTtnCxmEKbaJazIMSA7E0l96P92aeW4sKhFjftgQU5c
         JVjDNiCGzXq6pvK7oGsodCK/Ga/Zmsr6OjhxbFlaZy5999/C7ns+kmKuJZWKCW1BsslV
         wrbIM/c67uPCo9McUPSdAMEVsCdCPpxXprwz/sNxatxUw0wuFBzaiq8tYp+Dt9V+nEm4
         kcEQcFrFxVIdMUosBlN0yPhrWmpIzllamWAU6EWJydRwO6YwzStzFqW3jYVbcMm6QsOJ
         g+Og==
X-Gm-Message-State: AOAM53207PitcTt/Ys68JA5c92bs1jXoUzahtjmIYQseNFCchLuaQUPs
        XjvfeaSwzVq6T4HwdesUOgfEIGutipeBBg==
X-Google-Smtp-Source: ABdhPJxzRqRGRAo5ZS+zVyWfl14FoNKeNRQcRdvzrhyL28TL3zUalpTt6j9ZLaDRJ6uNhicwzmaNzg==
X-Received: by 2002:a17:90a:a24:: with SMTP id o33mr3756210pjo.229.1634539517708;
        Sun, 17 Oct 2021 23:45:17 -0700 (PDT)
Received: from [10.254.242.85] ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id t38sm7903771pfg.102.2021.10.17.23.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 23:45:17 -0700 (PDT)
Subject: linux-next: build failure after merge of the tip tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20211018172330.379b2061@canb.auug.org.au>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <60e736e7-cc37-9fea-a0fb-6628f87e741c@bytedance.com>
Date:   Mon, 18 Oct 2021 14:45:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211018172330.379b2061@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/21 2:23 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the tip tree, today's linux-next build (x86_64 allnoconfig)
> failed like this:
> 
> arch/x86/kernel/process.c: In function '__get_wchan':
> arch/x86/kernel/process.c:950:2: error: implicit declaration of function 'stack_trace_save_tsk' [-Werror=implicit-function-declaration]
>    950 |  stack_trace_save_tsk(p, &entry, 1, 0);
>        |  ^~~~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> 
> Caused by commit
> 
>    bc9bbb81730e ("x86: Fix get_wchan() to support the ORC unwinder")
> 
> stack_trace_save_tsk() requires CONFIG_STACKTRACE which is not set for
> this build.

Maybe get_wchan() can be updated to:

unsigned long get_wchan(struct task_struct *p)
{
#ifdef CONFIG_STACKTRACE
	unsigned long entry = 0;

	stack_trace_save_tsk(p, &entry, 1, 0);
	return entry;
#else /* CONFIG_STACKTRACE */
	return 0;
#endif
}

Thanks,
Qi

> 
> I have reverted that commit, and commit
> 
>    42a20f86dc19 ("sched: Add wrapper for get_wchan() to keep task blocked")
> 
> which follows it, for today.
> 
