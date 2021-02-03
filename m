Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AF930E3BD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhBCUCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhBCUCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:02:47 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8827CC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 12:02:07 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id b21so489374pgk.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 12:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2+ivHyW5vSRClijGIdqJth8jZWWn1brRkmUPJtYkVQk=;
        b=DfWAoyORj1ergXpxd7BlNktSx6gzMZ2fUMZS+ArQ00BJ8zwLGn2roh+MbtizPkaG7R
         vZqhtCFuUBNZR5ggHiGIh3I8WAie/lbcYvri+VsQ9en82iTIUMbLRgVcaoJ6VihNJYxI
         N+wIPlcIhSExdmYKXgc6r14O2RsvNy7LfnifQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2+ivHyW5vSRClijGIdqJth8jZWWn1brRkmUPJtYkVQk=;
        b=U9XO85DPP2cQIGYmDCKL+fG5TTQUXrYC/3wQirA+xuyVY5utHtMNRXF44psDywl4Mc
         piBXofXk5ZfH00bxqw7Q460REyBjyRyr4Yoms4mHkt5D2H72x5SPx5+pDFGJptV5EzYp
         aYu6q3q0w+a4/d26kLkMMQq8SV34xQeKducd13SuMDPlxaTNOSoFh9xugBsRvuCSmyLr
         KktgcEzmbPoOTEuGqU/KJxLtdPR7nPrULoezS48tSxbTE0Pu/WAs15TL+J/zKU6YY+T6
         aGGF8Nbiyuf2mD+xuIhgUqPzxgzq0ziiIjzSfwpfIdpft4mkML+1Q2JcH2DV6/edMber
         uBFg==
X-Gm-Message-State: AOAM531SNdbaSmgqsuDpgbzW07o19Ljyw/M1sgGw5rQ69U1tilduMMpl
        K0kAYJYAcAVXeyPGsXqFhAOcYw==
X-Google-Smtp-Source: ABdhPJw6lzZ6LwZ41tjrzUuYBuPd0hYclReofrZKy2Lu3ZLsdWDYmbeRTeXFZahiBa8rpiv0OI/S2g==
X-Received: by 2002:aa7:94a2:0:b029:1b8:eba7:773e with SMTP id a2-20020aa794a20000b02901b8eba7773emr4560818pfl.51.1612382527131;
        Wed, 03 Feb 2021 12:02:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x8sm2888699pjf.55.2021.02.03.12.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 12:02:06 -0800 (PST)
Date:   Wed, 3 Feb 2021 12:02:05 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Timur Tabi <timur@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        john.ogness@linutronix.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        akinobu.mita@gmail.com
Subject: Re: [PATCH][RESEND] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <202102031201.FFED9547D@keescook>
References: <20210202213633.755469-1-timur@kernel.org>
 <YBpyzxBYIYapHaDT@alley>
 <YBqlooegQgEfPG4T@alley>
 <19c1c17e-d0b3-326e-97ec-a4ec1ebee749@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19c1c17e-d0b3-326e-97ec-a4ec1ebee749@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 12:58:41PM -0600, Timur Tabi wrote:
> On 2/3/21 7:31 AM, Petr Mladek wrote:
> > Also please make sure that lib/test_printf.c will work with
> > the new option.
> 
> As you suspected, it doesn't work:
> 
> [  206.966478] test_printf: loaded.
> [  206.966528] test_printf: plain 'p' does not appear to be hashed
> [  206.966740] test_printf: failed 1 out of 388 tests
> 
> What should I do about this?
> 
> On one hand, it is working as expected: %p is not hashed, and that should be
> a warning.
> 
> On the other hand, maybe test_printf should be aware of the command line
> parameter and test to make sure that %p is NOT hashed?

It seems like it'd be best for the test to fail, yes? It _is_ a problem
that %p is unhashed; it's just that the failure was intended.

-- 
Kees Cook
