Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E659335B76B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 01:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbhDKXVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 19:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbhDKXVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 19:21:50 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F9CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 16:21:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u17so17262183ejk.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 16:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kOV4oCzTeKO+DA448DhGZDKH57V9k69RD8UX+W5GrQw=;
        b=xp75p+4y3LiZM8+S3YPtJIniiQEvAJV3ACclpLITT7/xhMeJrc+Q4Hz53rIfGXZ4MI
         MLsSZa9XS+/0xkGF4hxgTDCU3wLmvPQ05XJAlPKkpdYOe7Eu9IBDhaC8a5zENXvw4IOq
         iPk/VECaTXzOaHWtIyDopVoZxla1pmwl7wGEPU9i/EmlRbdJYIhzE0cLVxFdueZmstim
         Myx04sO1pNpmjZWN67KWHSq4gIFb1kvqF8Njv0LIZjbbkT8AJ+2pcA9bSqOpeLyMET40
         7XDMpy9U3dfoYtgCqvZWgsWqy+sZpGW9osxlAoEYOWhOArrSZxPX0iJxU87EdP4Xvtm9
         rEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOV4oCzTeKO+DA448DhGZDKH57V9k69RD8UX+W5GrQw=;
        b=tPq8D91+xen34tuB4WGwUAl3NwkPNPurcKsPehMWFm3EixTBWVBWuGyrGGIhFwpUkG
         gIQ5Pnu5rz+xaNQ2ZM7KIdRzTSekfYfdTOKoT3c6Ecsz0v65l/uY4fFBj2+4pPS+kaBZ
         gOjVcpQVO7R5JVTr+cyhUE+Uy1LXjWEzfNCUeL/2Q5WRJs1X7khKZkDaeUiByDJzAxRi
         nS4JYL1bYuVLvXArVReR5DC+1J5wg+x8R+qXPwjcmxuKGRlOlyQetbfW3c3OCNw/r2zM
         GGjOZ8Thid10MqTs3Ap2xeMWLgJp7y5YUBd351uwIjlqCbadY7WT9aym+ZLbi7ntIyDS
         FmZA==
X-Gm-Message-State: AOAM533EjCeXirXfx8RW5zAiWUHSEOh4rjNhb+sFboC0Yf4xggftUCuP
        chvK7zDNhepEtAzBS8JnckMU9RaQ3dhcysFQoRk5JA==
X-Google-Smtp-Source: ABdhPJxjtdtw+2AGwJoxd9f8r05aCVGmtHs9nZ8Y3SeTGk6FjnhIMAJkBPjdTqco5EajS7pVj7lyv4VXZSCGnaYqvmA=
X-Received: by 2002:a17:906:4f91:: with SMTP id o17mr25029799eju.503.1618183292216;
 Sun, 11 Apr 2021 16:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210411164342.GL3762101@tassilo.jf.intel.com>
 <C7F7BE8D-562B-4BC3-A209-8EDD7DAF0AAA@amacapital.net> <20210411170357.GD14022@zn.tnic>
In-Reply-To: <20210411170357.GD14022@zn.tnic>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Sun, 11 Apr 2021 16:21:21 -0700
Message-ID: <CALCETrX-WvuK0hC21Zes6auU9gM702wd0fV2FyP9ha-ma3=71g@mail.gmail.com>
Subject: Re: [PATCH] x86/msr: Block writes to certain MSRs unconditionally
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Feng Tang <feng.tang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 10:04 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Sun, Apr 11, 2021 at 09:57:20AM -0700, Andy Lutomirski wrote:
> > Working around a kernel bug. The workaround only worked on AMD
> > systems. The correct solution was to fix the kernel bug, not poke
> > MSRs.
>
> Do you remember which program(s) and where I can get them to have a
> look?
>

https://bugs.winehq.org/show_bug.cgi?id=33275#c19

I sure hope no one is still doing this.

--Andy
