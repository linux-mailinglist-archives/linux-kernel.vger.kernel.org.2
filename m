Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BC543B4A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbhJZOrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbhJZOrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:47:19 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C585C061745;
        Tue, 26 Oct 2021 07:44:55 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id y17so17535421ilb.9;
        Tue, 26 Oct 2021 07:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Iy+awNeYow+pZc/iB1UDBBsLq5AXRGWMxqulAP9fDkA=;
        b=MaFGLlXw8Ugv98OU2Ywa01KZmCS1SMD0hUBKIvK2njSBNmhmhbUUJjHDAubWhhY96/
         1uoOCR18qWVWXpL4p9ElnAxI9EId8fCBeRaApfRpFvFo6gLUzst4uulZoKVKaKplepD4
         jbg7SH6E7l6whBKq0FGjBfj0NkQhv1ChdDXnlHXXKmZdX+5srX3YnyeMDQAkAEiTX0SR
         X/yJEI5JCUjHYiWcPCMqb4tIhsQ1yMU4GJ5taDHufVyh+8DKZAHt7x+GLvpQN3IZd4pG
         IpXDmjxH3dtrOgMp1sQ1HbTCmtOvkAjr6ZBMH1cfiiFRIcFYuKdSUqGCBK0x0r2vUH/M
         H7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Iy+awNeYow+pZc/iB1UDBBsLq5AXRGWMxqulAP9fDkA=;
        b=7Y7bd/nTf3a8Nw9/vjVlSQUtdco7+Fq87eBdkdlM2xspQiQd2XFmyfkuykg3Xzbgj3
         8c0XrM/CvrUlz9ngZyW0JTokDVAgDJYy2hDsI8Ka2UjYHpq89dzj1BA5W128X+brycih
         5jW+CsVPaLcLYbWv57FcLLPbZk18WSAO506pypdoqqf7Rq9B/uhGkvDPwmKXDiZh52qu
         kg8AA/zOa8Hb52u/w89KgHFeGExfI5DGqdurPX2yByTADneEcEKRCRpIrMobcpa8kpJs
         pdwcKcvBMcq7+jtJ/gk2YKGM7D0LWp7b7gbEmRyRXCR1b2W82rX+TZwezZbY4/tbCWjQ
         r/tw==
X-Gm-Message-State: AOAM533ZUh8eLF/znef7B5lPsmpILOAsdgUR9MoWJhwWyD/DsccfZvn5
        2ZmoLzloY0vXwcV0bjnRgESRfAB9tH0=
X-Google-Smtp-Source: ABdhPJyzdApKplVzN7/9JWa4Tw5Xsfjg1GuQfTiTMYS5/pJNyb7FjRJq9TcM98BEdvYLiJcOvsG0yg==
X-Received: by 2002:a05:6e02:104b:: with SMTP id p11mr15157863ilj.187.1635259495054;
        Tue, 26 Oct 2021 07:44:55 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id z26sm10063738ioe.9.2021.10.26.07.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 07:44:54 -0700 (PDT)
Date:   Tue, 26 Oct 2021 10:44:52 -0400
From:   Trevor Woerner <twoerner@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Joe Perches <joe@perches.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Yorick de Wid <yorickdewid@users.noreply.github.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] coding-style.rst: trivial: fix location of driver model
 macros
Message-ID: <20211026144452.GA40651@localhost>
References: <20210423184012.39300-1-twoerner@gmail.com>
 <CANiq72mUBh+76iy5uCAGHpKHDnTGRVyQduMngEWDMCF6kRySJA@mail.gmail.com>
 <CAHUNapQfFBcqrX7MvUvq8qbPgk2bPu-h3+9NxAUFpRtpOGFODw@mail.gmail.com>
 <CANiq72=iDhHiFKBzud6sj6reCS=pEYxFn5x4b=VfNLMxva-RuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiq72=iDhHiFKBzud6sj6reCS=pEYxFn5x4b=VfNLMxva-RuA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-10-26 @ 02:47:12 PM, Miguel Ojeda wrote:
> On Mon, Oct 25, 2021 at 11:40 PM Trevor Woerner <twoerner@gmail.com> wrote:
> >
> > ping?
> >
> > It doesn't look like this was picked up by trivial? Although, it doesn't look like git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git has been used in a while. Is there an alternate (preferred) path for trivial patches?
> 
> Jonathan should be able to take it, or perhaps Andrew.
> 
> Note that you should put whoever should take it in the To field (I
> just noticed your original email did not) -- use
> `scripts/get_maintainer.pl` for getting the relevant people for a
> patch or path.

Ah, good point. I have a "cccmd" line in my ~/.gitconfig for adding people to
the CC when I "git send-email", maybe I should switch that to a "tocmd"?

get_maintainer.pl didn't add Andrew back then on my patch and still doesn't
even now. Maybe the MAINTAINERS file needs an update if Andrew is to be
included on trivial/documentation patches?
