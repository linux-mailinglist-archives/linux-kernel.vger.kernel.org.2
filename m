Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A65A402C42
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhIGP7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhIGP7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:59:01 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BB7C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 08:57:55 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id h1so17327279ljl.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iIiYxupSjlJVesLQ5Se7T4ey4EA4tPfggiDuRfDLa94=;
        b=bLJF2jmdHWvYCvTIC4Pc+0cskBDRlG7IJ03PR4oYQFgBAVzC/q95gOcy1Cu//xQR+g
         hDnjrI6ZKVr3aa5ahEfW0dZ3BtR7xNLXa44fUnYW4O9OyHL+Ksji/i8ScsEy0AqzmUal
         PpC50txOWBXFXRk8OPuCPrw4AjitR7Q4vQfUizkXrWbbEXL1S0GlUDosx2bLyO6Sw3A8
         FOezSNU4sgr5m9haJ3j1fr9Uow3wM/lKgpStw4cYfbHOgbjeSikN98R7yjLPYEpu4p1S
         usCph7YQVxgVTcdCZ2j9bQyCx6hP1aW+ARSDNUn4D+pf02WGOLlxVDMaIUJ95CpWkYHo
         KcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iIiYxupSjlJVesLQ5Se7T4ey4EA4tPfggiDuRfDLa94=;
        b=ZfGzv2TWo9N3WBtcPFgeB2IXgN2iJcei0HwT357kD0VVUHfq9ClPr6u344VE/15Etc
         yiqgIOHDCUz8TXM08cNhUnquFH7HvDL4G29ag0uzGJcNQgaD6nuCciboLdOMucl99sBM
         uES6sejlyhYEmeuSDz2juyEHzHr9Ud0irfQufLrVIGcxmx5/q9xD7YfRdi4bcOF43mdh
         ZytjJ+EbjtZpWX8lNLMYhyBGMIQVOv1x4XyP/OJZUiJfBMrDgwq2jO7W2jK+XNAZNqWp
         MsJawwpA548CyaTdalyKl+QMS+jcUNWfm+ngoMFT6Ky5WgN9Ac4EymQNCCxl8PBXeDVR
         yYDg==
X-Gm-Message-State: AOAM533xF/U/p79idBArtNcVLcW8jMpfaTMfOUb97sd6C9sfqA8w3KWU
        WLRgdAb3UUbAKr4CY142xVw/XltZ2sONvTLVljc3uw==
X-Google-Smtp-Source: ABdhPJzE+Ck5JrobGN2Hg+h7ptptJkWtTFdlNcyT/x6lNvXKh/S901CQ0XicySdpOb/NJ6YXIOu90d335JKSb7QlSFk=
X-Received: by 2002:a05:651c:1029:: with SMTP id w9mr15100528ljm.202.1631030273217;
 Tue, 07 Sep 2021 08:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210907150757.GE17617@xsang-OptiPlex-9020> <dbc9955d-6c28-1dd5-b842-ef39a762aa3b@kernel.dk>
In-Reply-To: <dbc9955d-6c28-1dd5-b842-ef39a762aa3b@kernel.dk>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 7 Sep 2021 08:57:42 -0700
Message-ID: <CALvZod6S+NmG8+-ftS-w3t3zJg_kbr3-F9h-n4jwSnqh0jTUGQ@mail.gmail.com>
Subject: Re: [memcg] 0f12156dff: will-it-scale.per_process_ops -33.6% regression
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Huang Ying <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 8:46 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/7/21 9:07 AM, kernel test robot wrote:
> >
> >
> > Greeting,
> >
> > FYI, we noticed a -33.6% regression of will-it-scale.per_process_ops due to commit:
> >
> >
> > commit: 0f12156dff2862ac54235fc72703f18770769042 ("memcg: enable accounting for file lock caches")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> Are we at all worried about these? There's been a number of them
> reported, basically for all the accounting enablements that have been
> done in this merge window.
>
> When io_uring was switched to use accounted memory, we did a bunch of
> work to ameliorate the inevitable slowdowns that happen if you do
> repeated allocs and/or frees and have memcg accounting enabled.
>

I think these are important and we should aim to continuously improve
performance with memcg accounting. I would like to know more about the
io_uring work done to improve memcg accounting. Maybe we can
generalize it to others as well.
