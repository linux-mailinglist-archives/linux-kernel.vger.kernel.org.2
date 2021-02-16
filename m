Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3878831CEC6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 18:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhBPROG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 12:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhBPRNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:13:55 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13ECC061574;
        Tue, 16 Feb 2021 09:13:14 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id e9so6363927pjj.0;
        Tue, 16 Feb 2021 09:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ekOOag42UZN3Eu67e57VbrsLUqfCOHv+bajvQxzjCe4=;
        b=vECeKvEornGldAk+V24b5sxJbH61gD6gHUEXzmN6ARUlrYfeXRiqU9DfNGRmiS6xLj
         CeWYuB3Iq6kRvbBXFuGpeZmq72b3eMSd4VNRZySiFH4s9i38NH5hL1teBWwiMXPNluHh
         o5U4n5ecv5yyWzoQKJIKWQj4+rhfoDGB8FEVuCZ/VTde0Qr9MuEToWR+M9rtB1bLixrI
         UKN23a8j+sAYq/LCZFp1uCNJaRJFoRLrfF6c8KTH1yXn01KzOCQWRuYfafqO9M7QJdOE
         KH4LIU93AQMnz71OvGv/4Dj/uM8nWp/j8k35j3uhmt/96rsT/uC3agVHqVkUjB/UTsX9
         I08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ekOOag42UZN3Eu67e57VbrsLUqfCOHv+bajvQxzjCe4=;
        b=RF3kctDOnXteL89owP4kJdtoFOm8WkutMHfxhdTuMs7cV0ukDATAZbloY5it/R4F3H
         nWmKjkvt8GbjyUgIuVG1JcaFHh9HpXpnCrQe7eeeFZo4jaDjx/YBZ4N2y+9sBggo0Rw1
         Wu1ynPz/x7jvWKMfZCDFgw/LQC75eAfY3kJIjxf+UuFgx9JDLBrou3ExnLVVNYaPgSVt
         X0OaqngIWCaKQj65pfcuG7FTk4YF5drISGt6U4pGj4NH5NJaMIx6sFkm1R7NXD5NYO1b
         yTw3mKpFL5hMDX6QfjRKmWKDRqJer9D4ofEAsekGsgHkzKAS61l590HgfuzrzVXqz/Cc
         FcIw==
X-Gm-Message-State: AOAM533LWbFhFerUJq4qNFvzmkyvWRgaqp3aKsc8Xsdl6h1/Wqb1mhAO
        2bHTc8EJnBn5zDx4qt0CIs+2g0+qQLZqoYlVTke0JFrtb6Q8/DKV
X-Google-Smtp-Source: ABdhPJzJFQwKvwwImUTfk2G7QtMM6riW7fPAclHtUuLi4u7CADjEahzY9WVX/ijntYSu6gGZPAHOCe+JOamrSPBouK0=
X-Received: by 2002:a17:90a:4fc1:: with SMTP id q59mr5380026pjh.129.1613495594441;
 Tue, 16 Feb 2021 09:13:14 -0800 (PST)
MIME-Version: 1.0
References: <CAHp75VfpnGEZcnrQLFYaFQ-HuxTmPw5OnewKmRGfXQf__ztjww@mail.gmail.com>
 <87r1lgx8fo.fsf@meer.lwn.net> <CAHp75Vc0SwC=WxUOiokUik1G4uPE6bHfX_F_ckgp-eEJaVuWhA@mail.gmail.com>
 <87mtw4x7rw.fsf@meer.lwn.net>
In-Reply-To: <87mtw4x7rw.fsf@meer.lwn.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Feb 2021 19:12:58 +0200
Message-ID: <CAHp75VcG544HZ1j_6jvZoba6kEjKXXfZ8deJWmwNQ08mC35NrA@mail.gmail.com>
Subject: Re: anonymous enums in kernel doc
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 7:05 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>
> > On Tue, Feb 16, 2021 at 6:51 PM Jonathan Corbet <corbet@lwn.net> wrote:
> >>
> >> > Mauro, can you do some test cases in your workflow against anonymous
> >> > enum in ernel doc, please?
> >> >
> >> > They are broken again, please fix the script!
> >> >
> >> > drivers/pinctrl/intel/pinctrl-intel.c:204: warning: wrong kernel-doc
> >> > identifier on line:
> >> > * enum - Locking variants of the pad configuration
> >> >
> >> > Above is simply a wrong statement.
> >>
> >> The real problem, perhaps, is that there seems to be little point in
> >> adding kerneldoc comments for anonymous enums; where are you going to
> >> use that documentation?
> >
> > I had been explicitly told during review (IIRC by maintainers) to make
> > it such, while the initial version was exactly like you are thinking
> > of. So, I'm not the right person to be asked :-)

Just for a reference [1].

> >>  The error message could perhaps be changed to
> >> say that; meanwhile, perhaps this one could be fixed with an action like
> >> s%/**%/*% ?
> >
> > See above. I think regression comes from the kernel doc script,
> > earlier it was okay. That said, the author of kernel doc changes has
> > to submit a patch to amend the driver and maintainers will review it.
>
> kerneldoc now warns about various incorrect things that it used to just
> silently pass over.  There is no regression here, just a new diagnostic
> to point out something that was never going to work right.  Unless you
> have a good idea for what kerneldoc should do with a block like that?

As it does, put description of individual fields and prepend it with a
common part.

So,

enum - Bla bla bla
 @FOO: ABC
 @BAR: DEF
Description

Should go in the doc for the corresponding file like (as an example)

Anonymous enumeration Bla bla bla
Description

FOO ABC
BAR DEF

(not sure about indentation, emphasizing and separators, but I think
you got the idea).

> (An alternative fix, of course, would be to give the enum a name so it
> can actually be used for type checking.)

That enum is not used as an enum, it provides the logically unified constants.

Personally I don't see why the kernel doc can't digest this.

[1]: https://patchwork.ozlabs.org/project/linux-gpio/patch/20190808132128.13359-1-andriy.shevchenko@linux.intel.com/

-- 
With Best Regards,
Andy Shevchenko
