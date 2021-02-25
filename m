Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B30325751
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhBYUKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:10:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:60182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232686AbhBYUJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:09:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F6DA64F18
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 20:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614283757;
        bh=kLTa/ubC5MochBZlwWejAWH8i38DT4RgDPx/X3yeOzc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HB+M50wRHdwO/ucVOsAAXf1v2xWYkj4i2rP7Mt0ZG5fAXfaM1eVekZ4cz2EKC0HfC
         hvoIgj4gj1rMeiMs9MeVDpjKZnJsGBD3YcXtfTUdxbMP8SBmm58k4c0AWK6LBjVSSs
         /40rAI32LbzVUHZAc/RFHum2O7k5JBq2YyV6tVAbFApwQCmRlTqgQeR5j+AzA1r/pP
         EtrbDnb+y1GqTwsXAFYAMUQQGXWXqygxS7gFRySQ9zDUDlxCIPcQVOH2HXwdWrn5Dc
         I9ApDojD+MskbMzkXR8optf+ve8O/G9XBwwXnXk4LDoiazBNBEZbRXnpgKU3vle6i8
         mlT29ulV9QnBA==
Received: by mail-ot1-f41.google.com with SMTP id x9so2575907otp.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:09:17 -0800 (PST)
X-Gm-Message-State: AOAM533MuVmFHzhLWxjZyn1LVLHqzen0bPgwGxf7PWiCi6IKSxm9/AhL
        LeQeKO5FHrcYviUi9qEWawG8MJYYoKSeRSa1Ous=
X-Google-Smtp-Source: ABdhPJxiCYzAOoEh7nBXC2d0Xs4hgMMGrMRmBQcEHjrsR8s1Yzp8rGEYfK68hLTds3lh/hr9+c+Ip/sI1DPjrmMMyFY=
X-Received: by 2002:a9d:7f11:: with SMTP id j17mr3778751otq.251.1614283756180;
 Thu, 25 Feb 2021 12:09:16 -0800 (PST)
MIME-Version: 1.0
References: <20210225094324.3542511-1-arnd@kernel.org> <20210225164522.GA3554437@xps15>
In-Reply-To: <20210225164522.GA3554437@xps15>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 25 Feb 2021 21:08:58 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3nnPKOcVUN=wUBrPDAQh3E4P8ApC_D+37H8W-DZTn_xw@mail.gmail.com>
Message-ID: <CAK8P3a3nnPKOcVUN=wUBrPDAQh3E4P8ApC_D+37H8W-DZTn_xw@mail.gmail.com>
Subject: Re: [PATCH] coresight: etm4x: work around clang-12+ build failure
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        coresight@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 5:45 PM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
> On Thu, Feb 25, 2021 at 10:42:58AM +0100, Arnd Bergmann wrote:
> > index 15016f757828..4cccf874a602 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > @@ -691,13 +691,13 @@ static void etm4_disable_hw(void *info)
> >                       "timeout while waiting for PM stable Trace Status\n");
> >
> >       /* read the status of the single shot comparators */
> > -     for (i = 0; i < drvdata->nr_ss_cmp; i++) {
> > +     for (i = 0; i < min_t(u32, drvdata->nr_ss_cmp, ETM_MAX_SS_CMP); i++) {
> >               config->ss_status[i] =
> >                       etm4x_relaxed_read32(csa, TRCSSCSRn(i));
> >       }
> >
> >       /* read back the current counter values */
> > -     for (i = 0; i < drvdata->nr_cntr; i++) {
> > +     for (i = 0; i < min_t(u32, drvdata->nr_cntr, ETMv4_MAX_CNTR); i++) {
>
> This patch will work and I'd be happy to apply it if this was the only instance,
> but there are dozens of places in the coresight drivers where such patterns are
> used.  Why are those not flagged as well?  And shouldn't the real fix be with
> clang?

This is the only one I see in randconfig build tests. In fact I only actually
see the second one of the two causing problems, but it seemed silly
to change only one of them. I had not noticed the other similar
loops that use etm4x_read32() instead of etm4x_relaxed_read32().

I first suspected that the memory clobber in  __iormb() prevents the
compiler from running into the same problem there, but changing all
etm4x_read32() to etm4x_relaxed_read32() did not make it show up
in other places either.

While I expect this will be fixed in mainline clang, the workaround should
be harmless and let us use the existing releases as well.

      Arnd
