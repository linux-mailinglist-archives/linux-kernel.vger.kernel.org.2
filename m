Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93846441DF9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 17:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhKAQW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 12:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbhKAQW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:22:26 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D63AC061764
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 09:19:53 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z200so12824068wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 09:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GjGM4teGqtDHqaR2B16eUUHA1jOhBf1T+SnFsnnEpAU=;
        b=Hl6MQ1jaQz1jMur7ZmBQKDuC7Ccoqkja5LIKeqHTJcJRp6EomUbw3hPl6+aK4HZmmY
         4XJn7a3L1niihW4HvsL2DHIig3BziHa9A1J3KgwFmB3i7SBCjJOoJltRCABG/R1ZDVXC
         s6tY8E97EpNNYS+D/gMa4HiyOzSwz5xTWcFti+UgJ1J4L5L7ssCq+aadmDJ2QS5T5dQY
         gYWKLEv5Ofhn64+P4rR3hGR1hFInr5FYng88dnHZ+QCAlBPE8NJZhB7euI7NGoXEwwyb
         p6ECAYEEMGmnY4NsEBsXgnlegqFK/h7ebOPfdwRIzz+nMcZN2T9BgSAz98jl8ywTN8jp
         8yGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GjGM4teGqtDHqaR2B16eUUHA1jOhBf1T+SnFsnnEpAU=;
        b=ca/7FFAOUTEJ6OMTtEL/3ziCIVG2YnJ62vpGCysJnu5bLG/evo3pRbKdDz0pbfi1/U
         oFRqq5jDkYN0GJayffUyu0sk1Lb0bxb9iJJeSXMW7vrq3m/t0D6ZFURwnxxn6z6/FbkY
         PRi0ro7EuNNKxFStJpBF17E1kLzVneU5IKSb2hC+p6/5z1KxoAz1LoBjcx/uvILLVzcr
         tC0ffZtP/hrfTbSvOmW8ANg0DHyJho+F1fO37d5qKbUhUoGDBp3X8Pxg08YApzZb7qPd
         Usitxy0eUO7L/XNLmbZ+NgeZRFH6dbLjGplKrq5TmuDPgW23C7SgLRJaxuCf9tti66JI
         sN+g==
X-Gm-Message-State: AOAM533W3EmbpTKF3UHf0VnNYtHhOiZWkAGFPlqKrMFeCa94Hj+8QgJy
        BwyH9i+ZCEbCnlYIdL+HFwabdgpAu9bsSg==
X-Google-Smtp-Source: ABdhPJzefHJrHdesfKDcmMU6SAYYnAZEs29pZpKXnfk/IADsybI27/Z+IIwiiXstMPvHD8DY7rI78Q==
X-Received: by 2002:a7b:c097:: with SMTP id r23mr17040806wmh.193.1635783591751;
        Mon, 01 Nov 2021 09:19:51 -0700 (PDT)
Received: from google.com ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id h27sm8321752wmc.43.2021.11.01.09.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:19:51 -0700 (PDT)
Date:   Mon, 1 Nov 2021 16:19:49 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.15
Message-ID: <YYATpRgJHditIHZT@google.com>
References: <CAHk-=wjfbfQobW2jygMvgfJXKmzZNB=UTzBrFs2vTEzVpBXA4Q@mail.gmail.com>
 <CAHp75Vef8QW3Y0yA702KUqPDHNRLN0kCv06=cgPpgPbUeAb-dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vef8QW3Y0yA702KUqPDHNRLN0kCv06=cgPpgPbUeAb-dw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Nov 2021, Andy Shevchenko wrote:

> On Sun, Oct 31, 2021 at 11:09 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > It's been calm, and I have no excuse to add an extra rc, so here we
> > are, with v5.15 pushed out, and the merge window starting tomorrow.
> >
> > Which is going to be a bit inconvenient for me, since I also have some
> > conference travel coming up. But it's only a couple of days and I'll
> > have my laptop with me. Sometimes the release timing works out, and
> > sometimes it doesn't..
> >
> > Anyway, the last week of 5.15 was mainly networking and gpu fixes,
> > with some random sprinkling of other things (a few btrfs reverts, some
> > kvm updates, minor other fixes here and there - a few architecture
> > fixes, couple of tracing, small driver fixes etc). Full shortlog
> > appended.
> >
> > This release may have started out with some -Werror pain, but it
> > calmed down fairly quickly and on the whole 5.15 was fair small and
> > calm. Let's hope for more of the same - without Werror issues this
> > time - for the upcoming merge window.
> 
> Do we really now have any use of COMPILE_TEST=y WERROR=y with `make W=1`?
> To me it seems every CI just disabled it because it's impossible to
> build a kernel anymore.
> 
> What is the roadmap of fixing this (to some extent)?
> 
> I remember that Lee spent a lot of time cleaning up W=1 cases. Maybe
> he knows the state of affairs of this with -Werror enabled...

Probably never.  I managed to get the warnings down from ~18k to ~2k
IIRC.  However subsystems like GPU keep adding 10's of them every
release, so the job became perpetual.

I do plan on doing another rotation once I get a bit more free time.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
