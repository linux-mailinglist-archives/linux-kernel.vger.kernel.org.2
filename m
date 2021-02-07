Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608C431267E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 18:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhBGRuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 12:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGRuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 12:50:18 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B932C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 09:49:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b2so18799677lfq.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 09:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rKILYpI3PDZZLQo46QELRQYDGmjmBPTZ+ke6OG3wj+g=;
        b=JjPN+LY2C2uyhXZ0GtU1rW4T/flfPNtwdwO85Gl1yztwYYTSt65Ku+sV7Id+UoMl46
         SlRryj4NNXdIdWH8sBsj7S76IYWDud1Anm/73ObDwgM89pDKfKvg8dS61hcW/yJH0/5Z
         2kq3/HvGZFCM/bTEBOr57Lgztr2XG2r1BAShU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rKILYpI3PDZZLQo46QELRQYDGmjmBPTZ+ke6OG3wj+g=;
        b=cmHKGHqmVh6JBWonikUHNrdhXvfXBqgc8ULfp+lROiz3Thd5JPoIMacQ9S18/JeK/T
         zhhpEg8E5W/B/lDY6czTYwShoJpCkuaOUsSgJzk6vbDPChRsoshKkVrICni7tUt08j3r
         ZqoRHH4IzqJpTzF1iS0lRYRfREI9v5jeCbkyDxtZvbRS3btP1ISH8ZYO0QO87hmw58VA
         1Js4QE8lcWMUb6f009URBw8WOAGo48MGwtiaSg5wsSYucyOW2cUyqwww3YMpTU2dgoUD
         xGbmatQmlnCwp2xMp+Fu+SNg6tHqMM/c+mjV6C+JdlG8F0+OYHi31He/ihiiR1Vs2x1w
         K6hA==
X-Gm-Message-State: AOAM531mBFzN0PX+eUg1K/vFeYFCcl68baMwjpthlDaMPmS2zng7akwx
        1A/6KgU1Fj/LIiUMm09DfICH1kVIciDSag==
X-Google-Smtp-Source: ABdhPJwPmDhRSp2OAf0/yQOzfmGT66CkBsCN1u1UrOGcHBCb3EvkHKjWBvkkQQTH/sBvRHKxLSesCw==
X-Received: by 2002:a05:6512:398e:: with SMTP id j14mr8704023lfu.9.1612720176307;
        Sun, 07 Feb 2021 09:49:36 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id h7sm1805376lfc.200.2021.02.07.09.49.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Feb 2021 09:49:35 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id y14so13971346ljn.8
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 09:49:35 -0800 (PST)
X-Received: by 2002:a2e:8590:: with SMTP id b16mr490129lji.507.1612720174886;
 Sun, 07 Feb 2021 09:49:34 -0800 (PST)
MIME-Version: 1.0
References: <20210207104022.GA32127@zn.tnic>
In-Reply-To: <20210207104022.GA32127@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Feb 2021 09:49:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=widXSyJ8W3vRrqO-zNP12A+odxg2J2_-oOUskz33wtfqA@mail.gmail.com>
Message-ID: <CAHk-=widXSyJ8W3vRrqO-zNP12A+odxg2J2_-oOUskz33wtfqA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/urgent for v5.11-rc7
To:     Borislav Petkov <bp@suse.de>, Steven Rostedt <rostedt@goodmis.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 7, 2021 at 2:40 AM Borislav Petkov <bp@suse.de> wrote:
>
> - Disable CET instrumentation in the kernel so that gcc doesn't add
> ENDBR64 to kernel code and thus confuse tracing.

So this is clearly the right thing to do for now, but I wonder if
people have a plan for actually enabling CET and endbr at cpl0 at some
point?

            Linus
