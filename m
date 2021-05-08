Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F31377295
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 17:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhEHPYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 11:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhEHPYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 11:24:48 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C985C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 08:23:46 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id e11so1769278ljn.13
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 08:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LA1s7H8iJNlnGDJOvq18ISrXAvebu3dTqmmAHQk0eXA=;
        b=GY8IBu+m+3oUOVWXByoeS1RqLfBljlxVoPUO1aOBONw/W07fMf6agecd8aDLxdwOd1
         3nY23XwejNO4BDe6uUc6gc5TIl5KmHHzgM8kd80MEqMLfPLKYvYzuPjuevyTVI9cpP47
         Kot8+lOIrEr77RreB4ghtv0EkSpqGsJgtN0WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LA1s7H8iJNlnGDJOvq18ISrXAvebu3dTqmmAHQk0eXA=;
        b=DrnP9sfqNXlZyQOTeI2S47WKmLSDQSNzcnCfZKNL6/oQe7pMoMdzj1aygD2t/1pscp
         0+0JxglI5NId2wn2+oDM7pWI0Ag1yUE0OXn9IPoKH7iuDBOhoWdqVeERQU0qP1CIDPdM
         jWPAhCCvV/qABocaouBHh9YHbIrN84dOLcHYdjeCNpp46NNboz9gxzf9ndUIZebP8Kl3
         bd9kvXeNeyQ3oilgu+AF/GyruKcunXTQy/rKo4KiloF+LeQhMEZvjfo+YcLJwyHldc5M
         e+6mwn2KRHgs9enNDfP0u1LdNyTsUml0HSY0nDEC/vR5HaZ98fqP+8GGT0uvewtwKnNG
         S5YQ==
X-Gm-Message-State: AOAM530AsKjuuwloylhFOGUv1Ooa7oCeV2a0eM+DHfW+o1SqaAQxiiKS
        zZ98JQFrGs7wjaW3TAUTQxVkOMnc9yBihoL6
X-Google-Smtp-Source: ABdhPJwKPmczlIVzpCQ0MLHsh+U3YAzXqtpCLCCZgNr7eMia8QZboLHf6XdqoWTtf37uLlnE1RYhOA==
X-Received: by 2002:a2e:b5b0:: with SMTP id f16mr12588929ljn.52.1620487424857;
        Sat, 08 May 2021 08:23:44 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id k18sm1657363lfg.200.2021.05.08.08.23.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 May 2021 08:23:44 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id w4so15321803ljw.9
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 08:23:43 -0700 (PDT)
X-Received: by 2002:a05:651c:33a:: with SMTP id b26mr12695518ljp.220.1620487423720;
 Sat, 08 May 2021 08:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210507220813.365382-1-arnd@kernel.org> <20210507220813.365382-13-arnd@kernel.org>
 <CAHk-=wiqLPZbiWFZ3rDNCY0fm=dFR3SSDONvrVNVbkOQmQS1vw@mail.gmail.com> <CAK8P3a3sxfYG4WReXPe6fg33K7tQaP4K-F53yBcTfyEXv0W22A@mail.gmail.com>
In-Reply-To: <CAK8P3a3sxfYG4WReXPe6fg33K7tQaP4K-F53yBcTfyEXv0W22A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 May 2021 08:23:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZvroqVj0+R+Eg_OAjk1DkvP9AVzQn81E+BZeoWR5AFQ@mail.gmail.com>
Message-ID: <CAHk-=wjZvroqVj0+R+Eg_OAjk1DkvP9AVzQn81E+BZeoWR5AFQ@mail.gmail.com>
Subject: Re: [RFC 12/12] asm-generic: simplify asm/unaligned.h
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 8, 2021 at 2:29 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Sat, May 8, 2021 at 1:54 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >   #define get_unaligned(ptr) \
> >         __get_unaligned_t(typeof(*__ptr), __ptr)

That's missing a set of parentheses around that __ptr thing ('*__ptr'
should be '*(__ptr)'), btw, so don't use that as-is.

> Both versions are equally correct, I picked the __auto_type version
> because this tends to produce smaller preprocessor output when you have
> multiple layers of nested macros with 'ptr' expanding to something
> complicated,

Ahh.

Yeah, that's probably not a problem for get_unaligned(), but it might
happen in other situations.

              Linus
