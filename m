Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760ED402E6A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 20:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345938AbhIGSfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 14:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240131AbhIGSfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 14:35:08 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D21C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 11:34:01 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g8so13974653edt.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 11:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1aOJIDEqMjm8ZK3GtU+MSwaNYHHbxj0jU2uYyqL9MW4=;
        b=ZbxHP7Of0TVF2MchIXcNmmJEkQD4+JHAVxIOsVBBh2mzWBWAR/dP2rl/+DgZuyLfT8
         CQyVgq6n5L9QsMQ1Mtku3GgYKtLGaT+9T+yqwqKmliCV2CLOdHjn7p8w7Kv6UVI2rXqG
         ZjtC6nobVPWQfg6EyH5TWKGknJrIdjt9Lj5+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1aOJIDEqMjm8ZK3GtU+MSwaNYHHbxj0jU2uYyqL9MW4=;
        b=ihzYKs0rtbiFwA0zwH1mgtiAV1TzIP0DFED8fncBzLtCdyii3Q58oJs4yxa7bahVb2
         OvjenuYLGy1O2ZqngWZTAEwOby+XJma9oXa+WWRXKdMO8ydRA670ocMpkrZ5e09FU+x4
         N3816ElXls+KgbRlesfqwU0qYMRxVcwhbqxqXZdxXLQlcTdkgiXFAq6S4d8Y3s7u39OP
         neHwtcksemSKRlgXWjSw/3/s1Pbz6ZRaZ6LIw5GYr3W/ifUgytXPi3usF20TJBbh9DLF
         2nbOBwcbfA3R3lszZkUS12Si1E0dnUupyrGsQQfvkhkFgvBxj7icvojgwBTOnxnXljgj
         IpXQ==
X-Gm-Message-State: AOAM532UkZufEjlLlQXHqMf4kpiB+lD+1wfEA01CvXa8mKBcYA7XchgO
        Z8DqqH+BiDT4jA7QSCjHPy2S4SUMjUVNOVff/Jg=
X-Google-Smtp-Source: ABdhPJwKld9/A9FOdaZKINxvW7MldzerxdmwxjWI5AwvOIToSTMk4a+S7auFRqXErLT3uzWC68cvew==
X-Received: by 2002:a05:6402:2708:: with SMTP id y8mr956323edd.84.1631039639745;
        Tue, 07 Sep 2021 11:33:59 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id k12sm6967502edo.9.2021.09.07.11.33.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 11:33:59 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id n5so15833931wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 11:33:58 -0700 (PDT)
X-Received: by 2002:a2e:a363:: with SMTP id i3mr15409370ljn.56.1631039628449;
 Tue, 07 Sep 2021 11:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210907150757.GE17617@xsang-OptiPlex-9020> <dbc9955d-6c28-1dd5-b842-ef39a762aa3b@kernel.dk>
 <CAHk-=wgrF65BpP6P6_a6+k+C8V+JOBiEx0X-c9idiM87uk32FQ@mail.gmail.com>
 <CALvZod5Q_K=xLpBWTLgg38X_w23HVSyqW2_Jnz7p=JR+kDD_-w@mail.gmail.com> <CAHk-=wgW3dYJyh6S_U5ot_0Q-OU0-vrS=L8Uky4+Y5fZXeLcKw@mail.gmail.com>
In-Reply-To: <CAHk-=wgW3dYJyh6S_U5ot_0Q-OU0-vrS=L8Uky4+Y5fZXeLcKw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 11:33:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whiFC8Az2wD5_DCeysw+DV4srAj3sCbVP4asPPEJbOpqQ@mail.gmail.com>
Message-ID: <CAHk-=whiFC8Az2wD5_DCeysw+DV4srAj3sCbVP4asPPEJbOpqQ@mail.gmail.com>
Subject: Re: [memcg] 0f12156dff: will-it-scale.per_process_ops -33.6% regression
To:     Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        kernel test robot <oliver.sang@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>,
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

On Tue, Sep 7, 2021 at 10:52 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So _right_now_ my plan is to revert the two obvious cases:
>
>     0f12156dff28 memcg: enable accounting for file lock caches
>     b65584344415 memcg: enable accounting for pollfd and select bits arrays

That "my plan" became "my action", because I ended up having another
VM revert due to an oops report and once I started doing that, I just
did all my pending reverts.

If people are aware of any other cases I missed, please holler.
Because right now my revert queue is empty, but it migth be because I
overlooked something.

                  Linus
