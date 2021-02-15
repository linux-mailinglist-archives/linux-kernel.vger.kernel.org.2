Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580C931C001
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhBORBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhBOPvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:51:20 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E14C061223
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 07:50:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t15so9421449wrx.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 07:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYv02kkDzygIz/c9kOz4zAZRF/qlhW6TZOluFWpeXaY=;
        b=JjLOlNL2WTq0Ismr3EVMEOfEVjfKUSqtfkQ1In8tOV+sJlej3MswyDj39mBRI4+5Qf
         agiRbXymc9s6rAoWpgd8V6xCi5uZiCzYJ5cja9oyAtWQ+CX2lldDVyr57oxdv3uQ1MrX
         iAWm4fCJqzuqSRHziqxyinAsNBk6SiSI94ITSbYJgy+/SjZ0DJeR0u0ermFMjwyGUlP1
         0s7HodiEOv4ZwI+n/AoVdqjxPy2Un4G9je3aJ3KX7Eh8BMWrviCoeAdfSjJQ44b9KJao
         TL1hUSjfTIoXBI7ClFcFDkUaCwAVFv9NA7F58wRH3euBOLy1h+tFHSNbDCEq/aKsuQPD
         bM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYv02kkDzygIz/c9kOz4zAZRF/qlhW6TZOluFWpeXaY=;
        b=Y8j7AZaUt4T7+bpHxgkw5x7XoPsUnbkql7TyF7vwfRufHmooIjlLiv2P7+StQXrjCe
         NPp18r9UtTke9fBmRILhnZCZkSvCKGRQLH4++w566tx6OnhSTnVPZZJj0faCNLX3c0h6
         BKqn/f8eCiaCOUjGbKkqp7RxL0ztUdheVLlhpvU5nh7+2T+d80F/r2yampMKyf+hg7Yx
         As/jl8SGVzG7B/FIopame0fk9YqqlH6V72VlriWdK9zFq+3+EPA7biVJ+xUO0zQMpg1o
         NHgpN7sbQ7kZcKTz8lPXxwqInyQDOanhHkfLf9AmAgKtmV589q0zpkCgLUWjaqXobwla
         14iA==
X-Gm-Message-State: AOAM533FunmM+jG4is4DPuimgpPyWtLjOrcRUgjBHoKIiMQM1PHMluXD
        CPPGGsq5pmLrqWacu+Us3nP1/hFyjB2J/i07Ns4WxSGAUVc=
X-Google-Smtp-Source: ABdhPJwA1XGVnTWtihmdhv2mp/tRHTN0xJnmw+gRkdYClgm5YJknJdJ8Ml9KbUdZHifU5rsl6N3xKg4dTu2ruWrlPyQ=
X-Received: by 2002:a5d:620d:: with SMTP id y13mr19338833wru.88.1613404235605;
 Mon, 15 Feb 2021 07:50:35 -0800 (PST)
MIME-Version: 1.0
References: <20210213131513.51386-1-dwaipayanray1@gmail.com>
 <20210213131513.51386-3-dwaipayanray1@gmail.com> <b2e25e683a3e2f31d4dc2d666e082634e30643b3.camel@perches.com>
In-Reply-To: <b2e25e683a3e2f31d4dc2d666e082634e30643b3.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 15 Feb 2021 21:20:35 +0530
Message-ID: <CABJPP5As+68yMdX1CafXsam4rg56aCWUzsSNx6kHjtQnaJ_ofQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/3] docs: add documentation for checkpatch
To:     Joe Perches <joe@perches.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 10:27 PM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2021-02-13 at 18:45 +0530, Dwaipayan Ray wrote:
> > Add documentation for kernel script checkpatch.pl.
> > This documentation is also parsed by checkpatch to
> > enable a verbose mode.
> >
> > The message types in checkpatch are documented with rst
> > field lists. A total of 33 checkpatch type descriptions
> > are added.
>
> Alphabetic ordering isn't that great for these entries.
> Please group them by use:
>
> whitespace/code layout style:
> SPACING, TRAILING_WHITESPACE, LINE_SPACING
>
> commit message defects:
> BAD_SIGN_OFF, BAD_STABLE_ADDRESS_STYLE, COMMIT_COMMENT_SYMBOL, COMMIT_MESSAGE
>
> Allocation style:
> group: ALLOC_ARRAY_ARGS, ALLOC_SIZEOF_STRUCT, ALLOC_WITH_MULTIPLY
>
> > diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
> []
> > +4 Type Descriptions
> > +-------------------
> > +
> > +This section contains a description of all the message types in checkpatch.
> > +
> > +.. Types in this section are also parsed by checkpatch.
> > +.. Please keep the types sorted alphabetically.
> > +
> > +:ALLOC_ARRAY_ARGS:
> > +  The first argument for kcalloc or kmalloc_array should be the
> > +  number of elements.  sizeof() as the first argument is generally
> > +  wrong.
>
> If you look at the generated .html file, the output format  is poor.
>
> It would probably be better to use
> **<TYPE>**
> for each of these blocks instead of
> :<TYPE>:
>
> and update the script appropriately.

Thanks, I will do these.

Also someone pointed out in the list that some lines in the patch contained > 80
columns. Checkpatch doesn't generate any warning for that. Is it something that
could be added to checkpatch or was it decided against at some point?

Thanks,
Dwaipayan.
