Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2D13A7841
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 09:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhFOHtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 03:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhFOHtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:49:39 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E749C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 00:47:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s6so49780197edu.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 00:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KBRdVIOa/asDmbEumkxjOA8DSurhtMGcGIoG3TYPT2Y=;
        b=Crcal5RtkkBcDXdj5iAxnD1gvaFJfEwDwRgm8xZ3EAOu4RtYaSVDFtFHKFShRPlhAl
         npephrwP1CJpcdeyMS//t5/d1phcMaiAJQmWJAdCIIH0UP6ZQqOIwmnPf8VuFtbWJR9B
         5jD6Ol1iZrpaHrkafsh7V369VJXsflwxQ6TBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KBRdVIOa/asDmbEumkxjOA8DSurhtMGcGIoG3TYPT2Y=;
        b=kC0CScFLrIXtcwJowz9RM6BUgXkZDx0sSS6D3Q0fwODP0yGu4s7unCw5iciTSS/NJA
         ncvGrHLyylDvN8X9PREvcwGSfPzqYzvnKHWothY3OpGpub5EF+qXcGzQ18TSxCB9S+lX
         JhgK2k/H/W0ZA8+sBoSKXHjTNwkTQl0+rTiPvDS61RzTT9fFCYehlBOBD9+QtfXyArzy
         GlXc6phI1fLxgazBEpXgIeI61n3RaCIZwjUvqM8I3FNUNCOJAEYD6LHFH2112+86w/Hq
         Mc70x0HSsN0Txb2djr6wqSOm8PzN2g2pNzU1r/8CIN+LsxsbLbPqANRiZ3MKbOgT7Dkh
         INOw==
X-Gm-Message-State: AOAM532js7WqTFAMO2/6v/wCAWTHas1ioekeMaPJXNJiP7qcwe4wDYTA
        bB4yBq7R6pumTJUzxoxDHJ8I/g==
X-Google-Smtp-Source: ABdhPJwNMbkXylErvIagkPbri2w/XvfHjlohoakbcrmNIZJjV8B28X6xTCIhWQnNhW0EWElzSW60cw==
X-Received: by 2002:aa7:c1da:: with SMTP id d26mr21437105edp.92.1623743253307;
        Tue, 15 Jun 2021 00:47:33 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id cf26sm9394124ejb.38.2021.06.15.00.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 00:47:32 -0700 (PDT)
Subject: Re: [PATCH RFCv3 3/3] lib/test_printf: add test cases for '%pD'
To:     Justin He <Justin.He@arm.com>, Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20210611155953.3010-1-justin.he@arm.com>
 <20210611155953.3010-4-justin.he@arm.com> <YMd5StgkBINLlb8E@alley>
 <AM6PR08MB4376096643BA02A1AE2BA8F4F7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <55513987-4ec5-be80-a458-28f275cb4f72@rasmusvillemoes.dk>
Date:   Tue, 15 Jun 2021 09:47:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <AM6PR08MB4376096643BA02A1AE2BA8F4F7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2021 09.07, Justin He wrote:
> Hi Petr
> 

>>> +static void __init
>>> +f_d_path(void)
>>> +{
>>> +   test("(null)", "%pD", NULL);
>>> +   test("(efault)", "%pD", PTR_INVALID);
>>> +
>>> +   is_prepend_buf = true;
>>> +   test("/bravo/alfa   |/bravo/alfa   ", "%-14pD|%*pD", &test_file, -14,
>> &test_file);
>>> +   test("   /bravo/alfa|   /bravo/alfa", "%14pD|%*pD", &test_file, 14,
>> &test_file);
>>> +   test("   /bravo/alfa|/bravo/alfa   ", "%14pD|%-14pD", &test_file,
>> &test_file);
>>
>> Please, add more test for scenarios when the path does not fit into
>> the buffer or when there are no limitations, ...
> 
> Indeed, thanks

Doesn't the existing test() helper do this for you automatically?

        /*
         * Every fmt+args is subjected to four tests: Three where we
         * tell vsnprintf varying buffer sizes (plenty, not quite
         * enough and 0), and then we also test that kvasprintf would
         * be able to print it as expected.
         */

I don't see why one would need to do anything special for %pD.

Rasmus
