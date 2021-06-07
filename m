Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22F139D79B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhFGIok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhFGIoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:44:38 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB697C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 01:42:47 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d16so12527451pfn.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 01:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wDg8/aI1PuYOAa2UFE+KVmLp+L8E9j1GBJnNz/20160=;
        b=DnqQNTiXccMXKvEMdxBrWrV1+npUmpiZFOKUaNbe9s4kwc4oWESXEWzfdu8kukfLjY
         xYAb2QgLbef6ca/V6V7077rRzvgq8Ccpb0noOcuvGk+oYahrooyUdLORTJnl7iiEB/5r
         tq1wFnBqX62mqQmZyTg3CVtRwTYnqKAz1Q7Okcfl5fTnYyk+RpRE02iR+ohVbBKrszFu
         izakVi+NLWDUakCZ47YE7Zw7C9RGgipWLHBOvHm3QYlEEDOkRFSW/vqbSFh6KUxx21VZ
         Skd4K8MihUztx6gKSJ8xHZRnOrhGXAdp7xzXnkvs6UbGq9lSd1JabwYR7A3SYUKc/yvN
         fotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wDg8/aI1PuYOAa2UFE+KVmLp+L8E9j1GBJnNz/20160=;
        b=PRhCz0WzofumySWf9dD1KYeB0phTZ2FHRbx/uzBq5gbiC+N+PKb+SsjRuUTp5+wW5k
         18IQJJ3cT8EvBvf6OfqBE/Er/5s6vJAUFY6iLjKX9DdJs/qSemEkAp/L+vya3LerMqUU
         naI+tVY7GGFHPphFVVh/FhoRuqreYG2G15QhuCf6Gk3I1x7B9IQHmuPS3VXFN2CVwRzG
         1019PGECMRNEK0Y6r4UKsY6TFEc1iVyHoHTRPtBdKY02JEz8+KZe0lOPjMjQAgR1fCe+
         5avfnx4jSpP2RKarQKjhG6tPCoaX3rvRaBYzsAIHUIxsfWUr7lhTogn6PqXx8CV4b45W
         e2dA==
X-Gm-Message-State: AOAM532zaNZEBl8xe+e0IEmYGHqwMGJbFMrujhOgCJMovWT1ZiR+vCMX
        834l2YavPBzvxvWFABjURltyDxXxMbo0ipYkj/g=
X-Google-Smtp-Source: ABdhPJzFEb94kqJTu/BGex0Ss8ROGxSRDb7v248+ug+o6gMFoBTJnzzyhTyFlJW6S6wdIo/LvRo0u0sGUmhWlC6aOZE=
X-Received: by 2002:a63:79c3:: with SMTP id u186mr16809558pgc.203.1623055367160;
 Mon, 07 Jun 2021 01:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <1622996045-25826-1-git-send-email-faiyazm@codeaurora.org>
 <CAHp75VdM0aziN4zHaf6=z6D0Nb=+GTbjV1pdTpRZ=yxGDZRkhw@mail.gmail.com> <dd0e3e4e-7eba-039f-7b2b-3fb3131ce2eb@codeaurora.org>
In-Reply-To: <dd0e3e4e-7eba-039f-7b2b-3fb3131ce2eb@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Jun 2021 11:42:31 +0300
Message-ID: <CAHp75VfQz4WGF3FvpPGLeYHtjEfWFB7gMUpWN7DHjgi1fc1X0w@mail.gmail.com>
Subject: Re: [PATCH v10] mm: slub: move sysfs slab alloc/free interfaces to debugfs
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <greg@kroah.com>, glittao@gmail.com,
        vinmenon@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 5:40 AM Faiyaz Mohammed <faiyazm@codeaurora.org> wro=
te:
> On 6/7/2021 2:01 AM, Andy Shevchenko wrote:
> > On Sun, Jun 6, 2021 at 7:16 PM Faiyaz Mohammed <faiyazm@codeaurora.org>=
 wrote:

...

> >> +               if (l->sum_time !=3D l->min_time) {
> >> +                       seq_printf(seq, " age=3D%ld/%ld/%ld",
> >> +                               l->min_time,
> >
> >> +                               (long)div_u64(l->sum_time, l->count),
> >
> > Hmm... Why is the cast needed here?
> >
> To avoid below warning while preparing build for arm/32 bit,
> "format =E2=80=98%ld=E2=80=99 expects argument of type =E2=80=98long int=
=E2=80=99, but argument 4 has
> type =E2=80=98u64 {aka long long unsigned int}" .

Perhaps use %llu?

> >> +                               l->max_time);
> >> +               } else
> >> +                       seq_printf(seq, " age=3D%ld",
> >> +                               l->min_time);

--=20
With Best Regards,
Andy Shevchenko
