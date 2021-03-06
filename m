Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B844F32F8A7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 07:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCFGjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 01:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhCFGiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 01:38:50 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690C8C06175F;
        Fri,  5 Mar 2021 22:38:50 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id k2so4437099ioh.5;
        Fri, 05 Mar 2021 22:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/sw+/0dBPQokk2b5m8FztuNfd7xqS1fRXTj5tWyq3w=;
        b=GfVFKlEpTDkLf60dzJSRpQN0KurTd+Yl6BBM8eU8fNVlXhYDoeQ72Y8bF2Cdr2iCn4
         /Ee6mpsOPnM5aVdO9wvgtFdNq6CHZ6neuRxvjdyP6SAHNcljLDMgu76Q/4qvsitkOg2D
         sNMSsxT0iyCFZIBqmrCww1PC1Jh6M0peUnuisjhNKpDfR32HeFFfzBFIfAMo3CbLk9hE
         50RVlbz3vmPlGUXaA7o/hzIQkLsytSEnlY9Us0o7vSkaiI7SFjToc7p2zFlhOIGTO+tI
         +BDXN9avPgBkhWrqEDUAg6v12NP26gegy+wugT6n5yJsbje+0YQ2ynQnR2iF82vbCmZb
         b1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/sw+/0dBPQokk2b5m8FztuNfd7xqS1fRXTj5tWyq3w=;
        b=Uchyl51Z/WbEZkw7a6YJw8FACiE3h545wmRSmj26rGFgR6cx2d1r0uwOZ2pqQ3Qewr
         X8uP2MiLUq0yhtso4imwF5cxczoEGpPboQmFHbIBOWs/cJ1boenqRK6g006nmWJyq8PG
         oriN4ageJ1lItVVRWQcR8OR0S/ogBCHiLmd66DwhL4Hx5QP9B9WmZtgs34sgcdIToNjA
         P3QRIKm7cIXhbk6VKuaDoxeirVm3da9CyKG0/08Bm55MPwI3uxyohQ+5l6RlRN1lCCbg
         2Q2B614sNy6UajW1eqLrfM5jZe/+YAfTYgYROWnr8PUst7rqX8ePxKpxT6kjzPz+YFG2
         ykWQ==
X-Gm-Message-State: AOAM531gRUjX3X12pq2zkStwso5hDh74N12VFga/4ib5Vc6kqQTdmMlN
        +ChjvDUX+fuVBlU1/uCTjs/WAB4AC8fpur9xfgw=
X-Google-Smtp-Source: ABdhPJw4Wg/pG/DiNIEzk3AX99dPL7N8vAXKtJeSEjZ5UKsgj2ZPkr0U+dNvNEuVexUBCDsH3DMe6SMvGRyC8jGTMo8=
X-Received: by 2002:a05:6602:2191:: with SMTP id b17mr11293912iob.114.1615012729875;
 Fri, 05 Mar 2021 22:38:49 -0800 (PST)
MIME-Version: 1.0
References: <20210305182000.8363-1-yashsri421@gmail.com> <20210305184322.GN2723601@casper.infradead.org>
 <bcd38964-bfff-99c2-eb24-1942836e9526@gmail.com>
In-Reply-To: <bcd38964-bfff-99c2-eb24-1942836e9526@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sat, 6 Mar 2021 07:38:39 +0100
Message-ID: <CAKXUXMwoYa6xbCsqnUYL5uSA71h_3xV7-8erF6XTpmkck8ozaw@mail.gmail.com>
Subject: Re: [RFC] scripts: kernel-doc: fix attribute capture in function parsing
To:     Aditya <yashsri421@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 8:38 PM Aditya <yashsri421@gmail.com> wrote:
>
> On 6/3/21 12:13 am, Matthew Wilcox wrote:
> > On Fri, Mar 05, 2021 at 11:50:00PM +0530, Aditya Srivastava wrote:
> >> Provide a simple fix by adding "__attribute_const__" in the corresponding
> >> regex expression.
> >>
> >> A quick evaluation by running 'kernel-doc -none' on kernel-tree reveals
> >> that no additional warning or error has been added or removed by the fix.
> >
> > I'm no perlmonger, but why isn't this simply:
> >
> > +++ b/scripts/kernel-doc
> > @@ -1753,6 +1753,7 @@ sub dump_function($$) {
> >      $prototype =~ s/^__inline +//;
> >      $prototype =~ s/^__always_inline +//;
> >      $prototype =~ s/^noinline +//;
> > +    $prototype =~ s/__attribute_const__ +//;
> >      $prototype =~ s/__init +//;
> >      $prototype =~ s/__init_or_module +//;
> >      $prototype =~ s/__meminit +//;
> >
> > (completely untested)
> >
> >> +++ b/scripts/kernel-doc
> >> @@ -1753,6 +1753,7 @@ sub dump_function($$) {
> >>      my $prototype = shift;
> >>      my $file = shift;
> >>      my $noret = 0;
> >> +    my $attribute_const = qr{__attribute_const__};
> >>
> >>      print_lineno($new_start_line);
> >>
> >> @@ -1808,7 +1809,7 @@ sub dump_function($$) {
> >>      $prototype =~ m/^(\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> >>      $prototype =~ m/^(\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> >>      $prototype =~ m/^(\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> >> -    $prototype =~ m/^(\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> >> +    $prototype =~ m/^(\w+\s+\w+\s*\*+$attribute_const?)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> >>      $prototype =~ m/^(\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> >>      $prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*+)\s*([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
> >>      $prototype =~ m/^()([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
>
> Hi Matthew
> You are correct, it should be placed there. I was considering it as a
> return type instead.
> I'll send a modified v2 with the changes.
>

Aditya, I also ran:

git ls-files | xargs ./scripts/kernel-doc -none 2>&1 | tee kernel-doc-output

cat kernel-doc-output | grep "cannot understand function prototype:" |
sed 's/[^:].*:[0-9]*: \(.*\)$/\1/' | sort

and I found another instance of failed parsing function prototypes in
mm/percpu.c:2671:

struct pcpu_alloc_info * __flatten pcpu_build_alloc_info(size_t
reserved_size, size_t dyn_size, size_t atom_size,
pcpu_fc_cpu_distance_fn_t cpu_distance_fn)

Could you address that one in your patch as well?

Lukas
