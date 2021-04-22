Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3625D3679F2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 08:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhDVGbU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Apr 2021 02:31:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52697 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhDVGbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 02:31:19 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1lZSrM-0004dM-3y
        for linux-kernel@vger.kernel.org; Thu, 22 Apr 2021 06:30:44 +0000
Received: by mail-wr1-f72.google.com with SMTP id t18-20020adfdc120000b02900ffe4432d8bso13368706wri.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 23:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3kzgVjAjXqA0gwr2eY96/OSAGqGr3gZ/6NHtH93TvQg=;
        b=HjWM/mqzGX2fnxwilEnY7PbmJQjcg4FmMrQU27Be2HCYHYrksVUxP+aMfS2IjTvFCi
         wbwrMd/NGLuJ8NGzrYs6I1taSCQ+RP4x/kxRXadUqcnJVm6xj35h1IBbBIuGTyXW8PPc
         vb4D37wLgBipa6dE7BG+/CHBIuMYPbjW4cJfk6zjWwRq08IXPmvNrlldTFpXnN41I9he
         6eJEcj2x7Squ6EyxgZwycU9W0//vT6wRhE9hisQvA6oqrXc8oRKrlEP39fYHDlS9NkAJ
         5uN7HIkuLI3tKqChe66qJW/fB1hDlPfDVrXW7TgrH3ZUAc7nvBTSd3B1tZEnj+hoFNJ0
         uxZQ==
X-Gm-Message-State: AOAM532eVpTtOphydwIP1I7mk8rgPRMR/GsHyYh6+KslOvzL7cRAFSIm
        mFU8Mh34si1Cy1CZaQNpZJlDskDf+ABZEn9tG9zldne4LKEQubLRPTE4SX/7jUqxT+EEhPXQi7v
        NeV0UmKhHCAtLLJmBbGpw1Zbi30cB6qnTmigtHNVlk683G7N/FYyARLvpeA==
X-Received: by 2002:a05:6000:362:: with SMTP id f2mr2040246wrf.141.1619073043680;
        Wed, 21 Apr 2021 23:30:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMm37YQsQ4/hlEwqWuIlwD6IKPHsqmYKLABs/OQviK9ixplQD7thz/dQSRJv43omgMMbMvDLU5phYp3mqNLTg=
X-Received: by 2002:a05:6000:362:: with SMTP id f2mr2040231wrf.141.1619073043512;
 Wed, 21 Apr 2021 23:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210420075406.64105-1-acelan.kao@canonical.com>
 <CANn89iJLSmtBNoDo8QJ6a0MzsHjdLB0Pf=cs9e4g8Y6-KuFiMQ@mail.gmail.com> <20210420122715.2066b537@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210420122715.2066b537@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Thu, 22 Apr 2021 14:30:32 +0800
Message-ID: <CAFv23Q=ywiuZp7Y=bj=SAZmDdAnanAXA954hdO3GpkjmDo=RpQ@mail.gmail.com>
Subject: Re: [PATCH] net: called rtnl_unlock() before runpm resumes devices
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Wei Wang <weiwan@google.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Taehee Yoo <ap420073@gmail.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, should add

Fixes: 9474933caf21 ("igb: close/suspend race in netif_device_detach")
and also
Fixes: 9513d2a5dc7f ("igc: Add legacy power management support")

Jakub Kicinski <kuba@kernel.org> 於 2021年4月21日 週三 上午3:27寫道：
>
> On Tue, 20 Apr 2021 10:34:17 +0200 Eric Dumazet wrote:
> > On Tue, Apr 20, 2021 at 9:54 AM AceLan Kao <acelan.kao@canonical.com> wrote:
> > >
> > > From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> > >
> > > The rtnl_lock() has been called in rtnetlink_rcv_msg(), and then in
> > > __dev_open() it calls pm_runtime_resume() to resume devices, and in
> > > some devices' resume function(igb_resum,igc_resume) they calls rtnl_lock()
> > > again. That leads to a recursive lock.
> > >
> > > It should leave the devices' resume function to decide if they need to
> > > call rtnl_lock()/rtnl_unlock(), so call rtnl_unlock() before calling
> > > pm_runtime_resume() and then call rtnl_lock() after it in __dev_open().
> > >
> > >
> >
> > Hi Acelan
> >
> > When was the bugg added ?
> > Please add a Fixes: tag
>
> For immediate cause probably:
>
> Fixes: 9474933caf21 ("igb: close/suspend race in netif_device_detach")
>
> > By doing so, you give more chances for reviewers to understand why the
> > fix is not risky,
> > and help stable teams work.
>
> IMO the driver lacks internal locking. Taking rtnl from resume is just
> one example, git history shows many more places that lacked locking and
> got papered over with rtnl here.
