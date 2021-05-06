Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A709375D48
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 00:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhEFW6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 18:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhEFW6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 18:58:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53FFC061761
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 15:57:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r9so10697295ejj.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 15:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uLdKGXmtZv4WOuhm8GJ7l80lpB4+OjgqxObqMF2doJs=;
        b=olQg5p0yjDBdujSQAJeptHdz7B978JcsgXB9UIBSNoFK5KCqy+qN+4Gt+hKbnHJwK7
         GQfwYyNIi+Uz3YrbHHF+nj3Dc3XdPffsmjkoXLl1kkaeV7EzetPFMjTizg05TSYSzviW
         s47efjQQhDT3RVUekS5jUEIQc35IBuFDtzc/gfDS5ohqqYZ3uSeMvQGKsdnK1MIdH/Tm
         NFFKYdsLhUflgltsCMpTX/lDAFz+3Y+N1sQW4axEkG5HTyEVhuOh8goZ6/WXevnPsXsx
         Sgy5PpKo2vSWRC559RcC0O8QgK7UXvUvTtQn1/hUaEMWBnyXkOIyXIsXuAtw6F+vQmOe
         H61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uLdKGXmtZv4WOuhm8GJ7l80lpB4+OjgqxObqMF2doJs=;
        b=s613Wxy4ktVhnpQQc7xON0QQ5XuUkHBPI7baYM7J6rN55LbI8kM7P9rE9RyJxSGpMs
         g0xIypPkX0bqy1EfVQLB2t6jzD7qMPRXnLN7xZUjGKcKBvuDluQ5dn4pPIm16UZrdbtC
         Y/eijcHrmhAa0XtOhoLVSOwEeF/wtXzjrmTXihMOgfnsknmIOXGkAGJ6xxx8/mWSqngP
         RojQA+BrY8uqi/IPElv2h+GvKc0Fbid0LFf7xz75XEZsxotcZHCMXZjFhAoauw66cfDT
         qGfgeOMnAM04B8s/W+SaZ2igmQrWxvmGfkTHlGMayNy0le1AespyrL9ey6cD65hY9BAA
         /e/g==
X-Gm-Message-State: AOAM5305ErhXWawRnTp+VZ2XLOGZfgH+qKBFFnmlQ3Og9juUnQhyX1VP
        rdaR1PlSq/7ZPcOdKQRuHv10NpbRyzPkaQByrk2HzA==
X-Google-Smtp-Source: ABdhPJx6sMOvb6H5iHbspfXj0fUHVG8/SxmDU8i4ZBrPKGpv38LFo9MPmmLJUfQXrmER+EiMNK2dVF1dMoWrHOgOKTs=
X-Received: by 2002:a17:906:4a55:: with SMTP id a21mr6616986ejv.215.1620341833273;
 Thu, 06 May 2021 15:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210506180530.3418576-1-wdu@google.com> <cc2f068d6c82d12de920b19270c6f42dfcabfd11.camel@sipsolutions.net>
 <CAD-gUuCt5ugOyo-9Ge5omTgNJu26OORZFEZ2tSnQEiNLZN9ZyA@mail.gmail.com> <285a8ab279d5ac6caa6e44d808ec2b0ae134bc1e.camel@sipsolutions.net>
In-Reply-To: <285a8ab279d5ac6caa6e44d808ec2b0ae134bc1e.camel@sipsolutions.net>
From:   Weilun Du <wdu@google.com>
Date:   Thu, 6 May 2021 15:57:02 -0700
Message-ID: <CAD-gUuAbgons-j_q5TiqjP5ekRtk5cStfi7eLvH8D94WoC4zCQ@mail.gmail.com>
Subject: Re: [PATCH v1] mac80211_hwsim: add concurrent channels scanning
 support over virtio
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, kernel-team@android.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 2:13 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Thu, 2021-05-06 at 14:11 -0700, Weilun Du wrote:
> > On Thu, May 6, 2021 at 11:19 AM Johannes Berg <johannes@sipsolutions.net> wrote:
> > >
> > > On Thu, 2021-05-06 at 11:05 -0700, Weilun Du wrote:
> > > > This fixed the crash when setting channels to 2 or more when
> > > > communicating over virtio.
> > >
> > > Interesting, I thought I was probably the only user of virtio? :)
> > >
> > > johannes
> > >
> > Hi Johannes,
> > Actually, Android Emulator uses mac80211_hwsim for wifi simulation
> > over virtio and it's working. This patch fixed the crash when we set
> > channels=2 to speed up scanning. I am trying to see if it makes sense
> > to upstream this patch since it's not Android-specific. Thanks!
> >
> Oh sure, I'll take a look and will probably apply it for the next cycle,
> haven't done an in-depth review. I was just surprised somebody actually
> *used* the virtio thing :-)
>
> Does that mean virt_wifi isn't used anymore by the Android emulator?
> Maybe then we should remove that again, it had some obscure bugs that
> syzkaller found? Not that I mind it being around much, but ...
>
> johannes
>

Thanks for looking into it. Actually, virt_wifi is still in use. There
are two different emulators that target different use cases. Android
emulator (goldfish) is mainly for third-party app developers. But yes
eventually, we are going to converge the Wi-Fi solution.
