Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE5C446958
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 20:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhKET55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 15:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhKET54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 15:57:56 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B91C061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 12:55:16 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id p8so7874615pgh.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 12:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9BE6s8fqPo7si+9hU4rA5Zx86f+DZzTQse4zPUGhzI0=;
        b=K2JJlQhfcPmTgqNvZMN022hVqYO6eH/8AxgqtQORXguKa8NM7Wo9wB2mxAZqdkfBJP
         ppNT5YQE5mZot/jPo/6TlUfDTaT2X/TQF4QITNnD9iyLfm2WK1BHpKNEffle0LCGh2b4
         sndnUuP6PC/3WEqL8sKDAROrX/WuH+koIv7G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9BE6s8fqPo7si+9hU4rA5Zx86f+DZzTQse4zPUGhzI0=;
        b=2hxz7mjXllRrdHk7R1PdfFjpJkjKqFo7miHMvtzewhfijkjgtNhIEkBi9hVzANBEdy
         x1chJL8kpnL4dS5yzUSbWsZJFiOnkplDV7E42pzau1Mf0tEtAeEFi7pOII13uVu+fVL6
         Yv2+l9OfXRlVBClQY9hGpC0i/NrFEPet1FPqlOrRJEpxfCtTwomC9uvGpTz1iedCh3Wn
         mxzARxG8RyDud7shDS/K8tv9DJXEkPOrY1PsB2uma01ryQMwIyPJVoY0XzlFvniOMdL6
         gh3dDNI3GahMRuaOOobOd0Q6csnZxoo52bHukUOUDTL7MpmGYM7etCu+NODuHAgbL6M8
         L+QQ==
X-Gm-Message-State: AOAM531sPeWN9glL9xQltOLLzE3ak04r2wgGxkxSYCyk8SLSyWgvYJjI
        vAgLU1CXEl3r/EQoDdc3QtxVvA==
X-Google-Smtp-Source: ABdhPJz6C1Esv0poMTWA9OAwWm7CjuefshOeHGRbguhnJfCUTwK+nbqOyx93dmWbZ6c/B8FKQ1fObg==
X-Received: by 2002:a62:ee10:0:b0:49f:9994:354e with SMTP id e16-20020a62ee10000000b0049f9994354emr7956301pfi.21.1636142116413;
        Fri, 05 Nov 2021 12:55:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d13sm8252555pfu.196.2021.11.05.12.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 12:55:16 -0700 (PDT)
Date:   Fri, 5 Nov 2021 12:55:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        linux-parisc <linux-parisc@vger.kernel.org>
Subject: Re: parisc build failures in mainline kernel
Message-ID: <202111051254.1AAE34273@keescook>
References: <20211104031554.GA34798@roeck-us.net>
 <CAHk-=wjvWORtC5vwgavJxpBtV3-q9GGidezS_2NjtUFvqg7H5Q@mail.gmail.com>
 <77dc70f4-879a-eb5c-2dd6-682b4c7cfd03@roeck-us.net>
 <CAHk-=wjZo3yj46FwVi0BNKfy5fZ4-UeWkeQ6nhcAbbnKS7K=dQ@mail.gmail.com>
 <202111051242.86E9DBF@keescook>
 <CAMj1kXGhHGD047BzXC3m9afW+9x_UBj1jgDdC+i2GLqHbrj-Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGhHGD047BzXC3m9afW+9x_UBj1jgDdC+i2GLqHbrj-Fg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 08:43:52PM +0100, Ard Biesheuvel wrote:
> On Fri, 5 Nov 2021 at 20:43, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Nov 03, 2021 at 09:45:47PM -0700, Linus Torvalds wrote:
> > > On Wed, Nov 3, 2021 at 9:30 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > >
> > > > Unfortunately not. With that patch it complains about task_struct.
> > >
> > > Gaah. You'll need something like this too
> > >
> > > -       DEFINE(TASK_CPU, offsetof(struct task_struct, cpu));
> > > +       DEFINE(TASK_CPU, offsetof(struct task_struct, thread_info.cpu));
> > >
> > > in arch/parisc/kernel/asm-offsets.c.
> > >
> > > And really, it should probably be renamed as TASK_TI_CPU, but then you
> > > have to rename all the uses too.
> > >
> > > There might be other details like that lurking.
> >
> > I'll check this out too if Ard doesn't beat me to it. Thanks for the
> > investigation and sorry for the breakage!
> >
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2a2e8202c7a16a85a881ad2b6e32ccbebdc01dda

Heh. Ard did, in fact, beat me to it. Thank you! :)

-Kees

-- 
Kees Cook
