Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846AF3BA468
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 21:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhGBTpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 15:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhGBTps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 15:45:48 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26527C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 12:43:16 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id w11so14876585ljh.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfx5fSmOdgY90FoUlA/sfF9P5clz6NRu1yzH0lQXy18=;
        b=A/SegpDPvGpVDgVFaqmM0GXMqPsQ/YHD1gkkXyAN6+ZudmMV3Oj69yFt8Zsw66RCuG
         K3vuuTgR1a5B67XiC6xopZzPFZV+4QKrQ620iRpmYgken8P2VG5mnpN5IKG785/EDPoz
         m6WWZRkWp8qmJ7M/20I+XPw9h9fKWKKZgpaXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfx5fSmOdgY90FoUlA/sfF9P5clz6NRu1yzH0lQXy18=;
        b=tUW8W35C1Akz90bFJPm6VwSW6PF9eGPsMUwaOzbQfTbjs6nw0Gp93tYvmuokZDZJva
         eZjaYwzGtvbOhtItR4O3l7GurGQOAQEv8JOGcYZQn3rMXtYmFwDS6XwIWHwtCj1WoCLl
         sCGbYsUNyuCAHJ1BIY7ZZD8ax2SSDnamEG/ePfh+aVUjOwVU3vYmsTKdKD6rX/mttuZg
         oOR7f0CtBZLUZWb1gnXcDflxwDd7+xyJS4852ZBad4YXnFdyOCZR77UqyKPLITts53+x
         tzoaGTNfq/RNfT2wcYDl4tX5u08tmOHUugtwc6BDjKzunTdQ0i5v6yBrqJXyvFhruwyD
         eIYw==
X-Gm-Message-State: AOAM532y4zZrahD+U0u7XQzQgJZ67VngtQ3ascyxJnnCBZSApcZIraw5
        83I4B6Um9RF8WHgwERuSfzFyzStNCa9lkrsq+hk=
X-Google-Smtp-Source: ABdhPJw/OsQTz+ZPLKYOIYHABhwhldX6OBVVB98SyNzYX8lW12szV2JKCPKUIUwvj7vdlx2+sSvC4g==
X-Received: by 2002:a2e:9c02:: with SMTP id s2mr784095lji.299.1625254994222;
        Fri, 02 Jul 2021 12:43:14 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id u9sm75990lfm.127.2021.07.02.12.43.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 12:43:13 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id q18so19989918lfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 12:43:13 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr866325lfs.377.1625254993210;
 Fri, 02 Jul 2021 12:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
In-Reply-To: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Jul 2021 12:42:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com>
Message-ID: <CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 6:48 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> A rework for PCI I/O space access from Niklas Schnelle:

I pulled this, but then I ended up unpulling.

I don't absolutely _hate_ the concept, but I really find this to be
very unpalatable:

  #if !defined(inb) && !defined(_inb)
  #define _inb _inb
  static inline u8 _inb(unsigned long addr)
  {
  #ifdef PCI_IOBASE
        u8 val;

        __io_pbr();
        val = __raw_readb(PCI_IOBASE + addr);
        __io_par(val);
        return val;
  #else
        WARN_ONCE(1, "No I/O port support\n");
        return ~0;
  #endif
  }
  #endif

because honestly, the notion of a run-time warning for a compile-time
"this cannot work" is just wrong.

If the platform doesn't have inb/outb, and you compile some driver
that uses them, you don't want a run-time warning. Particularly since
in many cases nobody will ever run it, and the main use case was to do
compile-testing across a wide number of platforms.

So if the platform doesn't have inb/outb, they simply should not be
declared, and there should be a *compile-time* error. That is
literally a lot more useful, and it avoids this extra code.

Extra code that not only doesn't add value, but that actually
*subtracts* value is not code I really want to pull.

                     Linus
