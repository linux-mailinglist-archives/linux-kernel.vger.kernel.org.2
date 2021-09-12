Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4A8407FD0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 21:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbhILT53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 15:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbhILT52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 15:57:28 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ABAC061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:56:13 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id k13so16398071lfv.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0JrZ+GcsRiXZedFUkepLcXeLWeQiUelfJ9m4RLoEZFU=;
        b=XawmD5eAfkLOxVAdIF1rhrNfsxN0xrqcFF+jMcPdY7tk1j7DB5eKFVwRl3JaxKbJZI
         WWsUuCYVz/l9No4NyZv0MEU4GLsBgv+TMurdoY+UDl0AqC5YtbPe6zN+4Nxh4+xZ87MA
         o2DuQ9sQS7S24/9EPeCAbJRvaV3/792icfSOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0JrZ+GcsRiXZedFUkepLcXeLWeQiUelfJ9m4RLoEZFU=;
        b=pYv2m5H/FAWCFT0yHhMYD589v5YdXjiQ/CcWBjGB2WsZyjyergMgYHuVfmKxyPnR5Z
         cHtnRNnwgO3r1sMC/QBKl0I6pUq44qWzaw5aVBkvwKT/M+mbIrOkyiRoEZx4vQE1RIQl
         MXNol7Hwm6goF2zkiuZ6osqzkutQ7VLg5LmRA0VlGrN1SYupfU7LTtD2BdqqiSPaEygV
         IKB3csCxFdModHK400QnIu70mgyEORWgveVnUZrfkuF1wFkGOCgH3y5F2pZ1grCcO9Dt
         6z8bE4qWPOMJ1KnF4xSdpZrF+HtQYOn5t5r/3RkzXCdM0LDitDAznzKT/dSeSslrph8j
         Neig==
X-Gm-Message-State: AOAM530JqfQCYkvjlpsERP6sozwKOtGt0aWitg5EU/BejPjl4d9ehEjn
        bADqyFEg9fCW7sDh+/RayLQtDBGRplscyGT0ikM=
X-Google-Smtp-Source: ABdhPJy9cr6fuErPDEnZCIwg0CpYQ4Qi6BD1D76UeANN8dQGjG9O0VD9snJAsdaCuzb7ogS9yOjD7A==
X-Received: by 2002:ac2:5ca4:: with SMTP id e4mr6334176lfq.534.1631476571397;
        Sun, 12 Sep 2021 12:56:11 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id p18sm316616lfa.148.2021.09.12.12.56.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 12:56:10 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id f2so13293698ljn.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:56:10 -0700 (PDT)
X-Received: by 2002:a05:651c:158e:: with SMTP id h14mr4047475ljq.56.1631476570533;
 Sun, 12 Sep 2021 12:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <YT4IvKLQHm9mfpR+@kroah.com> <CAHk-=wh7FYyewcJkozsjA95yj0AYvmpMDoZd0RxQ3ZbMMdXUdQ@mail.gmail.com>
 <202109121213.A47D575@keescook> <CAHk-=wiVEEzLPLTkb9U6YB-2qXpbuqP3a1q=gRx8Nkg-dpLeqw@mail.gmail.com>
 <202109121236.4C17E6B00B@keescook>
In-Reply-To: <202109121236.4C17E6B00B@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Sep 2021 12:55:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFvfkoFixTapvvyPMN9pq5G-+Dys2eSyBa1vzDGAO5+A@mail.gmail.com>
Message-ID: <CAHk-=wiFvfkoFixTapvvyPMN9pq5G-+Dys2eSyBa1vzDGAO5+A@mail.gmail.com>
Subject: Re: [GIT PULL] Misc driver fix for 5.15-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2021 at 12:44 PM Kees Cook <keescook@chromium.org> wrote:
>
> Right, I completely understand that. If you really want it gone, I
> will rip it out; it'll just make it more time consuming to analyze some
> CI reports.

Well, I've pulled it, so it is what it is.

I would ask you to try to get the CI cases fixed, and then remove the
odd printouts from LKDTM, but it's certainly ok by me if that doesn't
happen immediately.

           Linus
