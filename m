Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E0B3EA9D1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 19:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbhHLRzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 13:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhHLRzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:55:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34469C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:55:11 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d4so14881414lfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DAW/6xmllsArdqmIkDcoorUsT0TSzTZwgbuuzKmFCGU=;
        b=LArikgSoq0m8hTE7N72xjOeklwXi6WD7Rhj7U1lbDpdzRIKI3tKGXnSJla6rSNwInp
         AcIMfNpu0yKUFi8PALqzJGvgziIGzYqJz2yEY35B2a6tCN/Mo2eNxAsaBOVN/eprh+aP
         3PTmlvhvnDsTxm0JiNrPSLl1hxnTArQw+4znk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DAW/6xmllsArdqmIkDcoorUsT0TSzTZwgbuuzKmFCGU=;
        b=Nzn00cOAat4bN3eMdLlWxXvYpBBJSw1Hm81lUKwVvuBq7v/4G315t+RLAVPL+Vjg92
         dOc1I3EekgxD9KeLQkDi9u6uMWU5YrwaLmnUJ9HWcEfaKvGj/ZOvxJVi5lnFtKCc7EOO
         zqqalIadWacvrS3+tAl27RTx6ltrLE9ZisL0zVeLIOCqCdyL83DpuRgaM57EZDiPUXBB
         h0uZl1kxVJ964FQu/bHBcmUNtuzKIJwidCOVBmJakPhoZmS7LUJST9lI9vRjjTcdlIZI
         MGxDsFA/Sv/9iD/l8zvyAS0OZr2bKUbJtbgziZoi2vvOW35V4GgM0aA213ADG3kf+eGZ
         sWkA==
X-Gm-Message-State: AOAM5311cVrzX6DYcOAE4ludlfNf6XHph9ZtJq875U7MUIWTg9uiNcBt
        kfnsVaULuKdO4YetAnDxzhvLUl0lnpF1k51spFA=
X-Google-Smtp-Source: ABdhPJy8j71RL+QX7ISM1MNRd5cXXyuX/8eo70cOo2LLQ5CfSBiIpjY1GtUvbbApMDLIP48++H5Grg==
X-Received: by 2002:a05:6512:3c9c:: with SMTP id h28mr3353106lfv.7.1628790906012;
        Thu, 12 Aug 2021 10:55:06 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id v8sm327384lfo.107.2021.08.12.10.55.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 10:55:05 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id m18so11762823ljo.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:55:05 -0700 (PDT)
X-Received: by 2002:a2e:944c:: with SMTP id o12mr3709757ljh.411.1628790904975;
 Thu, 12 Aug 2021 10:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210812112938.3748c7f5@oasis.local.home> <CAHk-=whHxeUjaNrWOLb0qx=-nibRZzQomwkw9xMPH_aHCf=BWQ@mail.gmail.com>
 <20210812133306.1c480741@oasis.local.home>
In-Reply-To: <20210812133306.1c480741@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Aug 2021 07:54:48 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj=8xh+AcwQ+w62-QHfVU6wXC2xW8L17VvVBaR6dR6Ttg@mail.gmail.com>
Message-ID: <CAHk-=wj=8xh+AcwQ+w62-QHfVU6wXC2xW8L17VvVBaR6dR6Ttg@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes and clean ups for v5.14
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 7:33 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> That was my take too, when this was first addressed:
>
>   https://lore.kernel.org/lkml/20210730204050.46975ae2@oasis.local.home/
>
> >
> > The commit message talks about "some compilers/analyzers" without any
> > explanation, and the "Link:" thing doesn't link to anything useful
> > either.
>
> I should have added the above link. :-/

Even the above link doesn't explain it to me.

What is it that gives this crazy garbage warning?

It looks like Randy Dunlap compiles with the '-Wmain' flag, and then
complains about it hurting.

It's a classic case of "Doctor, doctor, it hurts when I hit myself in
the head with an ice pick".

The solution is not to take some Ibuprofen.

The solution is DON'T DO THAT THEN.

People who build with W=2 or some other crazy thing need to understand
that the bad warnings it exposes are not kernel problems, they are
THEIR problems.

               Linus
