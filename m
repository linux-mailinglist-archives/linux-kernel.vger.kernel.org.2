Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419C54411A8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 01:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhKAA0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 20:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhKAA0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 20:26:22 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A71C061714
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 17:23:49 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so23026186ote.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 17:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2CHkqHjHCff4sGccC/ZMT8H1CrwBDcvZTko55XAWQ7U=;
        b=DPOGVEbyiovmMa9FyZ4iS4HZ2hB0w8eO9BQApbKnNMmfN9WIRUBmTG9AYaJFfhWD80
         3KLVTkAQ6u8kyblwqKBN4eOw2cbZ6bBVzMHYJBRrvuK7lk73SUonNkyhdo2/fuG4YT18
         wTHkZYc06gbdyvmr+KWaiguH2zsOoJn+MO/XeHmw24nYzpSHWWdqdnynNkjXeoY07kLo
         L669PJJ4QnlgkcmlVLxoJhxwGo5t/0FmJPvPkhWqOAMzG0+kPtJqjqDepI8l+RD2bF7p
         08HawfoE9MaDxPG3Gb9ScsjJvSRDPsaJrMPE8XvAt9xcrgqpwaUVK9LaClfO24PW2dp1
         p0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2CHkqHjHCff4sGccC/ZMT8H1CrwBDcvZTko55XAWQ7U=;
        b=As8nFl1FssWJ96GFUUgzMiASl59IKNtum5oZMvXQnU/Jw48BxW+SIfXVX8+YDk4kbg
         YxvlVD3Lk59ilPXp8CUcUh38eVHushDblUGQY6MlRG5zP7G2EAbZ8EUq6HedRFgJYJN1
         fYgO8zP68SVtcCCI1PpzzXHBXHtPJJJyPX4CWNxEWIZIG+owCC3RoqTtcpukPbeh+/ib
         ny17h0XzOIPp6O1SOfBB7+YVSwYtnWMAbwUZc8PH6ywl2m4mBy4AIfcmWXI0Pe3ldpLy
         3TYnioJzFoZuH9BajfhpLXy2HWbvESvxTbKu4j9w9pbNrOFYzUVhQYzvO8CH35bydodI
         6tYg==
X-Gm-Message-State: AOAM533MeTJsZhwBAspipnPanVVVzRRW1RwFAyd1slG7kyqGjw6F8M4L
        hUb7HyUTWRHsWxtlEoQnyL1ppC6oqw0=
X-Google-Smtp-Source: ABdhPJxIOAyqFzWbI0bWQQNW898MAc2ftlVFu9WbDIg/16porJd4TBItcprsb1GkKnXbX7j130fQXQ==
X-Received: by 2002:a05:6830:25d1:: with SMTP id d17mr3005281otu.303.1635726228137;
        Sun, 31 Oct 2021 17:23:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i205sm3796998oih.54.2021.10.31.17.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 17:23:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 31 Oct 2021 17:23:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.15
Message-ID: <20211101002346.GA304515@roeck-us.net>
References: <CAHk-=wjfbfQobW2jygMvgfJXKmzZNB=UTzBrFs2vTEzVpBXA4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjfbfQobW2jygMvgfJXKmzZNB=UTzBrFs2vTEzVpBXA4Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2021 at 02:09:07PM -0700, Linus Torvalds wrote:
> It's been calm, and I have no excuse to add an extra rc, so here we
> are, with v5.15 pushed out, and the merge window starting tomorrow.
> 
> Which is going to be a bit inconvenient for me, since I also have some
> conference travel coming up. But it's only a couple of days and I'll
> have my laptop with me. Sometimes the release timing works out, and
> sometimes it doesn't..
> 
> Anyway, the last week of 5.15 was mainly networking and gpu fixes,
> with some random sprinkling of other things (a few btrfs reverts, some
> kvm updates, minor other fixes here and there - a few architecture
> fixes, couple of tracing, small driver fixes etc). Full shortlog
> appended.
> 
> This release may have started out with some -Werror pain, but it
> calmed down fairly quickly and on the whole 5.15 was fair small and
> calm. Let's hope for more of the same - without Werror issues this
> time - for the upcoming merge window.
> 

Here are my test results:

Build results:
	total: 154 pass: 153 fail: 1
Failed builds:
	m68k:allmodconfig
Qemu test results:
	total: 480 pass: 480 fail: 0

The build error is:

Building m68k:allmodconfig ... failed
--------------
Error log:
In file included from include/linux/string.h:20,
                 from include/linux/bitmap.h:10,
                 from include/linux/cpumask.h:12,
                 from include/linux/smp.h:13,
                 from include/linux/lockdep.h:14,
                 from include/linux/spinlock.h:63,
                 from include/linux/mmzone.h:8,
                 from include/linux/gfp.h:6,
                 from include/linux/slab.h:15,
                 from drivers/nvme/target/discovery.c:7:
In function 'memcpy_and_pad',
    inlined from 'nvmet_execute_disc_identify' at drivers/nvme/target/discovery.c:268:2:
arch/m68k/include/asm/string.h:72:25: error: '__builtin_memcpy' reading 8 bytes from a region of size 7

Another instance of the same problem:

In function 'memcpy_and_pad',
    inlined from 'nvmet_execute_identify_ctrl' at drivers/nvme/target/admin-cmd.c:372:2:
arch/m68k/include/asm/string.h:72:25: error: '__builtin_memcpy' reading 8 bytes from a region of size 7

This is seen with gcc 11.1 and 11.2. gcc 10.3 builds fine.
The code in question is

        memcpy_and_pad(id->fr, sizeof(id->fr),
                       UTS_RELEASE, strlen(UTS_RELEASE), ' ');

and UTS_RELEASE is "5.15.0". I have no idea what might be wrong with the code.
Does anyone have an idea ? Do I need to revert to gcc 10.3 for m68k ?

Thanks,
Guenter
