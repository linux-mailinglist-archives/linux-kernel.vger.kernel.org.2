Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA5C340B95
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhCRRTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbhCRRSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:18:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA27C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:18:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z7so5785683lfd.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xTnWj/7c7qy2ihci4+Y8gZArZFtgvGoRKaFa4tN0PI=;
        b=gx8T9ew1kWacLuISFevAmlg/0TSWj6LGrBs57CPyJX4luB44zWUeTWhXt8tyDUuIE9
         YsvKZ/LldkMM/f0NQILbCGYZ655Cd9/LK0JieXnt/lpFZh1O3uRg0/fE1LyNyzCO50Oc
         bDr9cRxLuDzb0+PtOm1z8wW4Tz4ic8UQ+yW/xVEuNGXog1mLHFlol7P/+SOoFMeQAJWK
         wlDeSomtYDWWvfjqandt7a67OJexGFRRxX4+6QdfcyK7ZrhJeSDoO3xE/MF3TnkIPeBn
         RdJi3pHBBK5WxhEI9JV1mNl4jmidXPXSfvLPfZbGBy7w8RbkVTF5osRBRCYZXBfGjN2z
         eyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xTnWj/7c7qy2ihci4+Y8gZArZFtgvGoRKaFa4tN0PI=;
        b=AX+cQfRH2PdxRnN5RBLL1uPyeGiqxY2jOZcxellxtEzwjYz4gNk8eUpvhO22U4nwJA
         wyvhcnGQz/kYSxNLFAgzlonI6VJrmDUSex+EmBsdFa5z66vQVsB3vG3jQhLZr2MSjzA1
         iHVVJ7RfMVf3YZ/SP4BOUCEjEbXQkf6EZYQY3yykV5f6VZKLmaOPB1xWkS4c2VC4N3uw
         /yIwRtByVWyGdLYL3T+gG+ncwhsdJo4bxbHiFrMuo2MzFqYeLwcbwf6RKI4n74RjPZAB
         Q4yDvnIM7qnXoJR0qQyJsksAKnkSDZ6zAa2AdqSvZvd1c7Rm6c17FL4ngOoQHlxwwcrp
         JYCg==
X-Gm-Message-State: AOAM530Itl7VMhtMdBBvO77ahBAEdAenb9N4ge1yfouujkef/+k6gNcG
        34IR/MI7Du780mF38JJVYvXc1rnoAF/fY5Vn5PI=
X-Google-Smtp-Source: ABdhPJxUwy+7SX3CVT2cYmJN2D0xs09DxE0Stt/8JLbLrbG02AYYzZD5t24i0lk+qPVW9FO74Uj2D2NpkZ+Z8an1LrY=
X-Received: by 2002:a19:b49:: with SMTP id 70mr6302090lfl.342.1616087927722;
 Thu, 18 Mar 2021 10:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <CABJPP5AjUJ+OWqUy7cR1Ar2zcs6QuLizciGf64WVQ-027rS=bA@mail.gmail.com>
 <CAKXUXMx-4p361gFewN61NEbrwTjVY9wZFg2i13VMZTUxiDJB=Q@mail.gmail.com>
In-Reply-To: <CAKXUXMx-4p361gFewN61NEbrwTjVY9wZFg2i13VMZTUxiDJB=Q@mail.gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 18 Mar 2021 22:48:36 +0530
Message-ID: <CABJPP5DbeBmVT5CTZxtwS2fpJtnasueaPkzUMrwzZZ51cdDRHQ@mail.gmail.com>
Subject: Re: Checkpatch still worries about include/asm/ ?
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 10:33 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> On Thu, Mar 18, 2021 at 5:47 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
> >
> > Hello,
> > include/asm/ got removed a long time back (probably v1.1.45).
> > Checkpatch still worries about that:
> >
> > if ($realfile =~ m@^include/asm/@) {
> > ERROR("MODIFIED_INCLUDE_ASM",
> > "do not modify files in include/asm, change architecture specific
> > files in include/asm-<architecture>\n" . "$here$rawline\n");
> > }
> >
> > Can we remove this check?
> >
>
> Wow, v1.1.45... that must have been taking quite some digging in the
> ancient dirt to find that out.
>
I was actually helped by an user who send a patch in 2016 to remove it:
https://lore.kernel.org/lkml/1482260987-21457-1-git-send-email-pebolle@tiscali.nl/raw

Don't know why it wasnt removed back then.
But it's safe to say this check hasn't been used for decades :)

> I agree, let us remove that rule.

Sure will send the patch.

> Thanks for the documentation effort on checkpatch.pl and cleaning up
> obsolete rules while documenting.
>
It's my pleasure!

Thanks & Regards,
Dwaipayan.
