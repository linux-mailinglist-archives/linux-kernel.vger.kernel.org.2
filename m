Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E623EAA80
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 20:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbhHLS6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 14:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbhHLS6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 14:58:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9F3C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 11:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=2TMktU68VItlfLVKEQGEsWCkv9G1cvfENhrTJPhMk+Y=; b=hdljJWzE1+eLjhxjK6o0lAS2Rc
        YyMEJq5b9lYg40sXOacxryKEQeLtc9667oVgrivlbMov5bQyhSxYUoM38eJg5J2ju8z9scLYE7Dy6
        U7HDP/AGemfiuRSBkVuSPp+u0yIaqBGcdOvRd9RS4emi9BHX9dzwoxy8H3XR4b3eambTEqAkiI5xu
        3vjOUOknONlsqygQuTBMSgNoNi7l7V0W522aImsTitrP84CS/0brDARCA8BJwu4oIuT+21vtGRyor
        TUwi11NaQQS7AufrXHahZHdBOksFGQeRHk4Bcba/u5DJ+kfcnY6hCcpS6lCPu+LIS5bFzroMO9nnm
        PR2oairg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEFtq-00AwWB-61; Thu, 12 Aug 2021 18:57:54 +0000
Subject: Re: [GIT PULL] tracing: Fixes and clean ups for v5.14
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <20210812112938.3748c7f5@oasis.local.home>
 <CAHk-=whHxeUjaNrWOLb0qx=-nibRZzQomwkw9xMPH_aHCf=BWQ@mail.gmail.com>
 <20210812133306.1c480741@oasis.local.home>
 <CAHk-=wj=8xh+AcwQ+w62-QHfVU6wXC2xW8L17VvVBaR6dR6Ttg@mail.gmail.com>
 <cef5b624-b5f8-7729-3b05-3543578c6e3e@infradead.org>
 <CAHk-=wiEK+RooMgy+-vUbvfJi2PXCVh2K+ENeJszo6HyzYb-Cw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a294a454-89c8-d32c-3b0a-1c53480a8ab6@infradead.org>
Date:   Thu, 12 Aug 2021 11:57:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiEK+RooMgy+-vUbvfJi2PXCVh2K+ENeJszo6HyzYb-Cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/21 11:17 AM, Linus Torvalds wrote:
> On Thu, Aug 12, 2021 at 8:04 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> I just used some default settings. I didn't choose to use -Wmain.
> 
> What broken distro, what broken gcc version?

openSUSE 15.3
gcc (SUSE Linux) 7.5.0

> We can certainly add a -Wno-main for this case. We already do that for
> a lot of other idiotic warnings like -Wno-pointer-sign.

That's what my first patch did, but Steven didn't like it.

> But when we do so, I want the exact tool and distro version named and
> shamed. Because I sure don't see that warning, and from what I can
> tell, most other people don't see it either.
> 
> So it's almost certainly your distro that has configured the gcc
> install incorrectly - or some new gcc version that makes new insane
> defaults. The commit message should talk about those kinds of details,
> exactly so that people like me get an explanation for why we'd need
> that odd '-Wno-main' flag.
> 
> Maybe even the line in the Makefile should have it. Like that
> -Wno-pointer-sign thing does:
> 
>    # disable pointer signed / unsigned warnings in gcc 4.0
>    KBUILD_CFLAGS += -Wno-pointer-sign
> 
> just because unexplained random compiler flags are a bad thing (the
> same way unexplained random code changes due to them are bad)


-- 
~Randy

