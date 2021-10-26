Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359E743B52A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhJZPNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbhJZPNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:13:10 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E5FC061745;
        Tue, 26 Oct 2021 08:10:46 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id o184so20918668iof.6;
        Tue, 26 Oct 2021 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=leS0/NaaYLKtfLrdxPy4xO2Kdcc++8pSTs9bmAMcg3U=;
        b=eta4hMz9pfoCRtNg/nwYnCVrFsB3FdaaWIkrWuiuo0obFPbdUd2DjZsWQfv81mWidj
         EGWvd8FqFxqymeuhGRN1KHZIW8x+kijSmcW3KAOfvtK8wSLVH3bOoQUY+4p1HAgNV8+R
         ZphsXErJauZn2wzzvyA3c50DmSthOXUJ30Hvfhxsoo9P8PI9R1WWLH+uffPq2a8fzilU
         cBrWEaDNn3owFPey3Y32FVX0Hs+AnPEl9701pR2S4N95DjvjrGRZ2hsT907M6djE4igD
         qNGMQS1nAMe8JFhI/JV+u+NFr3tlYA9mEqQdWE2HnBWHz7vvdJ9FTyxs27NwsatqYT6K
         u1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=leS0/NaaYLKtfLrdxPy4xO2Kdcc++8pSTs9bmAMcg3U=;
        b=J6kA5XN+aQbDLMOUdxtaD/rHSyp9ccEqwvT+r4/8T1eVdjspSmJ0sMOeHX0FWIFmYr
         jfAc/qSmMlrKYhYlB0rkoCISfvjwVcH8srYEXIntg7dMTKbKbyp5CfgeAcs1iXI8D7kq
         TcOGuZdlZNX2aWx3/JIh1Yo5/9bnuKTDASgHeb7JM7u93WBK7iwpv8Wj8NrK7jR60IeX
         tyPjeAnCyIK41l4iEA4HErzx0/7+BBfNyDiK8lln2SrIXQ/E4CytAeUhusKLOz3B6FM6
         ZxRzPfQTdTLoSMUDRgUaJwhxMpAL6EdIjuCBfeZF6LGwNllYukDKIzLAwDtzK/E1ckHN
         p42Q==
X-Gm-Message-State: AOAM532XnJ9EnFPura7J8nsx2Ql98mpnobUfwa5S8Z/3LSKJztn50qbh
        UYwnoS6RuR6IghvN6amBHgSBQII6RYLBwwD8gO0=
X-Google-Smtp-Source: ABdhPJwWbLtW3CT7cBcX4C+TiLUAsmbALUd0+piWbeflsgxf+SHLX+uMRf/ch3Ap1o24Pe/h9qvcBp7QJYtnHFpelwk=
X-Received: by 2002:a05:6602:2d4e:: with SMTP id d14mr16054823iow.172.1635261045995;
 Tue, 26 Oct 2021 08:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210423184012.39300-1-twoerner@gmail.com> <CANiq72mUBh+76iy5uCAGHpKHDnTGRVyQduMngEWDMCF6kRySJA@mail.gmail.com>
 <CAHUNapQfFBcqrX7MvUvq8qbPgk2bPu-h3+9NxAUFpRtpOGFODw@mail.gmail.com>
 <CANiq72=iDhHiFKBzud6sj6reCS=pEYxFn5x4b=VfNLMxva-RuA@mail.gmail.com> <20211026144452.GA40651@localhost>
In-Reply-To: <20211026144452.GA40651@localhost>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 26 Oct 2021 17:10:34 +0200
Message-ID: <CANiq72kf0QZUeO+=U67NLs=WXc=sEtasdv_yaZ5sZedNmzzJBw@mail.gmail.com>
Subject: Re: [PATCH] coding-style.rst: trivial: fix location of driver model macros
To:     Trevor Woerner <twoerner@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 4:44 PM Trevor Woerner <twoerner@gmail.com> wrote:
>
> get_maintainer.pl didn't add Andrew back then on my patch and still doesn't
> even now. Maybe the MAINTAINERS file needs an update if Andrew is to be
> included on trivial/documentation patches?

I mentioned Andrew because he does the hard job of being a backup for
everything and everyone, but normally you should try to put the actual
maintainer first in the `To` field and/or trivial@kernel.org.

Cheers,
Miguel
