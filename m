Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753A1387D75
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350721AbhERQ3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 12:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350664AbhERQ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 12:29:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FB9C0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 09:28:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a4so10949879wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f7Qfr88AMf42NCsAWwqvwb7EcfEtMGtA5TzoGX1tBmA=;
        b=MobHpimkp2Rio9K1VOeuXDp07ZYkrr8AD3CfZHVG4d8dRCJVWc0e/3wkLqPz2tD0qP
         +dhUrb4pJluk2pTgA9eZogkv2MO4ply/lgN9ChiNaGtiQoRC7Wh16t6Z16BvbCFIU5Uo
         m8B8fsd8w+2RgzDXrphWHep4nr8gtyrRYaCn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f7Qfr88AMf42NCsAWwqvwb7EcfEtMGtA5TzoGX1tBmA=;
        b=lH8Vckuu3MYoO8rziSOGFevggdqFM6zHaWBBg2ex8NZmd68iznC+r5coU570xF1fOp
         c55figCYtxtH6AaW6Jpl7jwSCyNlgg2tcypsIBbZp4oHoeqVcvBr8g9svf96igJ+RgrK
         EYOpT2q+lP3KNIjoEONsTxtW+AtnITXWrWnsXSB6scS/XK5zP7a8GrWawcwqDejB2X1/
         xAhugG1trae8LSJO62CPpIeAcevP71EzoHUU4jbmqlmYw3DaSRvpZB1HOQ/512wbC2pU
         SvrUGjQcFGSs0+r7bzmqT3CckMD+XqyKDRwLzcTYYBDqB+wi3OaQ1z/YbdX9EuDu/Hv9
         XM7g==
X-Gm-Message-State: AOAM531iRFVCsBOPfoEjBarSrB43e46cTcXXgl3yDwxnVtxbmCaWCLwq
        Vz79J3UF3SK1nb4x7ALjMxOeyw==
X-Google-Smtp-Source: ABdhPJwi/NJISY9eBi7r/EvI2mXpVb3vdhe7UkVj5itf87/qZAsSQagOYSC9JTB2tS8lHIu341XE3w==
X-Received: by 2002:adf:e291:: with SMTP id v17mr8133390wri.149.1621355291823;
        Tue, 18 May 2021 09:28:11 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id p10sm20549015wrr.58.2021.05.18.09.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 09:28:11 -0700 (PDT)
Date:   Tue, 18 May 2021 17:28:10 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v6 3/4] printk: Userspace format indexing support
Message-ID: <YKPrGr71Xp99oh0u@chrisdown.name>
References: <cover.1621338324.git.chris@chrisdown.name>
 <05d25c65d3f5149c1e8537f74041a7a46bd489d6.1621338324.git.chris@chrisdown.name>
 <YKPBk+7lTzs8WFAk@smile.fi.intel.com>
 <YKPKMCNz2hccaXfR@chrisdown.name>
 <YKPkkiCX6gdSa/rI@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YKPkkiCX6gdSa/rI@smile.fi.intel.com>
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko writes:
>> As for the literals, are you saying that you prefer that it's symbolised as
>> a macro or static char, or do you know of an API where this kind of name can
>> be canonically accessed?
>
>I have heard that modern GCC (at least) can utilize same constant literals in a
>single compilation unit, so it won't be duplicated.
>
>But more serious here is the guarantees of the name. Shouldn't it come from
>KBuild / Makefile into some header like version do?

I'm not against that, but it seems like something worth doing outside of this 
patch series, unless you have strong feelings to the contrary?

More than happy to put that on my TODO list for tree-wide cleanups.

>> > > +#define seq_escape_printf_format(s, src) \
>> > > +	seq_escape_str(s, src, ESCAPE_ANY | ESCAPE_NAP | ESCAPE_APPEND, "\"\\")
>> >
>> > Hmm... But after your ESCAPE_SPECIAL update why " is in @only?
>> > Not sure about back slash either.
>>
>> Good question! It's because ESCAPE_NAP (used to reduce scope of
>> ESCAPE_OCTAL) will cause double quote and backslash to be ignored for
>> quoting otherwise, even with ESCAPE_SPECIAL from ESCAPE_ANY.
>
>Ah, makes sense. Yep, it's a bit complicated, but okay, perhaps it needs a
>comment near to the macro.

Sure thing, will do.

>> > > +static int __init pi_init(void)
>
>> > No __exit? (There is a corresponding call for exit)
>>
>> Hmm, can't printk only be built in to the kernel, so it can't be unloaded?
>> At least it looks that way from Kconfig. Maybe I'm missing something and
>> there's some other way that might be invoked?
>
>While it's true, it may help in these cases:
> 1) getting things done in a clean way
> 2) finding bugs during boot cycle
> 3) (possibly) making better debugging in virtual environments
> 4) (also possibly) clean up something which shouldn't be seen by the next
>    (unsecure) kernel, like kexec.
>
>I'm not sure about these, but it what comes to my mind.

Hmm. Petr, what do you think? :-)
