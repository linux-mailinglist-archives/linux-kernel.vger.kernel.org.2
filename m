Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC1432AA3D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581701AbhCBTQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839581AbhCBQh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 11:37:29 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EFAC061224
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 08:22:50 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id u4so24676378ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 08:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AVUi94v2adYwy7RTK4EUuLQhFzs/P3fEZsoBSwdym5Y=;
        b=EtaYBlxAIHK+NeOBvUphS86OaMQzBpEW5eYh/BZJuZKpU7FLfoVhtXL1GrQd0GBedP
         QGEJrK4aYR217xO9L2x8sOOdtxSzt4ln62udC0QHTs3YZY0m1jKKZmSUnSdeYrvP4H6x
         oO06YfcgXDCHuSXG2oBChJoMdYBeSD6ncq13zXsaQ226IUK6F9xgN1nRV55UaU4zC6Jm
         XFr659eFGIJ4UnPu0m1YNJYUoZEH6C1I9q0fY2IGAOm+BO80XbZcN2RjIHZiZA6862XA
         toInP+9Xt+ukzWpTrnqHcpMhvY+y64hCgH/dhnnEiJlIf02dNlfvA0ydOczJHvnGb8/i
         o/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AVUi94v2adYwy7RTK4EUuLQhFzs/P3fEZsoBSwdym5Y=;
        b=VydIwofz7U716sNCHKJHgUYnZl2ehs2kDg8IDoTQgnuzo7dhplhJPb7SME4NI+BpLU
         D+bl+i1UbRKaeJrBYUXdRoji6OCW+yt378WxGkYQk1zGkxNVJqBCLMAmITK0W37PKGaz
         JbF37g2J1kLJZ2WBVk5ECRL9XaJHRonp64KPUmRGOtQc16P0UWh4w3R7J0pgE6SUSlIo
         TcUSyMWzfds4bK+SZP2K5mZF3JROrzgmbv9sr67Hh5t/li68J8FmtIyClvbZ0n8tnT7C
         7ETNqViOnaGGQa9mcVFM5iV15++S5MrU1LG2AT62cqen9hAg/yE9/qKXnBHvsfdyPEGL
         m/lA==
X-Gm-Message-State: AOAM5323cwsm328wlB/0CL00YPlxhzVP66l2FPmWZIVeR3KLrG5GmnwS
        rMZFB+xY0m4meyTTuisbmpqz2KEOGLWzpRj4oaSntA==
X-Google-Smtp-Source: ABdhPJykfAKuVTLldb3ZHBxyclmDjR3dvOrGSPnjfMXdnx39tDzL5Bcqx+6F5YCO+j4PUJrLyW1IWzGHw6ke9NponmI=
X-Received: by 2002:a2e:864a:: with SMTP id i10mr12045661ljj.467.1614702169044;
 Tue, 02 Mar 2021 08:22:49 -0800 (PST)
MIME-Version: 1.0
References: <20210212223015.727608-1-drew@beagleboard.org> <20210212223015.727608-2-drew@beagleboard.org>
 <CACRpkdb1-OqZU93nMD+iztPOfLEn3-j+-=uTEo+zbE2TmezmLQ@mail.gmail.com> <CAHp75Vcvo8v-emHJZ+9fiTg+Vv26Apotnm8nD8rF550VgY-5gQ@mail.gmail.com>
In-Reply-To: <CAHp75Vcvo8v-emHJZ+9fiTg+Vv26Apotnm8nD8rF550VgY-5gQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 17:22:37 +0100
Message-ID: <CACRpkda8rn94ks+aduvVqQuR4LLEZEKT2ja6rrk8sk_bDNSTRQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] pinctrl: use to octal permissions for debugfs files
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Drew Fustini <drew@beagleboard.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 11:23 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Mar 2, 2021 at 10:36 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> > Patch applied, thanks for fixing this!
>
> I guess we are at v9 of this.

Yeah I took it out again waiting for the waters to settle.

Yours,
Linus Walleij
