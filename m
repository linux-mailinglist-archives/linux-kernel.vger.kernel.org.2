Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CC436DD77
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 18:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241223AbhD1QvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 12:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbhD1QvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:51:06 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB504C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:50:19 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z13so19308332lft.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0uZJAIRFioTiHNk4LTl3GPgwLpvR/tqMtufSg3nWhNk=;
        b=MkEAqmIhebjBuyB/bFWJkeNmQq6+31Os4ltso3CHWcE/z6HMUwlD9kGKr75X1dcJZN
         nhAkq4TFetgPc3bclHi1B1uRcqtiTIb2JBFDflUDC+XnR14QbDiaFEnR1UXNn7Agvs3p
         CZs19Op5jQnv+sJsmNTa3kkHt1Kq8UyRB4q18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0uZJAIRFioTiHNk4LTl3GPgwLpvR/tqMtufSg3nWhNk=;
        b=W4Y1eHPUGQK3oLY5M7b+GpxxrCXlO/ehycXHAp6orhLTSIRGGvyq+tVviCsQsX/uGf
         FwQjC2VGSUD2jius3/OKNI/lcRWuXt2c1svxauPboGEwz9pf6fHHB2yqrYJPpG7eHGnx
         rvywYt0JcWbF54yxUCGJNmvnqIsblv+Xl8zpNc/orpAG32tmvVQ63siEkNzTlT7RI36B
         GrjWnUXoJsHd9wnpWb3mHfdLHx4FkU+XIMmP2gXBMpJHkvbRiFz7dQn8qnhn0gkQF8yF
         vH2Ut5o6Jrbek1d364Ak7S/2rkOnWmqDbfW/7CbxeeGASNSsLb7VYCswriCkwyT4UerA
         SVhg==
X-Gm-Message-State: AOAM530+fC/qzwaZ88EsBhGMJfn88JQ4qBzTmXc3lOR2RiG/C+i9rtvA
        5Bm1R1hudlud5eDENGo+6jOUAZwbKj0xIdbM
X-Google-Smtp-Source: ABdhPJwpC8Lt/74OFGYL6WVy560yyoXh1AZJvfBEBt6JwafgKihvAYFx8Tv6kCyXlld5amds8Bwtrw==
X-Received: by 2002:a05:6512:b90:: with SMTP id b16mr22098890lfv.37.1619628618141;
        Wed, 28 Apr 2021 09:50:18 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id m28sm88188lfq.180.2021.04.28.09.50.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 09:50:17 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 124so19275152lff.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 09:50:17 -0700 (PDT)
X-Received: by 2002:ac2:5f92:: with SMTP id r18mr7706166lfe.253.1619628617003;
 Wed, 28 Apr 2021 09:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210427025805.GD3122264@magnolia> <CAHk-=wj6XUGJCgsr+hx3rz=4KvBP-kspn3dqG5v-cKMzzMktUw@mail.gmail.com>
 <20210427195727.GA9661@lst.de> <CAHk-=wjrpinf=8gAjxyPoXT0jbK6-U3Urawiykh-zpxeo47Vhg@mail.gmail.com>
 <20210428061706.GC5084@lst.de> <CAHk-=whWnFu4wztnOtySjFVYXmBR4Mb2wxrp6OayZqnpKeQw0g@mail.gmail.com>
 <20210428064110.GA5883@lst.de> <CAHk-=wjeUhrznxM95ni4z+ynMqhgKGsJUDU8g0vrDLc+fDtYWg@mail.gmail.com>
 <1de23de2-12a9-2b13-3b86-9fe4102fdc0c@rasmusvillemoes.dk>
In-Reply-To: <1de23de2-12a9-2b13-3b86-9fe4102fdc0c@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Apr 2021 09:50:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimsMqGdzik187YWLb-ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com>
Message-ID: <CAHk-=wimsMqGdzik187YWLb-ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.13-rc1
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>, Jia He <justin.he@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Added Andy, who replied to the separate thread where Jia already
posted the patch ]

On Wed, Apr 28, 2021 at 12:38 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> So the patch makes sense to me. If somebody says '%pD5', it would get
> capped at 4 instead of being forced down to 1. But note that while that
> grep only produces ~36 hits, it also affects %pd, of which there are
> ~200 without a 2-4 following (including some vsprintf test cases that
> would break). So I think one would first have to explicitly support '1',
> switch over some users by adding that 1 in their format string
> (test_vsprintf in particular), then flip the default for 'no digit
> following %p[dD]'.

Yeah, and the "show one name" actually makes sense for "%pd", because
that's about the *dentry*.

A dentry has a parent, yes, but at the same time, a dentry really does
inherently have "one name" (and given just the dentry pointers, you
can't show mount-related parenthood, so in many ways the "show just
one name" makes sense for "%pd" in ways it doesn't necessarily for
"%pD"). But while a dentry arguably has that "one primary component",
a _file_ is certainly not exclusively about that last component.

So you're right - my "how about something like this" patch is too
simplistic. The default number of components to show should be about
whether it's %pd or %pD.

That also does explain the arguably odd %pD defaults: %pd came first,
and then %pD came afterwards.

              Linus
