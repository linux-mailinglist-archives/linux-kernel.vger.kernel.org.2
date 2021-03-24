Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F113483A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbhCXV2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbhCXV1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:27:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C3CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:27:44 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e7so66210edu.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qg+uRN1UVz59bXG8ixTxLJaA4rnDyKRg9P1HWdnjvz8=;
        b=imlEBMenzGIyx7jNh1TSp0GkwYJn3xsLEdndnorUwCqqRGh1tYECPHFLjjETSoZyuv
         s96amsaGRhRnwtS2FAyBn0CCiLkOmGJPHTqkW2S1/MhhXfVUa1m4oWnzdtypFMBSnVx9
         DAVVDh7KdgasdUXwd6zMs+zngrQXyGJaVsvi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qg+uRN1UVz59bXG8ixTxLJaA4rnDyKRg9P1HWdnjvz8=;
        b=Ta5/0vG8zanAZ52y78RX1119zPddRc2kxB2Yw3q7iWPtrwRdoNtD/C47nteHgW/Bwj
         ZOnH1VgpAHP75T45Jb89ujDwZVmmfWDnU/4ovCTFrKPCOVNnQ/tM0Gg41F4T5DYqeU4o
         JzJop/aT1MIPB/IS/cSWltNQo9s4ieQwgBl7imSnEQju8mKLxv34QX1DTa2DlC+CQP0j
         QA+xe6eTWPX0ie3Dg1Q8YaFSgxZ02+2Ow4tkekMxEVTSc6Uwryxx2qdQen4LsCwx7VM2
         oJUzUUJzPwYh8pmLAqIeAFe/3pSScokgqld7YBZhhxuv4flBNfVarmzDBVN4Ooqh+hfH
         Kg9Q==
X-Gm-Message-State: AOAM531VbQ8j26bYy0i+bxiYPQSj14n1+9N4RwPBqY5/oi7dPN+/Zu1B
        P71Js4DQm6nYn5WV9u3UdHB0prLh2hPUexYN
X-Google-Smtp-Source: ABdhPJydurQNiOX5WZNDFwgpZCNlbC9JenKEOl9tX6thmCOoc/W3yRk0Ks8Wt8bVZZKA03IvAA+Aag==
X-Received: by 2002:a05:6402:51cd:: with SMTP id r13mr5693993edd.116.1616621263348;
        Wed, 24 Mar 2021 14:27:43 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id s20sm1717716edu.93.2021.03.24.14.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 14:27:42 -0700 (PDT)
Subject: Re: [RFC patch] vsprintf: Allow %pe to print non PTR_ERR %pe uses as
 decimal
To:     Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Liu Ying <victor.liu@nxp.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210324121832.3714570-1-arnd@kernel.org>
 <e1310273dcc577f3a772380ada7b6cc1906d680b.camel@perches.com>
 <CAK8P3a0JyoAtTYTi+M_mJ3_KtUJ6NeJB=FNWhzezqcXMac++mQ@mail.gmail.com>
 <810d36184b9fa2880d3ba7738a8f182e27f5107b.camel@perches.com>
 <3252fd83141aa9e0e6001acee1dd98e87c676b9a.camel@perches.com>
 <9feab1e8-4dee-6b79-03f7-7b9f0cb24f6e@rasmusvillemoes.dk>
 <d184069de43135a9c9e5f031447faf98ab3f437d.camel@perches.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <3d66137e-7842-2764-456f-7cc9e54a6d2e@rasmusvillemoes.dk>
Date:   Wed, 24 Mar 2021 22:27:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <d184069de43135a9c9e5f031447faf98ab3f437d.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2021 20.24, Joe Perches wrote:
> On Wed, 2021-03-24 at 18:33 +0100, Rasmus Villemoes wrote:
>> On 24/03/2021 18.20, Joe Perches wrote:
>>
>>>
>>> Maybe it's better to output non PTR_ERR %pe uses as decimal so this
>>> sort of code would work.
>>
>> No, because that would leak the pointer value when somebody has
>> accidentally passed a real kernel pointer to %pe.
> 
> I think it's not really an issue.
> 
> _All_ code that uses %p<foo> extensions need inspection anyway.

There are now a bunch of sanity checks in place that catch e.g. an
ERR_PTR passed to an extension that would derefence the pointer;
enforcing that only ERR_PTRs are passed to %pe (or falling back to %p)
is another of those safeguards.

> It's already possible to intentionally 'leak' the ptr value
> by using %pe, -ptr so I think that's not really an issue.
> 

Huh, what? I assume -ptr is shorthand for (void*)-(unsigned long)ptr.
How would that leak the value if ptr is an ordinary kernel pointer?
That's not an ERR_PTR unless (unsigned long)ptr is < 4095 or so.

If you want to print the pointer value just do %px. No need for silly
games. What I'm talking about is preventing _un_intentionally leaking a
valid kernel pointer value. So no, a non-ERR_PTR passed to %pe is not
going to be printed as-is, not in decimal or hexadecimal or roman numerals.

>> If the code wants a cute -EFOO string explaining what's wrong, what
>> about "%pe", ERR_PTR(mux < 0 : mux : -ERANGE)? Or two separate error
>> messages
>>
>> if (mux < 0)
>>   ...
>> else if (mux >= ARRAY_SIZE())
>>   ...
> 
> Multiple tests, more unnecessary code, multiple format strings, etc...

Agreed, I'm not really advocating for the latter; the former suggestion
is IMO a pretty concise way of providing useful information in dmesg.

Rasmus
