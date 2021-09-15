Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A99840CCDB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 20:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhIOTBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 15:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhIOTA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 15:00:59 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96806C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 11:59:40 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a66so4654449qkc.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 11:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=avHjXeQ13wJPm+ZH0ocabGHBbHduG3G1S3OEBNfWY6I=;
        b=jlWN9GA974qgCvuNDp3XkdBzubEkQfCLu0KWXVJcssyLwokzMr2dROKaXdp5/ff3nI
         asqAlbkLBEJoil7ErHqXZgne8xEA6tqQbIsbl7LwwiU7yUu86unGFimCV61LDsCVjo90
         SZiF/DUN14Zfcnrb/JU3ePbX0l0b/Sn5sAlpEi7MEXDw852mzNy8Ccao6M6ENeS+GPfa
         2TiOsASWrCJFwEFELPuV8N8e/FHjroOeKfHY9Y7ljbcuGk0Nz86VZ87Dqfvtc/AUyFI8
         HZWo6yNS9d7E8mmtx1I7gBk2eRdpSGfDhIPHCEQAUdWw5QbPxUQfiFvjd0LG9uGj2vnu
         TaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=avHjXeQ13wJPm+ZH0ocabGHBbHduG3G1S3OEBNfWY6I=;
        b=AG3iMmkkGNPqyde386OrTlI4owQw1P9nYxUtkbApWsvxsIDpt4T0P5Ix172rCClVKQ
         k++JG0qiixIgZlJ0kv/j7shqqpnppFT+fCpe7YuxEvboojXTBGo83v4LgcdH8eyDSP6C
         Z5B1crQK539xYZFpLysvkbcQqBmMBm3KpgWP7D2BIJUsd5nG37XWdXKc8Hqt5YiUzAh6
         iZo1dwZyoVaMhiPpoBQ+pKnlhmGpfnLqCw6hpNEm8ma3b0/5kom86f++nl1Lm0ZEwzNm
         0UmYqD7Z0wS7Hv7S61swm4OqChZ8Zzc+kvEZJZrwLTLsLTgIZXJqY8BfMJYc+oESrR4D
         my0A==
X-Gm-Message-State: AOAM533b+lloNZzKJnnEXNV0INVpmuakMXyowSu+OfTO2bmkOXYkBoIB
        FwIaHLPhQAGnX8uER/MOmRjHYfozVASSYGi2+tECph1WtuHHSuVR
X-Google-Smtp-Source: ABdhPJw6U275eh+92f2WXPGRenZyySeezaujW/gX5ezOXb9W2FsIzpiSqEvQjjnB51gAx9PTS+vicUJHr3LPg9+lJ50=
X-Received: by 2002:a05:620a:199d:: with SMTP id bm29mr1456458qkb.14.1631732379710;
 Wed, 15 Sep 2021 11:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210819175034.4577-1-mkoutny@suse.com> <20210819175034.4577-5-mkoutny@suse.com>
 <CAKfTPtCAxksmsR6DJuAoSZ7XTon+gesyic36EHL-nQk0LiHWQg@mail.gmail.com>
 <20210914092207.GA23743@blackbody.suse.cz> <CAKfTPtDw6_iMxGyCK8vrwgV-zMyHtNKBksxs3OpbpK=houzp2g@mail.gmail.com>
 <CAKfTPtC5+4gf_R0bAVHe+0Fw6dQYQ_a-f529H9s4KLpm40X9Ng@mail.gmail.com>
In-Reply-To: <CAKfTPtC5+4gf_R0bAVHe+0Fw6dQYQ_a-f529H9s4KLpm40X9Ng@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Wed, 15 Sep 2021 19:59:27 +0100
Message-ID: <CAFpoUr3APdFordH+1XjHPWP5FtKuQBAXSRTt4arruMkQcx2ufg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] sched/fair: Simplify load_cfs_rq_list maintenance
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Odin Ugedal <odin@uged.al>, Rik van Riel <riel@surriel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ons. 15. sep. 2021 kl. 13:31 skrev Vincent Guittot <vincent.guittot@linaro.org>:
> The corner cases that I wanted to check, are covered by
> a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on unthrottle")
> and
> fdaba61ef8a2 ("sched/fair: Ensure that the CFS parent is added after
> unthrottling")

Still have some more of my testing stuff from when i discovered the issues
behind a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on
unthrottle") as
well, so will take a look at this patch later this week.

Need to wrap my head around this logic again, but the idea looks good
at first sight.

Thanks
Odin
