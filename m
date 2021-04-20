Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412B9364FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 03:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhDTBNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 21:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbhDTBNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 21:13:06 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9FBC06174A;
        Mon, 19 Apr 2021 18:12:36 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t14so1806517lfe.1;
        Mon, 19 Apr 2021 18:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pCUafHxo7zwOCFRvS2ayIuzN+F/t+3Ifch7UyWe1pSE=;
        b=Py1ReygCSFEIYHBUTukA+AjqKp1bmuCn4AIa+SrBYJDezzqEh7QwRrpkzVOpoHT3QF
         GGMw3QICdVBdzOdCimNS0oVC8pbwut3Y0cm593lf8JzDY/egRgFHEWG4RbBO8VC9zh5o
         ZnvZUuuKOTl4W+LqDNpw8k8DIL4TwIZeYX0Vr6CsszkdJUOBrlWOh57CTl6qegnB7Fes
         NJRiMwNyDLymyPU65hAjC2QpqeR6pOZWqYVHE+mmB/+8rlw5v7adBQvRMbOUBxxMolzX
         2NtrwK0iHMOklxsm1HDLIVXVpghWT4LQfArHsFRqBHq8r5DMDIvXtt9VT1lvum/Rz9GO
         XjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pCUafHxo7zwOCFRvS2ayIuzN+F/t+3Ifch7UyWe1pSE=;
        b=izpUejNEMiur2GoP/tsQmHjccXQ0GaWBcGJqW1N1Uioa6GecAVEBSD3ZYB3vGpLUik
         2DFAJKLFl9EU0sIFufl2E0hoUVdQZdMCH7KyA42cTO+KiH6rRHWPXYkL8zMmr5MdszkI
         jvfOeCHP6du0h8ETia4+Kn+qxmIwfMvfKLXcwVkkxKkhc98FwrQ6HWWTRG333m/4HQ0E
         fp2YhK4/Hzk5RVWZxO609BpVaacMuvMeB6kPzKMOfszTObLINnLKFcgvSL75Mc9eetsu
         LbqZvJ+cWz8GWxPHVaxSWfkr8rA1KZrja3R7jJI5msC5/j6rRCZYV6VpU5Uoob1G7z+M
         psGg==
X-Gm-Message-State: AOAM530Fw0j4wqmhN6qkRHs160nzFN4Dzg5XtuHrFfv/h/0wmf76xRjC
        vPLAt9CuYC23gSrf+meBkdk7Vu71AaKxuUtBEjg=
X-Google-Smtp-Source: ABdhPJy4QbZq6GpKOJR0Ui4FhbpWaBxUjIDZQtruRSxDc1mairsjSEzvBmJRHssRJ2cChC2T6OwozChm0iHqM5wGGmY=
X-Received: by 2002:a05:6512:2256:: with SMTP id i22mr6740073lfu.651.1618881154808;
 Mon, 19 Apr 2021 18:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210316054727.25655-1-foxhlchen@gmail.com> <20210316054727.25655-2-foxhlchen@gmail.com>
 <20210419021730.GV2531743@casper.infradead.org> <CAC2o3D+kq+U9vSp_9DNM3UGA=UGhS84Y+mwm=9S6eMPpf2-ogQ@mail.gmail.com>
 <20210419032513.GW2531743@casper.infradead.org> <CAC2o3DLJpMJDzQByJixPyLe47ajXXVFPRQBh3MaYPargrqS4tg@mail.gmail.com>
 <87fszmaxl4.fsf@meer.lwn.net>
In-Reply-To: <87fszmaxl4.fsf@meer.lwn.net>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Tue, 20 Apr 2021 09:12:23 +0800
Message-ID: <CAC2o3DLfzg=KeFJupLMHhyNbd0ww3hMvsmYeK87EVZPp=oUm+w@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] docs: path-lookup: update follow_managed() part
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Matthew Wilcox <willy@infradead.org>, Neil Brown <neilb@suse.de>,
        vegard.nossum@oracle.com, Al Viro <viro@zeniv.linux.org.uk>,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 3:22 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Fox Chen <foxhlchen@gmail.com> writes:
>
> > On Mon, Apr 19, 2021 at 11:25 AM Matthew Wilcox <willy@infradead.org> wrote:
> >>
> >> On Mon, Apr 19, 2021 at 10:33:00AM +0800, Fox Chen wrote:
> >> > On Mon, Apr 19, 2021 at 10:17 AM Matthew Wilcox <willy@infradead.org> wrote:
> >> > > You can drop ``..`` from around function named which are followed with
> >> > > ().  d74b0d31ddde ("Docs: An initial automarkup extension for sphinx")
> >> > > marks them up automatically.
> >> > >
> >> >
> >> > Got it, thanks for letting me know. But I will still use them in this
> >> > patch series to keep consistency with the remaining parts of the
> >> > document.
> >>
> >> Well, you weren't.  For example:
> >>
> >> +As the last step of ``walk_component()``, ``step_into()`` will be called either
> >> +directly from walk_component() or from handle_dots().  It calls
> >> +``handle_mount()``, to check and handle mount points, in which a new
> >>
> >> Neither of the functions on the second line were using ``.
> >
> > Oh, That was a mistake,  They should've been wrapped with ``.
> > Thanks for pointing it out. I will go through the whole patch set and
> > fix this type of inconsistency in V3.
>
> Please, if possible, go toward the bare function() form rather than
> using literals...it's easier to read and the docs system will
> automatically create cross references for you.
>
> Thanks,
>
> jon

Ok, If you have no problem with that inconsistency, I will go with the
bare one in v3.


thanks,
fox
