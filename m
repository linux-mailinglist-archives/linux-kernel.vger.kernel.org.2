Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B01316F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbhBJTD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:03:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234345AbhBJTD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:03:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5881F64E38;
        Wed, 10 Feb 2021 19:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612983795;
        bh=kTZfGdggxRtHZYIgCu8OFfF7udm1XiwSqpQUqRrxP0I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=T2Ix9cSxTBKT8MYrTLvLkcmI42l+LSfT1D//OioH+2yxHRiPsjMdo2V9TVEcRV1kn
         Dyl+oMt0i2DFFvBa8/gISyAS1RSex/W+2rmANgQW3+ngmDtbYyuQ8MZetKycsZG/Jq
         Afgjg6cSoZ8XN1pGmhqktNpWmIIBOy1wh+ngP6ahI6ufS+oQ5qXGKA5hRYWpOLrAjf
         IO5DTZIFDc0Rv1GFA9U7pTvKtpmNbtiNK9BTMV3fpbyAgUe6IHBof3HDTVnZflJ+8H
         4G1iZ7tMplCMgszR3d1/3E33z8QXKhcnO7UZXemPvF3gz6BZrnsW7usMoSEYVKMge8
         RF0CQKJDgSm5Q==
Subject: Re: [PATCH 0/3][RESEND] add support for never printing hashed
 addresses
To:     Marco Elver <elver@google.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        roman.fietze@magna.com, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        akinobu.mita@gmail.com, glider@google.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210210051814.845713-1-timur@kernel.org>
 <YCO/Y8cM/n5YRRJJ@elver.google.com>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <7247c04a-e05c-167e-32f6-f88476cc8842@kernel.org>
Date:   Wed, 10 Feb 2021 13:03:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YCO/Y8cM/n5YRRJJ@elver.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/21 5:11 AM, Marco Elver wrote:
> I wanted to test this for deciding if we can show sensitive info in
> KFENCE reports, which works just fine now that debug_never_hash_pointers
> is non-static. FWIW,
> 
> 	Acked-by: Marco Elver<elver@google.com>

Thank you.

> But unfortunately this series broke some other test:
> 
> | In file included from lib/test_bitmap.c:17:
> | lib/test_bitmap.c: In function ‘test_bitmap_init’:
> | lib/../tools/testing/selftests/kselftest_module.h:45:48: error: ‘skipped_tests’ undeclared (first use in this function); did you mean ‘failed_tests’?

This will be fixed in v3.  Thanks.
