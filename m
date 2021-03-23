Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E853457A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbhCWGOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhCWGOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:14:03 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEBCC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 23:14:03 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a1so24135129ljp.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 23:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9a7WpLfMa2pUk8U0O+U4UQy55bOLwjMqp9wpg8sCwwc=;
        b=ZUYjQ8HZYqvnzkDWkihzrDTJwFuJ2Yq41wGZeU7bkQuIAbTD3ggAZ7ELOJAeSC9M2g
         gu7ugP59zJupCQBu87rJq/beWbCd//MqrJgoncooJYkAK3Lv2xfUZ3DNIFjMK+XXwbva
         T0iXKjHVKlnCIQ/sYD8fYTLnWen549ARRW5N4kYuf6VVRnQIXVS8ECCiCy3TqRLsdbUo
         MS1vh9Ed8UEAv24wE66n+slCG8zsAi5wg73NImVr3P9wAbA7V/9qTt8OxJVRrE2SDd2F
         t+ytIPEhxZ+zfyN7VySbYjsODZSmDjoe3dXRYALuAZCAUsVYAkccGvGBfFgM78yTo1OV
         isdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9a7WpLfMa2pUk8U0O+U4UQy55bOLwjMqp9wpg8sCwwc=;
        b=Okih+LOSK4GeUrUAHuaU5UuOyWBogM32azdxxz/2XBhdcxm518Y79ueNirAucK26iR
         Q/tRKGmf0Q+3D4n3rXTkQLoV4pqz9NzFIalC8n0xdJnRoU8QxGMLodwQ4l+pzs9i0FX4
         Nd/3u/pnHCdiInWwXlsqlBXZsRFQQECET/f452C1KM9PJ2Zlmq3QKybGH8GgaAjLGTpj
         SVi4+5TRIQF4K+MaIDI8UdXY1SpFB1e/+3aKAoGBCNfOXMnQELnDKxo5BsxcekFUuG/B
         CTZRwUzSyqy/cRKrLpMKAkfQCHMpiU3Qv7+P3Q8hKzDWFlVeNzCnrcDdWlmaxX9wBaXg
         s4Jg==
X-Gm-Message-State: AOAM5339xudFo8V81aEt0cKiMnXuLFd5akwFpX/T3gKRjQkVJ5cqNxH9
        vVyqHlaEBnAGDsdCASLD2EDa3DDJN1W+6GD2yqILtg==
X-Google-Smtp-Source: ABdhPJzgCv0B3NkvwBItBmsL0LNXiWLVViYVx8mESU339kCVlZZq9+aHBwIsMSn2pxo9rQWj7bsiGFoOsOBdi5Hlx+w=
X-Received: by 2002:a2e:5c47:: with SMTP id q68mr2104505ljb.314.1616480041484;
 Mon, 22 Mar 2021 23:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210309121747.859823-1-sumit.garg@linaro.org> <20210319171712.vlkgnmp7cbnayxdn@maple.lan>
In-Reply-To: <20210319171712.vlkgnmp7cbnayxdn@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 23 Mar 2021 11:43:50 +0530
Message-ID: <CAFA6WYMxUNwAB2sJBeS_Uvy0O43JqNPe_7-+ORGiHB7gBKjzYg@mail.gmail.com>
Subject: Re: [PATCH] kdb: Refactor kdb_defcmd implementation
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 at 22:47, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Mar 09, 2021 at 05:47:47PM +0530, Sumit Garg wrote:
> > Switch to use kdbtab_t instead of separate struct defcmd_set since
> > now we have kdb_register_table() to register pre-allocated kdb commands.
>
> This needs rewriting. I've been struggling for some time to figure out
> what it actually means means and how it related to the patch. I'm
> starting to conclude that this might not be my fault!
>

Okay.

>
> > Also, switch to use a linked list for sub-commands instead of dynamic
> > array which makes traversing the sub-commands list simpler.
>
> We can't call these things sub-commands! These days a sub-commands
> implies something like `git subcommand` and kdb doesn't have anything
> like that.
>

To me, defcmd_set implied that we are defining a kdb command which
will run a list of other kdb commands which I termed as sub-commands
here. But yes I agree with you that these don't resemble `git
subcommand`.

>
> > +struct kdb_subcmd {
> > +     char    *scmd_name;             /* Sub-command name */
> > +     struct  list_head list_node;    /* Sub-command node */
> > +};
> > +
> >  /* The KDB shell command table */
> >  typedef struct _kdbtab {
> >       char    *cmd_name;              /* Command name */
> > @@ -175,6 +181,7 @@ typedef struct _kdbtab {
> >       kdb_cmdflags_t cmd_flags;       /* Command behaviour flags */
> >       struct list_head list_node;     /* Command list */
> >       bool    is_dynamic;             /* Command table allocation type */
> > +     struct list_head kdb_scmds_head; /* Sub-commands list */
> >  } kdbtab_t;
>
> Perhaps this should be more like:
>
> struct defcmd_set {
>         kdbtab_t cmd;
>         struct list_head commands;
>
> };
>
> This still gets registers using kdb_register_table() but it keeps the
> macro code all in once place:
>
> kdb_register_table(&macro->cmd, 1);
>
> I think that is what I *meant* to suggest ;-) . It also avoids having to
> talk about sub-commands!

Okay, I will use this struct instead.

> BTW I'm open to giving defcmd_set a better name
> (kdb_macro?)
>

kdb_macro sounds more appropriate.

> but I don't see why we want to give all commands a macro
> list.

I am not sure if I follow you here but I think it's better to
distinguish between a normal kdb command and a kdb command which is a
super-set (or macro) representing a list of other kdb commands.

-Sumit

>
> Daniel.
