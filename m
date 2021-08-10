Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF8C3E50BA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 03:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbhHJBrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 21:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbhHJBry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 21:47:54 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3EFC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 18:47:32 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id f8so13652605ilr.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 18:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1zULoJHWd9UvDL/zXcD+qAf4WLgg91y1oOYfAdlxaxA=;
        b=ImcjR3UZWaBdi+ZMuqtDKPBeq+ErHoylBndX94+E8WYPbc5/3EidCO91Ie9GhwFWLe
         Ep01uUtFFwFBiNQ3rB7kvJdWCyLQ6RYGIBgR2sQ2f8AyHYiWYSfDfo5xNG80alv2wXEi
         JjTiKGudIvijOc7v5uSwgT3nBllMSGs0OGFyg+AXwkMaiRtQR7LnE1igBKBrHWpJfm2Z
         1rtV3w3smuvRCbF4lO2GG3zPM4TUYOi9FN3rFUQGOlMDhUZiZulMFgec6MzHWG/V067z
         rQgtzIIRkjUw3RQ67fZKv+QLp1J1xpjk+0cbZBlC4yzxQz8Go0tsB0sTSfGP3UofPIjs
         4WjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1zULoJHWd9UvDL/zXcD+qAf4WLgg91y1oOYfAdlxaxA=;
        b=eC6+Kf8jvfPP7kJLZly7q78CubkGJK2oO+/uLnljZFZ0geXeK2bBtqBIggwWNgpJs1
         H48GfTdlTe9NFx7vBJHpwpCKsKQW4TiXi1f6UHSF+OtUxRtO2NRt7DSallAYF7foBlfC
         AwRw//xWy4a142jw0Rr7OWQXTNmvk1SiyExB1FtYd5H0FG6buYNA9wtCNvr1vpbe6SMJ
         gzoeEvI2DxJ7sc0lW//5P1J/XaoG8HL/IfiW+X/63MHyDlV0yVpTgbL3zFvkX0zI/UvJ
         DbVYOb8ReveQbDsTASos8/Kmr41NeHSftpktLBBziBtapBrd4HYh6r2NPenwWh+zMfZy
         4XFA==
X-Gm-Message-State: AOAM532WRn5xTsAVdmBxWKerMPdO6sBxUu8UYo50mmbYAlnLmsf2LqgR
        a7DaHWHICSXOepFK/44aUDs=
X-Google-Smtp-Source: ABdhPJz0uTjTE3aLaZHl7FNUVy56+5x294o/cD1OhN2K/ZFgLGFZcco/KrMqfUCvTFF1jV0HRyntcg==
X-Received: by 2002:a92:ad12:: with SMTP id w18mr225214ilh.3.1628560052210;
        Mon, 09 Aug 2021 18:47:32 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id z7sm3107450iog.4.2021.08.09.18.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 18:47:31 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 044ED27C0054;
        Mon,  9 Aug 2021 21:47:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 09 Aug 2021 21:47:31 -0400
X-ME-Sender: <xms:sNoRYU1gFFbRxtGTYzwGpItGS_lGHOsBf7ydeqHaP_-QSTMXvs-V1Q>
    <xme:sNoRYfFKJMqyLRjCpT5AtfBCfEEGYnBxPWCeg5cxE-HJ-TI3IC5Cgm2d7dbh5Y7pl
    QAa_8Z5iRjfD5CpJg>
X-ME-Received: <xmr:sNoRYc7GVLieYFB1575xsOReK6AbQSh9rpFmxu2949FvW3tcvbt9i2I2KkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeekgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevieejtdfhieejfeduheehvdevgedugeethefggfdtvdeutdevgeetvddvfeeg
    tdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:sNoRYd0lgdXYcJ6FywNwYt8fzu6BEznXuHEWDVgp90IH6w0nwTHAww>
    <xmx:sNoRYXFxAbpTTH9YBvu1R4DEqlpsLYHCcIWgSuxyP47GakZ4jGdokg>
    <xmx:sNoRYW9vm5Egoc79Ggy8oO_chdDGsGZijUmUD2frw0kG4vG2_DXlFQ>
    <xmx:stoRYc5yPjJleGel7vjZjQxWcQVhwYWBjFH1M-17S7XBhX1raZEMrA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Aug 2021 21:47:28 -0400 (EDT)
Date:   Tue, 10 Aug 2021 09:47:21 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] locking/rtmutex: Add the missing 'ES' of macro
 CONFIG_DEBUG_RT_MUTEXES
Message-ID: <YRHaqT5jm8N4G0Nj@boqun-archlinux>
References: <20210731123011.4555-1-thunder.leizhen@huawei.com>
 <20210809144107.GA1458@willie-the-truck>
 <196ac7c4-f6db-247c-689e-13e7bbae5660@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <196ac7c4-f6db-247c-689e-13e7bbae5660@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 09:21:15AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/8/9 22:41, Will Deacon wrote:
> > On Sat, Jul 31, 2021 at 08:30:11PM +0800, Zhen Lei wrote:
> >> The build option name is defined as DEBUG_RT_MUTEXES in lib/Kconfig.debug,
> >> commit f41dcc18698e ("locking/rtmutex: Move debug functions as inlines
> >> into common header") can also corroborate this.
> >>
> >> Fixes: f7efc4799f81 ("locking/rtmutex: Inline chainwalk depth check")
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  kernel/locking/rtmutex.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> >> index b5d9bb5202c6..ad0db322ed3b 100644
> >> --- a/kernel/locking/rtmutex.c
> >> +++ b/kernel/locking/rtmutex.c
> >> @@ -343,7 +343,7 @@ static __always_inline bool
> >>  rt_mutex_cond_detect_deadlock(struct rt_mutex_waiter *waiter,
> >>  			      enum rtmutex_chainwalk chwalk)
> >>  {
> >> -	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEX))
> >> +	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES))
> >>  		return waiter != NULL;
> >>  	return chwalk == RT_MUTEX_FULL_CHAINWALK;
> > 
> > Oops, yes. How did you find this?
> 
> I found it by chance. When locating a futex problem, I was confused when
> reading this part of the code. I used "git grep -wn CONFIG_DEBUG_RT_MUTEX"
> to search for the implementation in other places. But I found that it was
> not used in other places, then I checked the patch history and found it.
> 

FWIW, script/checkkconfigsymbols.py can be used to detect usage of
undefined CONFIG_*, Zhouyi Zhou used it to find a few cases in RCU
recently:

	https://lore.kernel.org/lkml/CAABZP2wuWtGAGRqWJb3Gewm5VLZdZ_C=LRZsFbaG3jcQabO3qA@mail.gmail.com/

And thanks for the fix:

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> > 
> > Acked-by: Will Deacon <will@kernel.org>
> > 
> > Will
> > .
> > 
