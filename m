Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57183D2AE9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 19:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhGVQ25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 12:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhGVQ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 12:28:55 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42550C061760
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 10:09:30 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id w6so48056qvh.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 10:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0KWjIUvssejxul/NQJNnk46DY8y9cdn4iweGJV3mrps=;
        b=klGEArfPT2JVo45FJ+D2h4cg5wMUxNv82s/Ugl9kYmY95SCzz/8N25LXSit+yQ909v
         Ndexb7rWUo6cSGqEx+PUD6X/ViBTphGVb9G4JdIWDuc9Xr9BAHsy53fhM1fzAE6pQzxe
         ndjsOjFaXq0/17MeIY6p3Fc4bJkPjtzE1ADCHruywhhbUzzGbSvx10e2LRP3N879Ca6W
         VTbZdV9/G6hIXyUsgVltCqGmK0r3wJ1QFIJKg2CFqF2uDzJ5KjlXTNO3p5nYsTyoZ+gt
         KGfo/FCtl7fB7pUR01uGDnF8ZD+2ZOjqavDiupsYw76eafzWurT0riwERqNlBTdH4DzJ
         CJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0KWjIUvssejxul/NQJNnk46DY8y9cdn4iweGJV3mrps=;
        b=N8XKqwtj3AJkClNWDu9b+d7brOktbtkVqGRzqXXCSq53Y43tiSW8OCIijfoIGfn/ga
         9t+QMTHWEeM0kZNP9qfg0+qQYNPy5Z1VrVvmAzitjjPQaYjclXobz6zMvLJKBve80nPc
         95I3UBf8BLquAGJWkRKbs//A28ghoaxmlOYKWG8BAzqxCyeEjp+kePO8kdG8cqU1ZS3D
         WPxpKfYlTNjdk6jty4RdRyec0hSI4M3pEr5eHI38dpn6aJM+twVtRDdL67ncYo/3G3l+
         oFhwKFOOuXzJVs8qnTzik+g5rPi2vdN5VERRPBKxTGWgJBdzBzC12yl4jX5YYEf2vEt0
         RIuA==
X-Gm-Message-State: AOAM533eetCtm/f3ELs13MD/GfCEGWsLoorKbPe86den3VKq9d627feh
        +Xcba2j/PMglShMuGxtT0Vg=
X-Google-Smtp-Source: ABdhPJwGNb2u4zrVEQIn9Rh4dVH5021TQMtYeCIWc88nstTCnPtEB4kwHgxbzB5oAZWdWL0hyk5V/Q==
X-Received: by 2002:a0c:f152:: with SMTP id y18mr686690qvl.4.1626973769301;
        Thu, 22 Jul 2021 10:09:29 -0700 (PDT)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id i123sm11483934qkf.60.2021.07.22.10.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 10:09:28 -0700 (PDT)
Date:   Thu, 22 Jul 2021 10:09:27 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
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
Message-ID: <YPmmR3JfgM/yIh1H@yury-ThinkPad>
References: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
 <20210715115856.11304-5-song.bao.hua@hisilicon.com>
 <YPAlg5c8uDSZ2WvZ@smile.fi.intel.com>
 <YPCe+f3GPDUuvwnW@yury-ThinkPad>
 <CAHp75VcoNPiKDaZzTVr3unV3F5u+LQwAjy1hKSq0WUw_tB6uAw@mail.gmail.com>
 <YPDDdAwgYEptz2Uq@yury-ThinkPad>
 <YPgHtJqXi8cKad1Q@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPgHtJqXi8cKad1Q@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 01:40:36PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 15, 2021 at 04:23:32PM -0700, Yury Norov wrote:
> > On Fri, Jul 16, 2021 at 12:32:45AM +0300, Andy Shevchenko wrote:
> > > On Thu, Jul 15, 2021 at 11:48 PM Yury Norov <yury.norov@gmail.com> wrote:
> > > > On Thu, Jul 15, 2021 at 03:09:39PM +0300, Andy Shevchenko wrote:
> > > > > On Thu, Jul 15, 2021 at 11:58:56PM +1200, Barry Song wrote:
> > > > > > The added test items cover both cases where bitmap buf of the printed
> > > > > > result is greater than and less than 4KB.
> > > > > > And it also covers the case where offset for bitmap_print_to_buf is
> > > > > > non-zero which will happen when printed buf is larger than one page
> > > > > > in sysfs bin_attribute.
> > > > >
> > > > > More test cases is always a good thing, thanks!
> > > >
> > > > Generally yes. But in this case... I believe, Barry didn't write that
> > > > huge line below by himself. Most probably he copy-pasted the output of
> > > > his bitmap_print_buf() into the test. If so, this code tests nothing,
> > > > and just enforces current behavior of snprintf.
> > > 
> > > I'm not sure I got what you are telling me. The big line is to test
> > > strings that are bigger than 4k.
> > 
> > I'm trying to say that human are not able to verify correctness of
> > this line. The test is supposed to check bitmap_print_to_buf(), but
> > reference output itself is generated by bitmap_print_to_buf(). This
> > test will always pass by design, even if there's an error somewhere
> > in the middle, isn't it?
> 
> Then please manually check it to verify it is correct or not.  Once we
> have it verified, that's fine, it will remain static in this test for
> always going forward.
> 
> That's what "oracles" are for, there is nothing wrong with this test
> case or "proof" that I can see.
> 
> > > 
> > > ...
> > > 
> > > > > > +static const char large_list[] __initconst = /* more than 4KB */
> > > > > > +   "0,4,8,12,16,20,24,28,32-33,36-37,40-41,44-45,48-49,52-53,56-57,60-61,64,68,72,76,80,84,88,92,96-97,100-101,104-1"
> > > > > > +   "05,108-109,112-113,116-117,120-121,124-125,128,132,136,140,144,148,152,156,160-161,164-165,168-169,172-173,176-1"
> > > > > > +   "77,180-181,184-185,188-189,192,196,200,204,208,212,216,220,224-225,228-229,232-233,236-237,240-241,244-245,248-2"
> > > >
> > > > I don't like this behavior of the code: each individual line is not a
> > > > valid bitmap_list. I would prefer to split original bitmap and print
> > > > list representation of parts in a compatible format; considering a
> > > > receiving part of this splitting machinery.
> > > 
> > > I agree that split is not the best here, but after all it's only 1
> > > line and this is on purpose.
> > 
> > What I see is that bitmap_print_to_buf() is called many times,
> 
> That is not what the above list shows at all, it's one long string all
> together, only split up to make it easier for us to work with.
> 
> > and
> > each time it returns something that is not a valid bitmap list string.
> > If the caller was be able to concatenate all the lines returned by
> > bitmap_print_to_buf(), he'd probably get correct result. But in such
> > case, why don't he use scnprintf("pbl") directly?
> 
> I do not understand the objection here at all.  This series is fixing a
> real problem that eeople are having

I explicitly asked about an example of this problem. Barry answered in
a great length, but the key points are:

        https://lore.kernel.org/lkml/4ab928f1fb3e4420974dfafe4b32f5b7@hisilicon.com/

        > > So, the root problem here is that some machines have so many CPUs that
        > > their cpumask text representation may not fit into the full page in the
        > > worst case. Is my understanding correct? Can you share an example of
        > > such configuration?
        > 
        > in my understanding, I have not found any machine which has really
        > caused the problem till now.

        > [...]
        > 
        > This doesn't really happen nowadays as the maximum
        > NR_CPUS is 8196 for X86_64 and 4096 for ARM64 since 8196 * 9 / 32 = 2305
        > is still smaller than 4KB page size.


If it's not true, can you or Barry please share such an example?

> and your complaining about test
> strings is _VERY_ odd.

The test itself is bad, but it's a minor issue.

My main complain is that the bitmap part of this series introduces a
function that requires O(N^2) of CPU time and O(N) of memory to just
print a string. The existing snprintf does this in O(N) and O(1)
respectively. Additionally to that, the proposed function has some
flaws in design.
 
> If you have an alternate solution, please propose it, otherwise I will
> be taking this series in the next few days.

I think I suggested a better solution in the thread for v4:

https://lore.kernel.org/lkml/YMu2amhrdGZHJ5mY@yury-ThinkPad/

        > kasprintf() does everything you need. Why don't you use it directly in
        > your driver?

I'm not that familiar to sysfs internals to submit a patch, but the
idea in more details is like this:

        cpulist_read(...)
        {
               if (bitmap_string == NULL)
                        bitmap_string = kasprintf(bitmap, ...);

        }

Where bitmap_string pointer may be stored in struct file, struct kobject,
struct bit_attribute or where it's convenient. 

If it's completely impossible to store a pointer, and the bug is real
and urgent, then the best solution I see is to move bitmap_get_print_buf()
to the driver/base/node.c code, because it's not optimal for general use.
Which I already suggested here:

https://lkml.org/lkml/2021/7/16/763

Can you or Barry tell, would one of those alternative solutions work for you?

Thanks,
Yury
