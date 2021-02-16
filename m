Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8131331CE92
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 18:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhBPRAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 12:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhBPRAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:00:05 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB240C061756;
        Tue, 16 Feb 2021 08:59:24 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l18so6322703pji.3;
        Tue, 16 Feb 2021 08:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4k94IHmYOAsw1neG4zAJJJPBOifn3q1Cm7s7hwfxAs=;
        b=pm3+yLEs1FyxPwpxgknSQ8OTZgHg4lpLMRYpWpJZZxYfW6yoVOFxufDnHrbDbqYbTP
         e7MhXhXdob/dn8p4bOP98QTw4btfZkKMcSHZohPQiTKIOh6wJajGxliMgWolHkOoURUD
         RcTH4UMgEH2bwmouvGPidMRmc8ZsLgRGXhUSU/Pk8qDLakNS688ElZzMyXGp994Dfzdg
         EY2qNS/Kd+VfZpUjjwDUkFeAGFdBBC11g/veGi7ndXsPG+1N73szQitNXhLQ/E7ddUan
         xtUN1VEOTeZ6O4vGg/7zxA55KaA+7vWvHyxJVhWfURM3R+liZfk+3YiwA/bIU4HSWhna
         mjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4k94IHmYOAsw1neG4zAJJJPBOifn3q1Cm7s7hwfxAs=;
        b=tgycEzmQwIV7KDkqq8nFKg6p8TGJRyKpVgMiL3S1iE+bdK+QJfbyZ7pAqvn3l8LB80
         mHY47wmSuCv4R65P6Jt7xVi7ex0JndlW2UXw32wM2qUKRp+L1uaTTPqBxYQwcWSmYJHV
         H0Z62xLeEFu/IxxR7qZ+ivBiTEr9OqkJHxh0bMs389//Ppv38InU6zs4cVMUg35fjEvl
         FIVY/apdhubSnYnSy3k/OpNX95Q3kZkDbh4Lbdk2Wf1Imtzt3kpL83o8z4dg18U0NUwR
         Kyi23EOqdjKS0ss/zxJztX0MlWeQid9m+U9RcbCN3psURBJw4Y+rfR740PFaBHGYWsNp
         6IOA==
X-Gm-Message-State: AOAM5322pgAJpb2htZIhp32GbTqloMKL0Cu5v6R+duSl7rLwOp1uPild
        zFFy9sxBaesl75ADxxUhBdMYHTS/OGxfWTRFKtM+t5hUsx9QWw==
X-Google-Smtp-Source: ABdhPJwdH193bkuaUeHGr5QPKbsuFa4cwImV+qjhoabD5rMFzZjl8wCp+iBTyrNK58yuJSsPTSdP1UhSM/n1w3kMaEo=
X-Received: by 2002:a17:90a:4fc1:: with SMTP id q59mr5319710pjh.129.1613494764257;
 Tue, 16 Feb 2021 08:59:24 -0800 (PST)
MIME-Version: 1.0
References: <CAHp75VfpnGEZcnrQLFYaFQ-HuxTmPw5OnewKmRGfXQf__ztjww@mail.gmail.com>
 <87r1lgx8fo.fsf@meer.lwn.net>
In-Reply-To: <87r1lgx8fo.fsf@meer.lwn.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Feb 2021 18:59:08 +0200
Message-ID: <CAHp75Vc0SwC=WxUOiokUik1G4uPE6bHfX_F_ckgp-eEJaVuWhA@mail.gmail.com>
Subject: Re: anonymous enums in kernel doc
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 6:51 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> > Mauro, can you do some test cases in your workflow against anonymous
> > enum in ernel doc, please?
> >
> > They are broken again, please fix the script!
> >
> > drivers/pinctrl/intel/pinctrl-intel.c:204: warning: wrong kernel-doc
> > identifier on line:
> > * enum - Locking variants of the pad configuration
> >
> > Above is simply a wrong statement.
>
> The real problem, perhaps, is that there seems to be little point in
> adding kerneldoc comments for anonymous enums; where are you going to
> use that documentation?

I had been explicitly told during review (IIRC by maintainers) to make
it such, while the initial version was exactly like you are thinking
of. So, I'm not the right person to be asked :-)

>  The error message could perhaps be changed to
> say that; meanwhile, perhaps this one could be fixed with an action like
> s%/**%/*% ?

See above. I think regression comes from the kernel doc script,
earlier it was okay. That said, the author of kernel doc changes has
to submit a patch to amend the driver and maintainers will review it.

-- 
With Best Regards,
Andy Shevchenko
