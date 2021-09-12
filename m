Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93031407FAA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 21:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbhILTTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 15:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbhILTTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 15:19:07 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0268AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:17:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id o8so1356920pll.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 12:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8mt2FRZeqYimYHzEQVx7rXtxD7Yn/OjWw1OJKBJgOrk=;
        b=eAereFvIbpprNdT0o3I8Mro8yyEKoRHVAbYc7MLj9bfdNL5h6c0NLyS/6vh/q13EkY
         zhiDkkpx4Ol7EDmlFj+nfgHU7HRHF/I4rI8u63uQMT+Y1ClNJbYo4GBkuz1iXy8aIRmj
         /hN4k1DzxF9W5Oa4gB2Gio0F8RMt6leq+FAKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8mt2FRZeqYimYHzEQVx7rXtxD7Yn/OjWw1OJKBJgOrk=;
        b=oSOIOFFghMa8VhourSPTfM8+zTkJ6X0/+DEsB1cMf2SHSnKGpSJMHmJml/08moN/bH
         fElwxrtxGij+eOvlCuGZ+ZJ3qEwyTPXpxFgNVRdhOt4+K3+brplDEiXbJw1A5p5zC7UD
         nYo6YB9scoq9tLsI55aUs/1uM9T4qf8V5PmOV8goAT12X9jjEBPDGqwE8VuWXjJqs7ve
         B9UQQ8+xvZw2BDA8kjTY3WVBNwHoccautwx9uLSAN/NjMrctCLjMCgBSSG2CLIXSbCHK
         jWjqzQvFeL95n5+CByggMUrY82kJkjsOV/NmH57wwxdFOKy4rg5A86q/iBK2XUtY/5UU
         U65g==
X-Gm-Message-State: AOAM53186E0W3+IOwqLmU0mGdZoF0aEF4eQVl86XyS2q9pf2et6zQAAa
        OHrBQw8p2rOq4UI4HGol0N6PeQ==
X-Google-Smtp-Source: ABdhPJyriW74lmYvmDJGr0xLlbz7qpdNg+OqXSZV4S2BsL8NQJPNrFYN94Kgbh0TcvZsVqziaB9N/w==
X-Received: by 2002:a17:90a:1990:: with SMTP id 16mr8927258pji.11.1631474271536;
        Sun, 12 Sep 2021 12:17:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e19sm4674932pfd.45.2021.09.12.12.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 12:17:51 -0700 (PDT)
Date:   Sun, 12 Sep 2021 12:17:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Misc driver fix for 5.15-rc1
Message-ID: <202109121213.A47D575@keescook>
References: <YT4IvKLQHm9mfpR+@kroah.com>
 <CAHk-=wh7FYyewcJkozsjA95yj0AYvmpMDoZd0RxQ3ZbMMdXUdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh7FYyewcJkozsjA95yj0AYvmpMDoZd0RxQ3ZbMMdXUdQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2021 at 12:03:35PM -0700, Linus Torvalds wrote:
> Could we please just stop pointlessly printing out kernel version data
> that  is already available other ways? Just do 'dmesg', or 'uname -r'
> or whatever instead of insisting on printing out redundant
> information?

This was done to deal with the various mangling of reports (i.e.
"summaries") I've been getting from CI systems that run LKDTM. It has been
difficult to reliably extract actionable details, so instead I included
it with the test output. And the extra details go the other way too:
frequently folks configuring the CI have no context for why tests fail,
and LKDTM usually has a reasonable amount of information about what
Kconfig settings have gone missing, etc, so those hints are reported as
well.

-- 
Kees Cook
