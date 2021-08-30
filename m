Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978053FB2EB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 11:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbhH3JNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 05:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbhH3JNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 05:13:00 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF57FC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:12:06 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id z18so26733478ybg.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 02:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YChlRIwNGYErlmU0QryVn5ed1Ie2ageBpLATHI0LS7I=;
        b=jGOF9gXLJt2KO1gz3XoWbK0fzlSey9CAQTTRVie+Bp+eOvzKreZhD9JcI9DQ7TRZIy
         58OjivsgS9GbuNV8qxo/q01bhHXQV2b0fPLQpjG0ewcd649Tp1fS/j0JcCR1XHx3z3oS
         bvJeE1MqMY0s9avZ6V8JZAfvKbJ9A8S/SWUIxvz+MaZSipuKwhEezMepJG9qXhur7zkP
         G354nwCpke4/5pLqRnfs8nHN51zk0J1zAXj4TLkl8qKtEvzOvuGn1F9AkFNxckco2lmm
         lsRpU/+v5mekYId6mnXC/bkkKXvGlh4bOnnRRDeXjIrkpUoa6p0RpXNnSqvOHjUYx9+x
         eA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YChlRIwNGYErlmU0QryVn5ed1Ie2ageBpLATHI0LS7I=;
        b=Sdo5+vf/z9Y1nfAUqc4OuD/Omk8rhwFkwjAPKIMkJmaid1ZutVitxQH065cOohO4BW
         E+4a53r4OzNx624A5/0DTl9xvmS52oGL6xlYaQn0KV9DOgMZuctIceQVUVXL7LKPgPtM
         2HtlFCb1SHbhie6+EeIs9RsuAQk/YTHxkBqKIF7GzMXSbQ1LjYZ8VgY+/FvBWPG2W6TK
         p78bWQR0NODMOVWXmJIU79agMh45U07CjQ9zT0L+/8yqh0mlAvrU9tqZDvC/PuvAhRJM
         MQdAlVlcO5YG0xkaIGpppSMQZ6ytt4IHhQGAHlXVjNdufc2iS2czw8OjXCtsc/DF/Yu9
         5vRg==
X-Gm-Message-State: AOAM533GTnPLsENIwEwAkMsz90+3pfLpPlybY4rm1RNssQnrIMWYSFMy
        z21mGSS0Wtvvvl5uWGaDTz5dBZn5FtZB3k5UDT56lBASVuk=
X-Google-Smtp-Source: ABdhPJyKl/L4iGAXckrro18BQ3MSSr+elNrdPc0y5fMhFkU49xetZHkj+4Z8aMAnJNZl1IhBeqbO1IpxdO0r9N/8Wmo=
X-Received: by 2002:a25:2b48:: with SMTP id r69mr23272560ybr.448.1630314726093;
 Mon, 30 Aug 2021 02:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh75ELUu99yPkPNt+R166CK=-M4eoV+F62tW3TVgB7=4g@mail.gmail.com>
In-Reply-To: <CAHk-=wh75ELUu99yPkPNt+R166CK=-M4eoV+F62tW3TVgB7=4g@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 30 Aug 2021 10:11:30 +0100
Message-ID: <CADVatmP8HQfZBPevLuuWtWh=1eBD=cmY84iJoMcoHh0n480Bag@mail.gmail.com>
Subject: Re: Linux 5.14
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On Sun, Aug 29, 2021 at 11:23 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>

<snip>

>
> Of course, the poor tireless kernel maintainers won't have time for
> the festivities, because for them, this just means that the merge
> window will start tomorrow. We have another 30 years to look forward
> to, after all. But for the rest of you, take a breather, build a
> kernel, test it out, and then you can go back to the seemingly endless
> party that I'm sure you just crawled out of.

We were recently working on openqa based testing and is a very basic
testing for now.. Build the kernel for x86_64 and arm64, boot it on
qemu and rpi4 and test that the desktop environment is working. And,
it now tests mainline branch every night. So, last night it tested
"5.14.0-7d2a07b76933" and both tests were ok.

rpi4: https://openqa.qa.codethink.co.uk/tests/68
qemu: https://openqa.qa.codethink.co.uk/tests/67


-- 
Regards
Sudip
