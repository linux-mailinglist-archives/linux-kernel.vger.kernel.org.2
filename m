Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED04443B598
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbhJZPbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhJZPbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:31:32 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCCAC061745;
        Tue, 26 Oct 2021 08:29:09 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r194so722507iod.7;
        Tue, 26 Oct 2021 08:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJolHZAJ+NHUzTXzRjY88iP/wLMrBD51AxY6Lzd7Fu0=;
        b=iQqj7HS27USEcuVJAO2uQWLah4eVJ0LMNq6R3/nx8Hceh9EqMC5O7NG4dKUyRlmMKs
         lX0JNHieIN4cqAzyiG/TSF6G7iH2cwk51t31MYAki7jqkbu1k56nRC+LLlUzii1vsj19
         9H85WDG+2lOj8W6UiCjhICCBhGn79l6oHA1paI5urGWf1da49QgO7B9XTTXZ6Eu72+3Y
         YJjlZBqDMvbhXFCyUxIjWIhI3dSaifhOr+eWEccUXjyOpjEGCGSW6BJ2xuwA3nTFqjsN
         fwQChTpLZZYDS6YB38FN5x+nYUrgcBWsYxkKJnPTEbpwFJLetCF0PzDuSgs/6jVlpyfp
         mFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJolHZAJ+NHUzTXzRjY88iP/wLMrBD51AxY6Lzd7Fu0=;
        b=l2K8Tu+sYcZfNkZBQ+IgUAx37giloyXD8tCudOiQzMurcA3hOzsPjINsCbs2t3oE39
         /tNMzgVcxr0s7IPanVKAXr5AXk+OK/qfW31b0ZmuIFh7dq0gov/LV8tI4CiAemINHIuz
         tk06r4gRWSbODHCQdNAU0NR/7DPhxJPzNUWTdYXskwGWPtbUS2+wHdnLC8TYCRorjrlh
         +QK9y3YjvYzC5+4VWXpmxcq5S+U7l+b9mpuP+fgXo+onqum3d/OC1+H9ELgVNrRXq8hX
         TQyJ/qBe1BqeO8s35614e5T0W5R1plbvOJhSDQb2OwvFHnjeIz6xnqufbOWveU/wKm/N
         q64Q==
X-Gm-Message-State: AOAM5324Ep8PIp+xetH3O2XsaSU4FoNHHIZ7L8/lvtp8BkC12lrCXap2
        U8KwxYfsiPBbn0+ir8+gev/bTUce2rL246tkt74=
X-Google-Smtp-Source: ABdhPJxahCG/EjlpsVlkUL4UB7ZYvXFOKMLyPnWHyZ5reTJl6PT6O9cdmV7V504GM+tmBiDhbrbTevRP53JuUMPzBHA=
X-Received: by 2002:a5d:8903:: with SMTP id b3mr16216589ion.44.1635262148559;
 Tue, 26 Oct 2021 08:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210423184012.39300-1-twoerner@gmail.com> <CANiq72mUBh+76iy5uCAGHpKHDnTGRVyQduMngEWDMCF6kRySJA@mail.gmail.com>
 <CAHUNapQfFBcqrX7MvUvq8qbPgk2bPu-h3+9NxAUFpRtpOGFODw@mail.gmail.com>
 <CANiq72=iDhHiFKBzud6sj6reCS=pEYxFn5x4b=VfNLMxva-RuA@mail.gmail.com>
 <20211026144452.GA40651@localhost> <CANiq72kf0QZUeO+=U67NLs=WXc=sEtasdv_yaZ5sZedNmzzJBw@mail.gmail.com>
 <fe86efbd-4e03-76c8-55cf-dabd33e85823@infradead.org>
In-Reply-To: <fe86efbd-4e03-76c8-55cf-dabd33e85823@infradead.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 26 Oct 2021 17:28:57 +0200
Message-ID: <CANiq72kVXwnP=BWkv-e_TcGBLj38hwKs4oWCtUxJPfvVr1Bd_Q@mail.gmail.com>
Subject: Re: [PATCH] coding-style.rst: trivial: fix location of driver model macros
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Trevor Woerner <twoerner@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 5:18 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> I think that we decided to stop using trivial@kernel.org for new patches
> a few months ago...

Ah, good to know, thanks! Then we should update submitting-patches.rst at least.

Cheers,
Miguel
