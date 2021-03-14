Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CBA33A886
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 23:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhCNW1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 18:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhCNW1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 18:27:31 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9175CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 15:27:30 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d3so53868543lfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 15:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=B69M3JrCEK0ya5ntUI5LNlXrDKtrw/fgg/okJWI4ryk=;
        b=dkoNba7KerQRJQcdc97z/uuWckglfnP1GOLcQlHwIFSehdohiKA9jrA320k3Dws9kx
         0W2df5bj6OlU1TE3c1RKxml6QUhgN1i3Tv+OWyjnXDekZ4aa8Sj5842/uwcYjonuIdNJ
         PsKLr3v69sTzA8HOrpAuEQfd0ItIPXxlo1EO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=B69M3JrCEK0ya5ntUI5LNlXrDKtrw/fgg/okJWI4ryk=;
        b=e9ObgJOaz39eWEHDmMyyFwvh3H6eXgh2OWr7DtUor/aPz0HC0F1B46vRXVR5TAzOC+
         kiNb6PiC+jDOTxNYAxvRMsTJpaEILEhj6bLExp/1DHsxzgS4bQCCAjvEA8OAZ3vV+/0C
         HQIDnR8RbfcShINxXG2ef5BHqkodfKUNz1AD7riFRpxpeMI7TU+sgP0Y1fr3z2vmNkGN
         ILWrhVndKwW7Fg2dR7iNKkpZIFS8Zkj7Hhd4KoRTiID0tmSUsvfMuUeGvxVyBwHWAD6C
         fpsyz8LCLsCLYNsR2CXQY8Ub7GZKggOXEHlPIodkv3kHzZnvaN2Wvy0KUJMnIbiShBX7
         RB9A==
X-Gm-Message-State: AOAM533dI3WWhguuxhLdyUDW1rDO8a9ErJp/Ores3ZcuceObkpQf1+2+
        dKTC0GVexHmrP/YbQ+STuKIFLqLXENxnEg==
X-Google-Smtp-Source: ABdhPJxIVLWus0n1VaddGKLrF7uu/6zOhrDQxci0QpyOZErKRgwPnxQLfSOJRmKF0wSSTfBuxQPKMw==
X-Received: by 2002:a05:6512:1195:: with SMTP id g21mr5880911lfr.512.1615760848077;
        Sun, 14 Mar 2021 15:27:28 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id n205sm2452399lfd.297.2021.03.14.15.27.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Mar 2021 15:27:27 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id n16so53979557lfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 15:27:27 -0700 (PDT)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr5867589lfu.40.1615760847110;
 Sun, 14 Mar 2021 15:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgAr4Z2deEQs+5L6bJb68FouwBZUSURh+m-47TBnEsGZg@mail.gmail.com>
In-Reply-To: <CAHk-=wgAr4Z2deEQs+5L6bJb68FouwBZUSURh+m-47TBnEsGZg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Mar 2021 15:27:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHX0SBy_RhbgkWETc_pxi8Gr7kmU72QE3jkRJieHuEPw@mail.gmail.com>
Message-ID: <CAHk-=wiHX0SBy_RhbgkWETc_pxi8Gr7kmU72QE3jkRJieHuEPw@mail.gmail.com>
Subject: Re: Linux 5.12-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 3:00 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So rc3 is pretty big this time around, [..]

Oh, and I had planned to mention the historical note that goes along
with today's date, but then entirely forgot.

Some people think today is =CF=80-day because of odd US date formatting.
But as any true kernel geek knows, March 14 is actually much more
important than that. It's the anniversary of the Linux 1.0 release
announcement.

No, it's not some nice round number this year - the 1.0 release
happened in 1994, 27 years ago today.

And it's arguably a much less interesting release than the _first_
Linux kernel release of 0.01, which _will_ have a nice round age of 30
years later this year.

But still. I should have remembered to mention that minor historical
significance of this date in the rc3 announcement.

           Linus
