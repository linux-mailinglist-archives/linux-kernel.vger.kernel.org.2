Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35ABF41400B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 05:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhIVDbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 23:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhIVDbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 23:31:39 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F8CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 20:30:10 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q23so1474276pfs.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 20:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=p3Afjb9SH1bKicKYKOh4KrtaQEM6g/6mD1pI9nF9WC0=;
        b=cbxtgRR/t2MdrPtKmSUYSAfi2a/Vgmxy02JtKodeTYaG3SLpK7ZBMI7MjGa5pP+aJo
         hihiwCcVI4V2CvaHj5CWhWH9UMjGVvoN9SHc1e+tFQTNZm7TecJw7KUXeG6ERJ1/6hud
         JNqHBtlzuTvoRXAkO1OWG9pfcHSa9kjVVmAzKd/s+fraAMUMxbkI4W7DO5VFXG1R81hT
         ynhDPI2XJRSHXqNhDJazKybvKA9tV+mebXiDiIjmKOfsua8QRCIGbP0JkzL63zEoGkRK
         R8givsnGxJL42krSwQhLpubs8ftsp7w3z/MjvYNSnzxOtOX6Ie7Wq+VldOCqi1GDJiw+
         RfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=p3Afjb9SH1bKicKYKOh4KrtaQEM6g/6mD1pI9nF9WC0=;
        b=pPCxQAFw9Uw5JMnpBkorWb7LmxV6Md5k3F3/XQcH8F8aH1rPQxql82vs7PuAkgYlU5
         6xjUJcrWoNcBoTcofrJ11rh05BDBE77LXaEa0oDMFrPJvXdHwOK8qD6w3nurp2iJ2zL9
         tQfxnusLIKZeGlr/aG395DQhs9xKpybaECVTC79htodL2XSBPWPc76IPRcDfY7YP+Ell
         D+RTTdoFUCGCgCg3I403vbEIILg1PEFSIwK8y+sejXmdJSqGCe8kzFa79nY606zjvxvV
         xXzSQb2CGz0298aViyGsVYbIYZg6Ro5fAZklKrlHdVmfsx37hP9mtBxOPDySlqhgFxm4
         0eCQ==
X-Gm-Message-State: AOAM53380LrW7HxmZyJLnHXg/ag2CXmzayHWIc1krMRk7MciGST/9IAR
        oPNDsYSemGGTeNc+IvKDkxthiw==
X-Google-Smtp-Source: ABdhPJyp2Tt0PgTcfHIp08CN9D/Odw7I51QJQhZ/vNuiaDTJnKXPeUwjbGVaKRukRR7outHIj/ZcWA==
X-Received: by 2002:a63:d017:: with SMTP id z23mr31183583pgf.108.1632281409740;
        Tue, 21 Sep 2021 20:30:09 -0700 (PDT)
Received: from [10.255.73.99] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id g22sm486882pfb.191.2021.09.21.20.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 20:30:09 -0700 (PDT)
Subject: Re: CONFIG_ORC_UNWINDER=y breaks get_wchan()?
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Vito Caputo <vcaputo@pengaru.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
        peterz@infradead.org, luto@kernel.org, jannh@google.com,
        Kees Cook <keescook@chromium.org>
References: <20210921193249.el476vlhg5k6lfcq@shells.gnugeneration.com>
 <20210922001537.4ktg3r2ky3b3r6yp@treble>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <930f0c5e-0fd4-aae7-334f-ec9cc42998a4@bytedance.com>
Date:   Wed, 22 Sep 2021 11:30:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210922001537.4ktg3r2ky3b3r6yp@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/21 8:15 AM, Josh Poimboeuf wrote:
> On Tue, Sep 21, 2021 at 12:32:49PM -0700, Vito Caputo wrote:
>> Is this an oversight of the ORC_UNWINDER implementation?  It's
>> arguably a regression to completely break wchans for tools like `ps -o
>> wchan` and `top`, or my window manager and its separate monitoring
>> utility.  Presumably there are other tools out there sampling wchans
>> for monitoring as well, there's also an internal use of get_chan() in
>> kernel/sched/fair.c for sleep profiling.
>>
>> I've occasionally seen when monitoring at a high sample rate (60hz) on
>> something churny like a parallel kernel or systemd build, there's a
>> spurious non-zero sample coming out of /proc/[pid]/wchan containing a
>> hexadecimal address like 0xffffa9ebc181bcf8.  This all smells broken,
>> is get_wchan() occasionally spitting out random junk here kallsyms
>> can't resolve, because get_chan() is completely ignorant of
>> ORC_UNWINDER's effects?
> 
> Hi Vito,
> 
> Thanks for reporting this.  Does this patch fix your issue?
> 
>    https://lkml.kernel.org/r/20210831083625.59554-1-zhengqi.arch@bytedance.com
> 
> Though, considering wchan has been silently broken for four years, I do
> wonder what the impact would be if we were to just continue to show "0"
> (and change frame pointers to do the same).

Agree, Or remove get_wchan() directly.

> 
> The kernel is much more cautious than it used to be about exposing this
> type of thing.  Can you elaborate on your use case?
> 
> If we do keep it, we might want to require CAP_SYS_ADMIN anyway, for
> similar reasons as
> 
>    f8a00cef1720 ("proc: restrict kernel stack dumps to root")
> 
> ... since presumably proc_pid_wchan()'s use of '%ps' can result in an
> actual address getting printed if the unwind gets confused, thanks to
> __sprint_symbol()'s backup option if kallsyms_lookup_buildid() doesn't
> find a name.
> 
> Though, instead of requiring CAP_SYS_ADMIN, maybe we can just fix
> __sprint_symbol() to not expose addresses?
> 
> Or is there some other reason for needing CAP_SYS_ADMIN?  Jann?
> 
