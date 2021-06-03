Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7272A39A4F2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFCPqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:46:30 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:46623 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhFCPqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:46:30 -0400
Received: by mail-ej1-f44.google.com with SMTP id b9so9860670ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+dyX45p2TEmbpf8Ziyr5yASE2TSeenBM5lJ0jfooR3E=;
        b=I76/RV1AfjaM8ug8aeJTwpKeDyq58fjCOA9+2SFMNmqIloIh3RwFGV9CENK8szh2JH
         gSo2fxF64Rb/AtvJatJ3sI6L6PI3THRfw15QRY5FVoCDfqX5jUdWWwNal6CoJxwOZLni
         WLhZbbmqhQDRq1NG/V49DH2Hm/nfu3vuRnCxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+dyX45p2TEmbpf8Ziyr5yASE2TSeenBM5lJ0jfooR3E=;
        b=RL4AGIEAI/SkvP5rDNDLiNnQyCTj6BmazY4vZDLqxDeHj6znevl5jhAICxzxikGez/
         aI0NbmgD7J+ccamDnq5gYg1LAgIh9X6GPjPTuu+UC4ex2mx6zTlijTzSqD3SXcUWzZh+
         qlYyWJ+FjHZ/aruuVihfVwxeuGnHDHludIuR1xf8B1/oDFxkzefS0yyDjZ2bl6Bp9YAF
         5oSVDnhkXPyTVp7Zn8DTh7v/WO//nBmUSyCOujUuRaosZ+UiaD80lA8VeaSpbXU36fjR
         ccR5mRt5/lAYcOHyfKOZvZu/CHdr5hMOx4U+sAO4prXEbrjsJrv4wibb5Dia1OAgo0W+
         +Iqw==
X-Gm-Message-State: AOAM531QImbb/IEeeY2MUF3IUoI7F9/xxbhQBizqkO/pXWFVc30Fse6M
        DztEDJWWVajfZ/wnNkLZyaKbZVaKcSJlkZ6K0clneA==
X-Google-Smtp-Source: ABdhPJykKGceIDXdiSiJ2QW9N83LnkxWv/wgZbHAjWedZKxT4m1XZslWObnTwTste+XgkI5PY6yi6uAByQVzv5pYCfg=
X-Received: by 2002:a17:906:f6d7:: with SMTP id jo23mr40854ejb.302.1622735014308;
 Thu, 03 Jun 2021 08:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210526223445.317749-1-jforbes@fedoraproject.org>
 <aa130828-03c9-b49b-ab31-1fb83a0349fb@kernel.dk> <CAFbkSA1G2ajKQg4eA947dv0Pcmyf-JQbkn8-jYnmUeMAEpfHtw@mail.gmail.com>
 <01c2a63f-23f6-2228-264d-6f3e581e647d@kernel.dk> <CAFbkSA2zt5QLBH0S8pcBROCaV3zSw_M-RvaQ-2yccCKgV-_2BQ@mail.gmail.com>
In-Reply-To: <CAFbkSA2zt5QLBH0S8pcBROCaV3zSw_M-RvaQ-2yccCKgV-_2BQ@mail.gmail.com>
From:   Justin Forbes <jmforbes@linuxtx.org>
Date:   Thu, 3 Jun 2021 10:43:23 -0500
Message-ID: <CAFxkdAqK+JyBysxYwUp8BAuQcjkdOpJ=kA_QNVJMTzGez10HVA@mail.gmail.com>
Subject: Re: [PATCH] io_uring: Remove CONFIG_EXPERT
To:     Justin Forbes <jforbes@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, asml.silence@gmail.com,
        io-uring@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 11:01 AM Justin Forbes <jforbes@redhat.com> wrote:
>
> On Thu, May 27, 2021 at 9:19 AM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 5/27/21 8:12 AM, Justin Forbes wrote:
> > > On Thu, May 27, 2021 at 8:43 AM Jens Axboe <axboe@kernel.dk> wrote:
> > >>
> > >> On 5/26/21 4:34 PM, Justin M. Forbes wrote:
> > >>> While IO_URING has been in fairly heavy development, it is hidden behind
> > >>> CONFIG_EXPERT with a default of on.  It has been long enough now that I
> > >>> think we should remove EXPERT and allow users and distros to decide how
> > >>> they want this config option set without jumping through hoops.
> > >>
> > >> The whole point of EXPERT is to ensure that it doesn't get turned off
> > >> "by accident". It's a core feature, and something that more and more
> > >> apps or libraries are relying on. It's not something I intended to ever
> > >> go away, just like it would never go away for eg futex or epoll support.
> > >>
> > >
> > > I am not arguing with that, I don't expect it will go away. I
> > > certainly do not have an issue with it defaulting to on, and I didn't
> > > even submit this with intention to turn it off for default Fedora. I
> > > do think that there are cases where people might not wish it turned on
> > > at this point in time. Hiding it behind EXPERT makes it much more
> > > difficult than it needs to be.  There are plenty of config options
> > > that are largely expected default and not hidden behind EXPERT.
> >
> > Right there are, but not really core kernel features like the ones
> > I mentioned. Hence my argument for why it's correct as-is and I
> > don't think it should be changed.
> >
>
> Honestly, this is fair, and I understand your concerns behind it. I
> think my real issue is that there is no simple way to override one
> EXPERT setting without having to set them all.  It would be nice if
> expert were a "visible if" menu, setting defaults if not selected,
> which allows direct override with a config file. Perhaps I will try to
> fix this in kbuild.
>

So it turns out that untangling this in kbuild is very difficult
without getting very unexpected results. Given the audit and security
discussions around io_uring lately, I am inclined to believe the
proper action is still to remove 'if EXPERT'.

Justin
