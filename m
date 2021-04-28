Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D8536E019
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 22:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241848AbhD1UJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 16:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241753AbhD1UIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 16:08:54 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CC8C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 13:08:08 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id i14so1041704pgk.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 13:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TvZXpxzUPr9ug6LqegfgGSaBKevdWw5NXJhgRMNXZU4=;
        b=XAyOcldawoNp4xxZKaCFJwhaVKU7aarB5d7FOUD4MFxkEcx0vWDw76h6mc3oWxEhe4
         zb+Stz42JWDgk2Rd01bB9thXHKLVnPGZR7LfYd2ARwpkCKZkPAgd5nKsXVw2/JEDFqIz
         GqJ8OFl/tkRk8TbRWm05ROiYQzTQbZ6R1qFis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TvZXpxzUPr9ug6LqegfgGSaBKevdWw5NXJhgRMNXZU4=;
        b=pjcrXzobUEG67je4k9nVrXtfCPapVbI3oImPupEyuYM2v6S3kL7lJ1E9KXXMZb8Fu0
         457Nu2LokHEnzMMMZYHi+nLqAaECccysmlULJsD5S8MjFIYxDiwE64HPde1gEReXNew6
         6kgoRHrIWEG7mtDpupb06XFDA0QOSF63UZd/H33WYLO2jbaaCMCqPQb6v0CTPWqNjJqX
         vyYKY65hjUY/sakGm8iEZvHDUhIQH2fe46nhECvzdeBjLjuNbIYAcJ87oYBpQM5zXgwW
         7zkd/9ZVa4onNfq8QC6Om8BO2ADpx0VjedvQo3MLvKZ58yNfi+fHmd1LBgPODln3H1GC
         5JYA==
X-Gm-Message-State: AOAM532vdfDB4f42aeJt2MN6+VAc7z6g0yPScCqGfjO/wI/WS4SvH1Vp
        iZNj/kkie0nwU8ROQ//uJJ72AHjvmJ+z7g==
X-Google-Smtp-Source: ABdhPJymuryoOIzSsUYW/mEdqS2ZeTIOacznUj2T1axeJaT8m3GIu+b1jLrnLkQhShwEafAZbFkppA==
X-Received: by 2002:a62:2904:0:b029:25c:13f2:47d4 with SMTP id p4-20020a6229040000b029025c13f247d4mr29929702pfp.4.1619640487586;
        Wed, 28 Apr 2021 13:08:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a20sm446928pfi.138.2021.04.28.13.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 13:08:06 -0700 (PDT)
Date:   Wed, 28 Apr 2021 13:08:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     bsingharora@gmail.com, "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Next revision of the L1D flush patches
Message-ID: <202104281307.F9FCF660@keescook>
References: <20210108121056.21940-1-sblbir@amazon.com>
 <cf89f0389379daaaff0cbce9c5f1550866e55e91.camel@amazon.com>
 <202104081319.DAB1D817@keescook>
 <87y2d5tpjh.ffs@nanos.tec.linutronix.de>
 <87tunsofan.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tunsofan.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 12:24:16AM +0200, Thomas Gleixner wrote:
> On Mon, Apr 26 2021 at 10:31, Thomas Gleixner wrote:
> > On Thu, Apr 08 2021 at 13:23, Kees Cook wrote:
> >>
> >> I'd still really like to see this -- it's a big hammer, but that's the
> >> point for cases where some new flaw appears and we can point to the
> >> toolbox and say "you can mitigate it with this while you wait for new
> >> kernel/CPU."
> >>
> >> Any further thoughts from x86 maintainers? This seems like it addressed
> >> all of tglx's review comments.
> >
> > Sorry for dropping the ball on this. It's in my list of things to deal
> > with. Starting to look at it now.
> 
> So I went through the pile and for remorse I sat down and made the
> tweaks I think are necessary myself.
> 
> I've pushed out the result to
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/l1dflush

Oh excellent; thank you for doing this!

-- 
Kees Cook
