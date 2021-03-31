Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6865F350933
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhCaV1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhCaV1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:27:16 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05C3C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:27:15 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so194109otn.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1a9nw4dRreT9m7i9jOCqKxsQ59JKMg1ge7idA3E/Sck=;
        b=tuDEf+Kre1ZbWuSHiFSb4hiX6jy2lM/UpLgdHJQts5NuJytoN7Ju3SdlTVJ+1svXHb
         vSqq1m6v5mQGNO1UcG9TV0F4kq7t7v7g6fuiO3bjpinAki0dVvncnmMkTKUtD9juMM5a
         KItp+PyMY/lYNJJ4yYCy0XGIzhC2xelH8CjlO3jA0bX47N3IEtlqfoaNYu77CPDuzKoL
         7yFOcuzleoiApY+XrlFZHXgKryiRzJEX1mOofMIYcqgEqxxzbNYCrOYb13Qi8FfwaN/0
         5FkCZYiS9mYFFsinxopSziASelBD/H5QJTTCZXKBdLMjT0P9Xv/vpkaleMQY04slf5/d
         bcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1a9nw4dRreT9m7i9jOCqKxsQ59JKMg1ge7idA3E/Sck=;
        b=dJF5HK201KTqbTKOw0dJdWRE/ox9/wUOwc7GXKZrXA4wZhOU89MevAjGqNbUBh1TgX
         ng7ajsXFPPG0qibuZeJxZKuoZ8hGjiSTyCle92ieHjfQ4WtqFSdOXXlJFqTQWWUXB5Mf
         DPesCEe7WVMnrGseeHk6I/7qmqU2ZYAd6eLiJ1pBiyYozJ7rqNDauydb2WJa5TJhwdHW
         FgzMxYb1uJVd544ZNnLaRujn+VMA/oa0skFIuASqRgbAAF+rw7RprOzE5y8rtsK3RmNB
         /y1c29LrPMMQPtxQ7RXNK8byAahmK3fYgIZRDyj5TEUU15RAS7fLldBjj2aqnVha/u1B
         vKMw==
X-Gm-Message-State: AOAM532UP/KF4rde2nvg/06qDXLZoKu3Vq0jUfY/8d1aP52bS/JGCgSy
        4/xkSjmkffvfA1G+8AIufqBgtxYfXfZpP+KU15Lo0g==
X-Google-Smtp-Source: ABdhPJxqpHdN7svLmbiegXnJZJx01oZbzlt5/S44MdPP/kG5+xAl0kvir3DOAOucUa6PAwcPR19n+2D2c5FyKz5huXE=
X-Received: by 2002:a9d:1c89:: with SMTP id l9mr4250360ota.25.1617226034882;
 Wed, 31 Mar 2021 14:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210330230249.709221-1-jiancai@google.com> <20210330232946.m5p7426macyjduzm@archlinux-ax161>
 <114a5697-9b5c-daf1-f0fc-dc190d4db74d@roeck-us.net> <CA+SOCLKbrOS9HJHLqRrdeq2ene_Rjs42ak9UzA=jtYb0hqWY1g@mail.gmail.com>
In-Reply-To: <CA+SOCLKbrOS9HJHLqRrdeq2ene_Rjs42ak9UzA=jtYb0hqWY1g@mail.gmail.com>
From:   Jian Cai <jiancai@google.com>
Date:   Wed, 31 Mar 2021 14:27:03 -0700
Message-ID: <CA+SOCLLBgKtTz732O5zcrNs_F=iS6C2bE4HBmJfoPTum3Yu1oQ@mail.gmail.com>
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

Hi Nathan,

I just realized you already proposed solutions for skipping the check
in https://lore.kernel.org/linux-block/20210310225240.4epj2mdmzt4vurr3@archlinux-ax161/#t.
Do you have any plans to send them for review?

Thanks,
Jian

On Tue, Mar 30, 2021 at 6:31 PM Jian Cai <jiancai@google.com> wrote:
>
> Thanks for all the information. I'll check for similar instances and
> send an updated version.
>
>
> On Tue, Mar 30, 2021 at 5:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 3/30/21 4:29 PM, Nathan Chancellor wrote:
> > > Hi Jian,
> > >
> > > On Tue, Mar 30, 2021 at 04:02:49PM -0700, Jian Cai wrote:
> > >> This fixes the mismatch of alignments between csd and its use as an
> > >> argument to smp_call_function_single_async, which causes build failure
> > >> when -Walign-mismatch in Clang is used.
> > >>
> > >> Link:
> > >> http://crrev.com/c/1193732
> > >>
> > >> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> > >> Signed-off-by: Jian Cai <jiancai@google.com>
> > >
> > > Thanks for the patch. This is effectively a revert of commit
> > > 4ccafe032005 ("block: unalign call_single_data in struct request"),
> > > which I had brought up in this thread:
> > >
> > > https://lore.kernel.org/r/20210310182307.zzcbi5w5jrmveld4@archlinux-ax161/
> > >
> > > This is obviously a correct fix, I am not just sure what the impact to
> > > 'struct request' will be.
> > >
> >
> > As commit 4ccafe032005 states, it increases the request structure size.
> > Given the exchange referenced above, I think we'll need to disable
> > the warning in the block code.
> >
> > Thanks,
> > Guenter
> >
> > > Cheers,
> > > Nathan
> > >
> > >> ---
> > >>  include/linux/blkdev.h | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > >> index bc6bc8383b43..3b92330d95ad 100644
> > >> --- a/include/linux/blkdev.h
> > >> +++ b/include/linux/blkdev.h
> > >> @@ -231,7 +231,7 @@ struct request {
> > >>      unsigned long deadline;
> > >>
> > >>      union {
> > >> -            struct __call_single_data csd;
> > >> +            call_single_data_t csd;
> > >>              u64 fifo_time;
> > >>      };
> > >>
> > >> --
> > >> 2.31.0.291.g576ba9dcdaf-goog
> > >>
> >
