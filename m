Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60CF30E2EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbhBCSya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhBCSyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:54:03 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7262BC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 10:53:19 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id f63so386857pfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 10:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dzT+zXS02AtWyri914T4RsybmYHwYLbz9EWKPRFdXXk=;
        b=LTV2jY7OP8MRqDVetuT8spPDkWetfx03dGt3EVUYfPjNPWzYtxcebRq9p+eTwnmfA8
         AtP4dGBBZH7vWOtm8Uwfo1u6KhoAaIZvRyo1hEfOdFi7dG0q9KS+67NPvo7taFJbjI2E
         A8RPRqYU630/EkxrpThbfq2xo5q0vEU7dnO1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dzT+zXS02AtWyri914T4RsybmYHwYLbz9EWKPRFdXXk=;
        b=m0D2SyzhhHsxAyhIVtf3nVbvEiFcatjWavc9aw03WuETValt7MuL0VZoybAy8HqxpL
         4kKUaT+YarU1fmfEOvMcTIOYVhivizVD0OZkBXbjJrr12HzD+5IlGlx286JUTXm8Wie9
         /GY+EycJzBU61JmOXn7Ak4c1k1fBgCVjK9db54IY74HAt5i4Vy9lA9mvdYLzPeXLwo3B
         xffeeowtVoTjNsYAzgQXQ25IP+9AU8CVFE5niXPrNVRlHci6d3QDvyJi3fE04hbanTS+
         5S5CbP3iP2jEI4bpjBrA+8eiMmM3up8rmdtwei3PbUSxn8Q3u0X/frkwThGqLXaoHc2R
         A+Pw==
X-Gm-Message-State: AOAM532qzxrjt/Zn26CrkzbTM2diGetpbMOgrj/czGnR5eYUdkPNQUV+
        d7+EiAcY43Uo8J0KoYvqyy7O4w==
X-Google-Smtp-Source: ABdhPJw6qtA6XXf+bOOkWXfhEVNcBeKb7xGPOAptplAWZ2eUzFpuxEg7zjxnEaLgPCkPgd6qn5w4Kw==
X-Received: by 2002:a65:654e:: with SMTP id a14mr5124637pgw.265.1612378399056;
        Wed, 03 Feb 2021 10:53:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b18sm3078716pfi.173.2021.02.03.10.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 10:53:18 -0800 (PST)
Date:   Wed, 3 Feb 2021 10:53:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Timur Tabi <timur@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        roman.fietze@magna.com, John Ogness <john.ogness@linutronix.de>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <202102031052.36869CC@keescook>
References: <20210202201846.716915-1-timur@kernel.org>
 <202102021351.AEDE896AB3@keescook>
 <9ce56a1c-9ea6-996b-84c6-cfde908c2ecd@kernel.org>
 <20210202173436.6516c676@gandalf.local.home>
 <CAHk-=wgaK4cz=K-JB4p-KPXBV73m9bja2w1W1Lr3iu8+NEPk7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgaK4cz=K-JB4p-KPXBV73m9bja2w1W1Lr3iu8+NEPk7A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 02:51:00PM -0800, Linus Torvalds wrote:
> On Tue, Feb 2, 2021 at 2:34 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >   "I also suspect that everybody has already accepted that KASLR isn't
> >    really working locally anyway (due to all the hw leak models with
> >    cache and TLB timing), so anybody who can look at kernel messages
> >    already probably could figure most of those things out."
> 
> Honestly, if you have to pass a kernel command line, and there's a big
> notice in the kernel messages about this, I no longer care.

Okay, cool; it's fine by me too. I prefer this kind of "boot into debug
mode" switch to having lots of %px scattered around in questionable
places. :)

I will update the %p deprecation docs.

-- 
Kees Cook
