Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8489D44F457
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 18:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbhKMRYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 12:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235785AbhKMRYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 12:24:10 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DD0C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 09:21:18 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id z26so15343098iod.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 09:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TDfD+2bBYCBWin4XicpoFuRSKI+m+KUd9LWnrt6X60o=;
        b=RecRxP9GQY9WZodIQaGoqVQaRon+QchYM3wC2UPU3ayZfCTDfb4EFCwRYuQVrS40mi
         UWqDjpR84iu07SXVxX5pbqCEs/uOmAIP5MLfL4olCX6Caf4ssYgVLBp3maN8j7Yl/aA0
         awt4x//hqVEahsn7PjF4/FXNG+87GveTk5ck/5hvamg2xwxcwBBdXIv0eY57YYF2+Rjj
         PTbrgf7YpqPyAwsM+UJSYFehw2qjGxJ6+/+SWS/SvKUztuqs2f9QRYjuroMSumex1tj7
         AiaOFj7VwNBxjbcGS6Da0Nw/OdkLIeAWP/IakDkQVSz6FHQGEgIYNNSbNpFXBN09pxpi
         Apmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TDfD+2bBYCBWin4XicpoFuRSKI+m+KUd9LWnrt6X60o=;
        b=feGvWCqaIopLws5eJRPJFle4wCq05qoP/L4JEGMLb9a2vc933qERyVw7AG8u2aNa9b
         S7R/8iUTacCzTFW+Lkt/95URqhc1HxmDaOaegcHh0aSOkxi1qGMTdjjTLameZ9abl96T
         dM7QPHC7IWXq1L7r4aXBZy1fMrZt3ruo89ZgqLFkozBHldVxtuuyc2cFxMg2wiB7xXJR
         ws32NvbLJi01z1yP5yWvnlqU+MdOV4rJFf5KcZ3fZHZRH8iQbhqKapbGxnmXTyTC/IRA
         6tUpDeSLv7152/3FmAglcyjd9tpdvzWMeBf4aJFBvxaCFx+z6yXi763MpwBKyWa+6OtW
         TZtg==
X-Gm-Message-State: AOAM533Z6TT7utyRjwdl1vY2WSW+mOFLTi71stqd0kg0X61p4Trk4SkE
        6z2zrCSb0da2ksiYePzQZ0e5wg==
X-Google-Smtp-Source: ABdhPJwEHCuN1iJH0gAfnwHyL+TisVAQjvYrzZUnY5vwUBIbeHkCNMq/AUx8cSksK2PUv7Fiqrvg6w==
X-Received: by 2002:a05:6602:2b0b:: with SMTP id p11mr16832447iov.62.1636824077343;
        Sat, 13 Nov 2021 09:21:17 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id y3sm6166352ilv.5.2021.11.13.09.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 09:21:16 -0800 (PST)
Subject: Re: [PATCH] mm: shmem: do not call PageHWPoison on a ERR-page
From:   Jens Axboe <axboe@kernel.dk>
To:     Ajay Garg <ajaygargnsit@gmail.com>, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20211111084617.6746-1-ajaygargnsit@gmail.com>
 <CAHP4M8V2WEQ0LgHp7PHdBMYFp+_frn=7GLQVF7=faqapojQ+2g@mail.gmail.com>
 <628a49dc-f6f7-5aa4-8a4d-4f2ed19b7f3f@kernel.dk>
Message-ID: <e87601bd-21c4-00b0-9500-054bca8abced@kernel.dk>
Date:   Sat, 13 Nov 2021 10:21:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <628a49dc-f6f7-5aa4-8a4d-4f2ed19b7f3f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/21 10:59 AM, Jens Axboe wrote:
> On 11/11/21 10:45 AM, Ajay Garg wrote:
>> Another report of the issue (different call-flow, but the same error
>> at "shmem_read_mapping_page_gfp") at :
>> https://lore.kernel.org/lkml/6bb8c25c-cdcf-8bca-3db2-9871a90d518f@kernel.dk/T/#m52d98b6bdb05764524a118b15cec048b34e5ca76
>>
>> with a tentative approval for the patch :
>> https://lore.kernel.org/lkml/6bb8c25c-cdcf-8bca-3db2-9871a90d518f@kernel.dk/T/#m24c2888a879d428cde5b34c43838301de544eb7e
> 
> Andrew, I've hit this multiple times on resume on my laptop, and it's
> a very apparent bug in that b9d02f1bdd98 commit that it doesn't factor
> in error pointers. My oops clearly shows it being one too, with ...fff4
> being the dereference address.
> 
> Can we get this pushed upstream asap if you're fine with this patch?

Maybe Andrew is out - Linus, if you follow this thread, there are two
proposed fixes for this. It'd be nice to have one of them in -rc1.

Backstory is that commit:

commit b9d02f1bdd98f38e6e5ecacc9786a8f58f3f8b2c
Author: Yang Shi <shy828301@gmail.com>
Date:   Fri Nov 5 13:41:10 2021 -0700

    mm: shmem: don't truncate page if memory failure happens

adds a pretty obvious error, where PageHWPoison() is called on an error
pointer in shmem_read_mapping_page_gfp(). I can trivially hit this oops
on resuming the laptop.

-- 
Jens Axboe

