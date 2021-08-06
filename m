Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECDE3E28F5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245086AbhHFK5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhHFK47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:56:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C037CC061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 03:56:43 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628247401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C03BkgqLQ9ruY//c0rzNTOJoKiptzTsTimQnhDnEo40=;
        b=FMiU0j+YGqYaWcVDgoHhfo024/sOltzqJh7K+3Hl81SoE8wMQv7b3fQjoq+bRweQdbpJ3C
        vI5dx41nxFhchrq9yDnpR3cnd6YPhmAMSuIPAbEc6GwdimUxj5lnFgbToUT5mWBEH+CJhv
        qhPQ3faEWEDr9ThE0MlEboBuI2om7jJ/cmg/Z4b9izqjVxMTI0SukOmpa2RfHtrpWlzTlY
        1tc7ZZa/4tT4liKj/4sgIcmq2DzCK3TVUX+p3reI/GayF0EUbo+mc9DhIVO+AWPkswFrvm
        YL9Avwj82Mq4iPXkS3HJogm5bjrMziaLZ3u/b4hSxvmvlDFV4Ob+cS0eww1s2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628247401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C03BkgqLQ9ruY//c0rzNTOJoKiptzTsTimQnhDnEo40=;
        b=FyGc/FkcK9Xej8O9sJISb/NRjecamjdh5SRFVWyE/ewQb6+PmhVX6093fIf0dYmZnRpXSx
        9z+NR4J/8pM8eBCg==
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Changbin Du <changbin.du@intel.com>
Subject: Re: [PATCH printk v1 07/10] console: add write_atomic interface
In-Reply-To: <YQlMZT1Isc1zS9A9@smile.fi.intel.com>
References: <20210803131301.5588-1-john.ogness@linutronix.de> <20210803131301.5588-8-john.ogness@linutronix.de> <YQlMZT1Isc1zS9A9@smile.fi.intel.com>
Date:   Fri, 06 Aug 2021 13:02:40 +0206
Message-ID: <87tuk2j0yf.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-03, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>>  #include <linux/atomic.h>
>>  #include <linux/types.h>
>> +#include <linux/printk.h>
>
> Ordered?

Agreed. v2 will include printk.h first.

>> +			if (!(con->flags & CON_ENABLED))	\
>> +				continue;			\
>
> What about
>
> #define console_is_enabled(con)		(!!(con->flags & CON_ENABLED))
>
> or inliner equivalent
>
> static inline bool console_is_enabled(struct console *con)
> {
> 	return !!(con->flags & CON_ENABLED);
> }

Generally kernel code uses the console flags directly. A quick check for
CON_ENABLED shows direct flag queries all over:

$ git grep -l -e 'flags.*& .*CON_ENABLED' | wc -c
16

Are you suggesting I replace this usage in all of these files? Or just
the one macro in console.h for now? And since there are 6 more console
flags, they should probably also have equivalent wrappers?

Thanks.

John Ogness
