Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F8F4071B8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 21:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhIJTJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 15:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhIJTJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:09:43 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7954CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 12:08:32 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id a20so3089938ilq.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 12:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CGR2907jA1AKoyCj8Tk/IjWSPxjZVjA/qpLk/UXRDlY=;
        b=Hu9zaQGAp6wamEYNfxPwGiKlL47T37nt9w+WbLEo2ZSyIQiTi28r+GC4veIIKwxspb
         vM+tG30AJxLZRuKJ4H/qOCIwR3xrkKXzrU5RUIYsNzMWo8U+0qE4cp1kTZwl7yjzUBrk
         cwb61bWa0uruAVM6j+kSRzKaXx6hsl7nnFLcu0aH1r9huIs/u2MQLX7IJ81nAL2ycMg3
         cPbrjHTYXJqEuKcBjSvPKPVNh3b3KpHnGKuGHByPpmQHrRi52snHgGSeFNtAQElpPrTg
         KAXF4zaH0y84+rp55mN9a3eBYcgq374jDodYyer6EBrBg4ncKoQuoT8BtNSsDM2Vohiz
         pl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGR2907jA1AKoyCj8Tk/IjWSPxjZVjA/qpLk/UXRDlY=;
        b=PLA1WduTABIo0riAvOKm6uWFHcnCKgijJa9TXXT1iv8xpfElsivfFwvTlAkCSHtHwo
         5ks0ldEvWw3eQAm3ow7crpYATrBrmYVF+DhLO+E6BTaBwkfnqdfMJAyLoK2UEosQnOpC
         ZVxf58k/36LmwHZgJOjz9P8mUtESV543gHOmuUAylLXqTZI2lylQH/6IIH8Q+wqCqZwr
         qQX7RU6jhvgEBtmyzwKlHXy6EUmfikm7XK2d3yMYspOJK9PI9vnWcDSbAV9iEjP1lJGZ
         cobElTkDMTaW8USzQ05n8rGKmVldYZio2lNs5e2kgg5BBxdunZPEcr2Z/M4gTVZEQ97/
         nNDg==
X-Gm-Message-State: AOAM5305sAj2pfmV8CJcPvk5eOFqPZqQ4WExaM9IuhHTwk9VOrzV0c1/
        Rx7NYmQHvkhXfPIBHFRplRUHFXlSftSi0WA5AXU=
X-Google-Smtp-Source: ABdhPJzhzdUaBPwCkzhBi3vRe37qRpviqGQRMvzN5lvBxYoOuwJiWfGRLbrhlhc9KPcsN5usBcAmO1gX9XwapXqESCA=
X-Received: by 2002:a05:6e02:1747:: with SMTP id y7mr5105442ill.5.1631300911962;
 Fri, 10 Sep 2021 12:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210908234751.GA8052@kernel.org> <20210909000141.3136241-1-ndesaulniers@google.com>
 <CANiq72nwzPt2zx-m8Cbi8-GAztknEefVDVM4VGhOFyUvagcukQ@mail.gmail.com>
In-Reply-To: <CANiq72nwzPt2zx-m8Cbi8-GAztknEefVDVM4VGhOFyUvagcukQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 10 Sep 2021 21:08:21 +0200
Message-ID: <CANiq72muNDdCeiA8EWMkuD9Ksa8KKoqMT1h081UfoM3iWbxj8g@mail.gmail.com>
Subject: Re: [GIT PULL] Compiler Attributes for v5.15-rc1
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Marco Elver <elver@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 2:13 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I would like to have that one in -next for a couple days before making
> the PR. Since we are in the merge window too, I decided to send the
> one I had in the queue first.

I am sending v2 now.

Cheers,
Miguel
