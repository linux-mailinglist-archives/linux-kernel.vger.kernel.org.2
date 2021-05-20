Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EC838A0AC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 11:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhETJTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 05:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhETJTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 05:19:04 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3005C061574;
        Thu, 20 May 2021 02:17:42 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id w7so5469662lji.6;
        Thu, 20 May 2021 02:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q5NNCzIDPxqo067q//hI06QgTQ23wAipeV7AqsspEK8=;
        b=dMifFK5mrbM1Aw7kDsK+Jze9zdTq/tR03g+XfLe9dj0vGZWFlJZ5I6cO3SH8ZxIpK4
         BlL1K81BNi6yCiJ8kMxf1iWv84QmbdXSor1jjZB9BQUWSB9Eo0hvyfmNnLehYDUjsX4A
         n1vAw1n8c56zTAQzKtULbGBYm/IE6e6ZZXIMvs3xe8xEtESi4ZDcDT8OSE+eUyFCFEaX
         nXPMitLkndG5KIAdZ5mfbG0tTDrjvgvTQow29im9268oVqNi/y3ECdVGdx+b1IJKHV8f
         bhWKtdxw6uGU5Wu/P1+qAmrTvU/kfhTkY6yCF6PQkz5s/JqhOgeclwYhX4GLKXljBWO6
         pPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5NNCzIDPxqo067q//hI06QgTQ23wAipeV7AqsspEK8=;
        b=jf71rP3xdGM198jAAcFfgRVPy6ueIhhMKbr3dQ87CgrCZWNrP2gdlIVEwMflDvdhPT
         PurtMQcG6YLtImgsJ0yb0Oq9zByRSwiU49XHxrsQEtgVk/yMRMYH5/usf9GXBhej7246
         PO6pbUpaXYPDsVFLg/ldfxGvPvnGP3nCW0/XMrT4v9ipIg3r+jZlmX1/N2l3+nQyY8Ut
         yiWb3KZr6wStHIER4NWIroDN8gDRdup291oUa1P5CG1+BXYII5etsSRQlw6XgNCI5BXM
         Qwj6yMI5K8Ba9OIJ7i70SCGelxBqfhYraAFEa0WKUfnFOf+IYMl8Af5Zv0CCM2c6VoFl
         2uTA==
X-Gm-Message-State: AOAM533+3PmtpS0H7A9AEzDj6ovnpb9emL5LEFD3KauQTHWHY9cqUjix
        FzMw7uiUDeKFvaMcIz9QS8aHWGx+wPikn4Md+WNOOiooBvWmjpAy
X-Google-Smtp-Source: ABdhPJz4WFFNBnmNgryAJqy1rEQkzpS2J5xI4uNUIVb52y/tSHKTrUi6aO0f+Xw7ZYW8JsoC08GKWLqwhdT2s0mVxSs=
X-Received: by 2002:a2e:8903:: with SMTP id d3mr2359627lji.373.1621502261149;
 Thu, 20 May 2021 02:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210520015704.489737-1-andrew@aj.id.au> <CAKXUXMxTnz6edBLpBgqOo6uUiSGm8rULH9P8G24xx2OhP_Yb6A@mail.gmail.com>
 <a0d1f44a-c8ff-4108-af34-6455b5683262@www.fastmail.com>
In-Reply-To: <a0d1f44a-c8ff-4108-af34-6455b5683262@www.fastmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 20 May 2021 14:47:28 +0530
Message-ID: <CABJPP5C7ZokRycaE0aAvUv3BfOJqOvPyqn-P0bbPdyCfnuuESw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: checkpatch: Tweak BIT() macro include
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org, Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 12:55 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Thu, 20 May 2021, at 16:28, Lukas Bulwahn wrote:
> > On Thu, May 20, 2021 at 3:57 AM Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > > While include/linux/bitops.h brings in the BIT() macro, it was moved to
> > > include/linux/bits.h in [1]. Since [1] BIT() has moved again into
> > > include/vdso/bits.h via [2].
> > >
> > > I think the move to the vDSO header can be considered a implementation
> > > detail, so for now update the checkpatch documentation to recommend use
> > > of include/linux/bits.h.
> > >
> > > [1] commit 8bd9cb51daac ("locking/atomics, asm-generic: Move some macros from <linux/bitops.h> to a new <linux/bits.h> file")
> > > [2] commit 3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO")
> > >
> > > Cc: Jiri Slaby <jirislaby@kernel.org>
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> >
> > Looks sound to me.
> >
> > I would prefer a bit of word-smithing the commit message by just
> > removing the references:
> >
> > So:
> >
> > > While include/linux/bitops.h brings in the BIT() macro, it was moved to
> > > include/linux/bits.h in commit 8bd9cb51daac ("locking/atomics, asm-generic: Move some macros from <linux/bitops.h> to a new <linux/bits.h> file"). Since that commit, BIT() has moved again into
> > > include/vdso/bits.h via commit 3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO").
> > >
> > > I think the move to the vDSO header can be considered a implementation
> > > detail, so for now update the checkpatch documentation to recommend use
> > > of include/linux/bits.h.
> > >
> >
> > And then drop references [1] and [2].
> >
> > Andrew, what do you think?
>
> I mostly did this because initially I wrapped the commit message and
> checkpatch spat out errors when it failed to properly identify the
> commit description for [1]. But, leaving the description unwrapped
> inline in the text feels untidy as it's just a work-around to dodge a
> shortcoming of checkpatch.
>
> With the reference style the long line moves out of the way and
> checkpatch can identify the commit descriptions, at the expense of
> complaints about line length instead. But the line length issue was
> only a warning and so didn't seem quite so critical.
>
> While the referencing style is terse I felt it was a reasonable
> compromise that didn't involve fixing checkpatch to fix the checkpatch
> documentation :/
>

Hey,
Can you share which wrap around caused the checkpatch errors
to be emitted? We can try to fix that.

I was able to wrap it without checkpatch complaining. You might consider
replacing it with this if you wish?

While include/linux/bitops.h brings in the BIT() macro, it was moved to
include/linux/bits.h in commit 8bd9cb51daac ("locking/atomics, asm-generic:
Move some macros from <linux/bitops.h> to a new <linux/bits.h> file").

Since that commit BIT() has moved again into include/vdso/bits.h via
commit 3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO").

I think the move to the vDSO header can be considered an implementation
detail, so for now update the checkpatch documentation to recommend use
of include/linux/bits.h.


Thanks,
Dwaipayan.
