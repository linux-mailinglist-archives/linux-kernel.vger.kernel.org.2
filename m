Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBF439D245
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 01:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhFFXsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 19:48:02 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:34683 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhFFXsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 19:48:01 -0400
Received: by mail-lj1-f170.google.com with SMTP id bn21so19646429ljb.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 16:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uu/Sy+/+5gdn1LkuXnr8FX4KpSViz81yPU6cQOIlizA=;
        b=HSOFWCYaI4JplGo9PNU8Bbt0H04vfi4A8D71uHnmXedCnIPRXbvEu7QZL5Kfsp2DdB
         GidNETequ5xm/f7hshUSXwVIbVerCUNNb+kZ4sNwu+M9BpRkS7WFpDAntvD1YfeqZFSd
         zxowt78Mgw/V1HxA4xvQfdXdxrScPi3XPIblk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uu/Sy+/+5gdn1LkuXnr8FX4KpSViz81yPU6cQOIlizA=;
        b=NSw5tLWt9rUO3o4qKiQtOKAAaq27oH0nqFMV0gLDBqTL5CrQpLJWrwEtBx4GvXSTfS
         0OUNiAy8VuERe2ZdRjzpbkl/MN8wuFk504lv7lUuSLFDhwZ0EuxVqWw1Uv1pcrCCmrNp
         MK7PuNrSSkVaj+ZgNoJPD84tC0nmKrd5QLprRlV4EuNZ1hWN2/2NUSpwqLE7ug6YWaeF
         wAvb53OuzT4nr6RuI3FUUq8l8z0EMFB4qVucd8UvvYXyvXbMaGVFJLW3wC26BH3iSruf
         phM5sVY5uupEjRbYO11JdXgO7F06idSK3HAKfzxIOtFsJjx/1mdQ2eCBuJQv57jWZZ9e
         FFMA==
X-Gm-Message-State: AOAM533KgTOx0ziwcmxUJVm6Rbo6b/LdGaB4B+mpYmocWKx+BUzIZaxp
        MgnIJLGjvONwbpAq0J6TO1nH/g==
X-Google-Smtp-Source: ABdhPJw25WTHEUwJF3hh14WICkof9eE2YFmWHbJ0kkQobeinrEJjM65xyfo24FS/tSzfPJJS79gDYQ==
X-Received: by 2002:a2e:8009:: with SMTP id j9mr12870582ljg.172.1623023101380;
        Sun, 06 Jun 2021 16:45:01 -0700 (PDT)
Received: from [172.17.20.50] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x3sm448542ljd.12.2021.06.06.16.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 16:45:00 -0700 (PDT)
Subject: Re: [RFC] LKMM: Add volatile_if()
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
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
 <e11bc0fd-f231-d015-f8b1-6de71fa403f6@rasmusvillemoes.dk>
Message-ID: <193ca8cf-cf2c-9372-c0ab-16714ec37f57@rasmusvillemoes.dk>
Date:   Mon, 7 Jun 2021 01:44:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e11bc0fd-f231-d015-f8b1-6de71fa403f6@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2021 01.39, Rasmus Villemoes wrote:

> memory". Replacing with a call to an extern function marked pure does
> indeed cause gcc to cache the value of y*z, so in theory this should be
> possible, if one could convince gcc to "trust me, this really is a pure
> function".

Don't know why I didn't think to check before sending, but FWIW clang
doesn't need convincing, it already takes the __pure at face value and
caches y*z.

Rasmus
