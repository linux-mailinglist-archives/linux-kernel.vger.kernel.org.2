Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76252444DF2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 05:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhKDEc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 00:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhKDEcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 00:32:53 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61663C061714;
        Wed,  3 Nov 2021 21:30:16 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id r10-20020a056830448a00b0055ac7767f5eso6603577otv.3;
        Wed, 03 Nov 2021 21:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0yHPGLbq6On1e7pWir603wCoQ9SKcstFN6eq4jdzTZs=;
        b=OYbbqxbt1AEfBa11ZGsJ7rUXDxO0GiV/I829SspKA1iwuucR5+FKvRzNJQ+mVLPmBm
         QF+1zp5Xzgp4PPyB5qEfdQBi4sWjBpFNLZp4QonPjwekrTSXpDXMtu+7tLOLnljVNnhR
         vPlkEXSfiAOe4to9GrFq16BKVnTfJQKf60E0ybIS0x89WuUE/k8iBwRPOO7nxk+A8Atd
         Ug3qd1KLnKdGPNourgJzCIOyWrAqaQ0IXu9Smh9snSrmO8psK25hKpnxT/Jf1U+9Cxv6
         fe0gumuwa05/lthnAyNacqZQZeevDNuu78ED92pFTehvSUa/AJdOeBXFUGdhYg92Gj5g
         A6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0yHPGLbq6On1e7pWir603wCoQ9SKcstFN6eq4jdzTZs=;
        b=QzY5G+22K1ujkZCdc14Ffb72OVWX3mEHlBHKy+ShyxLtW5qFNvgNrvoWZ/oTH/q7gq
         N4htkreG+GscM+13YIZmmLfGZ6VcB2+2MN8WnSAIySRaoWW9r8e5UHMnZ2/xXWws36lW
         rcUsH+EMWPk0M4y8I3okhk3mmmtHc78/nU+7OfWp3yLK39YJfaIu4DhbwEE1xwMg36Dp
         4KKnuZn+itTfJq4oa811oDSiYb0rs6DuXOp3Z2x8SVsPawGyIY7Nwl/9Yt6u+vn9rRPm
         Ff4dMhGU7gbLDoubWsi2nyH5DuYolD0Mya4De2vvE1q969heXjHl70fsUXpD+nNjk8Rl
         b65w==
X-Gm-Message-State: AOAM532CaRc2oWyzbOSwY0Ankd3V49ZKm+Rt1YYgQz/OvyL9lJRtRfJx
        vj9EmZ4fMkxP0HsUjNjAdfOHRS5RtLQ=
X-Google-Smtp-Source: ABdhPJzwJzbMwn9uADuHz2/jx6oD6N+b2PC9KX0Y19FIKZrTEGylQZsR+0eX820pf/9CSm/gbIFQug==
X-Received: by 2002:a05:6830:1ad5:: with SMTP id r21mr35708648otc.98.1636000215531;
        Wed, 03 Nov 2021 21:30:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s206sm1136105oia.33.2021.11.03.21.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 21:30:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: parisc build failures in mainline kernel
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, Helge Deller <deller@gmx.de>,
        linux-parisc <linux-parisc@vger.kernel.org>
References: <20211104031554.GA34798@roeck-us.net>
 <CAHk-=wjvWORtC5vwgavJxpBtV3-q9GGidezS_2NjtUFvqg7H5Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <77dc70f4-879a-eb5c-2dd6-682b4c7cfd03@roeck-us.net>
Date:   Wed, 3 Nov 2021 21:30:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjvWORtC5vwgavJxpBtV3-q9GGidezS_2NjtUFvqg7H5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/21 9:18 PM, Linus Torvalds wrote:
> On Wed, Nov 3, 2021 at 8:15 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> the mainline kernel fails to build almost all 'parisc' images.
> 
> All with CONFIG_SMP?
> 
I think so. tinyconfig (SMP=n) builds fine.

> Does this silly patch fix it?
> 

Unfortunately not. With that patch it complains about task_struct.

In file included from arch/parisc/kernel/asm-offsets.c:24:
arch/parisc/kernel/asm-offsets.c: In function 'main':
././include/linux/compiler_types.h:140:41: error: 'struct task_struct' has no member named 'cpu'
   140 | #define __compiler_offsetof(a, b)       __builtin_offsetof(a, b)
       |                                         ^~~~~~~~~~~~~~~~~~
./include/linux/kbuild.h:6:69: note: in definition of macro 'DEFINE'
     6 |         asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
       |                                                                     ^~~
./include/linux/stddef.h:17:33: note: in expansion of macro '__compiler_offsetof'
    17 | #define offsetof(TYPE, MEMBER)  __compiler_offsetof(TYPE, MEMBER)
       |                                 ^~~~~~~~~~~~~~~~~~~
arch/parisc/kernel/asm-offsets.c:43:26: note: in expansion of macro 'offsetof'
    43 |         DEFINE(TASK_CPU, offsetof(struct task_struct, cpu));
       |                          ^~~~~~~~
make[1]: *** [scripts/Makefile.build:121: arch/parisc/kernel/asm-offsets.s] Error 1
make: *** [Makefile:1223: prepare0] Error 2

Guenter
