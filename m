Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4DE3164F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhBJLSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhBJLMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:12:20 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14F4C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:11:39 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r21so1985794wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+4PQbDkgN9ma23iEvdVJptQ3V05007RBQo09oRIADY0=;
        b=cAGrzzuDpMyMx9zeHVxV8zzXndWSOBxcAiA8Q2fzJpvwbWPzBwJX+Ks5FoY/wEcAMb
         U5yVawsoLPVK/aIKDXL5HcywijuYJML4X3/NcMTGsA5oKoAXaejqn5hKaBZNn78r4qm9
         zsip4sZMqdAt1JNkr4CDubIDtTF/6J/27d8O0TbEOqrcxmzBbFgtsmGuIFnyJy5MBCPW
         KH/voTqThO5o3pbw8VXfgxDN6y4S7lcDrDizA8uLaf+m1JSprazI3dMmAr/7zltJiUYy
         1oRem3Gc2w9HZ6TXk3Ug5lgQ4Sdqzb1LMFTEO+YShKgs975lrU4SeZ2GVpdLG3OLvwyb
         Cazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+4PQbDkgN9ma23iEvdVJptQ3V05007RBQo09oRIADY0=;
        b=enqnzRyPu2Y7xu1NicgKRLAEGscwVOyIgslv1Or5ip8HAt5CZJkew5O7H8lCpwsGYX
         2hK/WK48xw26vduHudWhuzBjZWczOEVQ4zwg1FyqvB1aU3LIwPSDnwPTUoQGv+lUGgn+
         tAqVmBgoJXRRgWO25LNtVHNf6R08VHsZv5wZG3FJeS9osOYx2LlFfrpupIsAXBB8Ql9g
         Rq+BoJLRg0YvsU3uKUp+xazlOh/GxvIE283Svio8T6kX4BYxT0KnVzRBCbSHLotqZIcX
         IW2RNC0hWHVGgQgFRJj638th0KfCMnyS/RYrsaM2/GBoDnqQoZ7f1HWYHJRYZX7eiAwI
         VYWQ==
X-Gm-Message-State: AOAM531zkaXFhBj3pgCQQL9IAC3Gk1KQfVEqCubfBsZ2e/fYDvdu7zHN
        WFY1XElgj/422LtNG3772n86sA==
X-Google-Smtp-Source: ABdhPJylZFyEw0m+WWAQyCxMXaWhtWJF3P157jdX/UsfgWQDUHkMuezWf4uQ7pspK79rtEJEKtL+rQ==
X-Received: by 2002:adf:f647:: with SMTP id x7mr2941035wrp.160.1612955498200;
        Wed, 10 Feb 2021 03:11:38 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:a559:3455:b3db:9311])
        by smtp.gmail.com with ESMTPSA id t15sm1889365wmi.48.2021.02.10.03.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 03:11:37 -0800 (PST)
Date:   Wed, 10 Feb 2021 12:11:31 +0100
From:   Marco Elver <elver@google.com>
To:     Timur Tabi <timur@kernel.org>
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
Subject: Re: [PATCH 0/3][RESEND] add support for never printing hashed
 addresses
Message-ID: <YCO/Y8cM/n5YRRJJ@elver.google.com>
References: <20210210051814.845713-1-timur@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210210051814.845713-1-timur@kernel.org>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 11:18PM -0600, Timur Tabi wrote:
> [accidentally sent from the wrong email address, so resending]
> 
> [The list of email addresses on CC: is getting quite lengthy,
> so I hope I've included everyone.]
> 
> Although hashing addresses printed via printk does make the
> kernel more secure, it interferes with debugging, especially
> with some functions like print_hex_dump() which always uses
> hashed addresses.
> 
> To avoid having to choose between %p and %px, it's easier to
> add a kernel command line that treats all %p as %px.  This
> encourages developers to use %p more without making debugging
> more difficult.
> 
> Patches #1 and #2 upgrade the kselftest framework so that
> it can report on tests that were skipped outright.  This
> is needed for the test_printf module which will now skip
> %p hashing tests if hashing is disabled.
> 
> Patch #2 upgrades the printf library to check the command
> line.  It also updates test_printf().
> 
> Timur Tabi (3):
>   lib/test_printf: use KSTM_MODULE_GLOBALS macro
>   kselftest: add support for skipped tests
>   [v2] lib/vsprintf: make-printk-non-secret printks all addresses as
>     unhashed
> 
>  .../admin-guide/kernel-parameters.txt         | 15 +++++++
>  lib/test_printf.c                             | 12 +++++-
>  lib/vsprintf.c                                | 40 ++++++++++++++++++-
>  tools/testing/selftests/kselftest_module.h    | 18 ++++++---
>  4 files changed, 75 insertions(+), 10 deletions(-)

I wanted to test this for deciding if we can show sensitive info in
KFENCE reports, which works just fine now that debug_never_hash_pointers
is non-static. FWIW,

	Acked-by: Marco Elver <elver@google.com>

But unfortunately this series broke some other test:

| In file included from lib/test_bitmap.c:17:
| lib/test_bitmap.c: In function ‘test_bitmap_init’:
| lib/../tools/testing/selftests/kselftest_module.h:45:48: error: ‘skipped_tests’ undeclared (first use in this function); did you mean ‘failed_tests’?
|    45 |  return kstm_report(total_tests, failed_tests, skipped_tests); \
|       |                                                ^~~~~~~~~~~~~
| lib/test_bitmap.c:637:1: note: in expansion of macro ‘KSTM_MODULE_LOADERS’
|   637 | KSTM_MODULE_LOADERS(test_bitmap);
|       | ^~~~~~~~~~~~~~~~~~~
| lib/../tools/testing/selftests/kselftest_module.h:45:48: note: each undeclared identifier is reported only once for each function it appears in
|    45 |  return kstm_report(total_tests, failed_tests, skipped_tests); \
|       |                                                ^~~~~~~~~~~~~
| lib/test_bitmap.c:637:1: note: in expansion of macro ‘KSTM_MODULE_LOADERS’
|   637 | KSTM_MODULE_LOADERS(test_bitmap);
|       | ^~~~~~~~~~~~~~~~~~~
| lib/../tools/testing/selftests/kselftest_module.h:46:1: error: control reaches end of non-void function [-Werror=return-type]
|    46 | }       \
|       | ^
| lib/test_bitmap.c:637:1: note: in expansion of macro ‘KSTM_MODULE_LOADERS’
|   637 | KSTM_MODULE_LOADERS(test_bitmap);
|       | ^~~~~~~~~~~~~~~~~~~

My allyesconfig build suggests test_bitmap.c is the only one, so it
should probably be fixed up in this series.
 
Thanks,
-- Marco
