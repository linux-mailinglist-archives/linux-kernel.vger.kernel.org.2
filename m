Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE553B7A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 00:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbhF2WHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 18:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbhF2WHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 18:07:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962CCC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 15:04:44 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b2so488577ejg.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 15:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kpsr/FtbpsGhngyVxXXIyq1SDK1oPHQRTq+LLV3RKrw=;
        b=fvKRMzIgXBVRWCquKoY2dVqVG6FbFRKPzRAC5insxR9tsKcDAGFi7WDOxoK9YQSTX5
         fetZ+gSSB7cTVIv9Ry1lOEaGDk6nYKFVIbx0JY14z3TboccJBsMyX3w+Fqd83bB5e0wJ
         ez+H/eSUFK5uLi9Z6IHqIZ6nKxbzRTkwTnhK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kpsr/FtbpsGhngyVxXXIyq1SDK1oPHQRTq+LLV3RKrw=;
        b=SBWisjsKhvSmEpmE5cx6BKe00AdutkM3FoDvF99u4AbAJmyMN+d3IzP/VhBicsUYDT
         NsuLmVPI0CeTtr9mV+Ep1s0JKHNZ/CFxSL/8GkXnbAvuWH9uOC/pCWNWdxeYqhWaYhQK
         kU36kBsaeBaG+SrGgTlMhHAfn5QeNJFDl6kCRzTxZI+3TAf1cOVSYPYXBNrQfO7pPkib
         N0V/iDz+XmENxw/coQ+k0Pp2pr6XSNGdDtHlWnfXF+kPPVQVH+QIa2/JsonhEGfd9KOX
         jwe8R7bklT3hTqBWr0Z9W9W6HUC2cAlx099WiU4ENXPEkdF01VEl1p6vJnud/iRFDmov
         28OQ==
X-Gm-Message-State: AOAM530euPpzVZpG7CwekFbltq8xsVKttN4a5GCXjQM809fsa2oJMcnL
        WCbmgI2VMDz4G/gd7wCqO5L23ngPXZqMwVCHSsQ=
X-Google-Smtp-Source: ABdhPJxwi0cYXBDnM7GeaKXV/5WZMYjdU1wK1HZPXcVEIu0bTIQHqLmCWH1ConAX8ER9lvs6v/XkBQ==
X-Received: by 2002:a17:906:25cb:: with SMTP id n11mr32173066ejb.539.1625004283037;
        Tue, 29 Jun 2021 15:04:43 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id f3sm8970092ejl.29.2021.06.29.15.04.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 15:04:42 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id hc16so450750ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 15:04:42 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr5398881ljp.251.1625003885865;
 Tue, 29 Jun 2021 14:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <202106281231.E99B92BB13@keescook> <CAHk-=whqCT0BeqBQhW8D-YoLLgp_eFY=8Y=9ieREM5xx0ef08w@mail.gmail.com>
 <202106291311.20AB10D04@keescook> <CAHk-=wg8M2DyA=bWtnGsAOVqYU-AusxYcpXubUO2htb6qPU9dg@mail.gmail.com>
 <CAKwvOdkcKU4K9LWTymmzi_c0wKPTQjWEbNu04WOd6D-EcnWDSg@mail.gmail.com>
In-Reply-To: <CAKwvOdkcKU4K9LWTymmzi_c0wKPTQjWEbNu04WOd6D-EcnWDSg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Jun 2021 14:57:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wioxa9Ur6u+pd7shoRSHqMWn9UFKaR9D4ymj8Er2LYFFg@mail.gmail.com>
Message-ID: <CAHk-=wioxa9Ur6u+pd7shoRSHqMWn9UFKaR9D4ymj8Er2LYFFg@mail.gmail.com>
Subject: Re: [GIT PULL] Clang feature updates for v5.14-rc1
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill Wendling <morbo@google.com>,
        Bill Wendling <wcw@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jarmo Tiitto <jarmo.tiitto@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 2:27 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Right now we're having trouble with hardware performance counters on
> non-intel chips; I don't think we have working LBR equivalents on AMD
> until zen3, and our ETM based samples on ARM are hung up on a few last
> minute issues requiring new hardware (from multiple different chipset
> vendors).

I agree that perf profiling works best on Intel. The AMD perf side
works ok in Zen 2 from what I've seen, but needs to be a full-system
profile ("perf record -a") to use the better options, and ARM is..

But with x86 ranging from "excellent" to "usable", and ARM hopefully
being at least close to getting better proper profile data, I really
think it's the way forward, with instrumentation being a band-aid at
best.

             Linus
