Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2883CAFA3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 01:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhGOX0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 19:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhGOX03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 19:26:29 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9D9C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 16:23:34 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id m68so6929451qke.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 16:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AjtdaoQZ45bxzGgCiJntGt6g0pRHoR9DO7a2agOTNlc=;
        b=Y2s4sh/soW5dDmJ4H40KzRCbr0hs3j3SC7h8OU2TKaFP5nP83nI08bg8c1yQTPzZyS
         cQIrIvd2YaI0WAChCQsCbHk3YONTzqnTyx8t1SB2r319Uli3fsVqr5NXG0HZ7dMkZP7W
         vnwbfqXdv47mZIIJSuGmOPouyyQMvKcxAYShzQvL0TwRBU0aXvTcCLv2MZIPCJps2sTo
         ZooxxaopxGFQemqFnn7uOWrPSOIPb+8ZCzEKj2Op7aizEhtiBLOcUyodhwRWjDY2WLMO
         vIb9hHE4i6P/sfCue2EW/gCHAL7+H49j//wBev6cJLo/zF0ahmOvFLgdDIS4xNrVyB1n
         w3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AjtdaoQZ45bxzGgCiJntGt6g0pRHoR9DO7a2agOTNlc=;
        b=m1GhKjRrDe4pZ+mabs4gJfr+oxYd6oUvUN2SvqkjpAIpM61kG8F3Yb758lCT6/+qzk
         eGzyN2yTJQ1aih6AhkTjaMGx6SafS95m0hUiEtD3G5RKnZ4ZKoz+DR2ZcAjyBOAdJuOb
         s0ot9Ojby/ZFAQsmlBnNMOCy8FNKgej2Wba15KOqGbe/0ucGawXafqiVvQNVyo7DQjYB
         o6YredEjMeBRSNb1GWKF7lg/kWpSjRRbNNyS9+HNMGyKUXmV92n0aEzYy/X8ec4X7hNx
         b4Wm8qSeVfohDwTjimw7kpWUuVmmM7t4aNoTqRmYpoHwpHjh/w3svUpg9fg0O8I1/ICK
         ArhA==
X-Gm-Message-State: AOAM533CvXbhY87HxTLxidDM8aUYkBlyL7F2hLfo1bdfD/M+wYblSjP0
        UL5I0G/l2BCKAtzyXEPbr5w=
X-Google-Smtp-Source: ABdhPJxMMCD85p1KEIX8VE2rohxiP2iEb8AwlHdJASvdDVJNd++dOyv9LYPa1XjQT2+bEJ8JytMWHw==
X-Received: by 2002:ae9:f30c:: with SMTP id p12mr6459406qkg.153.1626391413877;
        Thu, 15 Jul 2021 16:23:33 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id az37sm3143017qkb.91.2021.07.15.16.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 16:23:33 -0700 (PDT)
Date:   Thu, 15 Jul 2021 16:23:32 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Guodong Xu <guodong.xu@linaro.org>, tangchengchang@huawei.com,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        yangyicong <yangyicong@huawei.com>, tim.c.chen@linux.intel.com,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v7 4/4] lib: test_bitmap: add bitmap_print_to_buf test
 cases
Message-ID: <YPDDdAwgYEptz2Uq@yury-ThinkPad>
References: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
 <20210715115856.11304-5-song.bao.hua@hisilicon.com>
 <YPAlg5c8uDSZ2WvZ@smile.fi.intel.com>
 <YPCe+f3GPDUuvwnW@yury-ThinkPad>
 <CAHp75VcoNPiKDaZzTVr3unV3F5u+LQwAjy1hKSq0WUw_tB6uAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcoNPiKDaZzTVr3unV3F5u+LQwAjy1hKSq0WUw_tB6uAw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 12:32:45AM +0300, Andy Shevchenko wrote:
> On Thu, Jul 15, 2021 at 11:48 PM Yury Norov <yury.norov@gmail.com> wrote:
> > On Thu, Jul 15, 2021 at 03:09:39PM +0300, Andy Shevchenko wrote:
> > > On Thu, Jul 15, 2021 at 11:58:56PM +1200, Barry Song wrote:
> > > > The added test items cover both cases where bitmap buf of the printed
> > > > result is greater than and less than 4KB.
> > > > And it also covers the case where offset for bitmap_print_to_buf is
> > > > non-zero which will happen when printed buf is larger than one page
> > > > in sysfs bin_attribute.
> > >
> > > More test cases is always a good thing, thanks!
> >
> > Generally yes. But in this case... I believe, Barry didn't write that
> > huge line below by himself. Most probably he copy-pasted the output of
> > his bitmap_print_buf() into the test. If so, this code tests nothing,
> > and just enforces current behavior of snprintf.
> 
> I'm not sure I got what you are telling me. The big line is to test
> strings that are bigger than 4k.

I'm trying to say that human are not able to verify correctness of
this line. The test is supposed to check bitmap_print_to_buf(), but
reference output itself is generated by bitmap_print_to_buf(). This
test will always pass by design, even if there's an error somewhere
in the middle, isn't it?

> 
> ...
> 
> > > > +static const char large_list[] __initconst = /* more than 4KB */
> > > > +   "0,4,8,12,16,20,24,28,32-33,36-37,40-41,44-45,48-49,52-53,56-57,60-61,64,68,72,76,80,84,88,92,96-97,100-101,104-1"
> > > > +   "05,108-109,112-113,116-117,120-121,124-125,128,132,136,140,144,148,152,156,160-161,164-165,168-169,172-173,176-1"
> > > > +   "77,180-181,184-185,188-189,192,196,200,204,208,212,216,220,224-225,228-229,232-233,236-237,240-241,244-245,248-2"
> >
> > I don't like this behavior of the code: each individual line is not a
> > valid bitmap_list. I would prefer to split original bitmap and print
> > list representation of parts in a compatible format; considering a
> > receiving part of this splitting machinery.
> 
> I agree that split is not the best here, but after all it's only 1
> line and this is on purpose.

What I see is that bitmap_print_to_buf() is called many times, and
each time it returns something that is not a valid bitmap list string.
If the caller was be able to concatenate all the lines returned by
bitmap_print_to_buf(), he'd probably get correct result. But in such
case, why don't he use scnprintf("pbl") directly?

If there exists a real case where scnprintf("pbl") output is too long
(or execution time is too slow) that we need to split, the right
approach is to split the original bitmap, not an output of
scnprintf("pbl").

And I still don't understand, what prevents the higher levels from
calling the scnprintf() directly in this specific case?
