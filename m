Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033313CAEA3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 23:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhGOVgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 17:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhGOVgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:36:16 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AD9C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 14:33:22 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id q10so6783363pfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 14:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zn4Tf8PL7zNftVDiLUo9rrZ9NLkeTwR/wjn2FJ4Gcps=;
        b=jJ5R1kkDqAcnQIFNtadt6Xq81B97HQlBqc/zOHhj87jGYev8DqssW3J2kZ7mMXa1uj
         b0jdIBDawjgcaq0HvKAeXo+iKjqUd4naGTKq3s9RuxD68kAiT0cwKOBOG+jqEStm00Se
         W1KCx3VFTUeuYu7M5/mT31fOX1WNHpYXkDSNBJk5sRF43aZrfh23TMY3pSvMcz9YEVhe
         qrkHe8/jHLS8uhsmLgaL/0WRMDXpRx5Tfdx1hUvLAJlUeHoNmS1sbc8JIE2vZyvcnzJY
         QV6MtwEFvM3bgvluZWmp0KHqI9eTzPynOq+fwB4BkPv0W+MRzOlPnmqTwjswPJPwhMhy
         M7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zn4Tf8PL7zNftVDiLUo9rrZ9NLkeTwR/wjn2FJ4Gcps=;
        b=K5Loe2q9Bf8gzWBTfkOs/hRYmhMlYE+NNfxuJ+HPZ8E/fpIFvthEnmwY6jYIDhjXa8
         RKk05GmhGO93bNMZVLSSchRLawB4NFazHEmLG+eDxxdi7ZodWjr6utWB/sB4F9BKWSGk
         9/oDKv/VHZRAMxPs0292KM3XRZTsyjwUmrRbwtuMgEuiB0OCqfJ0869SujTmUyGwpa8k
         CpO9lR0UlX+2Ul5lMdWQ0HkG2/p/fkl3EK/0ZbS0eFHYuKZ/qVRdCJxyH9ijlurAbop9
         J+TBda7Hs8GzQDZFSvjbBVCBtU+u0aAP4mUsbEmqJ1UaMeff3i9sU84hVh2NqSyJtQVf
         nGsA==
X-Gm-Message-State: AOAM531mlT7gty6bD4A1NbMUu5OYDpdPb3/LKIlaz/rPOakxh/zxsC1K
        65MbqeiOZvVP8e3uY9yrMTxSy91qCoyhYiRBjDU=
X-Google-Smtp-Source: ABdhPJz+W8UFa6qzsXId1flx7/hvLwzYPMPPsp40rYbPZm7gE4D5eYRjFmHyyQOEF/19REsZsTUsrkEGp70GeihbWBc=
X-Received: by 2002:aa7:8a04:0:b029:332:950e:d976 with SMTP id
 m4-20020aa78a040000b0290332950ed976mr6662152pfa.40.1626384802498; Thu, 15 Jul
 2021 14:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
 <20210715115856.11304-5-song.bao.hua@hisilicon.com> <YPAlg5c8uDSZ2WvZ@smile.fi.intel.com>
 <YPCe+f3GPDUuvwnW@yury-ThinkPad>
In-Reply-To: <YPCe+f3GPDUuvwnW@yury-ThinkPad>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 16 Jul 2021 00:32:45 +0300
Message-ID: <CAHp75VcoNPiKDaZzTVr3unV3F5u+LQwAjy1hKSq0WUw_tB6uAw@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] lib: test_bitmap: add bitmap_print_to_buf test cases
To:     Yury Norov <yury.norov@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 11:48 PM Yury Norov <yury.norov@gmail.com> wrote:
> On Thu, Jul 15, 2021 at 03:09:39PM +0300, Andy Shevchenko wrote:
> > On Thu, Jul 15, 2021 at 11:58:56PM +1200, Barry Song wrote:
> > > The added test items cover both cases where bitmap buf of the printed
> > > result is greater than and less than 4KB.
> > > And it also covers the case where offset for bitmap_print_to_buf is
> > > non-zero which will happen when printed buf is larger than one page
> > > in sysfs bin_attribute.
> >
> > More test cases is always a good thing, thanks!
>
> Generally yes. But in this case... I believe, Barry didn't write that
> huge line below by himself. Most probably he copy-pasted the output of
> his bitmap_print_buf() into the test. If so, this code tests nothing,
> and just enforces current behavior of snprintf.

I'm not sure I got what you are telling me. The big line is to test
strings that are bigger than 4k.

...

> > > +static const char large_list[] __initconst = /* more than 4KB */
> > > +   "0,4,8,12,16,20,24,28,32-33,36-37,40-41,44-45,48-49,52-53,56-57,60-61,64,68,72,76,80,84,88,92,96-97,100-101,104-1"
> > > +   "05,108-109,112-113,116-117,120-121,124-125,128,132,136,140,144,148,152,156,160-161,164-165,168-169,172-173,176-1"
> > > +   "77,180-181,184-185,188-189,192,196,200,204,208,212,216,220,224-225,228-229,232-233,236-237,240-241,244-245,248-2"
>
> I don't like this behavior of the code: each individual line is not a
> valid bitmap_list. I would prefer to split original bitmap and print
> list representation of parts in a compatible format; considering a
> receiving part of this splitting machinery.

I agree that split is not the best here, but after all it's only 1
line and this is on purpose.

-- 
With Best Regards,
Andy Shevchenko
