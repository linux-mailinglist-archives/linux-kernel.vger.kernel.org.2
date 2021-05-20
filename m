Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C7138AEED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243143AbhETMsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242540AbhETMqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:46:09 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535A8C061364;
        Thu, 20 May 2021 05:06:31 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i4so22499210ybe.2;
        Thu, 20 May 2021 05:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BpnZbz1EGOrIuAMnUU3qLJnhcMy80CnQMklnM6U5PS0=;
        b=RpXnY12B54L3+4ROy8QkuQ1Vu9h+zk4PjZbv0y3FRvD+ad9TzbyN72GxGB4d2rjikO
         Tfp93Wx/ZeGJhHy6SQ/exodESiqY0D9pyXqSH1oE5kn3jw0uWjegTLoAPRbfFyVFx5Zd
         YPCwZkPFGJZdQOIMMXgXq3DV6iKhMkLu6qpr9Iz2L/PTHFjRR9QG4ssV3i4dhuMt3bYt
         oOMnY0OkX2umW2M62TSQGvSoC+oQrsRjLDLqE8IKImHqOdpwwno5voxKuVJxRQvJ0tJu
         xRWi8OSHiFkFx9tjAXbLDk0W4gWR8uaHFRoP/vTNKEZwY2iFgDx2W2d2ssON55hXGoVs
         sYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpnZbz1EGOrIuAMnUU3qLJnhcMy80CnQMklnM6U5PS0=;
        b=HHbMPi7dt/53ut3Oa3O6+iPWOCj00kZaXAce0erSKVDpfaCR3pF6FwPWf+3l8JeAdO
         PhnPQ+BmVPx/8FpOsctST6aXP09HI28Q98jecxAuzUe9NCA5ftvMLhR1tFQ2NJBolfKg
         au9wGcrskjsLBQ9Tut99K44SyeqUdQPj4NS2Jfj36lnsZgoPO9hzEVnw9TiyE5Uu6RDd
         z9fpC1zU653cH/+6uGTERU+IiFZLCDtLcWCKT0csnFhz8FcJ5XGWBC35aBpg21bg9n9b
         bgzNIK6NkhZL8CTRmjw7fn3T732//BwyH261rnrJWzYzL/0LOfoTVIX2mjqUb5P0qDzo
         dlRA==
X-Gm-Message-State: AOAM533K8KUXohavGOaGE/iD7aywGTamTU7HgViYvA8ZiCk7vJR6JG9b
        9a37G82QwEAzkx3M5gOZJjYqPLfLptKYF52nl6M=
X-Google-Smtp-Source: ABdhPJxcqHoGfDIubcpklyMLW47ufXvxtAvygG7bqSBd8EXKLuwNOUATJclwHf158J3+WUsorsyRORsNdi/mRFy+oK8=
X-Received: by 2002:a25:8b86:: with SMTP id j6mr6186342ybl.470.1621512390469;
 Thu, 20 May 2021 05:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210520015704.489737-1-andrew@aj.id.au> <CAKXUXMxTnz6edBLpBgqOo6uUiSGm8rULH9P8G24xx2OhP_Yb6A@mail.gmail.com>
 <a0d1f44a-c8ff-4108-af34-6455b5683262@www.fastmail.com> <CABJPP5C7ZokRycaE0aAvUv3BfOJqOvPyqn-P0bbPdyCfnuuESw@mail.gmail.com>
 <72ed5aa8-bca5-451d-9458-48735fc17b84@www.fastmail.com> <CABJPP5AMPL22dJ2YKNqdTtHrTJRr=SKnxo05PKn9FoveNX7tow@mail.gmail.com>
In-Reply-To: <CABJPP5AMPL22dJ2YKNqdTtHrTJRr=SKnxo05PKn9FoveNX7tow@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 20 May 2021 14:06:19 +0200
Message-ID: <CAKXUXMzTiYOe9T6w_mPny8S1gBGyktSzpZ+FFPLxVTUhkTTUcQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: checkpatch: Tweak BIT() macro include
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org, Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 12:21 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>
> On Thu, May 20, 2021 at 3:15 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> >
> >
> > On Thu, 20 May 2021, at 18:47, Dwaipayan Ray wrote:
> > > On Thu, May 20, 2021 at 12:55 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > >
> > > >
> > > >
> > > > On Thu, 20 May 2021, at 16:28, Lukas Bulwahn wrote:
> > > > > On Thu, May 20, 2021 at 3:57 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > > > >
> > > > > > While include/linux/bitops.h brings in the BIT() macro, it was moved to
> > > > > > include/linux/bits.h in [1]. Since [1] BIT() has moved again into
> > > > > > include/vdso/bits.h via [2].
> > > > > >
> > > > > > I think the move to the vDSO header can be considered a implementation
> > > > > > detail, so for now update the checkpatch documentation to recommend use
> > > > > > of include/linux/bits.h.
> > > > > >
> > > > > > [1] commit 8bd9cb51daac ("locking/atomics, asm-generic: Move some macros from <linux/bitops.h> to a new <linux/bits.h> file")
> > > > > > [2] commit 3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO")
> > > > > >
> > > > > > Cc: Jiri Slaby <jirislaby@kernel.org>
> > > > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > > >
> > > > > Looks sound to me.
> > > > >
> > > > > I would prefer a bit of word-smithing the commit message by just
> > > > > removing the references:
> > > > >
> > > > > So:
> > > > >
> > > > > > While include/linux/bitops.h brings in the BIT() macro, it was moved to
> > > > > > include/linux/bits.h in commit 8bd9cb51daac ("locking/atomics, asm-generic: Move some macros from <linux/bitops.h> to a new <linux/bits.h> file"). Since that commit, BIT() has moved again into
> > > > > > include/vdso/bits.h via commit 3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO").
> > > > > >
> > > > > > I think the move to the vDSO header can be considered a implementation
> > > > > > detail, so for now update the checkpatch documentation to recommend use
> > > > > > of include/linux/bits.h.
> > > > > >
> > > > >
> > > > > And then drop references [1] and [2].
> > > > >
> > > > > Andrew, what do you think?
> > > >
> > > > I mostly did this because initially I wrapped the commit message and
> > > > checkpatch spat out errors when it failed to properly identify the
> > > > commit description for [1]. But, leaving the description unwrapped
> > > > inline in the text feels untidy as it's just a work-around to dodge a
> > > > shortcoming of checkpatch.
> > > >
> > > > With the reference style the long line moves out of the way and
> > > > checkpatch can identify the commit descriptions, at the expense of
> > > > complaints about line length instead. But the line length issue was
> > > > only a warning and so didn't seem quite so critical.
> > > >
> > > > While the referencing style is terse I felt it was a reasonable
> > > > compromise that didn't involve fixing checkpatch to fix the checkpatch
> > > > documentation :/
> > > >
> > >
> > > Hey,
> > > Can you share which wrap around caused the checkpatch errors
> > > to be emitted? We can try to fix that.
> > >
> > > I was able to wrap it without checkpatch complaining. You might consider
> > > replacing it with this if you wish?
> > >
> > > While include/linux/bitops.h brings in the BIT() macro, it was moved to
> > > include/linux/bits.h in commit 8bd9cb51daac ("locking/atomics, asm-generic:
> > > Move some macros from <linux/bitops.h> to a new <linux/bits.h> file").
> >
> > This wording works because the commit description is only split across
> > two lines. With the wording I had it was split across three, and this
> > caused checkpatch to barf. If we do this:
> >
>
> Yes it won't work for 3 lines. We are checking only for an additional line
> for split commit descriptions. Might be a thing to improve in the future.
>

Dwaipayan, you certainly got my go to improve checkpatch for this
issue. You might want to re-run our known checkpatch evaluation and
see how often this issue for commit references with multiple lines
appears.

Looking forward to your patch,

Lukas
