Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18349363794
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 22:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhDRUhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 16:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhDRUhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 16:37:00 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA58C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 13:36:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z13so35735727lfd.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 13:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+njT44QYZ3Qq5BMIpyAraB9HjcJytfPjL+0P2G7goO4=;
        b=H5jpOUO2avviyFm4AO16gHz1ThurZ5Sr2spjH3XfrubjfbM+bL3kDD3IFgWVQjuLZ8
         dL1xkh5BT25R0YBpi3tOiYULQ92WKPw8x9uHKG1XtjRnhClzw1FUzf8p7co5UTzmWip4
         8crxUP1Jigs0m9lW0LddAxJBZNmxofFj4Br6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+njT44QYZ3Qq5BMIpyAraB9HjcJytfPjL+0P2G7goO4=;
        b=IG5fbuLCTCIPfmFrUuG60GTl49fB/VhcYozER6vK1Xfn+RwFIvUB9kihxG1xBnwpdb
         ggyR4LUo681q7HwI1LU9WQwMX97euUfERZg06QNUmS5DgeZo/xdpQ7hOVLOOKcQ2IxkL
         beodWIGJPGoYUw7Ng9OxJJFKe4CjmKW/bsbPE6mlzH0mYtF8N23qDdPfGpVvvJBNG58o
         pJkgIQFBy/BSw/J7PgGT3BrEZTPil3M4uO+AYDVBu8hsyFwfBM3EJoqvxwlkxDs5KLeT
         2lGCl2Ezk1LkB3a+SlB++21L+TR8ZBpPMJNZBM29s+7azsaJ366q9IWq0hR2kLDDY5Pi
         i3/Q==
X-Gm-Message-State: AOAM530uyvFohbZaSpRofht70LTIoAl9gX/IZeVBq/ic37RAPPLBUIfX
        Jj4fG2OsUAuv7fwQhwZVu009sybTh+z6tKto
X-Google-Smtp-Source: ABdhPJzpFdLmJTTeNPMWhC3jeAscyN+drlTQrQkIV2s9qcsSWV8RIt+XY/3e/zhbu/cejSfF15UK/Q==
X-Received: by 2002:a19:6906:: with SMTP id e6mr3454233lfc.514.1618778189550;
        Sun, 18 Apr 2021 13:36:29 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id z2sm935775ljz.116.2021.04.18.13.36.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Apr 2021 13:36:29 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 12so52593399lfq.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 13:36:28 -0700 (PDT)
X-Received: by 2002:a19:ca0d:: with SMTP id a13mr1019571lfg.253.1618778188783;
 Sun, 18 Apr 2021 13:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3h0QDvv-0yTVOMjx-8vUUcAFTQ6di71b2DwCELHNpPLw@mail.gmail.com>
 <CAK8P3a3oQm7P=Mj2xU=8v=g82mN-OXk7yrPmFMcK0XpMpwRctg@mail.gmail.com>
In-Reply-To: <CAK8P3a3oQm7P=Mj2xU=8v=g82mN-OXk7yrPmFMcK0XpMpwRctg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 18 Apr 2021 13:36:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNrFFVxF-9g1bjRZaG2OL4Big1_aKTMFyGagrhVNx2Kw@mail.gmail.com>
Message-ID: <CAHk-=wgNrFFVxF-9g1bjRZaG2OL4Big1_aKTMFyGagrhVNx2Kw@mail.gmail.com>
Subject: Re: [GIT PULL] Re: ARM SoC fixes for v5.12, part 2
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2021 at 12:24 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> I forgot to add the '[GIT PULL]' in the subject line, replying to myself
> here to ensure it hits the right email folder.

Well, the reply hit _my_ search criterion, but the pr-tracker-bot is a
bit more picky.

As a result, I don't think you'll get any automated reply from the bot.

So here's the manual one,

               Linus
