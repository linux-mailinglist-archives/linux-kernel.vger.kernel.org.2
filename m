Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7A64312BC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 11:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhJRJK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 05:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhJRJKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 05:10:12 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08032C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 02:08:01 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s19so7692744ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 02:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FA9zkt3TRCoLZEtoi5DA7JBeuBmLeLzb666axnIkoUg=;
        b=VNn2U114+hk6nRmOivu3Hv4vcO48jtV8cWK0GEHFllOfu+ZOnAXCYQRqIjfTa2i4+g
         jzTx3HoYefSoMh9U3xcqeMKmWEIwGZmovmDOUAb0O4wScj862eSrct4PomI+UyND92UY
         6/MoM9IRA6qf4BaRjQRJvxObPCrTJ62fj+UaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FA9zkt3TRCoLZEtoi5DA7JBeuBmLeLzb666axnIkoUg=;
        b=WXwUTXV7gqq9ajATtpxxUO3EoZbAhz+hqO+zIdy2NjKkMlptbc0w9YbbTSnKQC09/A
         g4TEOU2G5zZv9B4V0yGKF18CTqRasK7TO23ouHZpqOyvZgxPvsI2YM3NBIjGFrXmFr++
         U+l+bVF67ovEzRGhDy8Lsh2ccZmKCZRK7yy5NUEhLn94x75hF0Dxh8neNil9AMwVHJDT
         5ONIc8+zNF2Sr9Olb3ZbiNxh2o5RTBNcV+NYfhdPpTHVAxLKi3gR1XiQtJ3kPrDyqclL
         7GPvC7O2uCO4e1YAGYn+wxqmOePnVOKA9sfnZYe4erAswmdvbmeXb1pxQqm/NPInofRz
         kVfg==
X-Gm-Message-State: AOAM531qOAR6wNGfurE/a4t8hP3hx0ceEmkr9MKynoX5o3X4QD0paKi/
        1Cf/2mHtlWgNfHlJcl3/seuffQ==
X-Google-Smtp-Source: ABdhPJxZRjygPEv5V7JiCxqCgKp8PxPH5shz7BERIf3PY4aUGbBNSdsMghWoXsxDpCEErYGIVHtIQQ==
X-Received: by 2002:a05:651c:158a:: with SMTP id h10mr32588819ljq.455.1634548079309;
        Mon, 18 Oct 2021 02:07:59 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id bf20sm1262944ljb.137.2021.10.18.02.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 02:07:58 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the akpm-current tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20211015202908.1c417ae2@canb.auug.org.au>
 <YWl+0PFixaNqgIxb@smile.fi.intel.com>
 <20211018133538.2a0dec43@canb.auug.org.au>
 <CAHp75VcDwBkwL4+cFmeJt7b-p6V0w283ai9T9K02y0Sej0WLxg@mail.gmail.com>
 <20211018194533.7af364fa@canb.auug.org.au>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e262286b-ce0d-d46f-17be-2b59d9d42cd0@rasmusvillemoes.dk>
Date:   Mon, 18 Oct 2021 11:07:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211018194533.7af364fa@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2021 10.45, Stephen Rothwell wrote:
> Hi Andy,
> 
> On Mon, 18 Oct 2021 11:01:18 +0300 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>
>> On Mon, Oct 18, 2021 at 6:49 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>> On Fri, 15 Oct 2021 16:14:56 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
>>>>
>>>> Thanks! As a quick fix looks good, but I think we need a separate header for
>>>> those _*_IP_ macros.  
>>>
>>> Like this (on top of my previous fix - which I assume Andrew will
>>> squash out of existence)?  
>>
>> Yep, thanks!
>> I thought that it makes sense to have STACK_MAGIC also in this header. Thoughts?
> 
> You might want to think of a different name for the header file then.

Eh, it seems more reasonable to leave it in kernel.h, then figure out
how to get rid of it completely. AFAICT it's only used in one single
place under arch/ (and I can't figure out how that magic value is
supposed to get there in the first place... that arch was thrown out in
2013 and resurrected in 2015, but that particular line doesn't make
sense), and then in some i915 code which might as well define their own
cookie.

Rasmus
