Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CEF3C39DB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 03:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhGKBou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 21:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhGKBot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 21:44:49 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289CFC0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 18:42:03 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id k16so17615387ios.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 18:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DviByeW/MRd4o8QAxjQbNiyDl13TlKgHIeZcYevPf8U=;
        b=aEKYNlLyKmBIhtj2zpIjSnRJ+Qd4EOAwRFeseUtJvCj6OD+ekcsQK39PN/zn6cNbHl
         WGSEQ2S8qlVvBsOEXTGLUc/zrTpNltS/TXx2jqMA41Jqqjmj/Af+gcz+Wfc2H871qsbD
         kKOMiwfZo5T7EKQAU1PHMq4l/nkGMMHdValSnpEVrSptiF7e6jcC1kJ19HoiU7LfIZkF
         /XwH6CJ/JhwJf3FzqaXGVRZUtIzo6ZiOIzO6wkbPoi+W9jHLWPTMvUOdtbP8FR5nZFlA
         lC/t59OmgEJe5VGRTKxlrBEtrR3vgxjt1E3MV5HMMAyFnqCO9LazZ+8fTjSIz9M7RjA3
         IFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DviByeW/MRd4o8QAxjQbNiyDl13TlKgHIeZcYevPf8U=;
        b=ZOt1gTdVgFUZdT8J5ho3yHu0V7qu7LGh04WLhADNz76Rib7e5FrPiIONUA4tjk3ofL
         zEAv72O+MOP/ON89LQF8lRftV4Kvc+i8OylFxbV844hIAxz4neCsIEPnkMEsrrly4JsH
         uy2sZtZ0FKCMKUhH9cJD75/yPXMJz0jJj1VCb8oxL6lSM6zaElUQEj0AzMd8GJu2A+sJ
         LeqHWE+KTIOHUGoj5OLYWDwqAvkp7jXVo5AVNuM07XCPYSAr7yUSTxfQZWSwYDWbkVew
         D0c4J1nT9o8omYTGMbQt1w4IYx0GGGZL21gh7eZQb69u5GS1+iS+rYAJ1ayYNeFVRl0E
         YZBw==
X-Gm-Message-State: AOAM530aU2Ux4Zm9Tn6miqDl4XJMHVFpJQ5Z2kpEo1AhHw4SRATMSoXk
        NH5BA5g3auoZ70VujHkWlub99LQ1EPPQMm3BftJAJZtOLWw=
X-Google-Smtp-Source: ABdhPJx+rpq4HSXSp6jfp7UQ0J9hdUAfM226zfK6hZLavZmabddYLhfL+ajhRe1PyVE3+Be8kXbBeehdncaxRpDO7es=
X-Received: by 2002:a5d:9051:: with SMTP id v17mr33836994ioq.81.1625967721832;
 Sat, 10 Jul 2021 18:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210709234054.10288-1-olof@lixom.net> <20210709234054.10288-2-olof@lixom.net>
 <CAHk-=wg2G+4K=wCnHBsiFX2HXH+zN5X_VhmMa9-RsFLL+xMFyg@mail.gmail.com>
In-Reply-To: <CAHk-=wg2G+4K=wCnHBsiFX2HXH+zN5X_VhmMa9-RsFLL+xMFyg@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Sat, 10 Jul 2021 18:41:50 -0700
Message-ID: <CAOesGMjzU7bgX97_N08sLPsEew_6iHeQAi4EKgFK9EZVmMP+sQ@mail.gmail.com>
Subject: Re: [GIT PULL 2/4] ARM: Devicetree material for 5.14
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ARM SoC <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2021 at 9:45 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> What?
>
> My shortlog matches yours, but my diffstat isn't even close.
>
> You show 554 commits, but then your diffstat as not a single file from
> arch/arm*/boot/dts, and says:
>
> On Fri, Jul 9, 2021 at 4:41 PM Olof Johansson <olof@lixom.net> wrote:
> >
> >  97 files changed, 8428 insertions(+), 5174 deletions(-)
>
> while mine is very different indeed:
>
>  552 files changed, 24060 insertions(+), 3691 deletions(-)
>
> I suspect you got the diffstat from something else entirely, because
> mine looks a lot more believable and matches the commits listed in the
> shortlog a lot better..

Yeah, this was an operator error at my end due to the workflow I have
when I generate the pull requests. Thanks for noticing, and as you saw
on the 3rd branch, the info was swapped between them.

For more detail in case anyone is interested:

I merge the set of pull requests one by one on top of your branch, and
then run a script that generates the pull requests. At least when we
started out, git request-pull got confused and generated wrong info
when we had complex merges.

This time around I generated them backwards: Merged all 4, then
generated the last pull request email, reset back to the next head
(with the previous branch), generated that, etc.

The mistake here is that I mixed up the order of the two middle ones.
So I specified the tag (and got the commit message from it), but
obviously the diffstats and the shortlogs ended up generated from what
was in the working tree, i.e. the other branch.

My bad, and something I'll double check for in the future or add a
sanity-check for in the script.


-Olof
