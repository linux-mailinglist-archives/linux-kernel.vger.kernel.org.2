Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50E943B2A7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 14:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbhJZMtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 08:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbhJZMts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 08:49:48 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE868C061745;
        Tue, 26 Oct 2021 05:47:24 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id d63so1714200iof.4;
        Tue, 26 Oct 2021 05:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7NLWp1PQuPQBU42w6JvrH30tXoeFvkc29kFnDrFNYOk=;
        b=Nc0qMYVwQTcPLG8wjD4/lTLFY0dj327pTx3c5x3kPqOfC4chJF+mBN+N7lU1WnJHWo
         HRT92StwbjlzLqyg8biZpE940+tinnZGv5+5EAKII9HlAE//O0uau/Wea1TN06pcM/wq
         0X0o8CLrj1KPAbrZtUwIGeSPocGpSPEnPidXZ32naVEGatfZwkkjrysU0nIy+qwFFzo+
         dZtNaFka7v3KXgP5PU32GGUjm5nqec4Kscym3LoojXrPibcKFan5ycj+CU7VMni9nxyW
         wwTkoNd6QCt3jBofhjEFTngqWmfJG+7re1UOyyS8/mOyXlfQb9AAvJBLMs8v/PiXyCTC
         PtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7NLWp1PQuPQBU42w6JvrH30tXoeFvkc29kFnDrFNYOk=;
        b=LXpEa7IPdjHNj4DlOxvTAXDzDy/Do5CMMmRoToNhyj0LddEPd0eE089s0Ue+dXrnb4
         EJ/9MSiDqXyXqJNIRufFqXbrlADJdHV3k+qVRI3FpK52bWYJ1uuwhR0aMEukLqsg+K3g
         ff6sUQMTWMrOV2o+23hCsJ8g8AM6suVShVxTQ8QV4KZELNp2LXXViiS6oqZre53ok6wi
         RV4QHx432Dcsl93gY7qv7HoTQ0CQGa5z5JkhdypBFe6fFcxOBMjHVzRXLFcuuTQ74NM+
         6C7pe3ZRUi1SVezD2hLENlZZY/yWiUTerdvYe6PYjPwOdDfmeYQqBvvtIhfqJb+iIL6l
         SLGA==
X-Gm-Message-State: AOAM530xGUbrVws4JVGe10KCTWKXiKhfkmKwE6rH/gZuCop5AyHTnZrQ
        abQ/9erW1xqIRGLPkLWV2Ph8k/A2MXrVt/kSt4I=
X-Google-Smtp-Source: ABdhPJza0KBvOGtU8MfImRfHuqYiCFyQyWH0DxYaiZiIz1jbOGh7WDNmCXzMXLTqussoYip0FhGwBefIdsmCYIJI5M0=
X-Received: by 2002:a6b:e50f:: with SMTP id y15mr511808ioc.177.1635252444310;
 Tue, 26 Oct 2021 05:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210423184012.39300-1-twoerner@gmail.com> <CANiq72mUBh+76iy5uCAGHpKHDnTGRVyQduMngEWDMCF6kRySJA@mail.gmail.com>
 <CAHUNapQfFBcqrX7MvUvq8qbPgk2bPu-h3+9NxAUFpRtpOGFODw@mail.gmail.com>
In-Reply-To: <CAHUNapQfFBcqrX7MvUvq8qbPgk2bPu-h3+9NxAUFpRtpOGFODw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 26 Oct 2021 14:47:12 +0200
Message-ID: <CANiq72=iDhHiFKBzud6sj6reCS=pEYxFn5x4b=VfNLMxva-RuA@mail.gmail.com>
Subject: Re: [PATCH] coding-style.rst: trivial: fix location of driver model macros
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Trevor Woerner <twoerner@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
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

On Mon, Oct 25, 2021 at 11:40 PM Trevor Woerner <twoerner@gmail.com> wrote:
>
> ping?
>
> It doesn't look like this was picked up by trivial? Although, it doesn't look like git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git has been used in a while. Is there an alternate (preferred) path for trivial patches?

Jonathan should be able to take it, or perhaps Andrew.

Note that you should put whoever should take it in the To field (I
just noticed your original email did not) -- use
`scripts/get_maintainer.pl` for getting the relevant people for a
patch or path.

Cheers,
Miguel
