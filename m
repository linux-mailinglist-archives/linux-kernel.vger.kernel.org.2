Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51FF3B516A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 05:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhF0DuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 23:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhF0DuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 23:50:03 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD0EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 20:47:39 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id 68so7962553vsu.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jun 2021 20:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zz+tpqL2VFU7n1485QoknVd/8lHIokD5wKGpkOg4NkY=;
        b=gGuVbDPn97umt0E431sbLejZDFctxi5TEddN3rq5CYoEPFSxMs+DhV/xn0uf1cQeNe
         Evc2PkmGwgb+wimryGe7LPTkFmIRUy02UPXE8wwlx/uMPC6LlwF9RbftjxfszUPoc2vT
         AJLjidbqj6Qvvr3z51+zkT4xvvnuIHBkzTjc4+piiNkMl2fpZS8hDaoaK0moHo5uLFqj
         Ali4hEgm9EC00+FhXAmpKgfdlHLv+sxVfp1JlGAqXiK1tFEYmaBt92xB0QaUPPrehEnU
         Tb7uELLI7X84YqUxR/PyUTK2uKWfWJpGb00Qd/XgwywUKY4oAaxi3Bl5pxkr8bRAWGZS
         qOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zz+tpqL2VFU7n1485QoknVd/8lHIokD5wKGpkOg4NkY=;
        b=BlLoI+Il+Gjf+OWppUkXSNn7OPV2WCuDQF/2viZM8XOdImCsm08yyQ6H4avMJqT+Ul
         cRP1a6ZEjS86sShnxYVxbAdOnQOxygsjA19MpdJ/KSWrLgwiLYX2Sayb3XfY8sMAGHEb
         Z799BW0Hr8vhon+WTN/O4Yfc8mD76kshR5n9uFSSbSf5sro3it2CGfdGFZFwlm9/Buxs
         tljBHq6ybyOPYcD9QAPjxwWZaLyff1gQ9SPQjq++UcP0vfWsOkyfC/pWldqpsvx1roMR
         iCKMJrFzAHlqtLw4fC4p0tm0kSZMf12WS2gqzVmg2CVKUhxkHUUU/fuL5WryXS37MT/l
         0Ysg==
X-Gm-Message-State: AOAM530di+mjb50S31oWbaMPXVyUTG4MorVAqmdaAKY7xOCpHnmFQNuh
        o3BG6+OCK2Iq3v08SO0r7zqRQDYMwFqjiSauAqHX4zWqSmw=
X-Google-Smtp-Source: ABdhPJy/75rCoDD8b9iLT5LrAIQJ1jen0BlVbJG7xlsWUXlA7xFf8bzKihMG0FqrZTUZHMNHs3VkmN8V0w+PUGnC5uc=
X-Received: by 2002:a05:6102:11ea:: with SMTP id e10mr14365100vsg.7.1624765657760;
 Sat, 26 Jun 2021 20:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210626034016.170306-1-jim.cromie@gmail.com> <20210626034016.170306-3-jim.cromie@gmail.com>
 <b8758249e142da8c2db9920e4cf71596ff7f9570.camel@perches.com>
In-Reply-To: <b8758249e142da8c2db9920e4cf71596ff7f9570.camel@perches.com>
From:   jim.cromie@gmail.com
Date:   Sat, 26 Jun 2021 21:47:11 -0600
Message-ID: <CAJfuBxz7DMfFOwyvUvN7F9Jc=meQs7ro5OFhiycq1GxMNHRPzw@mail.gmail.com>
Subject: Re: [PATCH 2/3] checkpatch: tweak extern in C warning
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2021 at 12:46 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2021-06-25 at 21:40 -0600, Jim Cromie wrote:
> > The extern-in-C rule has one important exception: the symbol is
> > defined in/by the linker script.  By convention, these almost always
> > contain: _start, _stop, _end.  Suppress the warning on such symbols.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > @@ -6910,7 +6910,8 @@ sub process {
> >                   $stat =~ /^.\s*extern\s+/)
> >               {
> >                       WARN("AVOID_EXTERNS",
> > -                          "externs should be avoided in .c files\n" .  $herecurr);
> > +                          "externs should be avoided in .c files\n($stat)\n" .  $herecurr)
> > +                         unless $stat =~ /_start|_stop|_end/;
>
> nak.
>
> As far as I can tell, there's no reason these symbols
> should not be in .h files.
>

judging from the codebase, it has been a case-by-case decision,
with 8/10 of the linker-vars extern'd into C files, not headers.

[jimc@frodo wk-test]$ perl -ne '/(\w*_(?:start|stop|end)(?:_\w+))/ and
print "$1\n"' `find . -name \*.lds.h` > symbols
[jimc@frodo wk-test]$ wc symbols
  99   99 2112 symbols
[jimc@frodo wk-test]$ grep -n -r --exclude-dir=builds/ -f symbols .  |
grep -E '\.c:' | grep extern | wc
     79     331    6402
[jimc@frodo wk-test]$ grep -n -r --exclude-dir=builds/ -f symbols .  |
grep -E '\.h' | grep extern | wc
     19      81    1581

8/10 cases dont expose these symbols in headers,
Makes sense to me, mostly theyre internal, and often double-underscored too.
2/10 are presumably in headers for specific reasons.


> besides that:
>
> output is single line, $stat should not be used and
> using unless is not desired.
>

could you clarify ?
style issues are easy, std if form...
$stat is already used, it must contain extern to get here.
checking it for a likely-linker-symbol seems fair.
