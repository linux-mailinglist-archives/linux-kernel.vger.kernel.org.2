Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFB83F3659
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 00:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhHTWZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 18:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhHTWZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 18:25:35 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED591C061575;
        Fri, 20 Aug 2021 15:24:56 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id t7so2435400vsj.4;
        Fri, 20 Aug 2021 15:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YSs6ZD2a5ToMDYkxHLIhlinwMEhaHfUBHTJ87rIU9yM=;
        b=qARhwEMIX5ND5OOAQrLpczuNj42jfXV9wLxnNXk+kvJUpkPM0PssEZgR3xz0z3IMeb
         WocyfzL9xTHR3sQo4HDPqXfsdkz6vy6FXAHoEjkxFS6733Lbo2nSFq7LgsvBOpDqf/ut
         bJDIJF+3cmXfnhgvQCabEc5R8wwFqWHnqqpxxTwxs0mEIOh3N5YIBSjpX/q3IW7yO5pF
         PcluNCjMUMtWc/MZmRIMVAwzruhX5tUbvOSDLLRjdOk8byGWazR/W43Hb+6gJbwWzgKu
         sl4EiVywsoR8tzANTRXOyiKejSWpXNLNGeje07xbIISBn0Y+hr8TtFkzKCV99dsxvdxv
         b2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YSs6ZD2a5ToMDYkxHLIhlinwMEhaHfUBHTJ87rIU9yM=;
        b=Uk1z7XLKQIf2VskVi1CHqsghw+XrOVO9GVAQPkuCIdagLW2ThXzZIUJws4w5ah6/GJ
         zY87QZmGNKeGAIa/Sm15AOLAs/MRgPSk7GzS3E+zGOjSfZAO+Hd9plyGnIkY/RGTMPVW
         zHOMLXbw2y2H/Fn7f6PbhgBwSpuAoozrI9j/xG3BE6QrEiDDvUdzeMPMUWtyP3FisphN
         wIMihTUTmKxXg8ea11eoPjXwY+/J0Gmhacw+z5bOtLdwvSGyI/zfQOUEgzHJQL4jHhhn
         v27+qxJ6uc7IUbqTa3ir+2eDA5aatACtC4JCLk6j8E6YpbOW/huZQ5L5IxmgGWY5GaGO
         7YQg==
X-Gm-Message-State: AOAM532Q7inAL1BOrnrWgl4/OQprU5eEZqranH/nyLj0oEwWY5iUN8fr
        OOqnbYCmu09QLR1gCUA1URZhIArrlJKdm6cGozPCBA0DhCk=
X-Google-Smtp-Source: ABdhPJzKlJAJFCrq/qRPR+Q3pQ0wJF0GljlO/Uy6m97tOQoGOU6BjceS3tmGw+tmeIZevXUycQgaEE/d0eOuXh6pIt0=
X-Received: by 2002:a67:ec98:: with SMTP id h24mr19738408vsp.10.1629498295980;
 Fri, 20 Aug 2021 15:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210819031407.17044-1-henrybear327@gmail.com> <877dggrq6p.fsf@meer.lwn.net>
In-Reply-To: <877dggrq6p.fsf@meer.lwn.net>
From:   Henry Tseng <henrybear327@gmail.com>
Date:   Sat, 21 Aug 2021 00:24:44 +0200
Message-ID: <CAA5xa-kNcZ50cwP6aJ+GFQbbjMQoomtf=eEKXa_R43ML8fv6BA@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: Update details of The Linux Kernel
 Module Programming Guide
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     jmseyas@dit.upm.es, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 7:17 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Chun-Hung Tseng <henrybear327@gmail.com> writes:
>
> > Recently, the content and examples of the book "The Linux Kernel Module
> > Programming Guide" are being actively maintained and added on Github[1].
> > Currently, the book is being regularly built into webpage and pdf
> > file using Github static page[2].
> >
> > [1]: https://github.com/sysprog21/lkmpg
> > [2]: https://sysprog21.github.io/lkmpg/
> >
> > Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>
> > ---
> >  Documentation/process/kernel-docs.rst | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
> > index 22d9ace5df2a..631a3dc04e3e 100644
> > --- a/Documentation/process/kernel-docs.rst
> > +++ b/Documentation/process/kernel-docs.rst
> > @@ -126,15 +126,17 @@ On-line docs
> >          describes how to write user-mode utilities for communicating with
> >          Card Services.
> >
> > -    * Title: **Linux Kernel Module Programming Guide**
> > +    * Title: **The Linux Kernel Module Programming Guide**
> >
> > -      :Author: Ori Pomerantz.
> > -      :URL: https://tldp.org/LDP/lkmpg/2.6/html/index.html
> > -      :Date: 2001
> > +      :Author: Peter Jay Salzman, Michael Burian, Ori Pomerantz, Bob Mottram,
> > +      Jim Huang.
> > +      :URL: https://sysprog21.github.io/lkmpg/
> > +      :Date: 2021
> >        :Keywords: modules, GPL book, /proc, ioctls, system calls,
> >          interrupt handlers .
> > -      :Description: Very nice 92 pages GPL book on the topic of modules
> > -        programming. Lots of examples.
> > +      :Description: A very nice 93 pages GPL book on the topic of modules
> > +        programming. Lots of examples. Currently the new version is being
> > +        actively maintained at https://github.com/sysprog21/lkmpg.
>
> If this book is now being consistently maintained, then the number of
> pages is sure to change in short order; it seems like kind of a strange
> thing to track here...?
>
> Thanks,
>
> jon


Sorry about it.

v3 has been pushed, dropping the term "93 pages".

Thank you for the feedback!

Henry
