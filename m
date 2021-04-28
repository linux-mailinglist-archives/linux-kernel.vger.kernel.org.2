Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F051836D350
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 09:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbhD1HjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 03:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236343AbhD1Hix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 03:38:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29826C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:38:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r9so93163886ejj.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 00:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QkJ4vpHSUWaGMQDLA7ZMyh0ynmNQBlz+ZqztYkEPyuQ=;
        b=m1fQRpKJMRs6XXRylK+K2Q9aA1XWDgL/5ejc0MtzpzqqmohWyRbvsAYZBx7t1e5gwN
         whc9QfJUCBjYraOo4H3vSdp2nRELYMDFyeQx8ZjVrGTf+gvS0EPrxv12pibm07j6aUXO
         UEHNbYm7CxkO2+qaMuBOleWngcp9mTOl0fnbNIk0izy0d2MWEeCwqEZaNEsGVFMzDJNK
         0GBh3Tyr/fnsJ46U7dV1/pmvScgnZc1SI9ehKdSzUA2I8B8ZsxuMlu7ANtBh1abSqSo8
         uqGRso+SN+xqu/SD8kEr4pz3D/aHuyIsb8wKUIDSlawkyAKLxkAf6IOIEUPUc1uQAu8q
         8ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QkJ4vpHSUWaGMQDLA7ZMyh0ynmNQBlz+ZqztYkEPyuQ=;
        b=XuG3RxYxZf+rklb+hABQ9ARwQrmB1OKmbCCKfUbrfDVtE9LsJ9HY9Jfse9Xanq98dU
         qZHpszjWdK8mTozwnHULq+ICdgT2y4XSR0BOTwyn2hYLSaZolIXkL2BTyrbmKKUhfJaj
         efYwN0S0O1Wq8pA2d/Caey5dl4Wh2YY/pTJEVH0f+tlAS3waKfnhi1fiG7AIFXn9y93A
         62+HM9HIOSrylg/tkcvRvm4bi9/Oy4y9yIwdI3qsd1sazWuqGMomQwDhECerIxg8/+Au
         fQiJEXglUG6bLEekzzP1aG+R2B4bxhfQWXFURL6333VymewkZ5QR8NvsiDsAeh+1yx12
         2WHA==
X-Gm-Message-State: AOAM531D460pU8f6llk9MlPFSCyhRh4OtT1W5YUd4hOVH2+bTk892tAj
        VK/cB2GaNCxG1f7JYbyeyZKmEps974vtB7GWX1F+CU+VHxWBrw==
X-Google-Smtp-Source: ABdhPJySpqvgCso+yQC6dVX2kkkQwqHjiOGBaSeWdfU9qgjYUCeNEwH5NLI2NPjjBZggzW7MPKQOJyRfnPmm+gBqy90=
X-Received: by 2002:a17:907:7355:: with SMTP id dq21mr14701122ejc.157.1619595487363;
 Wed, 28 Apr 2021 00:38:07 -0700 (PDT)
MIME-Version: 1.0
From:   Shivank Garg <shivankgarg98@gmail.com>
Date:   Wed, 28 Apr 2021 13:07:50 +0530
Message-ID: <CAOVCmzEAMz4NGF3gi4O_tNUQfm2+-8AkGiOn0gPN+p3GHctkKA@mail.gmail.com>
Subject: Is there a different memory allocation path other than the buddy allocator?
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        sergey.senozhatsky@gmail.com, pmladek@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everyone!

I'm understanding memory allocation in Linux and doing some changes in
buddy allocator (__alloc_pages_nodemask) for my experiments. I create
a new flag in `struct page->flags` (by adding a new flag in `enum
pageflags` in `page-flags.h`. I set this bit permanently in
__alloc_pages_nodemask (to not to be cleared once set and survive all
further allocation and freeing). But I'm not able to see expected
behavior.

I'm guessing this is because Linux is also using some different path
to allocate memory (probably during boot). Is my hypothesis correct?

Is there any different memory allocation path other than buddy
allocator? Where can I find it?

To keep the newly added bit in the page_flag set for 'struct page'
lifetime.  I make sure not to clear it while freeing by unsetting it
in "#define PAGE_FLAGS_CHECK_AT_PREP       \
-       (((1UL << NR_PAGEFLAGS) - 1) & ~__PG_HWPOISON & ~(1UL <<
PG_NEWEXPFLAG))" I know  adding new bits in page->flag is probably not
a good idea but this if for better understanding :)

Thank You and stay safe!

Best Regards,
Shivank
