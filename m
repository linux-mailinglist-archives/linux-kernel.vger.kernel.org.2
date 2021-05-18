Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BF5387E14
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 18:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345024AbhERRAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 13:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbhERRAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 13:00:45 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D3CC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 09:59:26 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id z19-20020a7bc7d30000b029017521c1fb75so1953242wmk.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 09:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y1fFMMA5hyVC/F/uoCjCvi5quqKUxN90T6o2QdfgidY=;
        b=G9IW3q0KIwqsYdFKITs/5CvAwaLbmxR+DJZ3M0pwW2vXx7j/oq27G2yL5US7hF/rl3
         gFH2A3CH9vb0tj8oujLDSoVVnvdjVJ2unQvXnbJxAi/zk7gBdpvU+vy4yWQr1+xiLgew
         5GxcMU94Q29viJq89VIUrOnt6wMRvPCW3Yk9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y1fFMMA5hyVC/F/uoCjCvi5quqKUxN90T6o2QdfgidY=;
        b=IAU3X1W7ZEPRcMLvc6FekKdPdLuWX1Sq7LcOKEFGlP6JYMS/5KJ3ErquSOyFGdE00b
         4l82iPBlroFGqOSfprzccdRwfL95IptvACxJQghcD4ydAtRdsNWsJGYdRWpxAeTa3cmH
         iDYJSP3gKQatN8M/KbXRnRIueHduA0liGoOOqDnSuW0GWMy7XXwInT8quFdPfZCuP7Gc
         rAcBycmDXiOq4txasdYQCNSJDMvoBvKA24K67MORPf3L1ydYOxcgtYvWrPKq1aFLVEij
         jJVFcs8CRsXa4/eHFfWoNQrriYR17KiYhAxNihkbNOLkti1WjKcMET3G5K9q/uJAQ/fK
         iipg==
X-Gm-Message-State: AOAM532+kY3YrGqhZ+m3m0tJITTJVpBMmemjumH0s5JyFHf2SNQfew3r
        ChaOjE1BfncYieb3yqn8zkcNhA==
X-Google-Smtp-Source: ABdhPJw8qsbGgEyb+LpUDB3QLdhRr2nX+xIRJH2X2+3TWsCUGmS5F+Vn9gfFkcj0V7IWhz/3ZwTyjQ==
X-Received: by 2002:a1c:4907:: with SMTP id w7mr5929582wma.11.1621357164891;
        Tue, 18 May 2021 09:59:24 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id m7sm22261707wrv.35.2021.05.18.09.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 09:59:24 -0700 (PDT)
Date:   Tue, 18 May 2021 17:59:23 +0100
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
Message-ID: <YKPyaw0bt+e/BhnR@chrisdown.name>
References: <cover.1621338324.git.chris@chrisdown.name>
 <05d25c65d3f5149c1e8537f74041a7a46bd489d6.1621338324.git.chris@chrisdown.name>
 <YKPBk+7lTzs8WFAk@smile.fi.intel.com>
 <YKPKMCNz2hccaXfR@chrisdown.name>
 <YKPkkiCX6gdSa/rI@smile.fi.intel.com>
 <YKPrGr71Xp99oh0u@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YKPrGr71Xp99oh0u@chrisdown.name>
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Down writes:
>Andy Shevchenko writes:
>>>As for the literals, are you saying that you prefer that it's symbolised as
>>>a macro or static char, or do you know of an API where this kind of name can
>>>be canonically accessed?
>>
>>I have heard that modern GCC (at least) can utilize same constant literals in a
>>single compilation unit, so it won't be duplicated.
>>
>>But more serious here is the guarantees of the name. Shouldn't it come from
>>KBuild / Makefile into some header like version do?
>
>I'm not against that, but it seems like something worth doing outside 
>of this patch series, unless you have strong feelings to the contrary?
>
>More than happy to put that on my TODO list for tree-wide cleanups.

Now I think about it, we even just call it that in struct module's is_vmlinux, 
and set that by doing `strcmp(modname, "vmlinux") == 0`, so it seems pretty 
static from a terminology point of view.

It would be nice to just always use `mod->name`, but unfortunately with 
!CONFIG_MODULES we don't have `struct module` fleshed out at all in order to do 
so.
