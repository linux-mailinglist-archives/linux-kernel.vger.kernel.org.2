Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0AA402D88
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345647AbhIGRPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345589AbhIGRPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:15:54 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32522C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 10:14:48 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id u18so565142pgf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JWmYYu9NN+2ZZeOex6cdTbGXkeowRVyC44kBg+i7z40=;
        b=a2De8dILU0uxwmtHffLfQygiuvbaeom293MsfMvvSex2AS5xdC7fGZegP0s73u4rcZ
         xrzXzJvbHSHTelCKHAZeBJaOfrzCT2CaelHAgIVi3BllbntUHZEJQJ9iQFdVbvafADEq
         dJVMMsK1gGTDdmi3bDLtsWgn0pu4vAVxRc4RhIgJyniLiZe8ACrE6dMEpISj4XCyt50z
         eElO1QFSgq7jUH4QFCPB+u3VJmOuv4OWJHvhiSdNohu56rjwq3TNl1R7DvrmNcggMog8
         7GaL4BePsjSMMpfb7W6mt/xNzZPIir/bwXyTNfmuuQxFaByUxwDp8wJBLaLeMANRhOgQ
         zuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JWmYYu9NN+2ZZeOex6cdTbGXkeowRVyC44kBg+i7z40=;
        b=Kr6FVJpmYDW35iopgSCZMFYIxjDeobO8BAvsscjYFMf39ggyfkFkBUsPnPWy3XAYgZ
         XiHGVLnpBvDjxt8CtSHPr2cwNmZQl6d3jng1meuGajGkRh15z8TGBwR0uOFmPbBlEenh
         JKX18qde6W3HxuyXynspmPXtIbWMzo9VLupXJF/+yUZzx/htbP2bt+x5zdZw47To5QVU
         CH24u2KbRTCmL2TEOe43Dg2AAO0h1Q8/xe1b1MKdkgG0Cgoy673c9zFaOJK0ewF7PhZO
         Slt+bakzlrkZPySpX3QkWfwzzogDPF23yB4+NDEbBOUmMCd6bZZ51lLVHoDgAyWEL2nl
         ruKQ==
X-Gm-Message-State: AOAM533GyrtiK/fPJKaw8x8Wx3NVv9HXULIEEE5pfcW8lpHXMWcCYwe4
        aJrlUihua+OQ7MoM/9XxKSE=
X-Google-Smtp-Source: ABdhPJyfu7ELpEVqe1SvvWFGsuLRxO8koOOEx06ldm7ehr4VtIO3Pj52mWPiu7mjOKsfh1BND1nxWA==
X-Received: by 2002:a63:1d5c:: with SMTP id d28mr18046453pgm.143.1631034887383;
        Tue, 07 Sep 2021 10:14:47 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id n21sm11254080pfo.61.2021.09.07.10.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 10:14:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 7 Sep 2021 07:14:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
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
        Oleg Nesterov <oleg@redhat.com>,
        Serge Hallyn <serge@hallyn.com>,
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
Subject: Re: [memcg] 0f12156dff: will-it-scale.per_process_ops -33.6%
 regression
Message-ID: <YTeeBf64yUwj01Sf@slm.duckdns.org>
References: <20210907150757.GE17617@xsang-OptiPlex-9020>
 <dbc9955d-6c28-1dd5-b842-ef39a762aa3b@kernel.dk>
 <CAHk-=wgrF65BpP6P6_a6+k+C8V+JOBiEx0X-c9idiM87uk32FQ@mail.gmail.com>
 <774dee70-69bd-9f95-d197-4cff83e4e633@kernel.dk>
 <YTedOVCV3s6Z210f@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTedOVCV3s6Z210f@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Sep 07, 2021 at 10:11:21AM -0700, Roman Gushchin wrote:
> There are two polar cases:
> 1) a big number of relatively short-living allocations, which lifetime is well
>    bounded (e.g. by a lifetime of a task),
> 2) a relatively small number of long-living allocations, which lifetime
>    is potentially indefinite (e.g. struct mount).
> 
> We can't use the same approach for both cases, otherwise we'll run into either
> performance or garbage collection problems (which also lead to performance
> problems, but delayed).

Wouldn't a front cache which expires after some seconds catch both cases?

Thanks.

-- 
tejun
