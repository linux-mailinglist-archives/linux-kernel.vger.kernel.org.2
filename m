Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB504565C4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 23:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhKRWiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 17:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhKRWiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 17:38:12 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BA0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 14:35:11 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y12so33813172eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 14:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZBU6+cbURpZDV9BAPXUh+IOmWj30m+ZuEEK4smtjlw=;
        b=EJu8ngEmdZeVBUAPLpkM0MmprwTN67VTGBHRJoYEZv/TljtaEEK7d6gZ3U4UAGbdXT
         wsLnsEdC7YnfOCBGndtpqHgqjTqu5rMCd55/nAqVy8+6vCSDbIYMQny1ZYbUUrgJJcQT
         qfOpJxzerM8Gmyr4J0mO3AM+9wZQBgxMNcRzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZBU6+cbURpZDV9BAPXUh+IOmWj30m+ZuEEK4smtjlw=;
        b=33NoFRBpTh3TO81c8w4JRdXYFGbzfCAYMPsJtfBwNYhck4srzZxABmps2Ucp/omvo8
         PUM+Bic1DCMrDYgJSX69/Lnt3Q0Pe3flN/fCxeGlBlrJNehXPd8kthip1rrRVHgHyZ+d
         VqL3fjZKT6X4ZHPQcE89+QqLYRIwGTTltcFuUBmJhmGFUxIuq5JwgagjHcbLNVtt0Q/w
         KXza3sahMMzShFNyWYoPIk3XFgqwm07oukT4eXPP2rO3hmWrBDXQZzFBGNBgfYqLkpl7
         01tMF56K1Fj8GMFuA0tzznC+rkZ30g7UCa+3OF2sBcWwEk83IpRHbSnR/BR0Vd+1gWuw
         kAYA==
X-Gm-Message-State: AOAM530/1dSHcDRXZ0NbOsktaDFUvtVE6a3E+MjpqZAWDgXQpSPorzEi
        fZeYxQVszuv1nH5le0JGM/S9joA2sDbzk/KW
X-Google-Smtp-Source: ABdhPJxFe6HcMG3yHblV9xNtDd1WC5eVU8u9eZ8g9im4W0KDbHe0yTzdS3IYDoVu2GzwcWXlaPYfNw==
X-Received: by 2002:a05:6402:1e93:: with SMTP id f19mr16890913edf.60.1637274909715;
        Thu, 18 Nov 2021 14:35:09 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id u10sm591089edo.16.2021.11.18.14.35.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 14:35:08 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id d5so14507542wrc.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 14:35:08 -0800 (PST)
X-Received: by 2002:adf:d082:: with SMTP id y2mr1247846wrh.214.1637274907927;
 Thu, 18 Nov 2021 14:35:07 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjF=JzLkCi2wV+G=f8OWa5rNjPsZd2RMFG5MHwKZPgYvw@mail.gmail.com>
 <20211115045616.GA1012538@roeck-us.net> <CAHk-=whca4JrEExUZCf+iGhP+mV-_D2uyqiFHnaYqnfCOKyEVg@mail.gmail.com>
 <652edea7-28a0-70d9-c63f-d910b5942454@roeck-us.net> <87a6i4miwu.fsf@mpe.ellerman.id.au>
 <CAMuHMdVrpQJKKzpxrKKCCD_2+DzAvgFW+jsjPdR9JhBYeRgvNw@mail.gmail.com>
 <8D79B547-D606-4975-A79A-AEA65684F3A0@tuxera.com> <CAHk-=wgvzH=BaFg+kiWk1DXGLNELSmPS2VWcgSSmW5Y6vz-v_A@mail.gmail.com>
 <E1EED1BE-A0F0-4EFA-86A6-CF721E194CDC@tuxera.com> <CAHk-=wjoQYuOfhsiPXUvFbUbSd5iHmmoRHMP+zv+bzHKkWqAyA@mail.gmail.com>
 <20211118212349.GA3424901@roeck-us.net>
In-Reply-To: <20211118212349.GA3424901@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Nov 2021 14:34:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiNX2vr4JA=d5xr_2iwp+vSD62rze3gsxh5NwbiRuKbQQ@mail.gmail.com>
Message-ID: <CAHk-=wiNX2vr4JA=d5xr_2iwp+vSD62rze3gsxh5NwbiRuKbQQ@mail.gmail.com>
Subject: Re: Linux 5.16-rc1
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 1:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Like this ?

Ugh. Yes. Like that.

But now I have to go dig my eyes out with a rusty spoon and try to
forget I ever saw that thing.

Because a thing of beauty it ain't.

I would still hope somebody comes up with something prettier.

          Linus
