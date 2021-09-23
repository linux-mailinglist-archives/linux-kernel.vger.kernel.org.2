Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4094159C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 10:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbhIWIKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 04:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232435AbhIWIKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 04:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632384514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xUZgLGtKUz9aDU0USgUsTO5mp3XnVQM8D5e0FyChN6E=;
        b=HlchIMrbkpEvyQ+WpMpc9EXdCXNTc+vvfg7UCdAEBmX/qIw2nJwuGaL8AVIL+DtG6xD00t
        eU+dBfvwHCnU2/JSenFiKrbDSjcSNhBvZJN0u7i3lj/9XWvn1oZmbvin2Jn5/see1ZhkYQ
        hjxiHVV9ZBfDegInG1kKV2EpqEG3nJY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-_JDCvpR4M42-f8Nzv2LY1Q-1; Thu, 23 Sep 2021 04:08:33 -0400
X-MC-Unique: _JDCvpR4M42-f8Nzv2LY1Q-1
Received: by mail-wr1-f72.google.com with SMTP id i4-20020a5d5224000000b0015b14db14deso4393069wra.23
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 01:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xUZgLGtKUz9aDU0USgUsTO5mp3XnVQM8D5e0FyChN6E=;
        b=mUdNYWoWvyVpoJXVYJ9Es1l0OQd7yd62RL4ai1JZwx2xCgkI6vUHAD26ksRpE6mw6E
         xKLjjHrhPBMpQBe7WZsh/jadKeISY2bytPynV7a8K2TSQIghpsynmiuE2v7Sv+oNm7os
         Dgz3GCSCWpA0wmA7Q5ba9NqvMIyaBocBfxUd4K++nqECnC7/27Js5BrMcQNQVBUDwTPM
         oYpPg6RjV9ce98FlYAj5Jst0aD9P55S4bhWZxFHDbQc97ugOPu64ot49Labn+TbJEx5t
         FrVF0GPMGIE490FQ+6fFoD0QIRViTaZyEmZUUEbqRgFsppyhKL4QFz93ZNq0/qoulXxT
         innw==
X-Gm-Message-State: AOAM5331yM+vm+Mg10UnEAt+0BjmDKLZn9MCkXzt/C6EisHsTLHR4Sqj
        TvamO6O8Kr+HJ1ifTPiOEYHbLemwM2Htoxh3v8EOr9+XzROokIt40F95Mpl952475/0BEjXUD1F
        YjeQj+BSN7C7SmIzjDmg3FFos
X-Received: by 2002:adf:fd92:: with SMTP id d18mr3560904wrr.28.1632384512290;
        Thu, 23 Sep 2021 01:08:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDcD949afA9g54It1Y2+1Z80Jqmwxd9DR7zrgWPacMFIChPfheI9UU8zU/0m9dqiL/OS1hkg==
X-Received: by 2002:adf:fd92:: with SMTP id d18mr3560895wrr.28.1632384512106;
        Thu, 23 Sep 2021 01:08:32 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23e5d.dip0.t-ipconnect.de. [79.242.62.93])
        by smtp.gmail.com with ESMTPSA id z7sm4268228wmi.43.2021.09.23.01.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 01:08:31 -0700 (PDT)
Subject: Re: [PATCH] kernel: introduce prctl(PR_LOG_UACCESS)
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Colin Ian King <colin.king@canonical.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Balbir Singh <sblbir@amazon.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
References: <20210922061809.736124-1-pcc@google.com>
 <29f1822d-e4cd-eedb-bea8-619db1d56335@redhat.com>
 <20210922152250.4e7c869a@gandalf.local.home>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <4d70ee3c-ab2a-a0e3-0214-8cc65caf2acd@redhat.com>
Date:   Thu, 23 Sep 2021 10:08:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922152250.4e7c869a@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.21 21:22, Steven Rostedt wrote:
> On Wed, 22 Sep 2021 19:46:47 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>>> All signals except SIGKILL and SIGSTOP are masked for the interval
>>> between the prctl() and the next syscall in order to prevent handlers
>>> for intervening asynchronous signals from issuing syscalls that may
>>> cause uaccesses from the wrong syscall to be logged.
>>
>> Stupid question: can this be exploited from user space to effectively
>> disable SIGKILL for a long time ... and do we care?
> 
> I first misread it too, but then caught my mistake reading it a second
> time. It says "except SIGKILL". So no, it does not disable SIGKILL.

Thanks for pointing out the obvious Steve :)

-- 
Thanks,

David / dhildenb

