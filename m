Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1931340406
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhCRKzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhCRKzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:55:16 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69ADC06174A;
        Thu, 18 Mar 2021 03:55:16 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id r8so4429429ilo.8;
        Thu, 18 Mar 2021 03:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=98pxet5C8Gy9S6SIgsmctncU1QY7hRiKp+O67nhGkow=;
        b=uMqQlC9MavXYkB3kXbenRs4kfB7G4L7LXt93bxBJ0oImb0yLDPiOGn158iYYIi6wJe
         qBFhMWmNwYpdNImlAhLHUa5n+0rscYmzi+2G2SyHssG3jeoVZ58Ax+eiLGNP7ej1zc/9
         qzBi1DgfSEr1v79waqfnsgbyEKhfKmKB0M0zs2RZdvB4p7K7f+ikYi5Rs2ml+sN7k6oJ
         RvyEzHLbEsjo/09tTwv9j2+Pw4LQL6OFI+t62UEJurVc3+x4iJdqA8TzJPMrw4oZYY23
         jRmso1NujbFnyaWHBGNcV+ihb13EUs43KG9gakaiCWbhmvuzsIpLbUqIJRsOUlEJah39
         fxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98pxet5C8Gy9S6SIgsmctncU1QY7hRiKp+O67nhGkow=;
        b=oXUNg5zd0UFBp3ZAQUcCSC3/ZFg3LCOEHKgVP7LZg+NQk4Hib1tRY0PI8tdVrLw8do
         fedydJe7MVInvPWWgQ5oizgCgdSaYNSnNYHdISWaIM/ZTrzWPHs75DAuWN5GEeuRL0YK
         X7LrIj/nfVyqKHSiboS2sCpWcd6iexK2j1RQhj/1rB3bcPIiws9GSAMXepFocZJMKGfc
         XpEl9SkdQmv+OIZL18Il0Lwza7bqhnaxW90ADh6TpVw3X4dwNi8Y5jSeW4xn03hvFN2C
         UTLEMbe6RydywjuoxZ42zkW+sMQiROF586SK3n7aWBiY/tMVCA4iDrSuRuusc+lH+mzH
         GNnA==
X-Gm-Message-State: AOAM532cIbiLclIRdaOXo4i/kj3ClRnS7oiTgL8Ayg8AzdhQtKaGQID9
        e9/RxUlWs0Tim1Q0isE3KeNyv4QcgAHII+Xq2o7X1tdInDg=
X-Google-Smtp-Source: ABdhPJwCUz3YalePN71JfUxCQ+3ETyztCla/KstVAsnn2Y02f0u5BDOaY4GLiv8BmqjbQ9EaZMXtwwG4iM6kbJYnyyg=
X-Received: by 2002:a05:6e02:1aaa:: with SMTP id l10mr10477638ilv.251.1616064916024;
 Thu, 18 Mar 2021 03:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210309125324.4456-1-yashsri421@gmail.com> <8959bf29-9ee1-6a1d-da18-f440232864f3@darmarit.de>
 <c673e76f-72db-bbee-39d6-f5428e765173@gmail.com> <871rcg2p8g.fsf@meer.lwn.net>
In-Reply-To: <871rcg2p8g.fsf@meer.lwn.net>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 18 Mar 2021 11:55:05 +0100
Message-ID: <CAKXUXMzwTp1H_vokVEAJSnmm7jNHfWzhhmLfpcrrBD9b8ak+dA@mail.gmail.com>
Subject: Re: [RFC] scripts: kernel-doc: avoid warnings due to initial
 commented lines in file
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Aditya <yashsri421@gmail.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 8:25 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Aditya <yashsri421@gmail.com> writes:
>
> >> The opening comment mark /** is used for kernel-doc comments [1]
> >>
> >> [1]
> >> https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#how-to-format-kernel-doc-comments
> >>
> >
> > Hi Markus!
> > That's true. But the content inside the comment does not follow
> > kernel-doc format.
> > For e.g., try running kernel-doc -none/man/rst on the above file in
> > the example("sound/pci/ctxfi/ctresource.c").
> > The starting 2-3 lines in files generally do not contain any
> > struct/enum/function, etc. declaration.
>
> The problem is that it's marked as a kerneldoc comment without actually
> being one; it looks like somebody's internal corporate formatting.  The
> fix is not to put a hack into kernel-doc - we have more than enough of
> those in the file already!  The right thing to do is to remove the extra
> "*" so that the comment doesn't look like a kerneldoc comment anymore.
>

Jonathan, I agree that that is the right thing to do. Aditya is
already following through and is cleaning up the repository. So, let
us be optimistic that we will have cleaned up all of those occurrences
within a few weeks. But how to continue? Someone is going to come with
new files and introduce this pattern again in the repository; and as
of now, we do not have a script to identify that pattern and react...

Running kernel-doc on the whole tree continuously and just observing
the new warnings is probably not going to work as of now: there are
20,000 kernel-doc warnings and at least, I cannot see a really good
way to filter out this one specific type of issue among all the
warnings that will might appear in the future (without specifically
applying Aditya's patch and looking at the diff before and after).

I wonder if we could extend kernel-doc (not your preferred option as
it seems) for a new dedicated warning message or maintain a separate
kernel-doc sanity checking script to emit a dedicated warning based on
some heuristics that suggests when a "header comment" is probably
unintentionally declared as a "kernel-doc comment" when it really
should not be.

Jonathan, would you then prefer to have a separate kernel-doc sanity
checking script that then allows us to maintain checking for patterns
we already cleaned up?

Eventually, we might have cleaned up enough to just use kernel-doc and
keep it kind of warning-free (as with make htmldocs now) and then, we
can simply follow up with kernel-doc and some basic monitoring
scripts, but with 20,000 warnings in the whole repository to start
with, it is still a long way to that point, IMHO.

Lukas
