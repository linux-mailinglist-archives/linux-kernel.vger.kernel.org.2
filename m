Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692003DA314
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 14:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbhG2M1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 08:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbhG2M1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 08:27:46 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291A1C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 05:27:43 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id e3-20020a4ab9830000b029026ada3b6b90so1543988oop.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 05:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jAeYpTpD86gcaq0fp6AOwIIDB2L6QnWwp67+iHCveIY=;
        b=ml7Q/Yn+L1JNrhw7y+0CfmimrYs8yNnxEQL5SIK39c4Q4kU9hmEqtqiUIj7p0lualS
         0vl5sVIyOjyzAJs3BAYo00cW5Xuzev16ok5ctZ1VenR5k5EXd9Hs4EhZnOyoCHNxd2e8
         h6gi/8lbU8DnWXPHHV9lzdhTWrNGRNs/TgW0907rIkBQJgmhpBfuZUCcl9P5uAbSbudl
         6PY2SQe37ZnHdElfZ4fPaT+GKxN2JRT/bytQfZ5pkpMxa5xqutvqEJQNyuWCQq3v8OZD
         uIvrWImjE/wtpdzv+NDPzLdp+rslqBSRMHRTF3PRKSl0ihPR9C/7MqQwEX3Gsd5sw7Nl
         5txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jAeYpTpD86gcaq0fp6AOwIIDB2L6QnWwp67+iHCveIY=;
        b=ncWSLcgXgaGEOSJySaG/7gz+VKxF2ClyuVTb9PEbBJS9JL97Etyt6FzjIvfNhLfWAP
         4drXoG4mofN73c813RKjGU0tzDrG+tqv8tgdvxKem9T8IqYYFEM/vp1S9mve8r/dJQ5y
         fCYZZ4+ALZoJcKLHwHaLUb4/J72yQ2m3eaAlF3xsv62KWWws8LmatDD4L70eYD3zzzTJ
         Kw2/SveZwvugaQqgBiycCS4dNrRHC37Z9wlDCgoNND+O02kalNPRwyKvfZoprATyHAgR
         RtL/VUrbEK9sLbuvmm2VRVwrlWYB1pp8rdAEkC+ikBaf5c12YYfLckabE0WW3m+dkfi2
         h1/A==
X-Gm-Message-State: AOAM532TPHMQ/3jKLIglgug0FB8iqFt1gu9AeFruwyCf+iLnzPK+6dqx
        fJAnFg2EwoRrV+4dpQqnk/ddjwe4ZYjSqvZu5slzGA==
X-Google-Smtp-Source: ABdhPJzdZqCMYw/artCLUUOUtHTdZ/eyCd1qEAfxK53RlOp+/u7kO6WD0K9TwsO2g5IRhUr+gY/uSniuVTaTdFDFO3w=
X-Received: by 2002:a4a:e502:: with SMTP id r2mr2827562oot.36.1627561662128;
 Thu, 29 Jul 2021 05:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210728190254.3921642-1-hca@linux.ibm.com> <20210728190254.3921642-3-hca@linux.ibm.com>
 <YQJdarx6XSUQ1tFZ@elver.google.com> <YQKeNbU4HJhFP8kn@osiris>
In-Reply-To: <YQKeNbU4HJhFP8kn@osiris>
From:   Marco Elver <elver@google.com>
Date:   Thu, 29 Jul 2021 14:27:30 +0200
Message-ID: <CANpmjNPWj2vjNd2V-Wqgh1+AvmKQEbg=Qh43DQ_5P2vNv7+JDw@mail.gmail.com>
Subject: Re: [PATCH 2/4] kfence: add function to mask address bits
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2021 at 14:25, Heiko Carstens <hca@linux.ibm.com> wrote:
> On Thu, Jul 29, 2021 at 09:48:58AM +0200, Marco Elver wrote:
> > On Wed, Jul 28, 2021 at 09:02PM +0200, Heiko Carstens wrote:
> > > From: Sven Schnelle <svens@linux.ibm.com>
> > >
> > > s390 only reports the page address during a translation fault.
> > > To make the kfence unit tests pass, add a function that might
> > > be implemented by architectures to mask out address bits.
> > >
> > > Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> > > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> >
> > I noticed this breaks on x86 if CONFIG_KFENCE_KUNIT_TEST=m, because x86
> > conditionally declares some asm functions if !MODULE.
> >
> > I think the below is the simplest to fix, and if you agree, please carry
> > it as a patch in this series before this patch.
>
> Will do.
>
> > With the below, you can add to this patch:
> >
> >       Reviewed-by: Marco Elver <elver@google.com>
>
> Done - Thank you! I silently assume this means also you have no
> objections if we carry this via the s390 tree for upstreaming.

I think that's reasonable. I'm not aware of any conflicts, nor am I
expecting any for the upcoming cycle.

Thanks,
-- Marco
