Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801693F521A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 22:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhHWUa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 16:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbhHWUaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 16:30:25 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBA3C061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 13:29:42 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id f6so15918938iox.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 13:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jrb8MmGaC68emddPwQPjXM1GY7GuBgRkSODpa1XojoA=;
        b=Jix95rVYPKxFfYL/aPT0sbEErQFG61rQbSUAEgNs/qK+fLsttL42hCyXs3hCp5CV0R
         rsX0/JQ+9CLBWK5wOGmo8fqZW/0iI/q+zzd1IrZBKMm0G27kGdG5UyrDI7/mtfbYoBCE
         nWdejcd7DXz4DhU5ADMGa0i1ys42I2y/8956E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jrb8MmGaC68emddPwQPjXM1GY7GuBgRkSODpa1XojoA=;
        b=gPbY7nHG66VdJmVdPNIBEVpbuifEA3YrMS3y/RYtofGOzmuTW3qIf/8EpUVmgJZsZC
         m8Bej5PRL6ap+LB8MToUfSzCFfvy6AnaUxmFk9CIiOz8x5sJSucYxMxgeAVV/aFNiPCe
         BsiEPC7GPTyOMb5/WjUw30X7TI2/CND4CInb0z4kahzVDocP/tmnyBike/u9O5nSQggA
         QFlcFtNHOMdgpdY0SGh5ZbvO55h7DWOvGg7utygu5e9L5j38f7ZEnQNn32MRXHIAO253
         TLjQf6w0nJX2jQrDYUsW0jMAqSC7CGzeAd8hx2FciyLCDkNEk5sgKs5afd9EI5dAT93d
         tYrw==
X-Gm-Message-State: AOAM533OclvJMsUPnpCbAwU0/UkMgZXDedrWSio73rQwHRKGIssRyOXV
        kR9hZk+NJ8l7ojrMzU8Eqh+qcQ==
X-Google-Smtp-Source: ABdhPJxy1IRPOXexnqBhdOFJX0C6Doap9TfWg7EDkycAW0RxoKdX1OxZ1jB+j6JRstZSIPeYJNiV9g==
X-Received: by 2002:a05:6602:2ac7:: with SMTP id m7mr28422332iov.66.1629750582194;
        Mon, 23 Aug 2021 13:29:42 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y12sm8635418ilm.81.2021.08.23.13.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 13:29:41 -0700 (PDT)
Subject: Re: [V2][PATCH] selftests/x86: Fix error: variably modified
 'altstack_data' at file scope
To:     Jun Miao <jun.miao@windriver.com>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210823135626.3926364-1-jun.miao@windriver.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <437f8945-cbd9-dccd-2d86-bd6746d1424c@linuxfoundation.org>
Date:   Mon, 23 Aug 2021 14:29:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210823135626.3926364-1-jun.miao@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/21 7:56 AM, Jun Miao wrote:
> Based on glibc 2.33 -> 2.34, there is one new feature:
> 
> NEWS for version 2.34
> =====================
> Major new features:
> * Add _SC_MINSIGSTKSZ and _SC_SIGSTKSZ.  When _DYNAMIC_STACK_SIZE_SOURCE
>    or _GNU_SOURCE are defined, MINSIGSTKSZ and SIGSTKSZ are no longer
>    constant on Linux.  MINSIGSTKSZ is redefined to sysconf(_SC_MINSIGSTKSZ)
>    and SIGSTKSZ is redefined to sysconf (_SC_SIGSTKSZ).  This supports
>    dynamic sized register sets for modern architectural features like
>    Arm SVE.
> 
> Build error with the GNU C Library 2.34:
> DEBUG:	| sigreturn.c:150:13: error: variably modified 'altstack_data' at file scope
> | sigreturn.c:150:13: error: variably modified 'altstack_data' at file scope
> DEBUG:	|   150 | static char altstack_data[SIGSTKSZ];
> |   150 | static char altstack_data[SIGSTKSZ];
> DEBUG:	|       |             ^~~~~~~~~~~~~
> 

Please give more context on why this change is needed?

Doesn't look like you tried to compile this patch before
sending this to me.

> Signed-off-by: Jun Miao <jun.miao@windriver.com>


thanks,
-- Shuah
