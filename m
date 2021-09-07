Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86847402DAD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345680AbhIGRWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbhIGRWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:22:07 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123A0C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 10:21:01 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id j2so6257600pll.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 10:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QrALAof3e93o8mC9f1B/BSGreLUfRte55Ordj5X3t8A=;
        b=JMe6Am76oke/iV4XHXHAUjTAkwDcgN0Nz1QkaAqGuCMjDkWnlKu2SH1TtN8U+V1AOh
         PN+dYSG+cka6tpYAfqR2xrgv276jzV8y14RuxLob8x0vgAwSyFA7xq5sSu/KMxqxngmw
         egy8RKL5soJxS6Wv1g9T3EsnMu9TGpqiyKvMxKGYKIDoKVJcvs7aWtZEU26Vbf6HOm4h
         dhDOTzMZSM3j4x00EXhk283kYzcfeWOA61vZVVPEiSKSzQrgt0jEcrmniEfAn8RGWNrf
         kIp1sz4q8OTsZn7tinh+V9z1I5UHwrJiTjZm4fRugaUF5RSF8iMVBl/7ejbltotSmMBA
         Lkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QrALAof3e93o8mC9f1B/BSGreLUfRte55Ordj5X3t8A=;
        b=VQTNazA+wN62dxPP/73TWmyc+8xUyjzOAzirYJgRnuKWXB57MzjloUiOvUdZ3gOTZK
         5e0JujaxXrvjmcCs+VE3h4PnW3883CWtvfwjxy3L5ZpyUDrHSnrhx3OgWGNLrE3dT4uy
         nBfuz3DHijog5A7OnGaiXMUi2aDdXLKeKQcfuN8mKjvQmKT4LZuE6dE+9aYeIR5x9ONp
         60ziaSVRlR778B8B88S39fftaeKWu+p6YfCgwSzrtipFd6fcV9A8zTyrewf7hOKZNaRP
         VxKMsm241VGlyoVhUjgyq4MhiVea7SjPWdIgZ8pkByEBGv+C/gIn0RvCr2r4Ssox+Zxs
         N28w==
X-Gm-Message-State: AOAM533NgVpFTeqbfTDLDou61Tl8Zpl4EKgvchDZ6KgDthhAEfqWjlgW
        L9oQQhZOnnlXsL+/Xej6ocA=
X-Google-Smtp-Source: ABdhPJzXeli19eQnEd5f9odSdCpc3u5rS355h/GooW8HPHyZLRJkJe+DAQfrvgX54RO4hjaLi0NP1A==
X-Received: by 2002:a17:90b:3ec1:: with SMTP id rm1mr5626136pjb.5.1631035260480;
        Tue, 07 Sep 2021 10:21:00 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id v7sm3007849pjg.34.2021.09.07.10.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 10:21:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 7 Sep 2021 07:20:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Roman Gushchin <guro@fb.com>,
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
Message-ID: <YTefelthK5kSIvUU@slm.duckdns.org>
References: <20210907150757.GE17617@xsang-OptiPlex-9020>
 <dbc9955d-6c28-1dd5-b842-ef39a762aa3b@kernel.dk>
 <CAHk-=wgrF65BpP6P6_a6+k+C8V+JOBiEx0X-c9idiM87uk32FQ@mail.gmail.com>
 <774dee70-69bd-9f95-d197-4cff83e4e633@kernel.dk>
 <YTedOVCV3s6Z210f@carbon.dhcp.thefacebook.com>
 <YTeeBf64yUwj01Sf@slm.duckdns.org>
 <22a0156e-f74f-51c8-b7fd-9b5a375d7c81@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22a0156e-f74f-51c8-b7fd-9b5a375d7c81@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 11:18:21AM -0600, Jens Axboe wrote:
> A purely time based approach might be problematic, as you can allocate a
> LOT of data in a short amount of time. Heuristics probably need to be a
> hybrid of "time much time has passed" OR "we're over the front cache
> threshold in terms of deferred accounting". But yes, I don't see why
> we'd necessarily need different approaches for short vs long life times.

Yeah, it'd need some heuristics to guard against the cache exploding and a
lot of laziness in expiration logic but none of those should be too
complicated.

Thanks.

-- 
tejun
