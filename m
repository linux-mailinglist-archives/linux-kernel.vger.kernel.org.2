Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7D43102E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 03:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhBECkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 21:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhBECkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 21:40:51 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A07C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 18:40:00 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c4so5889920wru.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 18:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KrxuWR/Lm4v4BWcac9Ts2j/JMY/RAA6h700GnlMoUbk=;
        b=BOn1mNtq3puSazs0rViio49lg0t/e1BTWkIt5KnAQ9+Leu+6wtf9fZJ4ahbIH6NGZE
         1Tvz9u5MV0MvZNT6vPJJ9iftmwcFVom5j1I2ZkkRZew+ntGs81+G0R1R1tXs9HArCdUV
         P9Yodyq7r5/o0DLjI/VlezJ+VKS6bsOAde0GLNaok6TeoT4NPQAWeB8EFpBse3KIrT9y
         TqqW10gU876llTurg6M2nUXMvGDOzRQbVkWMcOUpZEsAbBMtnGxWQV+vyVI+lBVNi77K
         e2GLaOSkTsnQcMEf66aa7msysph6sdlTa6QJlA1N/OcxGKZicVjO32cj74CNtR89JLiv
         wwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KrxuWR/Lm4v4BWcac9Ts2j/JMY/RAA6h700GnlMoUbk=;
        b=JNmt1+K7pRg0oHY0Vnxpselgxi5hbvj2We3ihNX2v5CRtotiE/Jn8KsUKvUoxsvsO7
         jv/2tK4YBbsfXL6wyld0KD9K6u1LhteTtC4eF6pa2lXkFn6E2zxImQDbNf9UoCOhAVhJ
         pwZOMszbpoW8klzIpiP/nNbnSCyEC0ohSUXiGHGqyco5w1gO4VnvBl8iDVqdtkmdnEjX
         o3LVInlcEBTwxgVk1iE9X/A8J5BWzIy5pSarQ4UdMbi+KeTuJ246Nd3JbWWSWwtQtyzW
         wwe/vBl5T4pA8TdWKZ4ZH/PKtJsb9ekUyWyt1o62c7yfNKOoEdwiqWhswHBRfTIAhUN6
         h1CQ==
X-Gm-Message-State: AOAM532aBCTwG7L9kuCQq1hbMKuNOGmFJ18cvMgC5X3efz187JE9TAso
        pjkjjmiQMc7uNgV7LLeKVXokbIClGyfeTb8wDIx2Wg==
X-Google-Smtp-Source: ABdhPJz7jCN9ThVqAOwhnpQs7RtCjbmaX+bZOnmytw9bwt7OpRl7AdgZ8K+7ojC4UbsnDx2Omx4dOzf4impbO9I6jf4=
X-Received: by 2002:adf:e50e:: with SMTP id j14mr2437426wrm.162.1612492799266;
 Thu, 04 Feb 2021 18:39:59 -0800 (PST)
MIME-Version: 1.0
References: <20210203155001.4121868-1-minchan@kernel.org> <7e7c01a7-27fe-00a3-f67f-8bcf9ef3eae9@nvidia.com>
 <YBxT9XFE6QAQ4T9N@google.com> <cda5547b-0c78-756b-bd0c-f3e534d04bff@nvidia.com>
 <YByNU4Q7cc7gYwPh@google.com> <87d7ec1f-d892-0491-a2de-3d0feecca647@nvidia.com>
 <YByi/gdaGJeV/+8b@google.com>
In-Reply-To: <YByi/gdaGJeV/+8b@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 4 Feb 2021 18:39:47 -0800
Message-ID: <CAJuCfpHmMVFDZ7ZA0uVc_5b4HCB3QBptahBhTWovGvNtjmfGig@mail.gmail.com>
Subject: Re: [PATCH] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Dias <joaodias@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 5:44 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Thu, Feb 04, 2021 at 04:24:20PM -0800, John Hubbard wrote:
> > On 2/4/21 4:12 PM, Minchan Kim wrote:
> > ...
> > > > > Then, how to know how often CMA API failed?
> > > >
> > > > Why would you even need to know that, *in addition* to knowing specific
> > > > page allocation numbers that failed? Again, there is no real-world motivation
> > > > cited yet, just "this is good data". Need more stories and support here.
> > >
> > > Let me give an example.
> > >
> > > Let' assume we use memory buffer allocation via CMA for bluetooth
> > > enable of  device.
> > > If user clicks the bluetooth button in the phone but fail to allocate
> > > the memory from CMA, user will still see bluetooth button gray.
> > > User would think his touch was not enough powerful so he try clicking
> > > again and fortunately CMA allocation was successful this time and
> > > they will see bluetooh button enabled and could listen the music.
> > >
> > > Here, product team needs to monitor how often CMA alloc failed so
> > > if the failure ratio is steadily increased than the bar,
> > > it means engineers need to go investigation.
> > >
> > > Make sense?
> > >
> >
> > Yes, except that it raises more questions:
> >
> > 1) Isn't this just standard allocation failure? Don't you already have a way
> > to track that?
> >
> > Presumably, having the source code, you can easily deduce that a bluetooth
> > allocation failure goes directly to a CMA allocation failure, right?
> >
> > Anyway, even though the above is still a little murky, I expect you're right
> > that it's good to have *some* indication, somewhere about CMA behavior...
> >
> > Thinking about this some more, I wonder if this is really /proc/vmstat sort
> > of data that we're talking about. It seems to fit right in there, yes?
>
> Thing is CMA instance are multiple, cma-A, cma-B, cma-C and each of CMA
> heap has own specific scenario. /proc/vmstat could be bloated a lot
> while CMA instance will be increased.

Oh, I missed the fact that you need these stats per-CMA.
