Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B1737470D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 19:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbhEERl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 13:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236926AbhEERiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 13:38:08 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7D1C04BE5D
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 10:08:16 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z9so3587236lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TXfFZZ7b4TM1sxNDr6im9Q4SJx9GgI4o7b+U/NNzxDg=;
        b=a2PP4/dOpWwWz6i8Ys/3T5czqfvynoYnokJZqPWQcKLPYfQkT5vxYi5WRmOlW9D8ll
         3kDOSi5WH2RbH50m4ZpoddT4p+p2skW4/UdYlef9+ntUe5LCxqByTDu4cWaww4A1lawc
         s1MrmJ9CeyVWr8qgE/K1IiN5XbqAPR1C6jiUHWH/cXE2eGGa3UCY0SMzXYebjFAbbFpA
         tRf0Wt2e9jqOKxokZ/QTEX5Cp0/CVq+IXhVpofxD8a33emdMeqz9IyeF3Sakcu2hC/8q
         dfvmjGrnbvjFAAzpEPerCvbt9diX2hQf2VWVUaFaXyLbfto3EY/RV6/A6O6Egpdz/HSV
         +pCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXfFZZ7b4TM1sxNDr6im9Q4SJx9GgI4o7b+U/NNzxDg=;
        b=P4PmgshSgyd1vclyaJowz28Q0F0xBe/aaMPbS+hd+2k+wWuSCxohPr7olCumvkOzYK
         dMiDgPkOqw9q3u70mgqBVCXEbD+3JixMZ69aV8KQGblnMxbRP6duQnG10mqNHgUlQArn
         jos1J9MF8W80pBYugt5MNDnI/0SVaX+G8ynCg6aWUe6125Xl3joKKF+mfKLJYjTjeUHo
         nflmZLylOghInYDIJTDWGeVKilKy5TgiUHwVq/0rLWMkGBGu/buBXX2Rf8DFLV8l5ecQ
         IJ7hLEOuF86amVEI1Fz1xVSwy3JRWqtsLoSN2igyj0bf6K7fVxevdYP0BdEPhhaHisaL
         K90A==
X-Gm-Message-State: AOAM530ECl6EBNVVitbTZGV74loZezLKzWUer8mZNS+KRHeTXZbwfRvi
        cJCHs2wgrE+Z+kZTmBNETgScBSWBy/X1/F4ISC1IZJjh/bc=
X-Google-Smtp-Source: ABdhPJz+vJ1XKpfo47fXpgDuhePYd4J4KdoSuqucoSrW63wGOw/jYf4vzZuPNRNSudCGqPgAiXWNGiMnFBdm16zO044=
X-Received: by 2002:ac2:528d:: with SMTP id q13mr12956891lfm.73.1620234494387;
 Wed, 05 May 2021 10:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210505033945.1282851-1-ak@linux.intel.com> <YJI/OwoflyY2IXvf@hirez.programming.kicks-ass.net>
 <875yzxh8j8.fsf@oldenburg.str.redhat.com> <20210505143916.GS4032392@tassilo.jf.intel.com>
 <CAKwvOdneTkwm1xmte2SxwR=pcp3vi320kQuQHtVNVbnqLbcP3Q@mail.gmail.com> <a4d64648-6726-2046-0883-ac7f20c70445@linux.intel.com>
In-Reply-To: <a4d64648-6726-2046-0883-ac7f20c70445@linux.intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 5 May 2021 10:08:03 -0700
Message-ID: <CAKwvOd=jrmFxNMJzbMYbSYs7C6S1d7faOj-R60ZhpV50PNTdbw@mail.gmail.com>
Subject: Re: [PATCH] sched: Work around undefined behavior in sched class checking
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 9:49 AM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 5/5/2021 9:41 AM, Nick Desaulniers wrote:
> > On Wed, May 5, 2021 at 7:39 AM Andi Kleen <ak@linux.intel.com> wrote:
> >>>   Would you please provide a
> >>> minimal test case?
> >> You can only reproduce it with a LTO build because it needs knowledge
> >> between different translation units for this specific case.
> >>
> >> But gcc will totally do the optimization even without LTO if it can
> >> prove the same inside a single TU.
> > It would be helpful to isolate a test case that doesn't rely on LTO,
> > if possible.
>
> Like I wrote earlier we used to see it all the time in __pa_symbol
> before it used RELOC_HIDE. I bet if you make RELOC_HIDE a nop you'll see
> multiple instances.
>
> But not sure why you want a test case?

In general,
when making a feature request to a compiler vendor, having a
digestible snippet of code that demonstrates the problem goes a long
way, much further than "clone this branch of my fork of this project
and do a build and something goes wrong somewhere."  We're too busy to
do that, please take the time to isolate it before making such
requests.

-- 
Thanks,
~Nick Desaulniers
