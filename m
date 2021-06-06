Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E792439D240
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 01:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFFXk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 19:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhFFXk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 19:40:57 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BFCC061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 16:39:06 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 131so19629812ljj.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 16:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KZD8IflcYIe/9eJ/2AgNYmJumSxANKmiOTOD3q934Es=;
        b=IP/khOwCT+DU5R4G2+yFmZ2yVUMLZcvGBxyvkyuT/8uPP0uN6eXT0YzsPvySt8Pj+Z
         Gji8ZqiVa/B++AYQ9jDfxTICg+7XfQxfYM2XYaeWTi+t4D9icri3bTYUczGSY9vzAWjZ
         RNPUAVYaRPGzXUAMcuLQtW6m3NkMhGjcooMYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KZD8IflcYIe/9eJ/2AgNYmJumSxANKmiOTOD3q934Es=;
        b=RgMDuG74LQ3QFipTTUOOYWEneHB3UCrOGw9lLuHtOzFPcqG73/+NBVqr+JiESs9EyG
         DvlLL3qGBvp88XN/RXr8D4T/L/9BKIgShwPLeHclaVZUnin7zUtfOny6yq/mcnXu3XO8
         3/2smpBqHf5zLazHHVRmjHzfJZqFkG7ub7W0fdGFSwNB98IeIE708ZcJ4utexHSfXl5p
         w0XJQhFqyc1Hmvcu2OLiJv/qAwopkgxgDITzXRJsuB7hBtNFu/vHSbO5Jczci3X5TMIw
         RY1EdwIkJGFiruwNVV0DSIO2wicK8Q2Q7AiccJn/9AJu1Ec0xtdmaLLLr52MyX4Oo/2E
         8R5g==
X-Gm-Message-State: AOAM5306jud2V2xezwrVyhgVj0Gta2Cj9fA4tOFFOEmGbqo8zE6sWa7W
        tIwQu8gtE4IytdPQ0oNL+4Xnuw==
X-Google-Smtp-Source: ABdhPJw/vCNGZxeMhjjE5C3+p4AqAXpm+LIP63LI4O91yQgJPhnp9pVLYfbWZ2sOYJpcSITuw56sLQ==
X-Received: by 2002:a2e:b819:: with SMTP id u25mr12357920ljo.182.1623022744877;
        Sun, 06 Jun 2021 16:39:04 -0700 (PDT)
Received: from [172.17.20.50] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u10sm1631787lji.16.2021.06.06.16.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 16:39:04 -0700 (PDT)
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Monakov <amonakov@ispras.ru>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
References: <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
 <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu>
 <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu>
 <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
 <20210606185922.GF7746@tucnak>
 <CAHk-=wis8zq3WrEupCY6wcBeW3bB0WMOzaUkXpb-CsKuxM=6-w@mail.gmail.com>
 <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru>
 <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e11bc0fd-f231-d015-f8b1-6de71fa403f6@rasmusvillemoes.dk>
Date:   Mon, 7 Jun 2021 01:39:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2021 00.38, Linus Torvalds wrote:

> Example: variable_test_bit(), which generates a "bt" instruction, does
> 
>                      : "m" (*(unsigned long *)addr), "Ir" (nr) : "memory");
> 
> and the memory clobber is obviously wrong: 'bt' only *reads* memory,
> but since the whole reason we use it is that it's not just that word
> at address 'addr', in order to make sure that any previous writes are
> actually stable in memory, we use that "memory" clobber.
> 
> It would be much nicer to have a "memory read" marker instead, to let
> the compiler know "I need to have done all pending writes to memory,
> but I can still cache read values over this op because it doesn't
> _change_ memory".
> 
> Anybody have ideas or suggestions for something like that?

The obvious thing is to try and mark the function as pure. But when
applied to a static inline, gcc seems to read the contents and say "nah,
you have something here that declares itself to possibly write to
memory". Replacing with a call to an extern function marked pure does
indeed cause gcc to cache the value of y*z, so in theory this should be
possible, if one could convince gcc to "trust me, this really is a pure
function".

https://godbolt.org/z/s4546K6Pj

Rasmus
