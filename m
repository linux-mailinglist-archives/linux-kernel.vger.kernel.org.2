Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A353DA023
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 11:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbhG2JPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 05:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbhG2JPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:15:44 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0E8C061757
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:15:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x90so7210992ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJEWXYf+MLVoeyVL4aKf9RaWEeEr+d0jCBcU4Hehaxo=;
        b=AnEg2zJa2HgclUb2HGoxq7v2MTCXHykSvoYQd/HK1CtNl+LbKX5si0F7hlBYlNCsc/
         A1Hcib63x2knKIYHDoRtEmSTeNiNXCAcX6o0glPWsC5hscrxnQmerV2Ou3Gdxkin36ZS
         ZsBEITmnal1ahnz+TC0JkduwhgHOukSSdZv7yhNBQR1zlb0edkI0N5M38xv+Rh2EX5KR
         9Svw0ABIwdcXxPHHm/VwCuhnfnkySVumKny0DHdH7wobRKZA8EEe9CBAYJafaIXtSamj
         JbUxQPcw9j4dtrcofRZclrSwjtbFGk7rK5BYzpD3CidKNrqQqEjFjBbYDfq5Y7vCQP5z
         HI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJEWXYf+MLVoeyVL4aKf9RaWEeEr+d0jCBcU4Hehaxo=;
        b=oWblWJQa1o1STlSm7ZKwlVsjX9eAEv3poklyLnKMWqa1sI0obRwJp8ZqNxwRvVyr7U
         27WT4TmhlmHpe1Y40JTiAKsc5xpS05gXVmShVZUnOIAbzQjkCQsNkZqYgXRDWVNXwCgM
         hjIMHr9GT/c0Lt/4WW3+gbAQRQK496PG6+wv6squKwSlNxfaEDqpCcQErG6OtaKr8RL9
         cllg2iXP8SRsjfVh5mioGNlHXeLUgN1RXtPCFcJP46rFB0QLQ9TUMd+gwTb2iGU0D66G
         HiqhMih2NLYdGRuKnyS/+Qr/g3WgvpWXspylNd/BUAei8I1+lFB1Eg1UNkLLPxY+vlMZ
         k5dA==
X-Gm-Message-State: AOAM5337TkNMmUpJyCyCKYQAAm4km3LUvCzIpYBWl2XN4rvPDt23HxbY
        ozVd7PEA/yZILvfuYdzxW2JDW57jux40sPrayB837g==
X-Google-Smtp-Source: ABdhPJzGO5ZEDGWNIfoyBnRz2S9+ImksyNVrhgBKmRynSisfodXh4WyTGC9T8Thgtd3CToxg9p1mCZgsHir6qf9QKZo=
X-Received: by 2002:a05:6402:cab:: with SMTP id cn11mr4706255edb.369.1627550140422;
 Thu, 29 Jul 2021 02:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210729082549.144559-1-wangrui@loongson.cn> <YQJu6fTIpeuGV+UX@boqun-archlinux>
In-Reply-To: <YQJu6fTIpeuGV+UX@boqun-archlinux>
From:   hev <r@hev.cc>
Date:   Thu, 29 Jul 2021 17:15:29 +0800
Message-ID: <CAHirt9j2G62=7_a4Ow88smnRzOjKMkD1WQoj4uc=mQq9Qf8UFQ@mail.gmail.com>
Subject: Re: [RFC PATCH] locking/atomic: arch/mips: Fix atomic{_64,}_sub_if_positive
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Rui Wang <wangrui@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Boqun,

On Thu, Jul 29, 2021 at 5:04 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Hi,
>
> On Thu, Jul 29, 2021 at 04:25:49PM +0800, Rui Wang wrote:
> > This looks like a typo and that caused atomic64 test failed.
> >
> > Signed-off-by: Rui Wang <wangrui@loongson.cn>
> > Signed-off-by: hev <r@hev.cc>
>
> In your upcoming patches, please change this part to your real name.
> Here is a quote from Documentation/process/submitting-patches.rst:
>
>         using your real name (sorry, no pseudonyms or anonymous contributions.)
Ok, got it. :-)

Thank you. I will resend these patches.

Regards
Rui
