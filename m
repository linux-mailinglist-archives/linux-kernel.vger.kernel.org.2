Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AC6397A60
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 21:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhFATDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 15:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbhFATDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 15:03:33 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AA9C061761
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 12:01:50 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id p20so20687793ljj.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 12:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RAu0njSTC+kf8drexs7MaZKoE+RFr/l6rpBisM//YE8=;
        b=Ubm1IKre509GEWJnIt1bo0fRJNfmHccoI20TkXQ9yfHdF/oebFoF8keJiNoiUOrs7X
         VfT4DycS9NU6tC6PB5TL9w1v0tqnoJiSrlqYUM0sNWE2MwixNys6XjGaG7v6mpXb57b7
         LWKaKfyXXz9TMrKN2/lbmduSACCMKLBdvT3SM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RAu0njSTC+kf8drexs7MaZKoE+RFr/l6rpBisM//YE8=;
        b=NGKQ46YVWNpS77Us/q5yDceGs6pMm2/bbDFfkggmNOVjokWNDj7kSuGsqwUrKjeZb1
         MKiHwkBkwF5hG/1MAeMthHgZfC868nghsiwV/Ps48GDh6FeMrjg/FCo0TXqRBh8thVN7
         cvXiGngBPjXo98qGL+aW1lcQZ6PDu+flx4DzibEHK3PyI2GizK2IAIEkEb1PwXZuCjbm
         OXa3M893zlINLpBhmtCIAvK/mJVtEQ/MEb/ZzfsfT2cJslnXOTSYqDuVW6tQ8od78e/t
         yqfWl7+4DnZJV7u4xeT/x/dpnuX37rIvfS8LtTHoGeU2oPkDnGCuTNt2wFsOOnKs1p3y
         Sc5g==
X-Gm-Message-State: AOAM530DMCQsNm44GLRnwmFK6LxbpLGiEbZK8Kka2MvTxR5vHGcfKFvK
        4jYYyS699J69ETaYu5BYS3h7xg==
X-Google-Smtp-Source: ABdhPJw9s8bBsmzDHRpKgKg/J93DXW07RWbA/3WaPNRwJsVn9SJW571H6MDEnq3hSiz8E+K7r3/Pmg==
X-Received: by 2002:a05:651c:2c7:: with SMTP id f7mr22407178ljo.255.1622574107996;
        Tue, 01 Jun 2021 12:01:47 -0700 (PDT)
Received: from [172.17.20.140] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g2sm2103831ljn.35.2021.06.01.12.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 12:01:47 -0700 (PDT)
Subject: Re: [PATCH RFCv2 2/3] lib/vsprintf.c: make %pD print full path for
 file
To:     Matthew Wilcox <willy@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Justin He <Justin.He@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
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
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <AM6PR08MB437691E7314C6B774EFED4BDF7229@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <YLEDwFCPcFx+qeul@casper.infradead.org>
 <AM6PR08MB437615DB6A6DEC33223A3138F7229@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <YLEKqGkm8bX6LZfP@casper.infradead.org>
 <AM6PR08MB43764764B52AAC7F05B71056F73E9@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <YLZSgZIcWyYTmqOT@casper.infradead.org>
 <CAHp75VfYgEtJeiVp8b10Va54QShyg4DmWeufuB_WGC8C2SE2mQ@mail.gmail.com>
 <YLZVwFh9MZJR3amM@casper.infradead.org> <YLZX9oicn8u4ZVCl@smile.fi.intel.com>
 <YLZcAesVG1SYL5fp@smile.fi.intel.com> <YLZoyjSJyzU5w1qO@casper.infradead.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <39f599a7-9175-f220-3803-b1920ddb8d40@rasmusvillemoes.dk>
Date:   Tue, 1 Jun 2021 21:01:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLZoyjSJyzU5w1qO@casper.infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2021 19.05, Matthew Wilcox wrote:

> Here's some examples, what do you think makes sense?
> 
> snprintf(buf, 16, "bad file '%pD'\n", q);
> 
> what content do you want buf to have when q is variously:
> 
> 1. /abcd/efgh
> 2. /a/bcdefgh.iso
> 3. /abcdef/gh
> 
> I would argue that
> "bad file ''\n"
> is actually a better string to have than any of (case 2)
> "bad file '/a/bc"
> "bad file 'bcdef"
> "bad file 'h.iso"
> 

Whatever ends up being decided, _please_ document that in
machine-readable and -verifiable form. I.e., update lib/test_printf.c
accordingly.

Currently (and originally) it only tests %pd because %pD is/was
essentially just %pd with an indirection to get the struct dentry* from
a struct file*.

The existing framework is strongly centered around expecting '/a/bc (see
all the logic where we do multiple checks with size 0, size random, size
plenty, and for the random case check that the buffer contents match the
complete output up till the randomly chosen size), so adding tests for
some other semantics would require a bit more juggling.

Not that that should be an argument in favor of that behaviour. But FWIW
that would be my preference.

Rasmus


