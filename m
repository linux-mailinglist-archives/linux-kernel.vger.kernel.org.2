Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8F831A97F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 02:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhBMB3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 20:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhBMB3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 20:29:37 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ADDC061756
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:28:57 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id b16so1165884lji.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CiqXRmojC4JwBHhoVk4DYTWwIEbtC25jfG/VbdzJc2Y=;
        b=AVywlp9EKlBrA8lARvxt1258Gw3mHl0ZnHD9XiNJzUvYfdkbG+QmOVQLlbsKR61LjF
         sY1meUqr3pjxgqJuzwwqAjhmF30pGYmJAFlE9ANktxg9lxd24G8n9Z8uAsPu94c6CPFf
         eIiws2pR5nz43eMT/uYQnZ2lVgVYzWs6pmB24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CiqXRmojC4JwBHhoVk4DYTWwIEbtC25jfG/VbdzJc2Y=;
        b=himPlMPV551Fkcp1zVXwXcyc54H84k0cKjsqAiPQkqkcvWHCa9BulOyp2fq3hx9A71
         gHACFz7sDVfayuRliPPUk5t3Ja4JWhcXfnB8GWw5xE1zxOKYeb9AJ9IDU1fxUc0eQ8yX
         Estns/5SG7sD4GJmwzrGBzBb7s0rDkluOXQdr1Gy/uK6zncpTxqXjjMVB4Qg0ichb9YN
         Zy35mUeOcqxydybWIBPd/c7TVByaZrn2+tCl3NP5UV0AyMWAP4wStxH+ssb37bvlDK89
         IqHs5lRHt8NDPPi78AgNj5IEQtcOfrvoH25ez0ll+hdLowui0snD+Gr2as/fYDlyBlRt
         FnMQ==
X-Gm-Message-State: AOAM5320ne6O5jf5DDfWUMPcwjnwAIwdYLTpbaxt31dHoRtJFRH452EI
        S/olOULPQJNfwJqLrjDCXr/l0GdEQHqPzg==
X-Google-Smtp-Source: ABdhPJzx+RdNPWCRzpePD8Gru3ZaTNHJcXwvx8NSCIL7x1nRn6Wg3qIA86gz5cAMUQYI3Ewg3SEgEQ==
X-Received: by 2002:a2e:7a05:: with SMTP id v5mr3060609ljc.402.1613179735321;
        Fri, 12 Feb 2021 17:28:55 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id p14sm1846646ljg.103.2021.02.12.17.28.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 17:28:54 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id f1so2120666lfu.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:28:53 -0800 (PST)
X-Received: by 2002:a19:7f44:: with SMTP id a65mr2786768lfd.41.1613179733615;
 Fri, 12 Feb 2021 17:28:53 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mtYEj+WLy+oPSXEwS5sZ8+TNk_dU3PVx3ieBz2DFS94Sg@mail.gmail.com>
 <CAHk-=wja1Y8r5UKrmXcMFrS=VPkTPbkyK-vt8B9MBkEU4+-WLw@mail.gmail.com>
 <CAH2r5mtj+-xGDy-YN0JwSJAsgvB+HpQFCBi-zdTNXTRBY_Mteg@mail.gmail.com>
 <592ad76a-866e-f932-5a82-1af4a2ba4880@samba.org> <CAHk-=wh8n15NOcHkuxD=rXnMZCcsYD316JjRDdHUFwcFi8vq6g@mail.gmail.com>
 <cb3740c6-6413-8411-e141-798e9dadc6d1@samba.org>
In-Reply-To: <cb3740c6-6413-8411-e141-798e9dadc6d1@samba.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Feb 2021 17:28:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=whOXR8ha7Zjzn2UPM8Ka-X1VSY7R07Pv-Fxeb3iKjKK3A@mail.gmail.com>
Message-ID: <CAHk-=whOXR8ha7Zjzn2UPM8Ka-X1VSY7R07Pv-Fxeb3iKjKK3A@mail.gmail.com>
Subject: Re: [GIT PULL] cifs fixes
To:     Stefan Metzmacher <metze@samba.org>
Cc:     Steve French <smfrench@gmail.com>,
        =?UTF-8?B?QmrDtnJuIEpBQ0tF?= <bjacke@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 5:08 PM Stefan Metzmacher <metze@samba.org> wrote:
>
> > Zen 2 seems to have fixed things (knock wood - it's certainly working
> > for me), But many people obviously never saw any issues with Zen 1
> > either.
>
> Do you know about the Zen3 status, I was thinking to replace the system
> by this one with AMD Ryzen 9 5950X:

I have heard nothing but good things about Zen3 so far (apart from
apparently people complaining about availability), but it's only been
out a few months, so obviously coverage is somewhat limited.

I wish AMD hadn't decimated their Linux team (several years ago), and
they definitely had some embarrassing issues early on with Zen (apart
from the Zen 1 stability issues, they've screwed up rdrand at least
three times, iirc). But I've yet to hear of any Zen 3 issues, and I
suspect I'll upgrade when Threadripper comes out (I've become quite
spoiled by the build speeds of my Threadripper 3970X - the only thing
I miss is the better 'perf' support from Intel PEBS).

Note that I'm not necessarily the person who would hear about any
issues first, though, so take the above with a pinch of salt.

       Linus
