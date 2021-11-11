Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D3144CE20
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 01:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhKKALt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 19:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbhKKALs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 19:11:48 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D19CC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 16:08:59 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id v15so8615038ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 16:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDjMT76zXXGk5F960573DQU0E4PoEGZAHFCp+Tmf80w=;
        b=BKU4np8esifPSBuytBzf7Ief7UfpQSZCMuejwaH0SHBXEJr5alactVBostbfNmdeko
         7v1G/EUa+ikc3nm+85b3K59bSJARKCHz/8+2KMtSClrHsKWAywOfIwV82G4c9cc6rrwc
         HRu1b4onBc/AxjvQZt9Or0ewy/VFoMKJs3A0DdP/oeFKku2vhIZIlOcpPERde2R6t87Z
         0n1P/jWOFsCiM0wRbKpN8gyK4wchmRslOeHZqOH0GYLawvU0+hobupN8Kc5WPRJJrg/x
         3KNavWuU+6DzZ74IWDL2S61Dr4KvoJggcqEgArfnXxL6Ch4CMO5gkgAtGSA7nNYWryzc
         sqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDjMT76zXXGk5F960573DQU0E4PoEGZAHFCp+Tmf80w=;
        b=sRvmKN6URYYIksr+sq5xty8I7la68JlhLZK81FI/E7E2A5cGS1G0t4vCqxUOS46C2J
         74JO72L4fVXj4prT4VHL+wr5iZIigzgOCxL7dvJOKNggME7ykCNR3ZZZqV9aLHI+Nyim
         VhqEa2mcSVpCY5YFxowWLQGR6XpsrhMjEaAJAjegxyN8h5iBW8GB48T02BzFof59bjsb
         bcU4u9AD4Ioi93LaQl/KnnKSfUaOdBg7zRB8kvUsWeC6E0WnBcun5Fsfa5qa7+m5Bez4
         vBxtTeyNXkYVmLsvgj9brJsVdWcZ6nQl0EJTqWXRkVHcowR6FFVNmc4o9+vaTq1PwGsA
         2uVQ==
X-Gm-Message-State: AOAM531VYmJ9RHGXVviKVyQpghtsOk+6gPuyFlv6PuehNEM0LXkGO18n
        k50R2M0i/hG4NysUKp/nqKr30QzdDLj5tJdQI9h9ug==
X-Google-Smtp-Source: ABdhPJwYekg35ZpH8F5So1cR61CNazDOLuVjMR/QnicyLM0m8jsMRDK+GGrvLCJojntqikJb6Cm747AxAl3EzRmKpUI=
X-Received: by 2002:a2e:bc1b:: with SMTP id b27mr3100349ljf.91.1636589337211;
 Wed, 10 Nov 2021 16:08:57 -0800 (PST)
MIME-Version: 1.0
References: <20211110230138.3883950-1-almasrymina@google.com>
In-Reply-To: <20211110230138.3883950-1-almasrymina@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 10 Nov 2021 16:08:45 -0800
Message-ID: <CALvZod6o68s150XFoDFPmaHeiGxQGmTzARE7qrr0KHo4Mpi1BQ@mail.gmail.com>
Subject: Re: [PATCH v5] hugetlb: Add hugetlb.*.numa_stat file
To:     Mina Almasry <almasrymina@google.com>
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

On Wed, Nov 10, 2021 at 3:01 PM Mina Almasry <almasrymina@google.com> wrote:
>
[...]
>
> +struct hugetlb_cgroup_per_node {
> +       /* hugetlb usage in pages over all hstates. */
> +       unsigned long usage[HUGE_MAX_HSTATE];
> +};
> +

You missed my other question. Why do you think concurrent access to
this struct is safe?
