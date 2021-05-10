Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42871377A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 04:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhEJCzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 22:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhEJCzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 22:55:22 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBEEC061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 19:54:17 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id v22so9646757oic.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 19:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tcWX/pXHbSOvakEgT3NpvBMoIP10Mwx5q6UOsylrZuk=;
        b=dCuQSLy08OgdrUNEtroNPxppJ7c/gmIlQzyM1EVjCMPAmqjEiVo09bsNjhfxuVqlXW
         XwicWs2zzuGrMeyLi8OYvuu+N8WnuGvr6ssyuL1ywh+BKbsYSfo+n/wcBdE7du0JdMOP
         v5PRWtuic+EukkhpOgop/xwtxVgKwJRPf4W6YF/1zOII9tB4CzQ81injK82CkuA2aMvQ
         L5F7XDBXYxumsFTm2sAuZma54vm+wAMBEOk/Im3YytWaOm2VtxzkDdUZdr/nfD1m/xhe
         2yURdoMX6EkuV1MEGZrW7jQSlK3jZX9dW0R/fMx1FwV3Jc0pc+TsY+tOJpiOVtM4YfXW
         9+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tcWX/pXHbSOvakEgT3NpvBMoIP10Mwx5q6UOsylrZuk=;
        b=ho3+LlNB/lM5BUbJEFKuBMVJUUWRBvndcgH1M8pUhb4VZKHnKyoHzkpdjthn95Kbb/
         MZPckkNHMft0TejQ7GqiA8WKryrPQ6k8QJX3BlJTMYIq0oGC/biOySh9pKRoNZkA2p68
         5X3Qjk3uO5bLg6/xyZacyzXplG8qULQxTdX74UQ5+yrxN0qxFPYi2kwKOxyHQsNZLSR4
         SBHmBEfa+zvs+6tdEwfNFaRyf1usorKtany2OMpUm3Zk+lwvMMluYov5ztNwStqJpFd1
         NvD14J4zkAWQsgx+wGOnniFdbkV24V0BGpAdw9OCijNbqYauV1wwfT+7wKtJ2oukHo25
         5LWg==
X-Gm-Message-State: AOAM5310K0ihVtTETrD23g1eZnqHZPCqnqPQbiSJM416Z0oJFS2HI/ux
        NfFGNqukBdeJkwCRvfT6+bBG4WHpKQg=
X-Google-Smtp-Source: ABdhPJx++Z2kC9Q1JKjOegiwavSsLQfXSTwoGYvq3p7YkR/1rheaUxrZJfpCGsPVI7dM3iPSv/Y/tw==
X-Received: by 2002:a05:6808:14cc:: with SMTP id f12mr8645713oiw.115.1620615256749;
        Sun, 09 May 2021 19:54:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r19sm2472615ooj.5.2021.05.09.19.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 19:54:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 9 May 2021 19:54:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.13-rc1
Message-ID: <20210510025414.GA2041281@roeck-us.net>
References: <CAHk-=wiWTU+=wK9pv_YG01rXSqApCS_oY+78Ztz5-ORH5a-kvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiWTU+=wK9pv_YG01rXSqApCS_oY+78Ztz5-ORH5a-kvg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2021 at 02:43:40PM -0700, Linus Torvalds wrote:
[ ... ]
> 
> Go test,

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 462 pass: 460 fail: 2
Failed tests:
	arm:raspi2:multi_v7_defconfig:net,usb:bcm2836-rpi-2-b:initrd
	arm:raspi2:multi_v7_defconfig:sd:net,usb:bcm2836-rpi-2-b:rootfs

The raspi2 problem (a crash in of_clk_add_hw_provider) is well known.
It was introduced with commit 6579c8d97ad7 ("clk: Mark fwnodes when
their clock provider is added"). Unfortunately it appears that there
is still no agreement on how to fix it.

There is also a repeated warning

WARNING: CPU: 0 PID: 1 at kernel/irq/irqdomain.c:550 irq_domain_associate+0x194/0x1f0

in some pxa boot tests. It looks like that problem has been fixed in -next.

Guenter
