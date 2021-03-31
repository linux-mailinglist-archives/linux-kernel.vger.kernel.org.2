Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF70E34F644
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 03:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhCaBcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 21:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhCaBcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 21:32:04 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A3FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 18:32:04 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so17436523oty.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 18:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8Y07hDLvNzX62UUhlhC8myk9QBLpL9amBPbya95S+8=;
        b=sshq6hQZp/YiRNinDqntPqwwo3aL+kNJRNh6ZTY83UlX2yz2WeWW9E0/nCahP1Rz5q
         jHmgsCvdZGZGUhB8JRhax5Ped7fwUvernhBfxZUXKfpVSueKOdE+CCYn0D6Ikc+DVmNn
         9XCig06EsAkuIwbPYg3KDj1/qKoB/WZEoCDD26YeEDfawEELBUqUB3I+kFoC4RewWaMC
         iZnBX062q3hwLWPr1uu6rx0dkEDQBhm5X5hfW2DV1hmVGY4jB8nN+f5eXhMXCoOhj69d
         eJeruXmeQ8ZM5zGvlg9i/ITtNOTG8ZvuNRl8RX0j6XRJJZ5Uys6g5GlY7eReEhSXGxBP
         zQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8Y07hDLvNzX62UUhlhC8myk9QBLpL9amBPbya95S+8=;
        b=AfmSFz/gLLTnQrWWDL9gg4DdYQJBmrMBNIB3G8R3Zd1qVkfcRH46Q5pbfVRmzZQjWv
         uGHDH74CQ6NIH6tdfCbIHJLaU31qo8fnRq7Bmeevi0kmSVK8NlXh6tOmRMNiVHVGIAfC
         CWgzmTmCH+x4O6SR220pE7FpVKCCSZPvkqGDIaY6Uug0NFwDvGpFdwa0dzq55sNBpBOW
         wcUQvduHRUqyzdt3BKBFKh+aVyyqXh9oCGjnJ/VkbxoUESLCh1WpIDVxIbaMBFo1zyun
         YEtpV0oNhZVtSxuSoMY4s76vU2coigrQcRaq9xftqQE/qpQ8FINtBh/FBoPr4JQL0kj4
         B0tA==
X-Gm-Message-State: AOAM531UT4Yqa+A7hAQ7NzEgwdf9xnFSUpjH8LvXbXruKTayX1vaUCD7
        6Xr2Wpfr/U2mDf2LcSAo+SzvoipULSCLIH4+3Cc38g==
X-Google-Smtp-Source: ABdhPJx67O4CD1ajY0TISyAG6JELFzhiiDi4PxrW6eW6xxQ1uiwv0usZeuKKCtxWWSDiqUYFmxYisVWMUGR8Zt4JlHg=
X-Received: by 2002:a9d:1c89:: with SMTP id l9mr594551ota.25.1617154323238;
 Tue, 30 Mar 2021 18:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210330230249.709221-1-jiancai@google.com> <20210330232946.m5p7426macyjduzm@archlinux-ax161>
 <114a5697-9b5c-daf1-f0fc-dc190d4db74d@roeck-us.net>
In-Reply-To: <114a5697-9b5c-daf1-f0fc-dc190d4db74d@roeck-us.net>
From:   Jian Cai <jiancai@google.com>
Date:   Tue, 30 Mar 2021 18:31:52 -0700
Message-ID: <CA+SOCLKbrOS9HJHLqRrdeq2ene_Rjs42ak9UzA=jtYb0hqWY1g@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: fix alignment mismatch.
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Christopher Di Bella <cjdb@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jens Axboe <axboe@kernel.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all the information. I'll check for similar instances and
send an updated version.


On Tue, Mar 30, 2021 at 5:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/30/21 4:29 PM, Nathan Chancellor wrote:
> > Hi Jian,
> >
> > On Tue, Mar 30, 2021 at 04:02:49PM -0700, Jian Cai wrote:
> >> This fixes the mismatch of alignments between csd and its use as an
> >> argument to smp_call_function_single_async, which causes build failure
> >> when -Walign-mismatch in Clang is used.
> >>
> >> Link:
> >> http://crrev.com/c/1193732
> >>
> >> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> >> Signed-off-by: Jian Cai <jiancai@google.com>
> >
> > Thanks for the patch. This is effectively a revert of commit
> > 4ccafe032005 ("block: unalign call_single_data in struct request"),
> > which I had brought up in this thread:
> >
> > https://lore.kernel.org/r/20210310182307.zzcbi5w5jrmveld4@archlinux-ax161/
> >
> > This is obviously a correct fix, I am not just sure what the impact to
> > 'struct request' will be.
> >
>
> As commit 4ccafe032005 states, it increases the request structure size.
> Given the exchange referenced above, I think we'll need to disable
> the warning in the block code.
>
> Thanks,
> Guenter
>
> > Cheers,
> > Nathan
> >
> >> ---
> >>  include/linux/blkdev.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> >> index bc6bc8383b43..3b92330d95ad 100644
> >> --- a/include/linux/blkdev.h
> >> +++ b/include/linux/blkdev.h
> >> @@ -231,7 +231,7 @@ struct request {
> >>      unsigned long deadline;
> >>
> >>      union {
> >> -            struct __call_single_data csd;
> >> +            call_single_data_t csd;
> >>              u64 fifo_time;
> >>      };
> >>
> >> --
> >> 2.31.0.291.g576ba9dcdaf-goog
> >>
>
