Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E625D44CE5A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 01:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhKKAdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 19:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhKKAda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 19:33:30 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FC2C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 16:30:42 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id k21so4946340ioh.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 16:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fT8EyriSb2iTbW6FeExFuAllB5m3bIQ+kntOaqEpft4=;
        b=tIHVdpSGx/eIULXqasCsuoz+k1U2gnc1/sW3d+Le6rIdANCpKUfw7fHZrPm5HEz+AX
         cWiJQtBakCq7b+QWwFactAcTWGMUONNjOZPL9MHUvmKBXYdmYumS7/dD9g81zJ8G6stW
         inhiaxZ9ODFc0HssCtq7zTYEN+CoGC8m10GB2Cvi7EMzmt5DPzD3ENbYuftdTNtHYijj
         7r+vP53dmloQ5ZJTizIkEeO5p4X2OfdFVfZWkLZS7jJBHPJCddjf+fOwPhbPS7KSwo+M
         W2lDmR+U4yJr1dERn7ZLuQKe3W+pKbcsB0DHSqTHySofXLQacXw462cdVvs9NC8n6RZu
         JI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fT8EyriSb2iTbW6FeExFuAllB5m3bIQ+kntOaqEpft4=;
        b=y6SXXPIIoiPpqc6Ji25AjoEuiQz2Fzt0yVXD6ukLRVVnmlEq+DWdUk34qV6nFI0EUE
         nI8k1X4KyHS8WqhO26wexwLloRdOSYj7uxZGCMsRWV7tUWc43G624a+uAZXFZJyuSdwA
         bL7IMzKfxFUM44/OQXVyqnnNK0qYFz5CohdBPRTdeZRa66wYWbotsITWvOdMJDi5x1s8
         rXTnl7LC+VofKGSxPSo5xc88kj8c4lN9KP4B/kEldH+oiq8P77TuvwL/8Qty4uvU6LnU
         q7b3cwgOUYZ6P/TVfdmXSetnvYVvNGhDIaIinoKvKLEFcoVLYLrunKNIJsCpi04ubkxT
         qpcA==
X-Gm-Message-State: AOAM533484WUYuJHOsKCQidpdKOKh80URixlVtNTa6BytjDgAWvbc3sI
        2qaFqvdf+m6n5RFw1i7nG3C0+/35DS3nu5ly5pairg==
X-Google-Smtp-Source: ABdhPJwtwprt61SzFh4A9Utq6f0UjVGvoJCje/nmCTMC5hN0VJwRmCzn4kH/tJeXTGHQrT+tBF0/hmpY4RnBX19YQLk=
X-Received: by 2002:a02:6027:: with SMTP id i39mr2255010jac.91.1636590641382;
 Wed, 10 Nov 2021 16:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20211110230138.3883950-1-almasrymina@google.com> <CALvZod6o68s150XFoDFPmaHeiGxQGmTzARE7qrr0KHo4Mpi1BQ@mail.gmail.com>
In-Reply-To: <CALvZod6o68s150XFoDFPmaHeiGxQGmTzARE7qrr0KHo4Mpi1BQ@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 10 Nov 2021 16:30:30 -0800
Message-ID: <CAHS8izM9LKZDbVbHeegsV1uTX1_YSPuNFMwLMpQ-28=2ot8V9A@mail.gmail.com>
Subject: Re: [PATCH v5] hugetlb: Add hugetlb.*.numa_stat file
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Jue Wang <juew@google.com>, Yang Yao <ygyao@google.com>,
        Joanna Li <joannali@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 4:08 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Nov 10, 2021 at 3:01 PM Mina Almasry <almasrymina@google.com> wrote:
> >
> [...]
> >
> > +struct hugetlb_cgroup_per_node {
> > +       /* hugetlb usage in pages over all hstates. */
> > +       unsigned long usage[HUGE_MAX_HSTATE];
> > +};
> > +
>
> You missed my other question. Why do you think concurrent access to
> this struct is safe?

Oh, very sorry. I'll upload another iteration with a fix!
