Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BA73D48F6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 19:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhGXRPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 13:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGXRPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 13:15:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8DAC061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 10:56:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c11so6781630plg.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 10:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DqxieV6OJOFS2uVnNCqn+ysVrWDOwFD1yyQ6KVvASGg=;
        b=fASZ15piX4+nBUCyyojxI19I0Csii+leTzUjnLHMdhnaJ66bFUx0gwXE1Tn21mdxUy
         Z9eRxFtwZRhjnaJk8fB4EPgpUWojI+nbDkk9zeuUfLvLZNxTcyTzKTo7pyZMKvntuNhN
         e3P7vh+QV24iWefJk302K/LTVV0VWwBl9Md6N933loJ6uY++pmhtwwO7tRSmSLc0x2k1
         o5ukmTCVTmf+niSM+Js54VfMx0oBxO8C1pIqOFu8CwQSBNEKGR4RETT8jcKiD0YSBhtN
         e8IHUy8OxVwRh7AeTti3fD0zUPKF531IXPkMFMbotEuOIzmP2rS0kGGFNp8XFPV/YQhu
         P3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DqxieV6OJOFS2uVnNCqn+ysVrWDOwFD1yyQ6KVvASGg=;
        b=R/Aj6RYhKR5g7j2+OqTogKeYMoxWBa9HzfN5iL7qX7wkNpqJ8VXQCIBg6kl6xfBRhc
         AtrUEO/Dbdt4xuljCTneg27dUvBfz7Y96j2xH8xpAWy8Hnk5e1mx/CVuJjewdw3UsATv
         eV8wFEb/5h0VzBxnCoNR7/u/e/J2BAS38zFcBaV6AhH4VmNZZqG/JPgYE7IEY0mEQ+yl
         +rrhNoWyVSwSG5WQGBvBWwl9znXK0B8D1HcQ8bwn5TIU6P7wPm/XFEqmlLXEk8Qlsl3/
         /aSt8rpoz3prkYwONHgBmwYreY+tyn3bjQjlGLvx32B/sqhFJRy3HRlrtxszu2w/YaYn
         yi/w==
X-Gm-Message-State: AOAM5330/ynmbUJvQ0a1jmIOL+eM3M51/Sa89hcsHH3vw4ry61+XBT4E
        0RDH4tMpU6HXRI0ZdjtCXLRh0g==
X-Google-Smtp-Source: ABdhPJzQn0GQgI54tiY3kqx+taWVTVtpti9aGlmuLME5a/aLc4uLzBoIweerigmBnLKJG8hx+GZxuw==
X-Received: by 2002:a63:5963:: with SMTP id j35mr10391263pgm.341.1627149379483;
        Sat, 24 Jul 2021 10:56:19 -0700 (PDT)
Received: from [192.168.1.187] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id m24sm41624121pgv.24.2021.07.24.10.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 10:56:19 -0700 (PDT)
Subject: Re: 5.14-rc failure to resume
From:   Jens Axboe <axboe@kernel.dk>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <eeab973d-f634-a182-6d76-f3912f8cf887@kernel.dk>
Message-ID: <a607c149-6bf6-0fd0-0e31-100378504da2@kernel.dk>
Date:   Sat, 24 Jul 2021 11:56:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <eeab973d-f634-a182-6d76-f3912f8cf887@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/21 9:57 AM, Jens Axboe wrote:
> Hi,
> 
> I ran into this when doing the last bit of testing on pending changes
> for this release on the laptop. Outside of running testing on these
> changes, I always build and boot current -git and my changes on my
> laptop as well.
> 
> 5.14-rc1 + changes works fine, current -git and changes fail to resume
> every single time. I just get a black screen. Tip of tree before merging
> fixes is:
> 
> commit 704f4cba43d4ed31ef4beb422313f1263d87bc55 (origin/master, origin/HEAD, master)
> Merge: 05daae0fb033 0077a5008272
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Fri Jul 23 11:30:12 2021 -0700
> 
>     Merge tag 'ceph-for-5.14-rc3' of git://github.com/ceph/ceph-client
> 
> Since bisection takes forever on the laptop (gen7 x1 carbon), I
> opportunistically reverted some of the most recent git pulls:
> 
> - ec6badfbe1cde0eb2bec4a0b8f6e738171156b5b (acpi changes)
> - 1d597682d3e669ec7021aa33d088ed3d136a5149 (driver-core changes)
> - 74738c556db6c7f780a8b98340937e55b72c896a (usb changes)
> - e7562a00c1f54116f5a058e7e3ddd500188f60b2 (sound changes)
> - 8baef6386baaefb776bdd09b5c7630cf057c51c6 (drm changes)
> 
> as they could potentially be involved, but even with all of those
> reverted it still won't resume.
> 
> Sending this out in case someone has already reported this and I just
> couldn't find it. If this is a new/unknown issues, I'll go ahead and
> bisect it.

Ran a bisect, and it pinpoints:

71f6428332844f38c7cb10461d9f29e9c9b983a0 is the first bad commit
commit 71f6428332844f38c7cb10461d9f29e9c9b983a0
Author: Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon Jul 12 21:21:21 2021 +0300

    ACPI: utils: Fix reference counting in for_each_acpi_dev_match()

which seems odd, as it worked for me with the acpi changes reverted. It
could be that it _sometimes_ works with that commit, not sure. Adding
relevant folks to the CC.

I'm going to revert this on top of current master and run with that
and see if it does 10 successful resumes.

-- 
Jens Axboe

