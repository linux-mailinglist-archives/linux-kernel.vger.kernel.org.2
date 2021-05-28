Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3013947C6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 22:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhE1UIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 16:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhE1UIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 16:08:18 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494C9C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:06:41 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b18so2886440lfv.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 13:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SOmtzfnBo6NCPJmKRQ2bxbkBgbCrNqNnPAbwGffPcTs=;
        b=L006ZDgfzIz2uNo0e1HI0KncA6d5iUevfwGopHwj6KZ0AzwLFmI7P+KSXJTBenAtKt
         YvhygMCnEymm4R7ZuS6YSodjYjIrJh7LSsEhj+yn2mu+dh45d5tZjF54ls96OiZjrKl0
         /pLSn9bC8pY1aZrCrWbmH+zopo0dZdc4fx0t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SOmtzfnBo6NCPJmKRQ2bxbkBgbCrNqNnPAbwGffPcTs=;
        b=iamj5aLXzGPGclKKEEYVBWtpQPdJ5HYqh6b6NK4Y8SezhLEO8HGQJLPKTfg/2kz5OK
         Gq87m0SYrXnSSL/DNe6NJY2ZxbEyXK6pX0pShWJH4EcFNUoKSN2HBtUFAv/1kiBi42Te
         0Jz1gnVIx2fjboABGo2c2A7o6ky6nV0chKZMoPttPVTvNOMxCr7Jwxy7EBqV5/EuhfiZ
         Wzi1EWqVTRGbbU2eJEBcZ1G9LLH9boJkEbc/dgZoegy9uoFostwFxI4pwzpFDIXNhc0b
         r09bpyBGkn5aWiqjbwHLImMVhELHJqRyBip9BQg9bGKyAItiE8srbXYAblVnDyhNFNI7
         qqZA==
X-Gm-Message-State: AOAM531uwOpQ2cVyWT6C+4Zj973ibx+zpG/yZcIeRbVzE+VVIqC2d2jn
        L9qDGh3i49GVEqwHSJRKFZkmXw==
X-Google-Smtp-Source: ABdhPJzKa/84djfH8kXaEz32MIwheVqy9u5D3igsMvIDbXW8m90h4yHajGL+aZ2UQYuvum5S2hn3pA==
X-Received: by 2002:a05:6512:28e:: with SMTP id j14mr6669923lfp.360.1622232399648;
        Fri, 28 May 2021 13:06:39 -0700 (PDT)
Received: from [172.17.20.105] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id k8sm600385lfg.190.2021.05.28.13.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 13:06:39 -0700 (PDT)
Subject: Re: [PATCH RFCv2 2/3] lib/vsprintf.c: make %pD print full path for
 file
To:     Justin He <Justin.He@arm.com>, Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Johannes Berg <johannes.berg@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
References: <20210528113951.6225-1-justin.he@arm.com>
 <20210528113951.6225-3-justin.he@arm.com>
 <YLDpSnV9XBUJq5RU@casper.infradead.org>
 <AM6PR08MB437691E7314C6B774EFED4BDF7229@AM6PR08MB4376.eurprd08.prod.outlook.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <89fc3919-ca2c-50fd-35e1-33bf3a59b993@rasmusvillemoes.dk>
Date:   Fri, 28 May 2021 22:06:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <AM6PR08MB437691E7314C6B774EFED4BDF7229@AM6PR08MB4376.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/2021 16.22, Justin He wrote:
> 
>> From: Matthew Wilcox <willy@infradead.org>

>> How is it "safer"?  You already have a buffer passed from the caller.
>> Are you saying that d_path_fast() might overrun a really small buffer
>> but won't overrun a 256 byte buffer?
> No, it won't overrun a 256 byte buf. When the full path size is larger than 256, the p->len is < 0 in prepend_name, and this overrun will be
> dectected in extract_string() with "-ENAMETOOLONG".
> 
> Each printk contains 2 vsnprintf. vsnprintf() returns the required size after formatting the string.>
> 1. vprintk_store() will invoke 1st vsnprintf() will 8 bytes space to get the reserve_size. In this case, the _buf_ could be less than _end_ by design.
> 2. Then it invokes 2nd printk_sprint()->vscnprintf()->vsnprintf() to really fill the space.

Please do not assume that printk is the only user of vsnprintf() or the
only one that would use a given %p<foo> extension.

Also, is it clear that nothing can change underneath you in between two
calls to vsnprintf()? IOW, is it certain that the path will fit upon a
second call using the size returned from the first?

Rasmus
