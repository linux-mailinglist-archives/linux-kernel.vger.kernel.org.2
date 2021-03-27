Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C943E34B9F9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 23:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhC0Wit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 18:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhC0WiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 18:38:18 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3B2C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 15:38:18 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f10so6956406pgl.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RHjeeJhhxAMEgqVsCYKevD2kOR6mkQfGB9R2VirR+KQ=;
        b=CC1yNumwuzg2zUeNhA9HBNmQTFGL7tjIHcm8KTrSTBMb4eykrpzeqBchD3zoPhfx12
         ze47TtwkzM2M5McmhiuT5PVBTzHNWflBQ45EHx13PwxaDLcS+70LFZBNJuiGQo0QOy3N
         5DIEYwpF6e8IYomkrFCYvGHa7ROpqX5WWa8J5mrzWHNyJH/F6UZABCOwdFd1xu68vLFj
         AXxavXgfvU1SKnOr/6Vi4gFFZvPyy6okdIpEqVX08hOjZpGMBoVt4tfIRf1qfTfCsIyo
         e5aWaUWORD1a+D0f7ES1oozF5Ghj8VNgMOPxyKo6qF4pdojURWTSXrchuvIKxm0Q6eJm
         ogyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RHjeeJhhxAMEgqVsCYKevD2kOR6mkQfGB9R2VirR+KQ=;
        b=cDRY7CLbabb+z4oCxFCjs28+a2DuiEnF65rtEIhmgwiwxAYnlIDf740jVE9GMnXD6K
         R/Iq5zaBj5vecnKIEusSZenAWbQBMM4GvQpamfl+3wU9KhqS3AJu/cnfD5/97Zl7q+AC
         DU7B5RyupnQ38iFq7sFV0bZ9eSPK7ko8kNE9MO9Z1/bc7Mxubj8qASbqU/juLTASOYrx
         u+S2gKTqSGIRULAipsU++YATGL+3yX9AJmBl1gr5biVp34hFnR/4veEs4XT1KnN6RT9F
         7lNuWBTcXLYTd/gml2qPEs4dJHf4ylulK9Mfy5YY+cTm99VzyO2MPOJlGDTxL32bXKzu
         YWJg==
X-Gm-Message-State: AOAM530WQwiXGj+Uq6Y6kdpLq4PEIPZLaEYNY0nfXLsdz5G3H0lYO+na
        2fqd2tL9AugR63n/Md6RzIN6RhlXwTmMM9EdTnr9V52GRd88YQ==
X-Google-Smtp-Source: ABdhPJzdERl5ffDCYz3TZSLjpY7Cat9MrfEJJxZsEOrGmtXQvWnmjD+icmE2x/hHhjhgQROXIOqzkk488irE6oh6QU0=
X-Received: by 2002:a62:7c43:0:b029:1ef:20ce:ba36 with SMTP id
 x64-20020a627c430000b02901ef20ceba36mr19222229pfc.40.1616884697431; Sat, 27
 Mar 2021 15:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210326170347.37441-1-andriy.shevchenko@linux.intel.com> <YF+vHHxYQ1hnnNBm@zeniv-ca.linux.org.uk>
In-Reply-To: <YF+vHHxYQ1hnnNBm@zeniv-ca.linux.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 28 Mar 2021 00:38:00 +0200
Message-ID: <CAHp75Vfr3DrYxD2-=8q+KJwazGOnNHSUsX3Qod2xWBFKr=YZTg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Drop inclusion in bitmap.h
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 12:23 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Mar 26, 2021 at 07:03:47PM +0200, Andy Shevchenko wrote:
> > The bitmap.h header is used in a lot of code around the kernel.
> > Besides that it includes kernel.h which sometimes makes a loop.
>
> How much of the kernel does *not* end up pulling kernel.h anyway,
> making all subsequent includes fast no-ops?
>
> Realistically, any C compiler is going to recognize the case when
> included file has contents of form
>
> #ifndef <pp-id>
> #define <pp-id> <possibly empty sequence of preprocessor tokens>
> <lines>
> #endif
>
> where <lines> contain no exposed #else, #elif or #endif and
> remember that subsequent includes of that file should be ignored
> unless <pp-id> becomes undefined.

The problem here is not in C compiler, but in many unneeded loops that
make header hell dependencies.
For example, how you may move bitmap_zalloc() from C-file to the
header? Currently it's impossible.
And bitmap.h here is only a tip of an iceberg.

kerne.h is a dump of everything that even has nothing in common at all.
We may still have it, but in my new code I prefer to include only the
headers that I want to use, without the bulk of unneeded kernel code.

> AFAICS, on e.g. allmodconfig amd64 build it's (at most - there
> might've been false positives) 131 files out of ~30000; on
> defconfig it's 55 out of ~2300.  How much does your patch
> change that?

I'm not sure I understand what you mean here.

-- 
With Best Regards,
Andy Shevchenko
