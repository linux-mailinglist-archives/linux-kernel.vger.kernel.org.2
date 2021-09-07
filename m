Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30920402D22
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345120AbhIGQug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344757AbhIGQug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:50:36 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EC6C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 09:49:29 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id l18so17550450lji.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 09:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5nQbyJjyzYh1VE9otVZMdrlw6C2fQU7LqiyZwWhRq8I=;
        b=NVUbyStWPnZEpGwewjJDKQ49JQ1jS7fdS4WFuuEXH6Ec+tgit3cI7Zx+/Nl++iF5/h
         Qroa/KSzykKZxvfQ+R+/dAb8gqDg23zNrJp5/uL3kPZ3d5bjwG3gngjjBm8D5vrFHGvs
         LlirBmpO4+IJRyplk8tRs13DQ9RKkOR3feokKnAQmxoGoUKXx54JLH55zKw7mFzh2qS5
         X1ArRmg/W8oRHrwR2pL63LtrWLCLK+YitgQ7s3hhxfIpMpNW2nQXmSat6ET/kzbwL1bl
         K3Cj3YCHsKCd0FpU3XMY/KbyLnpMQ/ALHB6pCRJpfenplHLyqVheTimS207aLaqG568M
         suQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5nQbyJjyzYh1VE9otVZMdrlw6C2fQU7LqiyZwWhRq8I=;
        b=D9Rte9AZ2vgTzb4/dMUL/2DLOiruJWfD5ELXbqsmPpi1bWxGqlYldciBf9a2wXeiA6
         /Hfyq4T5bnir4WP87sUoRAL/jZiTzPoP6ZN1ouxRzuYoOaHBE4TjhcFLgeDQiJu4v4/D
         D+z5PUU1UUvGtFGUzpKG3FxxOE+CKSSHOKarJMfhl/MCPXHYipLuN0pKoTohWFn9aJ4D
         nxjI0DB+nsi9L7bca0cXpxzdgfg3J/ogNYxndOGU+wOyMcg5MEDUAkyg7Daw82eWfjwl
         mPP0fbvFV6DoTbmcVMiod99QEz+sc85NegETBOZSM2ySEtGSh+NLnmtI6o9peEaptFWi
         5W5w==
X-Gm-Message-State: AOAM532t5A1dxG6xbOfGwkOukizVEgpiay0lnw7IyVprcWj50SOqtqvy
        cD7IP5o4N/atMxSPaHit7b44Z0ES082TiNNtnQ5eLw==
X-Google-Smtp-Source: ABdhPJx1Mt+rA644wmpE0Q8tfmC+UipX8VAbZfje8lUVW/KXdgSthvVRLWXGw5okBj0K1CCXiGTB+0bobPIsyklSCW8=
X-Received: by 2002:a05:651c:1029:: with SMTP id w9mr15283815ljm.202.1631033367581;
 Tue, 07 Sep 2021 09:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210907150757.GE17617@xsang-OptiPlex-9020> <dbc9955d-6c28-1dd5-b842-ef39a762aa3b@kernel.dk>
 <CAHk-=wgrF65BpP6P6_a6+k+C8V+JOBiEx0X-c9idiM87uk32FQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgrF65BpP6P6_a6+k+C8V+JOBiEx0X-c9idiM87uk32FQ@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 7 Sep 2021 09:49:16 -0700
Message-ID: <CALvZod5Q_K=xLpBWTLgg38X_w23HVSyqW2_Jnz7p=JR+kDD_-w@mail.gmail.com>
Subject: Re: [memcg] 0f12156dff: will-it-scale.per_process_ops -33.6% regression
To:     Linus Torvalds <torvalds@linux-foundation.org>
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

On Tue, Sep 7, 2021 at 9:40 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Sep 7, 2021 at 8:46 AM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > Are we at all worried about these? There's been a number of them
> > reported, basically for all the accounting enablements that have been
> > done in this merge window.
>
> We are worried about them. I'm considering reverting several of them
> because I think the problems are
>
>  (a) big
>
>  (b) nontrivial
>
> and the patches clearly weren't ready and people weren't aware of this issue.
>

Sounds good to me. Please let me know which patches you are planning
to revert. I will work on the followup to make those acceptable.

thanks,
Shakeel
