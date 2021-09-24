Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A525E4175F0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345998AbhIXNgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346573AbhIXNgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 09:36:00 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A49C0613A0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:32:08 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id d18so12514496iof.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 06:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+v3z+GTl8YDcn3uh1XFfOevsjrdEdg5lDaT6Q/eFf/k=;
        b=DZj9D1lpKgneZAjzYBjLHueo5bWr5LuJiShKYAw4T0rFawg15G1ajEahro/9wj8Ti+
         f+5vU1mmwkrcZNd7mtcBPSRGOH1IiRQY0rVqYmD3Tp2Xp/WUo2DYI9CdHVp+IEqA8vWw
         xyHo5ebP2asO8Jir8XNTnoNeM5WGTB0RlJV87dV63C/w+S4RAXydXdM/iIdKu7IPxiRy
         3IpTjVKGb2Ra5zpgt3HnfINNE6s4TfBpVMOPn03U07OrxpYaoDJkbPwZ+a/0kFKgW/fi
         l+335PULEjaY2w8IqEB13auusKtKrv46aMx9zVC+RQAxWu3LF/5vXlpRkiRS1mYJSpXi
         Jnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+v3z+GTl8YDcn3uh1XFfOevsjrdEdg5lDaT6Q/eFf/k=;
        b=NkGSzwx3HRAzT2CLXpB7U5INmqjlmDzxIDKI2+s2vjjuIkqfc1o5366K714nWoX4sQ
         FJ2oxnZMEJW98HirH2ooBueyocRe21U6RqZlrjyPHoYZ0HEY0ihAeAutj1U1a3wvIf4w
         Of1sTv55M8swfbvcTmRaqIMNHTJyy7XIwsnGqYSeh+/OaDvvOLxuH8YCnqlQswjpDAZa
         8jT4l6ivgY8lx2a1mcR3ac42pwlUbNGuP4yY6CXDxRByr2oXQ81Pzg1fuYVe4aOGKvqG
         iWMpMAnFxSUkoclhUpG6GFmkqeXXNlajeowjqWWdB5oPnk+ap06lqXlPWuFggkj4n0/m
         qeRQ==
X-Gm-Message-State: AOAM53287sEpAPjUCkmSERdR/uvSdut6Vgy8LTCMgCqGOut/fEHBccEt
        bqJNXWSYBJgIJTR8deA+mIsm1rC2UoFps7r7UA==
X-Google-Smtp-Source: ABdhPJxOpwcDdTV0O6WlsGTsYhVOGgMxLVB3219XfEEakU5d2osyfuLr9QXw77+MQTec8932DgFTZ7YdE+Z5s27cA1U=
X-Received: by 2002:a6b:7842:: with SMTP id h2mr8956324iop.157.1632490328283;
 Fri, 24 Sep 2021 06:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210923140951.35902-1-kernelfans@gmail.com> <20210923140951.35902-5-kernelfans@gmail.com>
 <CAFgQCTsvrGSzxZKFOiE+yqLdFZTnXkh72G0pVbp2q_sEW_pjEQ@mail.gmail.com> <CAFA6WYO01=4KmE=MJFL9btSvP8-RmQHMO49pLwUrgR9-LFm5+Q@mail.gmail.com>
In-Reply-To: <CAFA6WYO01=4KmE=MJFL9btSvP8-RmQHMO49pLwUrgR9-LFm5+Q@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 24 Sep 2021 21:31:57 +0800
Message-ID: <CAFgQCTt7v4GdiZ=wb02hJDFC57W3OKyr9sHfn365PQ0_zHJVnw@mail.gmail.com>
Subject: Re: [PATCHv2 4/4] arm64: Enable perf events based hard lockup detector
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 1:19 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Pingfan,
>
> On Thu, 23 Sept 2021 at 19:59, Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > On Thu, Sep 23, 2021 at 10:10 PM Pingfan Liu <kernelfans@gmail.com> wrote:
> > >
> > > From: Sumit Garg <sumit.garg@linaro.org>
> > >
> > To Sumit, I think credits should go to you and keep you as the author.
> >
>
> Thanks, I am fine with it. If you like then you can add your
> "Co-developed-by" as well.
>
OK, I will.

> > > One thing to note here is that normally lockup detector is initialized
> > > just after the early initcalls but PMU on arm64 comes up much later as
> > > device_initcall(). So we need to re-initialize lockup detection once
> > > PMU has been initialized.
>
> This needs to be updated to reflect delayed initialization instead.
>
I will update the commit log accordingly.

Thanks,

Pingfan
