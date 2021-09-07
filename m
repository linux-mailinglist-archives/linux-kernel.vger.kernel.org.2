Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E478402CFF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344549AbhIGQkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbhIGQko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:40:44 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C141C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 09:39:38 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id me10so20862510ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=caN7E+Jp9gV/N2qAG+zwG3Ny5H5LTkTCLeyDIvVWjFg=;
        b=iHnyywJbb10KAIjqP+PtbJqd4z/wsIFM3hvnsxB8tw8c978znSUWNOkKvLpPSLJ7MQ
         pMu0kLrnlehTdnsAEWhBNEAxf6LO4ocZivc6TiR92eRKX9xFOFrWkZ7LRlLK6UBbcvmY
         y7wkjSvmK5+a64LPzOhzGf3wAl/7QNeFQVRMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=caN7E+Jp9gV/N2qAG+zwG3Ny5H5LTkTCLeyDIvVWjFg=;
        b=GB3ktMrsX1lc9tpjml34lbBQjHo/pi7NTlDx3p7TTgLEh4Wg6vxFh4eOE3daCDtzhL
         HJRLENsTRwVIyyUIZAC2ClwQr3oiHooL4sVla3qJq336FuBypY1ESvWpIkEj31/svI9K
         UV3usEMdpWZ2DI4e0k/kYk2EKdb/ogp4R/kDSGMAjpUHVQBtFrcFbReJhyv3u+AX3Ofh
         m84X6pNqFtozG/8bT3t5mnh/BM4rA+6ZOAOVdoHXnaeOA9OnU+LlDLjjRr+gnikH9NrE
         zqp8gBRh6W6QO+bm5AlyjAH35kwy0Qv9zUqT+FsGnffhkIN0iO076x9ZPWSJasw5W3JR
         LCuw==
X-Gm-Message-State: AOAM532cnNWHGpNP/4T5LSW2+zQ9hreA27fXv6RViZdNfIgHIShz6LLZ
        6cNeiNmGo6xclr4ZRF5frJqAciaS63nJKn6pCXU=
X-Google-Smtp-Source: ABdhPJzgoVg/fn05bCZKmL12v+Q/utpMRyR7ZcCUcs5P3mbgrFZWWjIm9l0fNPQnVek6WnycLICWEA==
X-Received: by 2002:a17:906:abcd:: with SMTP id kq13mr19907032ejb.195.1631032776255;
        Tue, 07 Sep 2021 09:39:36 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id y20sm5583072eje.113.2021.09.07.09.39.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 09:39:34 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id r7so14772877edd.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 09:39:32 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr13740102lfv.655.1631032761639;
 Tue, 07 Sep 2021 09:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210907150757.GE17617@xsang-OptiPlex-9020> <dbc9955d-6c28-1dd5-b842-ef39a762aa3b@kernel.dk>
In-Reply-To: <dbc9955d-6c28-1dd5-b842-ef39a762aa3b@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 09:39:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgrF65BpP6P6_a6+k+C8V+JOBiEx0X-c9idiM87uk32FQ@mail.gmail.com>
Message-ID: <CAHk-=wgrF65BpP6P6_a6+k+C8V+JOBiEx0X-c9idiM87uk32FQ@mail.gmail.com>
Subject: Re: [memcg] 0f12156dff: will-it-scale.per_process_ops -33.6% regression
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Roman Gushchin <guro@fb.com>,
        Serge Hallyn <serge@hallyn.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yutian Yang <nglaive@gmail.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 8:46 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Are we at all worried about these? There's been a number of them
> reported, basically for all the accounting enablements that have been
> done in this merge window.

We are worried about them. I'm considering reverting several of them
because I think the problems are

 (a) big

 (b) nontrivial

and the patches clearly weren't ready and people weren't aware of this issue.

           Linus
