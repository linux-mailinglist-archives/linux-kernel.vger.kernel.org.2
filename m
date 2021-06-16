Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2385B3A8D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 02:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhFPACl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 20:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhFPACk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 20:02:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C96C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 17:00:35 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso595776wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 17:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cavx6x3nhYXx5BnoO8glUCwT6RHhCwAb/VYzJ1vZ0Uo=;
        b=Pab3Zzxhu/tOKYzmcCnj0QqXTXH6fu4+7hf+f+cxFUFlbtNZTAVDuNr7sXGYalOAZH
         Aiac7+ZJjlISiIVcD7suOALI1LEMr3f2RhAtPJ2p7XlUfaAddPC93sjUNbMx4ckq3y0t
         HSVWKOYqeCxPyZbkf4idv1UsuhbpxGsSGMCmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cavx6x3nhYXx5BnoO8glUCwT6RHhCwAb/VYzJ1vZ0Uo=;
        b=PxhyJGQZYP5CqgHQobqWaDLTAJSS8E3bpAslKjr5fBCmEvmygGP5TsvElKXLjKLzMM
         JnWwJ5s2vjJqqQBYtBr6O/NbHb2SnxF9M5VENUzu6+sg9ZSwh5jcDqnefbJ0AivSZiMp
         7TkWNrAWbrxMXFcLSOr0rUyTkXlRUgmUi9S6zhrb3xqk/CUJhBQFmvblFi7RJE5g7VgJ
         3Cxtgzvre8Q7CKQAr9GaEf81pp1EpTkmNaxozRbpwh2gn0okyTL0zhVZblgFX8Ch3lxR
         13qrqfkaHIQ4gPYGKPdVpN7djEb5X3sQbMYaIKnWeBCm6Vne3afubPepXb9K4zmKhcdJ
         reBQ==
X-Gm-Message-State: AOAM5332mRVqzYNkksfEwmeq1Dng4dsu1rIWNkQbdQjZ1EdaNlIuMoaw
        yUdFZlMIKunJJR0meTaah6ZwLA==
X-Google-Smtp-Source: ABdhPJxTbX2f33fgYdd6RIbF7XV0MAabctYxu0RyqDuOQTKQPB46xOyE13DceU2g6tMhcKdV4XHHTw==
X-Received: by 2002:a05:600c:2284:: with SMTP id 4mr1930697wmf.146.1623801633607;
        Tue, 15 Jun 2021 17:00:33 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:db96])
        by smtp.gmail.com with ESMTPSA id g10sm363204wrq.12.2021.06.15.17.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 17:00:33 -0700 (PDT)
Date:   Wed, 16 Jun 2021 01:00:32 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v7 1/5] string_helpers: Escape double quotes in
 escape_special
Message-ID: <YMk/IKA4okfYSh57@chrisdown.name>
References: <cover.1623775748.git.chris@chrisdown.name>
 <af144c5b75e41ce417386253ba2694456bc04118.1623775748.git.chris@chrisdown.name>
 <CAHp75Vc-edpD5kz0EPsO7Q=zOPHWFckZzc17imO85dQy-PpOgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHp75Vc-edpD5kz0EPsO7Q=zOPHWFckZzc17imO85dQy-PpOgg@mail.gmail.com>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko writes:
>> I've checked uses of ESCAPE_SPECIAL and %pE across the codebase, and I'm
>
>checked the uses

Hmm, what's wrong with using the zero article for "checked uses"? I mean, I 
don't have any strong resistance, but I don't see anything wrong with it 
either, and it matches how I'd naturally speak.

Agreed on the others, though, hopefully they can be massaged in :-)
