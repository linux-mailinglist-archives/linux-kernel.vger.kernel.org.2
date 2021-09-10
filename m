Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E9440732C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 00:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhIJWE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 18:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbhIJWE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 18:04:27 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306A5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 15:03:16 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id g16so2096832uam.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 15:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dcqU9ZKZN47g77fb/rE27/hZjysW8Rw23gLua/TqJ3g=;
        b=m6aWXd2Gw4Bh6WEXuh6E/mhFWW2qOUaAXVIKQaGVEYvVg7FIGyKJOCA2XmKv0/l78E
         gkhKmn+zzD+ejrbhHZ5EfsAZYWV4wCaPUYDsdBpSIsoE1bRK7ErgU/yG65o84Z8xPwFn
         M+yeUkABwCrQlIwgMbXLVqKZdyS14pBia6tMJKUhttjVErg93dBD0Te7wH7/qlhrBpUu
         qvFGyWeEIVl8KWDteL7cEd3ogiiiNdbCy2xxO3DgaWzodE6YJXBwLuEIQUaPW1Foq6PZ
         hlC7P3yR+0tYq7Jav4Xg9d5+/PnVUH0za3AP6UuA+fvAeKhqINk8VlaPpTp+1pRCdLKx
         tU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dcqU9ZKZN47g77fb/rE27/hZjysW8Rw23gLua/TqJ3g=;
        b=QVcqZfHtCdzxWC/sRQDz8O+EPH3hZ5/GNLgjT7VSUIonrJXdtro3qKKXRONDw3eO3b
         FQ4msRAA4BL+GSjQZzDoB2L0jrAyzjVLic4DGLa9zedvp2HwiA7qObeEW/HpAopJTcIh
         zC3N+n8hjVDB4ZZFsCzHe47VHmu9ZnnUy5MD7BijLzSgn1aJUrsWsYuf1+6sKEzTiJw9
         3bzDO+aVFiGUpGXynJYDibFDlaTci2i01fWSJVr1+kr4qNZLgCWJlJxhe5KnwxKDq5zY
         CC9laCd3mLz3aooG/fYXZjgJ2sATdV0uKTadcc2U/FKYh6S3MLibeUAs/0mrfHHVPxUh
         h7iQ==
X-Gm-Message-State: AOAM532u9/fSZoGqB3HufTiM1iJSy7BB47qNaKuZFZfxB3gDA1j34LmF
        +EhT72YITvOp3ZdAMgGou24zsCS8GNPShTFaDIuEuviM
X-Google-Smtp-Source: ABdhPJzE48lT6fqiiuWBqWFJ0x87spa0lMjXvc0VaGDvNGGYnsC+9drMKpfUvUE2GtBvBI8gN5I8AhDu+lzquAQEWe0=
X-Received: by 2002:ab0:1647:: with SMTP id l7mr7838728uae.128.1631311395250;
 Fri, 10 Sep 2021 15:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210909161755.61743-1-ahalaney@redhat.com> <0849504a-b7ed-f448-6d66-1a9fd5ad70ce@akamai.com>
 <CAJfuBxzX9nEvxC1s-4uRCzLwN0=3gbFT__9vO_coEM5CrpnJng@mail.gmail.com>
 <20210910182445.vao7uhqveaen25tk@halaneylaptop> <CAJfuBxzWwXCmw+YsonMCOaHq=21C-rVPL8BhZpDU0NPQW0B_8w@mail.gmail.com>
 <20210910201635.4d3fhhrwvcusdwk2@halaneylaptop>
In-Reply-To: <20210910201635.4d3fhhrwvcusdwk2@halaneylaptop>
From:   jim.cromie@gmail.com
Date:   Fri, 10 Sep 2021 16:02:49 -0600
Message-ID: <CAJfuBxxh81UXb2re109Jirnfjca+db3_bicmoaea62nE0UiRhQ@mail.gmail.com>
Subject: Re: [PATCH] dyndbg: make dyndbg a known cli param
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 2:16 PM Andrew Halaney <ahalaney@redhat.com> wrote:
>
> On Fri, Sep 10, 2021 at 01:31:22PM -0600, jim.cromie@gmail.com wrote:
> > On Fri, Sep 10, 2021 at 12:24 PM Andrew Halaney <ahalaney@redhat.com> wrote:
> > >
> > > On Fri, Sep 10, 2021 at 11:14:45AM -0600, jim.cromie@gmail.com wrote:
> > > > On Thu, Sep 9, 2021 at 3:34 PM Jason Baron <jbaron@akamai.com> wrote:
> > > >
> > > > >
> > > > >
> > > > > On 9/9/21 12:17 PM, Andrew Halaney wrote:
> > > > > > Right now dyndbg shows up as an unknown parameter if used on boot:
> > > > > >
> > > > > >     Unknown command line parameters: dyndbg=module params +p ; module
> > > > > sys +p
> > > > > >
> > > > > > That's because it is unknown, it doesn't sit in the __param
> > > > > > section, so the processing done to warn users supplying an unknown
> > > > > > parameter doesn't think it is legitimate.
> > > > > >
> > > >
> > > >
> > > > your usage is incorrect for what youre trying to do in that example
> > > > what you need is:
> > > >
> > > >   params.dyndbg=+p  sys.dyndbg=+p
> > > >
> > > > dyndbg is properly unknown as a kernel param, it isnt one.
> > > > ( it was called a "fake" module param when added.)
> > > > $module.dyndbg is good, since its after the $module. (and the dot)
> > > > it also then inherits the "scan bootargs for relevant ones on module load"
> > > > behavior
> > > >
> > > >
> > >
> > > That example is (slightly altered) from
> > > Documentation/admin-guide/dynamic-debug-howto.rst,
> >
> > oh dear, I see the lines youre referring to.
> > I am surprised.
> > fyi, those lines are:
> >     // enable pr_debugs in 2 builtins, #cmt is stripped
> >     dyndbg="module params +p #cmt ; module sys +p"
> >
> > is your patchset removing those lines ?
> > if so, ack that part.
> >
> > > I can change the example used to be a little less confusing (using the
> > > module keyword is confusing, I could use something like
> > > func or file instead of what the docs use as an example).
> >
> > yes please, I saw bad usage, thought faulty premise.
> >
> > > Is that what you're after, a better example usage of dyndbg= being
> > > whined about in dmesg for the commit message, or am I misunderstanding?
> >
> > I guess Im inured to it.  Heres my regular version with a similar addition.
> >
> > Unknown command line parameters:
> > virtme_link_mods=/home/jimc/projects/lx/wk-next/builds/local-i915m/.virtme_mods/lib/modules/0.0.0
> > virtme_initmount0=/root virtme_initmount1=/root/sbin
> > virtme_stty_con=rows 27 cols 109 iutf8
> > virtme_chdir=home/jimc/projects/lx dyndbg=+p
> >
> > most of them do something, just not for the kernel.
> >
> > I dont think this is worth explicitly silencing.
> > rather rip out the misleading doc.
> >
>
> Ohhhhh, ok now I think I'm following what you and Jason are saying.
>
> dyndbg= parameter does need to process the whole cli, for cases like
> when $module.dyndbg= is supplied but $module is a builtin. And you are
> saying that this syntax (although it works)
> 'dyndbg="module params +p #cmt ; module sys +p"' is not the intended
> usage.
>
> So converting dyndbg= to act like ddebug_query= won't work because
> $module.dyndbg="+p" should work if $module is builtin or a module
> (settles my open discussion with Jason).

yes, $mod.dyndbg=+p  works now whether $mod is builtin or loadable.
 that must stick.

if bare dyndbg="str" works like an alias for ddebug_query=
 (its amazing what one forgets)
then I agree the warning is misleading.
