Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4727532461F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 23:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhBXWNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 17:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhBXWNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 17:13:46 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05AFC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 14:13:05 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v22so4436796edx.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 14:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UApUAr5aUTGGANGV03dJ/EdX6/gNj/uFRxv6Z3ZwiG0=;
        b=G6HRa4tFcZ0icwERNU3bqShT2VGAE/aZGrPJoUnJL5qp74veH/6YOuZuvIKcykMntc
         JnmPUMoTcSxU/MmG51Xe8HDAO8lJNMd91/F+awStb+fncySkfGCR2mwee5a1i3tVX4bI
         y76QGMcKJHpiYN+N/Gg8UnLbdqNurSaNJxaeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UApUAr5aUTGGANGV03dJ/EdX6/gNj/uFRxv6Z3ZwiG0=;
        b=Gv+uQj4YELuvL1z/hXTNbzGJ8tyfX9M5VWsl91fKgRSla9DzDHiGNa3SWQCnG7HAlo
         3ylqTlF5Ussrph0cqEZKBObDWdYTchnQRigFAngDn5uWNM6xRvZBQpv3A46jRZJJACAa
         oBJKOroMk1SI7Cnt93mwYWI6AbP6v4JHDCp4zbH56CyvFruUhjozLOmPo+l3kcSFlTVI
         nad0M84s6uI2ngu/gB7266BTk4ZVkucEyP5Ab8sus13BixovAwuAY/ZFXoX6NsbprIWj
         STRJUz/Jub3jEN3JWrTDRqXTirlvXjl3uUIo3uU+lF6T645tunAALt5Ib99DVjg9Kttj
         XtZQ==
X-Gm-Message-State: AOAM531R+iqZjq2QKttY8Qag9GiMC3kN9YjY5MSv7Ybi1817VKMCFBp/
        7P1sfnuIOppbVIYkbGo474cg8w==
X-Google-Smtp-Source: ABdhPJw31JmQb2U9hxnSi1tck9ojUKV8GQUw8l1du2a/V8uNEtS3qLmPrUahlUzGXGZnhyIVyExpxw==
X-Received: by 2002:a05:6402:1151:: with SMTP id g17mr35223342edw.48.1614204783891;
        Wed, 24 Feb 2021 14:13:03 -0800 (PST)
Received: from [192.168.1.149] ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id lu26sm404186ejb.33.2021.02.24.14.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 14:13:03 -0800 (PST)
Subject: Re: [PATCH/RFC 1/2] init/initramfs.c: allow asynchronous unpacking
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
 <20210224142909.2092914-2-linux@rasmusvillemoes.dk>
 <CAHk-=wgw1Eg9kDGUiEY6EL+6dTC8tVqAhstvcmUBgrF5hdoApQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8ccfae21-c72a-f00e-8ec1-56ed809e3295@rasmusvillemoes.dk>
Date:   Wed, 24 Feb 2021 23:13:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgw1Eg9kDGUiEY6EL+6dTC8tVqAhstvcmUBgrF5hdoApQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2021 18.17, Linus Torvalds wrote:
> On Wed, Feb 24, 2021 at 6:29 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> So add an initramfs_async= kernel parameter, allowing the main init
>> process to proceed to handling device_initcall()s without waiting for
>> populate_rootfs() to finish.
> 
> Hmm. This is why we have the whole "async_schedule()" thing (mostly
> used for things like disk spin-up etc). Is there some reason you
> didn't use that infrastructure?

Mostly because I completely forgot it existed, it's not an API you
stumble upon in every other source file.

I guess I could use that, but it would look very much like what I have
now - there'd still be some function to call to make sure the initramfs
is ready, only that would then do async_synchronize() instead of
wait_for_completion().

Is there some fundamental reason something like this shouldn't be
doable? Are there places other than the usermodehelper and firmware
loading (and obviously right-before-opening /dev/console and exec'ing
/init) that would need to be taught about this?

Rasmus
