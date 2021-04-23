Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80817368BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 05:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbhDWDmu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Apr 2021 23:42:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58176 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbhDWDms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 23:42:48 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1lZmhn-0005nL-Kh
        for linux-kernel@vger.kernel.org; Fri, 23 Apr 2021 03:42:11 +0000
Received: by mail-wr1-f72.google.com with SMTP id 32-20020adf84230000b029010705438fbfso9384021wrf.21
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 20:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q8lvXaeGOL2ljIFclzGPAA+7PF2oGf25ArF47SyOYRM=;
        b=DVpEHNxYpdY3zyd0a40YsLPNMfTTkRq1aAa3kmac22x+OHK13rM+9ugCNXkvx0LiOP
         6t3vTzVovAfHOB8IUP/jShPYuZuM2STEiQyxt97uV1rrpXilaW0qTPq0IX11nfejAgg+
         l/TXpwgcKMdOjMvFgXjKXWs9k3FaoHf76X2e0By+OirVS+hsU64zsyOOYdpcumIwYV11
         JCbtp7ekv9wBV0WKnQ3rMD3k0EgH/1y/fZj0qCXbOrwH8p31nTs6RDSz1luc31l/eD3n
         oyFcHqp7+KFwnl8h3CQRaXsYoa3kFTlxyuX1hx6dhTqPAj3O90rZRnTCBwbmqPadGeuY
         +8gQ==
X-Gm-Message-State: AOAM533/tT5gK8FLeRl/P73pbP1bh+Sud956a17R1XCCI3rIFjTKcR3O
        37Il6mIuPJnyWGyhBtzdRSvmwyZFvxxeO+fZJTplfepcLdEOikwkb9820I40q0SLgQo7u1zxyNU
        mT/JDd4nqA14leuLEE280Hs9dssfevuigBPvNu6b8LxtDdjV5R1RfC51TtA==
X-Received: by 2002:a7b:c017:: with SMTP id c23mr3133430wmb.175.1619149331332;
        Thu, 22 Apr 2021 20:42:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNlDwmWflqy+SayzrSbb1iZK2CutTxyvxMgBLZBnJG9zzkG9Kpnl5gkZ+xVwru25OVRRTPCIZfz4rlkuBlWxw=
X-Received: by 2002:a7b:c017:: with SMTP id c23mr3133427wmb.175.1619149331123;
 Thu, 22 Apr 2021 20:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210420075406.64105-1-acelan.kao@canonical.com>
 <CANn89iJLSmtBNoDo8QJ6a0MzsHjdLB0Pf=cs9e4g8Y6-KuFiMQ@mail.gmail.com>
 <20210420122715.2066b537@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAFv23Q=ywiuZp7Y=bj=SAZmDdAnanAXA954hdO3GpkjmDo=RpQ@mail.gmail.com> <c10a6c72-9db7-18c8-6b03-1f8c40b8fd87@gmail.com>
In-Reply-To: <c10a6c72-9db7-18c8-6b03-1f8c40b8fd87@gmail.com>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Fri, 23 Apr 2021 11:42:00 +0800
Message-ID: <CAFv23QkUsTf5M0MoUEFNYeFCtShAn3EmA3u8vXVeZyJa20Bx=g@mail.gmail.com>
Subject: Re: [PATCH] net: called rtnl_unlock() before runpm resumes devices
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
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

Heiner Kallweit <hkallweit1@gmail.com> 於 2021年4月22日 週四 下午3:09寫道：
>
> On 22.04.2021 08:30, AceLan Kao wrote:
> > Yes, should add
> >
> > Fixes: 9474933caf21 ("igb: close/suspend race in netif_device_detach")
> > and also
> > Fixes: 9513d2a5dc7f ("igc: Add legacy power management support")
> >
> Please don't top-post. Apart from that:
> If the issue was introduced with driver changes, then adding a workaround
> in net core may not be the right approach.
It's hard to say who introduces this issue, we probably could point
our finger to below commit
bd869245a3dc net: core: try to runtime-resume detached device in __dev_open

This calling path is not usual, in my case, the NIC is not plugged in
any Ethernet cable,
and we are doing networking tests on another NIC on the system. So,
remove the rtnl lock from igb driver will affect other scenarios.

>
> > Jakub Kicinski <kuba@kernel.org> 於 2021年4月21日 週三 上午3:27寫道：
> >>
> >> On Tue, 20 Apr 2021 10:34:17 +0200 Eric Dumazet wrote:
> >>> On Tue, Apr 20, 2021 at 9:54 AM AceLan Kao <acelan.kao@canonical.com> wrote:
> >>>>
> >>>> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> >>>>
> >>>> The rtnl_lock() has been called in rtnetlink_rcv_msg(), and then in
> >>>> __dev_open() it calls pm_runtime_resume() to resume devices, and in
> >>>> some devices' resume function(igb_resum,igc_resume) they calls rtnl_lock()
> >>>> again. That leads to a recursive lock.
> >>>>
> >>>> It should leave the devices' resume function to decide if they need to
> >>>> call rtnl_lock()/rtnl_unlock(), so call rtnl_unlock() before calling
> >>>> pm_runtime_resume() and then call rtnl_lock() after it in __dev_open().
> >>>>
> >>>>
> >>>
> >>> Hi Acelan
> >>>
> >>> When was the bugg added ?
> >>> Please add a Fixes: tag
> >>
> >> For immediate cause probably:
> >>
> >> Fixes: 9474933caf21 ("igb: close/suspend race in netif_device_detach")
> >>
> >>> By doing so, you give more chances for reviewers to understand why the
> >>> fix is not risky,
> >>> and help stable teams work.
> >>
> >> IMO the driver lacks internal locking. Taking 看rtnl from resume is just
> >> one example, git history shows many more places that lacked locking and
> >> got papered over with rtnl here.
>
