Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6025336886
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 01:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhCKASP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 19:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhCKASA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 19:18:00 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D66C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:18:00 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id p7so31130285eju.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 16:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G4FQbNRWUPHu0esiM/KhhSS0r0J+jY7lV+LBrNx60IA=;
        b=bHw6jMe/lzuOunnh4UmDL0wAQVP06RtK7GeTNu+koDs7UaTK3l+eizZkrdLQKNVyAJ
         CrsuHRMgQ9TUvIx0cGzlZfxFATWRS7Timti1zhG9rGKABgLMUGmJd4kNTdbw5J3Sm/kE
         CoH3/cCyTFEDWqK8WkUebLLHgZ4PL1ojRa+Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G4FQbNRWUPHu0esiM/KhhSS0r0J+jY7lV+LBrNx60IA=;
        b=PYcAnOKIgwMI00ZfuxGptx0lky2D/6pLFshdfLnjIRX+FH+og7C5fNcrPjIbOdtwWn
         51n/G8wbbY9/Lm1nmrVgch+mChCjOYSvfi8bOI6/jFHqBiGuOF5o2bZYcmz9bXrbuD7/
         XqRFYKgbOmFEJShsCVFEKz29zZdz3B/8HGnBA5e2B2w+qIGR3EcDBIQL5LSDU8My0p01
         h0tFeV3sAo5eIt2aHbi6Ll0O6EoNuaS6eiM9ZunE+FBfwzeiEMM1SihvdlBq4YdBxmaK
         4/ZIPaGYpif4aKvW0nx6PqXwQici5mkb/s6+zCyjoo+held1HjCJEDfAtIdcDTHUm9ZG
         Iuhg==
X-Gm-Message-State: AOAM533gOYzMoNrryzbgg495AbJxmy1KdSjxYrZwkq/U/IrNP933k4Al
        SnfOkQismh0wnp1dNhrSdFzd9A==
X-Google-Smtp-Source: ABdhPJzZ+lhnADptD+LfToJ+yS1ju2CjMP+M2S4DhwrkG8kEePr2iJ2g2I3vbiWU0RY54ex/RO5INA==
X-Received: by 2002:a17:906:35cf:: with SMTP id p15mr434674ejb.379.1615421877737;
        Wed, 10 Mar 2021 16:17:57 -0800 (PST)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id lu26sm458076ejb.33.2021.03.10.16.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 16:17:57 -0800 (PST)
Subject: Re: [PATCH v2 1/2] init/initramfs.c: allow asynchronous unpacking
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-1-linux@rasmusvillemoes.dk>
 <20210309211700.2011017-2-linux@rasmusvillemoes.dk>
 <CAHk-=wgfMQyYSkdRkCuHOQEcvoyw=fN7q+0cU-s9dNqDHkSmrw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <2a33d478-b7a8-5b3c-7bc5-f33eb27b44fa@rasmusvillemoes.dk>
Date:   Thu, 11 Mar 2021 01:17:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgfMQyYSkdRkCuHOQEcvoyw=fN7q+0cU-s9dNqDHkSmrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2021 23.16, Linus Torvalds wrote:
> On Tue, Mar 9, 2021 at 1:17 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> So add an initramfs_async= kernel parameter, allowing the main init
>> process to proceed to handling device_initcall()s without waiting for
>> populate_rootfs() to finish.
> 
> Oh, and a completely unrelated second comment about this: some of the
> initramfs population code seems to be actively written to be slow.
> 
> For example, I'm not sure why that write_buffer() function uses an
> array of indirect function pointer actions. Even ignoring the whole
> "speculation protections make that really slow" issue that came later,
> it seems to always have been actively (a) slower and (b) more complex.
> 
> The normal way to do that is with a simple switch() statement, which
> makes the compiler able to do a much better job. Not just for the
> state selector - maybe it picks that function pointer approach, but
> probably these days just direct comparisons - but simply to do things
> like inline all those "it's used in one place" cases entirely. In
> fact, at that point, a lot of the state machine changes may end up
> turning into pure goto's - compilers are sometimes good at that
> (because state machines have often been very timing-critical).

FWIW, I tried doing

--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -401,24 +401,26 @@ static int __init do_symlink(void)
        return 0;
 }

-static __initdata int (*actions[])(void) = {
-       [Start]         = do_start,
-       [Collect]       = do_collect,
-       [GotHeader]     = do_header,
-       [SkipIt]        = do_skip,
-       [GotName]       = do_name,
-       [CopyFile]      = do_copy,
-       [GotSymlink]    = do_symlink,
-       [Reset]         = do_reset,
-};
-
 static long __init write_buffer(char *buf, unsigned long len)
 {
+       int ret;
+
        byte_count = len;
        victim = buf;

-       while (!actions[state]())
-               ;
+       do {
+               switch (state) {
+               case Start: ret = do_start(); break;
+               case Collect: ret = do_collect(); break;
+               case GotHeader: ret = do_header(); break;
+               case SkipIt: ret = do_skip(); break;
+               case GotName: ret = do_name(); break;
+               case CopyFile: ret = do_copy(); break;
+               case GotSymlink: ret = do_symlink(); break;
+               case Reset: ret = do_reset(); break;
+               }
+       } while (!ret);
+
        return len - byte_count;
 }


and yes, all the do_* functions get inlined into write_buffer with some
net space saving:

add/remove: 0/9 grow/shrink: 1/0 up/down: 1696/-2112 (-416)
Function                                     old     new   delta
write_buffer                                 100    1796   +1696
actions                                       32       -     -32
do_start                                      52       -     -52
do_reset                                     112       -    -112
do_skip                                      128       -    -128
do_collect                                   144       -    -144
do_symlink                                   172       -    -172
do_copy                                      304       -    -304
do_header                                    572       -    -572
do_name                                      596       -    -596
Total: Before=5360, After=4944, chg -7.76%

(ppc32 build). But the unpacking still takes the same time. It might be
different on x86.

Rasmus
