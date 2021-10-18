Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0976B431247
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 10:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhJRIn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhJRInx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:43:53 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A863DC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 01:41:41 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ec8so68032543edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 01:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gAi3Zs8thaof3uAcf89FhN073t2oSWqd66UNX6kkSEQ=;
        b=eQMeLMaZT/f5oneG34ePiKf4TPlZQW5mFiBhMDQUvgCKSk1SBJ58Id6yid9clHBjoZ
         krlEAp0Xf60/RGkLlxrYwmcoXlbobVd1f0la8leydK9QVhQBDFgxF62wM9cGMH2P9ISi
         Y3gM/x0lwG+EKRvTRik6m5ntzD9OQYjnSPxfnIODvus1+D5RsqCjajFO+FgRdPIuEhPf
         gW/gxnxNthZ/NFt3NYlAWBA2cCZtmLE2iGgq6qle+jZ673sFbgMkFLjQvyxe+AhZXXQ1
         uxxGqSEnbNHU1Sbon3gQwzRbKL1rhbpC3UhAGYAlUXqeiPqfda4uhhhr/UdgL9oVgJxU
         CIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gAi3Zs8thaof3uAcf89FhN073t2oSWqd66UNX6kkSEQ=;
        b=SZV8xzOE4Ew6GD2NYsL1/fODs0bqTYaifkTraaEAp3tw7oeisgH2F61rX7PtAXdofL
         PQp3pKe0ANoxwpUGneXQqtMS6AIxFA0aIEiL80l3LY7xw3bS2iScM9KZQ+f5lq8XMDOH
         8TocIe/q11OSqzP9LaoGpRuA7L9FLHvZ73kbVEdZCRZv8nQkQTNzMEGhhg0FtN/V/8m4
         ejhBd2sXXeQNe+HWQuCtUi2F2ilWsnNm7BrLpjpxAYLQVu+HdX3ZCj//h7JMcbHGwuGE
         QV29tQSYRMhMw8XFS2qBnFOFGgUnBLFZcLS/lRK40GPwUsOxFj87UOBaRx2dbtIGOg1/
         7VHw==
X-Gm-Message-State: AOAM532Ig4Nfvpt/EExqo38VLg7Bf6hOmOh+yjrAiB264dC6RJuO4Ilf
        1KRm5UVH2s3akUqMBv5Pw1El3oyOgd6hxWh3DYw=
X-Google-Smtp-Source: ABdhPJx7bjcZm/6mA5+p1zXpotls2nfG4/ZgUljSzH9VEOu8q+vMudKgrIv7w8BmhHq2e2ignUnkVXQGV6j71jE4r3s=
X-Received: by 2002:a05:6402:2793:: with SMTP id b19mr42986730ede.80.1634546500090;
 Mon, 18 Oct 2021 01:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAD-N9QWd6Orm8d9AMk7mybByAKZod=GJ-HSNPOfhFDStSPwSUA@mail.gmail.com>
 <CAPj211vRdmJZBQvM-DE+saiY=LwoQdOu0hV-YFcny6worQ46rg@mail.gmail.com>
In-Reply-To: <CAPj211vRdmJZBQvM-DE+saiY=LwoQdOu0hV-YFcny6worQ46rg@mail.gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 18 Oct 2021 16:41:14 +0800
Message-ID: <CAD-N9QW0NEi6Jzh-bu0Bb=RFB6405G28t_jtctk_t8Kw+HUpVQ@mail.gmail.com>
Subject: Re: Any tracing mechanism can track the executed instructions of a
 user process in the kernel?
To:     FMDF <fmdefrancesco@gmail.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 4:07 PM FMDF <fmdefrancesco@gmail.com> wrote:
>
> On Mon, 18 Oct 2021, 04:46 Dongliang Mu, <mudongliangabcd@gmail.com> wrot=
e:
>>
>> Hi all,
>>
>> I am writing to kindly ask one question: is there any tracing
>> mechanism in Linux kernel that can trace all the executed instructions
>> of a user process? If this user process is run on different
>> processors, traces of this process on different processors should be
>> also recorded.
>
>
> You've not explained in detail what is the purpose of the tracing that yo=
u want to do. Missing this information I can only provide you a list of lin=
ks to various tools and methods. Take a look by yourself and try to figure =
out what is better suited for your needs...

I want to log all the executed instructions of a user process (e.g.,
poc.c in syzkaller) in the kernel mode and then would like to leverage
backward analysis to capture the root cause of kernel panic/crash.

Therefore, I need the instruction-level tracing mechanisms or tools.

>
> https://lwn.net/Kernel/Index/#Development_tools-Kernel_tracing
> trace-cmd: https://trace-cmd.org

Ftrace is working at the function level. Therefore, ftrace and tracers
based on ftrace are not suitable for my scenario.

> perf ftrace: <Linux source>/tools/perf/Documentation/perf-trace.txt
> perf-tools: https://github.com/brendangregg/perf-tools

I am not familiar with the perf tool and cannot verify if it works for
my scenario.

>
> In particular, the "function_graph" tracer of ftrace seems to be suited f=
or your purposes:
>
> https://man7.org/linux/man-pages/man1/trace-cmd.1.html
> https://man7.org/linux/man-pages/man1/trace-cmd-record.1.html
> https://man7.org/linux/man-pages/man1/trace-cmd-report.1.html
>
> Obviously, gdb (and friends) is still invaluable (but it may be difficult=
 to use, depending on your knowledge and experience, so use it if you reall=
y know that  you need it):
>
> https://www.kernel.org/doc/html/latest/dev-tools/gdb-kernel-debugging.htm=
l
> https://www.kernel.org/doc/html/latest/dev-tools/kgdb.html
>
> Regards,
>
> Fabio M. De Francesco
>
>>
>> Any comment is welcome.
>>
>> --
>> My best regards to you.
>>
>>      No System Is Safe!
>>      Dongliang Mu
>>
>> _______________________________________________
>> Kernelnewbies mailing list
>> Kernelnewbies@kernelnewbies.org
>> https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
