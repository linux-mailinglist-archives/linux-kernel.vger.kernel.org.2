Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18711348486
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238824AbhCXWVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbhCXWVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:21:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA011C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:21:36 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u9so35454759ejj.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 15:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kt9P1sP07wdx7f1Xs2ss4edkv9Xos7a6QFQrRD5299A=;
        b=Pr78ooKReei1r0cbLnfVzNvxWYHXM30lXKKN69Z+8Vh63ks81yWbw0IJ1bYoGOXDlt
         +Ssn5sClPUqMPyUzOJOOLCm5kzHRrJu2LD5k7Dwz2NrumsZFs9/KAL/XJ3j7VjGNwwKQ
         tA6RgCe6hvksMePDBKsuUy2jhctBiK2jJk8Gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kt9P1sP07wdx7f1Xs2ss4edkv9Xos7a6QFQrRD5299A=;
        b=qlSI6GIZAb2ODw0bdTCzqZSqXlemKLbYqn+9SnOCu5fvSWtjsw1ENR4wDCbkpt5jHd
         RPfx0c+uGO4WueLs1vlfE+1TCTOSf+ArAGzUClJ2kk/lMAddeO6vRJvWOAZFvByyS4rG
         UpPGvmQjPKHRVIbf8xN3kDwfCfHsaC7pCTPWDnBR7Vv4ROhiETU7LLc0XdAXH/ZIZQS/
         D+HY2smXkuiyf8BAsy0rv/mCLm9irJeX721+S0fXe0ToMflPETjhBQH9NE7dwc+MB5DB
         MA9v8ReIm3lD7CJWBmtETZXUPqlOrYsDwcnAj6nFuQJZB7bPjRaqblEhOKbg8JaBCKsK
         wK/Q==
X-Gm-Message-State: AOAM533F3dGKJHwXyLUrc/foKsrFp1ZribZyChAh/TwpOr9BqpBAWE8I
        Q3guCcp31wCBoAvNqho5Cn4NDw==
X-Google-Smtp-Source: ABdhPJyWpxCJypzm5ALKZnZCe6HWwSFkFptWPhCbyzSQ1D2sVOc5Rpe91qZvCDTu4NfPmOfrNuFAoQ==
X-Received: by 2002:a17:906:3f87:: with SMTP id b7mr6027998ejj.139.1616624495324;
        Wed, 24 Mar 2021 15:21:35 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id bm10sm1808021edb.2.2021.03.24.15.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 15:21:34 -0700 (PDT)
Subject: Re: [PATCH v2 04/12] module: Add printk format to add module build ID
 to stacktraces
To:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20210324020443.1815557-1-swboyd@chromium.org>
 <20210324020443.1815557-5-swboyd@chromium.org>
 <6dfb8ca2-20f3-e58a-ad6b-db6a6472afe0@rasmusvillemoes.dk>
 <161661308874.3012082.15483899786731677633@swboyd.mtv.corp.google.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <2785cae4-20be-85b5-7838-9a6dbd2baf72@rasmusvillemoes.dk>
Date:   Wed, 24 Mar 2021 23:21:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <161661308874.3012082.15483899786731677633@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2021 20.11, Stephen Boyd wrote:
> Quoting Rasmus Villemoes (2021-03-24 02:57:13)

>>
>> Is there any reason you didn't just make b an optional flag that could
>> be specified with or without R? I suppose the parsing is more difficult
>> with several orthogonal flags (see escaped_string()), but it's a little
>> easier to understand. Dunno, it's not like we're gonna think of 10 other
>> things that could be printed for a symbol, so perhaps it's fine.
>>
> 
> I think I follow. So %pSb or %pSRb? If it's easier to understand then
> sure. I was trying to avoid checking another character beyond fmt[1] but
> it should be fine if fmt[1] is already 'R'.
> 

I don't know. On the one hand, it seems sensible to allow such "flag"
modifiers to appear independently and in any order. Because what if some
day we think of some other property of the symbol we might want to
provide access to via a "z" flag; when to allow all combinations of the
R, b and z functionality we'd have to use four more random letters to
stand for various combinations of those flags. On the other hand,
vsprintf.c is already a complete wild west of odd conventions for
%p<foo>, and it's not like symbol_string() gets extended every other
release, and I can certainly understand the desire to keep the parsing
of fmt minimal. So 'r' to mean 'Rb' is ok by me if you prefer that.

Rasmus
