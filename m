Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324843534A2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 18:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbhDCQGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 12:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhDCQGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 12:06:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93345C0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 09:05:59 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id o10so11439487lfb.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 09:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gkdOqPqACzNXgbG1X/VVpsqAi1238gmmEATmwh5RCsU=;
        b=aD7cJRRRnXDc0FES7rd9ZbmwQ2tVE9r5yiK7Eb1blcGjUjJtOGLrm1Vsl0Xs6m/FEk
         dAZ/KETWZduO8tggiu8/g9TKmujxKiiTHNsAPkMeaIEDbob8rk27/COqf1LLG/mmdL8g
         arx7nKdYBEo4+oNeap8wvP/vcjPBCs6JPQUrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gkdOqPqACzNXgbG1X/VVpsqAi1238gmmEATmwh5RCsU=;
        b=iobCZ5Qb4v8vlS55OD9aCiNrwxL8wqK0XEt6Wd3tfA6Aana7LElVVp1SfyHiytcR3v
         xc0vdFRh3HpLOAQ1DEBAWkPIISceXa7NJ1c62RR9wbTwCJLZXysjioL8Ft+KpUq1bnWO
         WqCqw3SrdhOc4lKK13cGv26Zqgwb1y2cOUNv1jNPYA2qaL1XHgvLho0cgtM9Q6hBD0yM
         YsUuzzGBiiZCMCVFyNVW1qa5nVp1A0hyMJxIVvvJPHJlkyNdQDRAHyk8M72wxw/iMPMf
         Vj+i54oY5BPObuHkSVzBKgNXXl30SnI4gZ4QA+aaDwFDkGAOegePapc27qHdYiFa/lh6
         e/WQ==
X-Gm-Message-State: AOAM532zezes4snRZeZnhan9Ml/bl2s3AdYzpsCTed3znUqyovESM987
        54WEDtQizm5qlfo9vWPfX3IPveXbA6xE6A==
X-Google-Smtp-Source: ABdhPJwnX737SdO9wwUbL41UCE222IPjhkKl95U3y+M7TV9GfxrBlDFy5Hr4B+I/97E9v7f7h0/zsA==
X-Received: by 2002:ac2:4e6f:: with SMTP id y15mr12335546lfs.428.1617465957718;
        Sat, 03 Apr 2021 09:05:57 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id u19sm1272332ljl.49.2021.04.03.09.05.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Apr 2021 09:05:56 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id s17so8449783ljc.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 09:05:56 -0700 (PDT)
X-Received: by 2002:a05:651c:1117:: with SMTP id d23mr11823301ljo.220.1617465956597;
 Sat, 03 Apr 2021 09:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <1617433116-5930-1-git-send-email-zheyuma97@gmail.com>
In-Reply-To: <1617433116-5930-1-git-send-email-zheyuma97@gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Sat, 3 Apr 2021 09:05:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+sw_cYnL2XyuhknOpOh1jEPURg-W=jS2CyW2=ud+zog@mail.gmail.com>
Message-ID: <CAHk-=wh+sw_cYnL2XyuhknOpOh1jEPURg-W=jS2CyW2=ud+zog@mail.gmail.com>
Subject: Re: [PATCH] firewire: nosy: Fix a use-after-free bug in nosy_ioctl()
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     stefanr@s5r6.in-berlin.de, linux1394-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Greg Kroah-Hartman <greg@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 2, 2021 at 11:59 PM Zheyu Ma <zheyuma97@gmail.com> wrote:
>
>         case NOSY_IOC_START:
> +               list_for_each_entry(tmp, &client->lynx->client_list, link)
> +                       if (tmp == client)
> +                               return -EINVAL;

I don't think this is safe.

You are doing this list traversal outside the lock that protects it,
which it taken a line later:

>                 spin_lock_irq(client_list_lock);
>                 list_add_tail(&client->link, &client->lynx->client_list);
>                 spin_unlock_irq(client_list_lock);

so the locking is wrong.

However, I think that the proper fix is not just to move the code
inside the locked region (which makes the error handling a bit more
complex than just a return, of course), but to actually instead of
traversing the list, just look if the "client->link" list is empty.

That's what some other parts of that driver already do (ie
nosy_poll()), so I think that ->link field is already always
initialized properly (and it looks like all the list removal is using
"list_del_init()" to initialize it after removing it from a list.

So I think the patch should be something along the lines of

    --- a/drivers/firewire/nosy.c
    +++ b/drivers/firewire/nosy.c
    @@ -346,6 +346,7 @@ nosy_ioctl(struct file *file, unsigned int
cmd, unsigned long arg)
        struct client *client = file->private_data;
        spinlock_t *client_list_lock = &client->lynx->client_list_lock;
        struct nosy_stats stats;
    +   int ret;

        switch (cmd) {
        case NOSY_IOC_GET_STATS:
    @@ -360,11 +361,15 @@ nosy_ioctl(struct file *file,
                        return 0;

        case NOSY_IOC_START:
    +           ret = -EBUSY;
                spin_lock_irq(client_list_lock);
    -           list_add_tail(&client->link, &client->lynx->client_list);
    +           if (list_empty(&client->link)) {
    +                   list_add_tail(&client->link,
&client->lynx->client_list);
    +                   ret = 0;
    +           }
                spin_unlock_irq(client_list_lock);

    -           return 0;
    +           return ret;

        case NOSY_IOC_STOP:
                spin_lock_irq(client_list_lock);

instead. The above is obviously white-space damaged (on purpose - I
don't want to take credit for this patch, I didn't find the problem,
and I have not tested the above in any shape or form).

Zheyu Ma, does something like that work for you?

Comments? Anybody else?

        Linus
