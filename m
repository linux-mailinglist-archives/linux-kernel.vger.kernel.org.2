Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DD531FED5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 19:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBSSfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 13:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhBSSfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 13:35:14 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D289C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 10:34:34 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id r23so25277755ljh.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 10:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CW5m+qZ7gBGEIF7vx7/oEhHdKGHAYAdRbwZI8t7kIYE=;
        b=ZgeD29lkmpDtX59gYUOmtcAy+UeK9HvtEwZKVB+GH3HdqKSkdR8D1GZdwSOgDOgkec
         XhlRqK7zYIeCXUsPN1DGiQ3zYhKfu+qt5TJNMt8OhYv+hoIdeVqb8xdN1mpR03VF5QLY
         eJLGUOiMesVen7LbSngnFulhJaFGGEF+nEoRuRayM3aZGYEXdzAUYHMxdQOnIO9jhcR9
         ZryxamRhs7jH/SRZWOghQgjyLDe3KIsByRvgyiH3tDy9pk34O1l4vnYqE0SBw0KWtmkq
         rKqaXAlGtoYtB5Qv43xJy/xn00lkEI7lOoyubm+NjZ0QjSFmhwn9cbHvE2kTBh683NtH
         W6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CW5m+qZ7gBGEIF7vx7/oEhHdKGHAYAdRbwZI8t7kIYE=;
        b=txIfQSffXPuBGZCnGHKpxu/RQcdxnsh2LxuRCNyEA5eUEItb8uGEwFEkEG5irZ+dqG
         ZBzxySSQzKRCq9aKbBx7JEb/TRqnaws0TwFr2kuFW/aJQbmfASyINunDI9kbLfHJpFXF
         mI7Qjwtvm5AjgOlO/8pYBOlOKTn6t2hm3L9EwTQ6A0Jxc7AgHEImqW43Yn9nGJzEeI6u
         fcQvV64cf673S8BRiUkBpGlLH/XtpGL4lVbvwvM0lBZnnSHA9i43iAWfoW69W2npRnTn
         89qrEBDretTfC87xzhdj5dp5Ypj/KXwfLQxlYNcAHNp28fJIfNtYW4Gm0zyqtLDRq2Ds
         F5EQ==
X-Gm-Message-State: AOAM532dc+eSdgN8sxbcBododvM5sTatl6mzavzOi7f87XbFkJ88/D/g
        IC+PqVlK+VvOUx/UbBCaoHVar3LkDRJNqqE7j8PsH0p1oyMJoQ==
X-Google-Smtp-Source: ABdhPJxnFyATuq2qC795pWbKaHaXXI9idUixHlPBdO5otUNwcVgPOplvtCR8iRnGRawaLc721gPh7e+l9s8ev5wy8Sw=
X-Received: by 2002:a2e:8551:: with SMTP id u17mr2278991ljj.370.1613759672079;
 Fri, 19 Feb 2021 10:34:32 -0800 (PST)
MIME-Version: 1.0
References: <20210217165434.69298-1-dwaipayanray1@gmail.com>
 <20210217165434.69298-3-dwaipayanray1@gmail.com> <02966e73a288d49372746d61547084e13a2fac29.camel@perches.com>
In-Reply-To: <02966e73a288d49372746d61547084e13a2fac29.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sat, 20 Feb 2021 00:04:33 +0530
Message-ID: <CABJPP5DvMQZy2xbOEnsHHZ7o6BDYwDrPJfXhCFovCC0VhbnPfg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] docs: add documentation for checkpatch
To:     Joe Perches <joe@perches.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 11:25 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2021-02-17 at 22:24 +0530, Dwaipayan Ray wrote:
> > Add documentation for kernel script checkpatch.pl.
> > This documentation is also parsed by checkpatch to
> > enable a verbose mode.
> >
> > The checkpatch message types are grouped by usage. Under
> > each group the types are described briefly. 34 of such
> > types are documented.
>
> Of course with more to come as you are work on them... ;)
>

Yes sure I will be documenting all the types, albeit with a bit of time.

> > diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> []
> > +    This applies for all non-functional blocks.
> > +    However, there is one special case, namely functions: they have the
> > +    opening brace at the beginning of the next line, thus::
> > +
> > +      int function(int x)
> > +      {
> > +        body of function
> > +      }
> > +
> > +    Ref: `Documentation/process/coding-style.rst section 3`
>
> Ideally, these Ref: entries should use a form with the specific section
> to jump to.  For example:
>
>         Ref: `https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces`
>
> Perhaps "See: " might be better than "Ref: "
>
>         See: `https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces`
>
> > +  **CODE_INDENT**
> > +    Code indent should use tabs instead of spaces.
> > +    Outside of comments, documentation and Kconfig,
> > +    spaces are never used for indentation.
> > +    Ref: `Documentation/process/coding-style.rst section 1`
>
>         See: `https://www.kernel.org/doc/html/latest/process/coding-style.html#indentation`
>
> etc...
>
>

Okay, I will convert the references.
Thanks for the review!

With regards,
Dwaipayan.
