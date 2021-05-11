Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044AB379AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhEKABl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhEKABk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:01:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A737C061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:00:35 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id bf4so20732905edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 17:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=COJ8NBBBzki8eCqYkhkubi396uoYtn+d54xPdf/XDGI=;
        b=fH9edYhIhXNS45T3MKPNZuNyZ4Dr9Kbmj3SwoR11BHS2MVE+a5yRkITV4a69S0kjHu
         o7S9NeYgpsPgfHtBs8nzvPaYYEcZ7URxyvTqudEr5eWUINuOTQDjXIFcTSgD1KPlf86I
         4lD5FYlp4kKoYqU5yQJd9dwADWLWNUDiEjNFEHoUPIE/FzVZNqziWzHZlr7/U8TWv8xQ
         6pTsrld5W085RCcnKL1jgP2ngyknZ11vYsFI0Y4XDkzLqFJJAtqxyok7tNqKpis0klXB
         54Je8GGRJtt4olvZMQJaSujDP0tgo4TIR16tA8Ii9IdF2/HynKu8XhOwpVAoQklbK1fC
         PanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=COJ8NBBBzki8eCqYkhkubi396uoYtn+d54xPdf/XDGI=;
        b=G46/mcyvh4/9epX06GFO3lfMNZ2c6PhwwykjX9N6/7QHTbLErldSkl/alIPh4hc2jI
         90lpNPy3h4sDarodD0J7JU2XtLXBCem3c0Gxjdz7Vf6WgKcyU2VE4gIojR/x+vhYNvvU
         YCwlI7iyzdFr7MgmEelUGQiGtj7jb05wab9iWis+m7QMxqO2mi/cVSY4NJ33U6PKIFap
         PeBKwvht9PuiV3RRWB9KPg3ApUz/WBGzFbmubX4NAHZngiqk2hsuwKDGNjl7WGNohPx0
         UGKnTN17znT+Y7W78CHymLp0lRa/ZH+kF1FHOjQ7ZOmlJkrk1OXeLyl2BIlvO1YZ6s+y
         CYQQ==
X-Gm-Message-State: AOAM530JTf8M82l3lIQei4HE8EOBjmWa1YWTRSSNpD+Byk1U93274qAC
        gOifS5vpYbn1ZF5/KGIuHu8snsXbhtz/7v5KAGM=
X-Google-Smtp-Source: ABdhPJwMnW4d/P/eJMXyAPqHrDckrcImg4v7R2xNngA0QSNxtW4NN3Xb3qZk0Ph3lDWgq7Efq08BJMal5JOhjysYCxs=
X-Received: by 2002:a05:6402:234b:: with SMTP id r11mr32402032eda.137.1620691233856;
 Mon, 10 May 2021 17:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAOVCmzGX54u4VLUSLt_yEM4E8MQNLwW4VTkNVurPXbCuQX6d_g@mail.gmail.com>
In-Reply-To: <CAOVCmzGX54u4VLUSLt_yEM4E8MQNLwW4VTkNVurPXbCuQX6d_g@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 10 May 2021 17:00:22 -0700
Message-ID: <CAHbLzko8rHfE-3k=e+fdW2+S1Cc0his8-=Ch08HuMMmf=RJsDg@mail.gmail.com>
Subject: Re: Profiling execution time for __alloc_pages_nodemask
To:     Shivank Garg <shivankgarg98@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        gregkh@linuxfoundation.org, sergey.senozhatsky@gmail.com,
        pmladek@suse.com, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 7:57 AM Shivank Garg <shivankgarg98@gmail.com> wrote:
>
> Hi Everyone!
>
> I want to profile the time taken to execute the __alloc_pages_nodemask
> for different linux configurations/parameters.
> To measure the execution time, I use the ktime_get() apis. I get the
> ktime_get() on the top, and I want to do ktime_sub(ktime_get(),ktime)
> and record it in a tracepoint.
> However, the patch on implementation prevents the kernel from booting
> up. I debugged the bug to find out that the issue recurs on adding
> ktime_get() inside the __alloc_pages_nodemask path. So, that the
> kernel fails to boot up ( and show the blank screen without any logs )
> I'm using the Linux kernel 5.6.13 (5821a5593fa9f28eb6fcc95c35d00454d9bb8624)

Is there any reason that prevents you from using some advanced tools,
i.e. perf, bcc/bpftrace, etc? They are much simpler than adding
instrumentation in kernel.

>
> Is it an expected behavior? or a BUG? Has anyone else faced the same issue?
>
> Can you please suggest, what would be a good way to measure execution
> time for page allocation (if not ktime_get)
>
> Stay Safe!
> Best Regards,
> Shivank Garg
> Open-Source Enthusiast and Student, IIT Kanpur
>
