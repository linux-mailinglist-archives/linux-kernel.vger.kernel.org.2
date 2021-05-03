Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D34372061
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 21:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhECT2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 15:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhECT2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 15:28:13 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCAEC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 12:27:19 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l22so8188420ljc.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 12:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v5+rXtfYwt5hA3eVlBgy6ypO0la6kLZqFvjAuXbEY2Q=;
        b=hvAa0s4YtClyTcUl4el7UKtwkSYEgd2BPYWxTetXd5cwBHCoJzJPMy/BfwQZ/dWe0D
         b7l1Tb6pE6j39sbeSBwyIMRbNetK1cZonLR/5obZ+66wSodsu93ph915v4YpbICZJzFg
         UGL3LjGbVaym+KekpEp35y5qPOkOddCwIBhJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5+rXtfYwt5hA3eVlBgy6ypO0la6kLZqFvjAuXbEY2Q=;
        b=GvCa2Ja1Uk6O0CoD8SH8YArose1q4YTtNv6TwTsHyrXLn+BWEB6nqOOnl4kbeS7YnH
         gHkmh5UR3rt2W7S+hLXVMzhjNx2ApDn7fwwlX8SA3pRScQu7KBU+htnqDZQsf+2G0WCh
         DRN40Zugn7tRComqrQJjM6fEyMadu0ubxjwXxNUDamLrXxOGu6eLeq39QqRII0e1coMy
         tew+2+kDsAj38tnEtsqyr84Vt/t1QvKD1A2eBZcVa6elDFojCrQa7VSX6RgPouSdoewb
         gTehGNIC70h4LAAeibUwfsYY/oVh8TkkTxapimpqs6liIl8IGjtY6cOGtmtWXP2CtwsW
         G6tQ==
X-Gm-Message-State: AOAM531zCrIpyihJBuNW4nMNmZzYxY+D9Ffn1SLHaoGpiYmjWLz7j7v0
        Eg59MTpBFlZyHD/4E6vloH2PkHDzZYDKPfCmvPw=
X-Google-Smtp-Source: ABdhPJwsM1OFAH1yMfCsAPzCZB8RpLrPgMsmGo7IB7/fkeoBl6q8DzVbCrsgDYezTHUYZliY9/hYmQ==
X-Received: by 2002:a2e:8449:: with SMTP id u9mr14594018ljh.370.1620070037427;
        Mon, 03 May 2021 12:27:17 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id g15sm46724lfj.197.2021.05.03.12.27.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 12:27:16 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id t11so8224324lfl.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 12:27:16 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr4581761lfs.377.1620070036091;
 Mon, 03 May 2021 12:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210502220519.GA24775@duo.ucw.cz>
In-Reply-To: <20210502220519.GA24775@duo.ucw.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 May 2021 12:27:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0Cvmxk58f0waakTKo8G5wPWarVw5b2=11f35vBAOYUw@mail.gmail.com>
Message-ID: <CAHk-=wg0Cvmxk58f0waakTKo8G5wPWarVw5b2=11f35vBAOYUw@mail.gmail.com>
Subject: Re: [GIT PULL] LEDs changes for v5.13-rc1
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 2, 2021 at 3:05 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> This modifies MAINTAINER's file to remove Dan Murphy's email that is
> bouncing (and does it globally). I hope that does not conflict too badly.

Well, it caused conflicts, but it's not like they were hard to resolve.

In fact, the resolution was to ignore your changes, because those
email addresses had been removed by the other branches I already
merged, so they were gone even before your merge (and the conflicts
were just due to other changes around it)

                 Linus
