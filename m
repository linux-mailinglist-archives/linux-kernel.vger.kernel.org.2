Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C7A43BC49
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 23:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbhJZVXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 17:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239623AbhJZVXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:23:31 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7D3C061570;
        Tue, 26 Oct 2021 14:21:07 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id f9so1014517ioo.11;
        Tue, 26 Oct 2021 14:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3NsbRHAcbqeLB98tL/5OrkvKy4kl3HelWqG3LhV0gE0=;
        b=OH2Wv2wHn5wZKLgF467oUWhtBrZ2OQWHtq+JN8v6sNGGu42bFAQeKhoU3fvklJFpn4
         IzdE+KjpqJidy1yFqNIiJu07xtHc4kVrO9OnoN8zjWbK/637NNnZeV0oEqflPpO3X/Aw
         feIwMHA7xrQnwpEzgtGqM4wv9T2Sh590kIDukEUYQli32jt7bdV30lz+yiE334VTqNCh
         HNBjXMBq8AjqO7CJiouHnSnU3M43Kzd0m1YHXr+cI3LcQJAHSYWx55qI93T7m541vnjz
         PphAy2ItY7zwrIEc+jJY98oKfgwgNwY2hKOZOmg78Dc0/H5ekomNI54TQnlh2dmDv1Gh
         5lEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3NsbRHAcbqeLB98tL/5OrkvKy4kl3HelWqG3LhV0gE0=;
        b=wqj8KPKEfhK5aqVHmKRgQnSoVXmiNviQYXoKKOgBUVDys6U5lFlLoJpuEAFSqA1J3Z
         zoC9VPoLW395t6WmI4r2E2+J6qO35sw/lyoPEQIBLH4i8HeQeEh0klgoN/y5TbhTunz3
         utcfetWp7X6euwW1+wOPe5+xG08z2Brm6c+BUzZMUyPlTfnsx3oKS0ybtxTWypnyA1LQ
         SKYLUvihPjVdbsXSsH8HVQt5eMXoYjdgGDO6BmF533KnBPo6k8HkrFYY2SOO3Tya00Kh
         XGlVghgUwnyNGlLpiU3yD97MK9YL4MZoGWbyv6xoDT8+y3oOqo8XEovPMQ4svRmCvCJ9
         P2nQ==
X-Gm-Message-State: AOAM533FPMBzWsYYA39NbMBrX3dqPTYcE03ePv0m3SgphypfKcqJygBw
        3p8CHrHZGMavvryRYkLrdcU=
X-Google-Smtp-Source: ABdhPJy3SVZkvA3wIqlfARdTpCeLNj5tcqu7by2mqW9Nzq4fFquD6U7uFVkJZm/f9gL2tu9getYeZA==
X-Received: by 2002:a5d:8719:: with SMTP id u25mr17015971iom.140.1635283266966;
        Tue, 26 Oct 2021 14:21:06 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id z7sm551192ioj.38.2021.10.26.14.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:21:06 -0700 (PDT)
Date:   Tue, 26 Oct 2021 17:21:03 -0400
From:   Trevor Woerner <twoerner@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
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
Message-ID: <20211026212103.GA6830@localhost>
References: <20210423184012.39300-1-twoerner@gmail.com>
 <CANiq72mUBh+76iy5uCAGHpKHDnTGRVyQduMngEWDMCF6kRySJA@mail.gmail.com>
 <CAHUNapQfFBcqrX7MvUvq8qbPgk2bPu-h3+9NxAUFpRtpOGFODw@mail.gmail.com>
 <CANiq72=iDhHiFKBzud6sj6reCS=pEYxFn5x4b=VfNLMxva-RuA@mail.gmail.com>
 <20211026144452.GA40651@localhost>
 <52c1cd5fa698216734ffda706299d77a102fcb2f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52c1cd5fa698216734ffda706299d77a102fcb2f.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe,

On Tue 2021-10-26 @ 08:37:29 AM, Joe Perches wrote:
> On Tue, 2021-10-26 at 10:44 -0400, Trevor Woerner wrote:
> > On Tue 2021-10-26 @ 02:47:12 PM, Miguel Ojeda wrote:
> > > On Mon, Oct 25, 2021 at 11:40 PM Trevor Woerner <twoerner@gmail.com> wrote:
> > > > ping?
> []
> > > Note that you should put whoever should take it in the To field (I
> > > just noticed your original email did not) -- use
> > > `scripts/get_maintainer.pl` for getting the relevant people for a
> > > patch or path.
> > 
> > Ah, good point. I have a "cccmd" line in my ~/.gitconfig for adding people to
> > the CC when I "git send-email", maybe I should switch that to a "tocmd"?
> 
> I use scripts for both.
> 
> https://lore.kernel.org/all/1473862411.32273.25.camel@perches.com/

That is awesome, thanks!
