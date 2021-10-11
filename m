Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6541042979E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 21:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbhJKTjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 15:39:32 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:37451 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhJKTjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 15:39:31 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Ml72g-1n1QQw0ao0-00lU8x for <linux-kernel@vger.kernel.org>; Mon, 11 Oct
 2021 21:37:30 +0200
Received: by mail-wr1-f53.google.com with SMTP id u18so59688273wrg.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 12:37:30 -0700 (PDT)
X-Gm-Message-State: AOAM531gTvsbCbfpq1dzwSz7wbEsZkeBOB77HJCOJcGxuQvLN1pPQHft
        vZLjsRcCpeIEc6zzr6H+StKX/6yTGIgQB6G9xEM=
X-Google-Smtp-Source: ABdhPJyT47aAIrYNQxYrwNBoS8ZKcH/vNjyATZf3XLzGiQU8HJUA5uyJ0doiNGR4JQMooMYQW2fuN+IBS+gU1aX0WeA=
X-Received: by 2002:a05:600c:208:: with SMTP id 8mr911666wmi.173.1633981049777;
 Mon, 11 Oct 2021 12:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211011151443.12040-1-vegard.nossum@oracle.com>
 <CAK8P3a2+dU53PMJZvkDDGUyv=EiHuc03njGf6SXTxw9A4ByeHw@mail.gmail.com> <47e60186-2408-19cf-3231-92bd9c30483a@oracle.com>
In-Reply-To: <47e60186-2408-19cf-3231-92bd9c30483a@oracle.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Oct 2021 21:37:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2nai8xGQPPMH89rO83252trdRFM67s-mmivAXeDE0zfA@mail.gmail.com>
Message-ID: <CAK8P3a2nai8xGQPPMH89rO83252trdRFM67s-mmivAXeDE0zfA@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: select CRC32
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Oded Gabbay <ogabbay@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:sjAmUMxmtwwdHxTthPSUlnk03FpUdQnZP37oLcBtjKRhitRuFBZ
 tOh/mfJUAj5lImpHRAtSsWNnBvlyl3vAhJxBbfILWxMt7XQoJG41gwH9Vlets+cGtlQRJ4x
 Bf6fjfeVSutIP2Ca3LHECRSrjFmVdbdakASbSofkIqhC767f7PCvoJxetQF91h+k+zCBzbI
 T/YCoVqvxwt70uxq+pIqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BJtOYeTZfjk=:Bi11Yh1lFUPRo+O71XDw8k
 IswFkitPMfYyhorR7RnRUbsIEkuwehJtXYMX06j6Vf60p+3GxYwAnixUvDLUhB8xXyz/ofnU2
 KIEYzvqKiFAL0T21eB6pX9EWC9u+rqMJtj6evaJAe1MiNjh1IED+kyLRcyP54P5OqS8LKLCu5
 2orqqZkVJsG9VH9ZFdwrdy6eWAXtpH974wc8iuVryNav1G6Xh8QPPmUGsf/OhFlda3FJgElPq
 LvgSs98NSzicDfh0nnL0TmIzZChD556S+urH73fKS3a8AU1MaYMlIDEywmK3vIoCaTm2Jgwf4
 +uNKEGDX0eTalcgRFhZp2VCRMC3TSTAV2uWd7yDDzBBnEccCB7sdPYp9YmFJ2jEVgOm7wPrXy
 LKyrrWwQeC/5PoLZae7voF+8epIJmBLIyUAGXyQ4MzBVVxPoQpqDKlEcPAUA9mwakmXLzdg/x
 IAS2TnfLFytbyFiytOxta5Nko6QYfO4bA6OBGO2RdP3nS04cKhInuctGRzHMU4qKPMa5+K2Uk
 e95jNeRGVsHZ8XyQuas9iT3jyEK8sIuoU23G+gcNdDdfReQbEG/dvOWjgE8LnYs5LpXuvxpcr
 0KGw8fP71RsW1pnk7CSdFdU51MR/TcovVR1eeMlDlswCKGFZJSdaIM/w1xUhB2h4g4vu1yLjp
 74Q+wKAvdDZK7bP+Zk3+AipXlmlEfTRhwvFkTa9LDg8Sd4tORo7oPFiNW0NjxEvonSWU9A/v8
 p/GkxC15+9x+y9J/81r9/M2nY0szJ5013SrdLH9Ph6HXbKjBrPaKqDr9GU29/HhcPT9SnMBQE
 V9jrfiPBhE8E2+HCJc2XAO9E2RNEVVsYD7C0sCrf54wzBu6qkMu/aeFl4bT5FOACErcEsDH57
 qKyfzGob0K0p0w54wuow==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 6:29 PM Vegard Nossum <vegard.nossum@oracle.com> wrote:
> On 10/11/21 5:33 PM, Arnd Bergmann wrote:
> I'm working on a couple of new make targets, satconfig and
> satrandconfig, which can generate .configs that respect a set of choices
> specified in a .satconfig file (and, of course, the Kconfig files).
>
> In this case, I was just doing satrandconfig builds and noticed that the
> crc32_le ones popped up quite often so I just added CONFIG_CRC32=n to my
> .satconfig, which means that satrandconfig will generate only configs
> that have CRC32=n.

Ah nice! I had gone through some of those last year, but it was a rather
tedious manual process, and having some tool for it sound really
useful.

> I also suspect that satrandconfig samples the configuration space MUCH
> more uniformly than randconfig, in the sense that "make randconfig" will
> tend to have CRC32 enabled just because there are so many drivers that
> _do_ select it. (Think of it this way, every prompt for an option that
> has "select CRC32" in it will be another 50% probability of actually
> enabling the option.)

Yes, of course. I've seen other problems like this often happen with

CONFIG_I2C=m
CONFIG_LEDS_CLASS=m
CONFIG_IPV6=m
CONFIG_CRYPTO=m
CONFIG_PM_SLEEP=n

Not sure if you're already hitting those or if you need to add something
to your setup to make those more easy to find.

> I just tried doing 'make randconfig' 100 times and the result was>
> This project itself is about 11 years old, but I made a breakthrough
> recently and I'm polishing the patches for submission now. I thought I
> would try to fix the breakage that I could find first so it doesn't
> appear as if the tool itself is broken... (that's not to say it doesn't
> have any bugs, however!)

Sounds great.

       Arnd
