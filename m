Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DCC32DD9F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 00:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhCDXLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 18:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhCDXLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 18:11:51 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBEAC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 15:11:50 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ci14so33693657ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 15:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BE32Kfi4kj+ZAdJIcPt+s2HaEM0hO57R8c+yyi9e21g=;
        b=atcs3Qrf55HohHsaCh8HMvMzQuAaS7TmIGvNvghisxEdnQ/LGkArNBQhtJ0WeEfn6e
         Bq5+Zp/g3CBKhk4DF+fIGlKWqLb1wm718t+t6qn4viF487VfAMkPFAPAbIlc8xm3adBk
         xtAC8EN0NMaS+8FmuFnjjltMGViue0cHf96o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BE32Kfi4kj+ZAdJIcPt+s2HaEM0hO57R8c+yyi9e21g=;
        b=WvFnSoLVvBVml+vt75/JfZd6RMdXgHMf1gEHe02BZpEwmeuLyYOlSj5NlNk3iORcfw
         wunYALWuCeTzMSrBTD+jl3tYzaDlSf5SD/w8D4ow5ctaekAGkEhI8QrTmaxpxTrCJ5jt
         iNC2ACQv3aoByQE/MW5p3cXQQPH38/EXKB5OkgV/V6Y3XO88XStyK67Qv/3lVX9EZUQt
         yOs+5pVgUi3GyaU+R77eFBVq0SeNIuEVXC8YrBf4+B0F8vDHu6U4AcYz9kDOORXNXhVj
         d/b9/2AgFQG6klpmTF+xHVPH8VLIeGX52/JehfMz8esezPsGiOI1cQhF7ZOz8WJebjOJ
         93Ag==
X-Gm-Message-State: AOAM532Z1tWSe8CgDAzvuX/6GO+G+jEyb7kcXETiBK0O5NoHZ7v/8+un
        DfF7Y1qY143KiRkC1iZE7h1Fmw==
X-Google-Smtp-Source: ABdhPJz2r/KaoCDk/RFGF+DnUOSC4E+TysAwdut12JzaS2aFTJq1asshybOBQBCy7zSRuUJw5ta81w==
X-Received: by 2002:a17:906:d9c9:: with SMTP id qk9mr6485585ejb.504.1614899509299;
        Thu, 04 Mar 2021 15:11:49 -0800 (PST)
Received: from [192.168.1.149] ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id oy8sm398597ejb.58.2021.03.04.15.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 15:11:48 -0800 (PST)
Subject: Re: [PATCH 5/7] printk: Make %pS and friends print module build ID
To:     Stephen Boyd <swboyd@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org
References: <20210301174749.1269154-1-swboyd@chromium.org>
 <20210301174749.1269154-6-swboyd@chromium.org>
 <20210304170052.GK2723601@casper.infradead.org>
 <161488534185.1478170.10285681551102444519@swboyd.mtv.corp.google.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <95e58426-c7ab-6ba5-17ea-392754899959@rasmusvillemoes.dk>
Date:   Fri, 5 Mar 2021 00:11:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <161488534185.1478170.10285681551102444519@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2021 20.15, Stephen Boyd wrote:
> Quoting Matthew Wilcox (2021-03-04 09:00:52)
>> On Mon, Mar 01, 2021 at 09:47:47AM -0800, Stephen Boyd wrote:
>>> Example:
>>>
>>>  WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x28/0x30 [lkdtm] (ed5019fdf5e53be37cb1ba7899292d7e143b259e)
>>
>> Would the first 12 characters instead of all 40 make it more palatable
>> without reducing its utility?
> 
> I can't seem to request debuginfo from debuginfod without the full 40
> characters. It's not a git sha1 hash. 
> 
>> And I feel it should be within the [], so maybe this:
>>
>> WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x28/0x30 [lkdtm ed5019fdf5e5]
>>
> 
> Sure I could put the hex numbers inside the brackets. I suspect changing
> %pS or updating the "Modules linked in:" line isn't going to be
> palatable. I've decided to introduce another printk format %pT to print
> the stacktrace 

Can you avoid claiming a new "top-level" %p modifier? Isn't it better to
add a new flag to '%pS', say '%pSb' to include build-id?

Rasmus

