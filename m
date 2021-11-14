Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C64E44FB51
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 20:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbhKNTvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 14:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236959AbhKNTtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 14:49:19 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02F2C061207
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 11:44:27 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b15so61853672edd.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 11:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zhbWqnuppc9VHvw+T3sw7eqZTs709xUitHO7OSRR3cA=;
        b=RwkFiKJYladEGPysc3XBrcV7nziE7tUOkzLFggYNkVMZ1jil+kZIz9CYu5Kf9OFvL3
         Id17PglUQHb26nyeroZEeodszlRGrMRBGNjni6wK+2S6C+OHC8hcMgVjr5mAywX/iJN5
         Y/+LbD/jVkSN1IM4toWOl9TqTHR3cFxKvLvzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zhbWqnuppc9VHvw+T3sw7eqZTs709xUitHO7OSRR3cA=;
        b=xV+K0aWChRLr/BRb88jCT+BsUj3eHPaf6UW+Roefq+zEeauDeqXPfTOr7OCpprS8t3
         9E0NaIdiEYk5HnTj/yjt7vGsftdDdPm+fbIBgdOBtTCDYyU0q0XT5TGwfbexSoo/icx4
         NLY9DNTi7VLw+bxr+PwiOvG5qugEJ9Lm/7L2EOjHy75yPHaYR8yInkL0WClw8wHR+uZm
         q9y7JgzHNgJZiIlyUFiIJcRHDb4VbL+QU3nPrUqrmmbq2Au/DlQx+1pbIUluNVsJyvTi
         uelnvwXLlW4LV8Z+Z0WsXIAkHJeddmjQ+YbE2No+V/qmPXoLO1p+lqccucyH3bOOxEPz
         IrXA==
X-Gm-Message-State: AOAM531ODfglLEHswiiF2Q4bi25IUnIA7vSfEkazvGRLQoIgJ2NGFE9O
        DLbynYjJlTY3DMMDqswPhT62VUEVI2K4DjwLM0Q=
X-Google-Smtp-Source: ABdhPJz1PccS1FQ3rxVzB31f7f4oNnpHFhsUnfQ0cxDIontQwo8cFN7ldHJuwZty6r6QQlrNe9WQOw==
X-Received: by 2002:a05:6402:1e95:: with SMTP id f21mr11654281edf.139.1636919065647;
        Sun, 14 Nov 2021 11:44:25 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id i22sm6070329edu.93.2021.11.14.11.44.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 11:44:24 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id d5so26338478wrc.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 11:44:24 -0800 (PST)
X-Received: by 2002:a5d:50c6:: with SMTP id f6mr40526435wrt.131.1636919064600;
 Sun, 14 Nov 2021 11:44:24 -0800 (PST)
MIME-Version: 1.0
References: <20211114185302.GA13363@brightrain.aerifal.cx>
In-Reply-To: <20211114185302.GA13363@brightrain.aerifal.cx>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Nov 2021 11:44:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjro+9wzY=Po2PC3JHjUoaYegtOVaQmAdEufa4fo2aedg@mail.gmail.com>
Message-ID: <CAHk-=wjro+9wzY=Po2PC3JHjUoaYegtOVaQmAdEufa4fo2aedg@mail.gmail.com>
Subject: Re: [PULL] arch/sh updates for 5.16
To:     Rich Felker <dalias@libc.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 10:53 AM Rich Felker <dalias@libc.org> wrote:
>
> arch/sh updates for 5.16

I realize the answer this time is basically just "random fixes", but
even in that case I'd actually prefer to hear it spelled out what the
pull request actually contains.

I've pulled it, but please do give some indication of what has been
going on in sh land next time, ok?

                   Linus
