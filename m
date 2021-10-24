Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C94438B9E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 21:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhJXTaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 15:30:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231382AbhJXTaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 15:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635103668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pMzKKPAhr0lndZvzBEXrG2TXEiOnSLC+lm/RYubs1ww=;
        b=id/0uPNwhUN0GeMSymDPB2RNmYhR8se1/ySOZ2AnD28iBYImbtAbvIeWm1vEOgncVeRNTZ
        nHLgZ/LRDYIp2tgIQZVwylLKZDeRyg2xM9QE5ngB+qmBhtN8l7w+xgdeM5EZLrEuwBUNrZ
        nMfgWjJ2riIV4LoPsXdtLZ2jOhZde4A=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-ruhbRP8ENEWa2qJdw40Lew-1; Sun, 24 Oct 2021 15:27:46 -0400
X-MC-Unique: ruhbRP8ENEWa2qJdw40Lew-1
Received: by mail-oi1-f198.google.com with SMTP id w69-20020acac648000000b00298a3aee9a6so5993238oif.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 12:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pMzKKPAhr0lndZvzBEXrG2TXEiOnSLC+lm/RYubs1ww=;
        b=YEcjzJppuP6UJFwAlBtwyxSVTuUtPMYA1JgrCkDzeQvbpO3beCQOnj5QPYR/Ag7PDG
         iWMjHHlWGHmMs6khZOOzrm1dyQg+yFIDAcUfLcLixmBlcS7liwlB+jZ0cG9x2g+ieQ05
         rsVURHthNruTJmt5DNuFet6oIAIZZkvQMg6Rc574Z42LQVXpmxR08eRIPyq9aPLwBuh1
         JwHryuBsvxqARO3cDnAW6yKZjCoEAMEj2Yj7C0tAtbh0bbxc41f+y/QsJSwyXZchjpNX
         zq/86MRIzOvkpIwEzajowL19iBThF9yW6+zR+/gA+LmJEtAVqDAS1YV8zVHfINGTfu08
         jCeg==
X-Gm-Message-State: AOAM531EszYp2Yk8yh3z3R3hd1DeBmPXDvgaPOx+9fQarNJ9hf2EtFtm
        +hOnM8HzDOe5wCYWNdJFSWhfPB1xWWmbGnSAGlxJnD56OE6lRg0BxzkxskZ9Da0qpLof+fV6L26
        o4/l/VMD5WCSi+UG8+OgQip8D
X-Received: by 2002:a9d:4696:: with SMTP id z22mr10671664ote.218.1635103666074;
        Sun, 24 Oct 2021 12:27:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0rUBoTQy+2A6kOvDn+net8tKgY2mfkvAbsUD1jUg1HYrLh64YmzSnRSIxPx1b+SaX4mXUWA==
X-Received: by 2002:a9d:4696:: with SMTP id z22mr10671649ote.218.1635103665824;
        Sun, 24 Oct 2021 12:27:45 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id i18sm2594364oot.27.2021.10.24.12.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 12:27:45 -0700 (PDT)
Date:   Sun, 24 Oct 2021 12:27:42 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Rob Landley <rob@landley.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Commit 0d989ac2c90b broke my x86-64 build.
Message-ID: <20211024192742.uo62mbqb6hmhafjs@treble>
References: <53f767cd-9160-1015-d1b8-0230b5566574@landley.net>
 <CAK7LNAQFEi=4nky4nxRA8s+ODaf89Wa5kwDhe9dppKWX0UiFJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNAQFEi=4nky4nxRA8s+ODaf89Wa5kwDhe9dppKWX0UiFJA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 03:13:40AM +0900, Masahiro Yamada wrote:
> On Sun, Oct 24, 2021 at 3:36 PM Rob Landley <rob@landley.net> wrote:
> >
> > The attached config built fine before the above commit, doesn't build after. The
> > commit in question did nothing except remove support for building x86-64 without
> > libelf.
> 
> You enable CONFIG_STACK_VALIDATION in your .config file.
> At least, you observed
> "warning: Cannot use CONFIG_STACK_VALIDATION=y, please install
> libelf-dev, libelf-devel or elfutils-libelf-devel"
> in the previous builds.

Unfortunately I think CONFIG_STACK_VALIDATION is no longer optional on
x86-64 these days, because of static calls and retpolines.  But it
should be possible to extricate them if that's a problem.

> > It took me a while to notice because the commit ONLY broke x86-64. I can still
> > build arm (32 and 64 bit), i686, m68k, mips/mipsel, powerpc, s390x, and sh4
> > without libelf in my cross compiler. Heck, I can still build i686. The change
> > seems to have added a unique build dependency to just x86-64.
> 
> The other architectures are not affected because you cannot enable
> CONFIG_STACK_VALIDATION.
> 
> Please note only x86_64 selects HAVE_STACK_VALIDATION.
> 
> 
> > Rob
> >
> > P.S. Why do you need a special library to parse elf anyway? It's a fairly simple
> > file format, linux has include/linux.elf.h, the toolchain already has an objtool
> > prefixed for the appropriate cross compiler...

We didn't see the need to reinvent the wheel, and some of the ELF corner
cases are tricky.

Objtool heavily relies on libelf for both reading and writing.  The
kernel needs objtool to be robust.  Libelf has been solid.

-- 
Josh

