Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DA33D7DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 20:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhG0Sbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 14:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhG0Sbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 14:31:52 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F4AC061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 11:31:51 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q2so17171599ljq.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 11:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WzCeD96mdqS8ayUSQrtfxYNv5qyDkHlLyxEuT5l/fk4=;
        b=LzpEn20DuqJpfX0MM3CcahlLGfteKX6Zz6d6/G9/QDwM/LWXg1fL3kVu4luyf0RnDO
         K77CSVRHIqb1nvhebKA+k6z7K7TgGSwbrYDuYngJxkA6biKRO3i4HE5ahJ8PuoqJnJH0
         p14B3GPlfvmYXALdCHCBf+7htZ5skshF3jZjWwb/5Y0V0wpJk8/jYsAP/eTSVkO1A45O
         qW3rnWhwfEFMWasUg7XZDrf1iF6qGDuKsBQ4ARBxOssxLK+tfV9mCKaIov0aR5o/L+m1
         lCZow5VyGuDO58tUD6Ws5r6eO8kV56MgZh2BmlVdglR0N6/nHifWkwRbpYEp2JDrpWu6
         6ExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WzCeD96mdqS8ayUSQrtfxYNv5qyDkHlLyxEuT5l/fk4=;
        b=WNEBSxHovxSQR2WffttaVTlcNlORwGzZLPvpVBrHt4W78vXT9GAsftiurZ9loUb1k+
         bzzEAGunNFGWw9VrYmgxFr3920aIVis0JHaCs8JGuZBAAg8kh/VnNPHk74SAWErRqYJe
         BHzJyb18RcTPgVn6TTzSCv8EOvaNP1ME5e8jdIv7h/3dY46Ji4Gyasqh4au1sY3VfW46
         ka6n2kDIEpcPiNlfk7sQdzOrPZqpjkQtpWUJdr/PYMpvcKXvEifVM3mX22aYpNfwx5pw
         PdoXBKeiYzoFaGa1Q7ko3TPcqP2DIWpn6FV6h9qnO4Zf7yax5VDMwqTAyXLWZDoFE5cM
         fOlQ==
X-Gm-Message-State: AOAM533/H2qyfhUKNLGSyoUOCBkRC2DEyZ74fgY1LKDhpn99ZcoC5DQ5
        XuEnTptOVtKcc2veVvdZpRulWeFro8Zcorfuh4OIkw==
X-Google-Smtp-Source: ABdhPJxeeAO6VIYn0Z7PLNib97Doh6SSR5Ainw252nWL4kSBny7EysZWtcPN1c4djHY9htqCGY4r1hbOcfcTf+GUv5w=
X-Received: by 2002:a2e:a911:: with SMTP id j17mr16271349ljq.341.1627410709642;
 Tue, 27 Jul 2021 11:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210714091747.2814370-1-morbo@google.com> <20210726201924.3202278-1-morbo@google.com>
 <20210726201924.3202278-2-morbo@google.com> <c965006c-88e1-3265-eb9c-76dc0bbcb733@kernel.org>
 <YP+ZOx8BETgufxBS@kroah.com> <CAGG=3QX68umw5Ws9_HuGkqoTNT=Q1+QB7YpSaqw3R_kPsbxwsg@mail.gmail.com>
 <YP+ql3QFYnefR/Cf@kroah.com> <CAKwvOdm62a7mrLZb_eciUO-HZj7m3cjgfvtQ=EqRy9Nh0rZOPg@mail.gmail.com>
 <YQBJfAuMJhvd2TcJ@kroah.com>
In-Reply-To: <YQBJfAuMJhvd2TcJ@kroah.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Jul 2021 11:31:38 -0700
Message-ID: <CAKwvOdkbgr5uPBUC815nrJ_-fHQD2KEYmZ0E8qZRBLL9uQ2WFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] base: mark 'no_warn' as unused
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 10:59 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jul 27, 2021 at 10:39:49AM -0700, Nick Desaulniers wrote:
> > If there are
> > cases where it's ok to not check the return value, consider not using
> > warn_unused_result on function declarations.
>
> Ok, so what do you do when you have a function like this where 99.9% of
> the users need to check this?  Do I really need to write a wrapper
> function just for it so that I can use it "safely" in the core code
> instead?
>
> Something like:
>
> void do_safe_thing_and_ignore_the_world(...)
> {
>         __unused int error;
>
>         error = do_thing(...);
> }
>
> Or something else to get the compiler to be quiet about error being set
> and never used?  There HAS to be that option somewhere anyway as we need
> it for other parts of the kernel where we do:
>         write_bus(device, &value);
>         value = read_bus(device);
> and then we ignore value as it is not needed, but yet we still HAVE to
> call read_bus() here, yet read_bus() is set as warn_unused_result()
> because, well, it is a read function :)

Such wrappers are trivial with __attribute__((alias(""))):
https://godbolt.org/z/j5afPbGcM

At least then it's very obvious if someone adds more call sites to
such an alias. Then that calls for closer inspection in code review
that yes, this is one of those 0.01% of cases.  Since they occur 0.01%
of the time, I don't expect such aliases to occur too frequently.
-- 
Thanks,
~Nick Desaulniers
