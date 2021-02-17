Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C02F31D7EF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhBQLIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbhBQLHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:07:20 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C6FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 03:06:39 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f1so20800395lfu.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 03:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MwS831m1n6psR45EVgkCf+b/AQlrJ1Z/xieizsG7Xng=;
        b=D5fPkxhxdXGPtuBy7fS3LPZqJcgpEXb0+HlnxyRwfgihyLkIW3AJiW8nkodxy7By2I
         0iC6/ta7s16xMKKrgLgRiuw/e6vyzCv8q1RX37YKWQ83G765b1GFj/bhwug6CyiG+O8W
         9hjcKH6U8ndh2fx8R4MG+lPE28TsegzMrI9nKesJ7K38ueYuvMvbpKxmTuybZzX5l9y0
         5je2Vu2M8Jycf2JqlQZuwugcTMRUfm+ZdN6WoC0yKuRiYV5ghfyJaCRWx2ffUIH6CCow
         W+ZhPHkdTq//KhaEJ3QIL44ah6Fww4U8cL6XqyA/P2uDkQgruFOiFg/nrwMcUbSCgCWk
         6ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MwS831m1n6psR45EVgkCf+b/AQlrJ1Z/xieizsG7Xng=;
        b=IGc0Qy0qRlirJ2DmjhnYS/lOeSr2aBmxAhdSwrZ6MWhmXrdW2ttB/EwDgSfqR2LDCk
         8ArcooZ6PsEN7o9g7K+txcl9dVsAZ7xIGBusz/mSrS2mA+bAbBAlnhpHdBAIqI5qXxTV
         Yyq7PO+VwTgYDxqp0zOAea++RbJ7g/e/xZAr3AqC1Hpx5qrrJqWc2AKpnwWWdnF5gChN
         Z2W3FXnI1fjm3soBlvvEbQFUuoFIs4qGWcx+sG0vZgIMLBNDzMZnaqw7evo9TodtN5jg
         wMhWBzw9LmoAcuMjrRtngAycAKkWIC0FIa3rE5BTKoq8RWrnqX+GPXLZsUJ67x46kvCQ
         KTKw==
X-Gm-Message-State: AOAM530qJjmS3P4iuN49CEZofzQvKOLZk/Nym1psiWJYprannAGrdDsL
        tmHji/HkZo6BMVwk6lQJP9oB4x7pUxzJjSVHqbl4ZQ==
X-Google-Smtp-Source: ABdhPJwYy1FY3vO8pRA2SPYpVdqQHjNLkn9EQIvqD1qAzq8OcZlErQvrmfwwh4UCIAlqwTz4YM8VzTKz+vnqYPNbA/8=
X-Received: by 2002:ac2:5222:: with SMTP id i2mr3706138lfl.194.1613559998136;
 Wed, 17 Feb 2021 03:06:38 -0800 (PST)
MIME-Version: 1.0
References: <20210204150210.3nv734ktyeljsa6c@maple.lan>
In-Reply-To: <20210204150210.3nv734ktyeljsa6c@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 17 Feb 2021 16:36:26 +0530
Message-ID: <CAFA6WYOdprGAe7d6ryLYpvC657qEGt1nRkpmuErDAk+msdp3DA@mail.gmail.com>
Subject: Re: [peterz@infradead.org: Re: [PATCH] x86/kgdb: Allow removal of
 early BPs]
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@i4.cs.fau.de, qy15sije@cip.cs.fau.de,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, alexandre.chartre@oracle.com,
        rppt@kernel.org, ira.weiny@intel.com, adrian.hunter@intel.com,
        gustavoars@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> On Mon, Dec 14, 2020 at 03:13:12PM +0100, Stefan Saecherl wrote:
>
> > One thing to consider when doing this is that code can go away during boot
> > (e.g. .init.text). Previously kgdb_arch_remove_breakpoint handled this case
> > gracefully by just having copy_to_kernel_nofault fail but if one then calls
> > text_poke_kgdb the system dies due to the BUG_ON we moved out of
> > __text_poke.  To avoid this __text_poke now returns an error in case of a
> > nonpresent code page and the error is handled at call site.
>
> So what if the page is reused and now exists again?
>
> We keep track of the init state, how about you look at that and not poke
> at .init.text after it's freed instead?
>

Makes sense. I'll see if I can patch the debug core to get an
architecture neutral fix for this.

-Sumit
