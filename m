Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5F73A3DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhFKICF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:02:05 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:35581 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFKICD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:02:03 -0400
Received: by mail-pl1-f179.google.com with SMTP id x19so2441931pln.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NcNsMtMZJW2zk9YNIreDVWyjYe0TDH8l7DU3QNkDcEI=;
        b=XCfGaQOxJLUoO+PjZUtq4d7JrSxZKgp6GPV5G8uIGjj3O1xf9M/m8GuPG1m+vQ/Fkj
         omnVzrDGcPtHv1n1fYiXOhhY3cecgdpSBtQxzkToxH/zvIPNfxqm4JcpwRUxFt2LXkk6
         HGZzA2V03A0e1nHZALsXJlV0X4e7yjO72wcqmc/676Po91Lub4slOjPZ6IP+DMG6ijE3
         ZixtfkssrCDyEaVBkUE0okOeV90bQRjtEjSmLkh4kosVvIGEo3BppmJBLq7lrRk8gBmx
         l7sRA/iACyMosJBw5qqhsjQh95sPGtxuyhEl7hwgiLtmwp4i43rd+dXAu13CE9xmA+Y5
         QXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NcNsMtMZJW2zk9YNIreDVWyjYe0TDH8l7DU3QNkDcEI=;
        b=VmhdBU3uQjhVGV4h/ndKQ1XfheHzA1kVGfGPapLsOFn/d+8oFkaozDPJpJJd+sp1p5
         nF69uiGypUz9+WsLj7BU9Va59CbEzEHGFLghJ4oM+7+7Zof/jyqQwLzoJrXH9YIJW/vd
         A2rwtm4KzF+wa+QcXWM5lJgQKxAZt/tO3jOH4LRF6/Cj75Hg4UheIRxH5JZWdPY9MeMY
         26oGHmWHv+UEfH4wh/YEPzkeIwf8rEb0aq8b4Q4OYrzIEulYmCn4GPP8ATub40pPVBp0
         k6pWcgDHJCgDuMzsERG1FV8X4S+FSGBPkKy7f1+RTuOx369x75km5BT9bt6RDrv7XI6p
         u9Mg==
X-Gm-Message-State: AOAM530La6PFgVDplQeo/d9OYQs1iCdW1+n42a0FOva5FBEC2lNQv56D
        Z5Ik3PWbwZRBVBJW3pE+QAaRJNR/ezI1doFuzpo=
X-Google-Smtp-Source: ABdhPJxcSlyNJ+65bw8EVekh3K0PUcxpEG25Lmev8oT9zEgFrugaC7JLmkPTyCYWOuNz+SEIrXnOfD3pYSREKtd44Ts=
X-Received: by 2002:a17:90a:80c5:: with SMTP id k5mr7981045pjw.129.1623398346088;
 Fri, 11 Jun 2021 00:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210611071241.16728-1-thunder.leizhen@huawei.com> <20210611071241.16728-2-thunder.leizhen@huawei.com>
In-Reply-To: <20210611071241.16728-2-thunder.leizhen@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 11 Jun 2021 10:58:49 +0300
Message-ID: <CAHp75VfX95GVkd6iJ-aYNp7nO56nLSxgreE4fDXAm3h3p6VEjg@mail.gmail.com>
Subject: Re: [PATCH 1/3] scripts: add spelling_sanitizer.sh script
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Joe Perches <joe@perches.com>, Jason Baron <jbaron@akamai.com>,
        Stefani Seibold <stefani@seibold.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Axboe <axboe@kernel.dk>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 10:19 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> The file scripts/spelling.txt recorded a large number of
> "mistake||correction" pairs. These entries are currently maintained in
> order, but the results are not strict. In addition, when someone wants to
> add some new pairs, he either sort them manually or write a script, which
> is clearly a waste of labor. So add this script. It removes the duplicates
> first, then sort by correctly spelled words. Sorting based on misspelled
> words is not chose because it is uncontrollable.

chosen

...

> +#!/bin/sh

If you want to have stricter rules applied, use
#!/bin/sh -efu
in all your shell scripts, it will show you a lot of problems.

Missed SPDX.

> +src=spelling.txt

> +tmp=spelling_mistake_correction_pairs.txt

It will pollute the source tree, so use `mktemp` or utilize O=. In
case there is no O= supplied (or whatever equivalent to describe
output folder) you will get it in the source tree, so it needs to be
Git-ignored.

> +cd `dirname $0`

Useless use of dirname. Check for %, %%, #, and ## substitutions (`man sh`).
IIRC dirname equivalent is ${0%/*}.

> +# Convert the format of 'codespell' to the current
> +sed -r -i 's/ ==> /||/' $src
> +
> +# Move the spelling "mistake||correction" pairs into file $tmp

> +# There are currently 9 lines of comments in $src, so the text starts at line 10
> +sed -n '10,$p' $src > $tmp
> +sed -i '10,$d' $src

This is fragile, use proper comment line detection.

> +# Remove duplicates first, then sort by correctly spelled words
> +sort -u $tmp -o $tmp
> +sort -t '|' -k 3 $tmp -o $tmp

Can be one pipeline

> +# Append sorted results to comments
> +cat $tmp >> $src

I believe it can be done in a better way, but I was not thinking about it.

> +# Delete the temporary file
> +rm -f $tmp

What if the script will be trapped? It's good to handle SIGHUP I
suppose, so we won't leave garbage behind us.

> +cd - > /dev/null

-- 
With Best Regards,
Andy Shevchenko
