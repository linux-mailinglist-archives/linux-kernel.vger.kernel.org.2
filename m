Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CF430998D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 02:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbhAaBEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 20:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhAaBET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 20:04:19 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A60C061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:03:39 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id e19so9100391pfh.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=hSBYDxZn5/M7G0OS88+UqBJx7yJ7nHUBiYaAGSX3hI4=;
        b=iIYzfLNBZl/AqmiCioUXu8Aq2eCpRcgawdqxPP3HhSm9qyMyUCW11GBzrbEQ2bssVX
         JwkXwi9kfHMn/aTu5H4E/pDS6rG/XF61pGtW9wMV9g0BPRx9ATjERfIKPMI6RvND1npU
         IfNVXj+f+9SN6WB7j/PjFXHALpAh4NGbEzy2u2UdGlJ3KGNmX0wyCbvigqcXonbW1GwR
         nuzVqItsOzZEaGEhCLUDNMH1KPJuEzgAv4RhMBpJNPJh+YsFmt9KCa/af4gVEL1DJYCP
         n38VX/FIx+r8MyKvfQt99Nu7h7bl/F8hHBxDTnLRPb/SYZsuvwqztuPqvj8bJjnH8g2V
         DT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=hSBYDxZn5/M7G0OS88+UqBJx7yJ7nHUBiYaAGSX3hI4=;
        b=DpQ59+dAM0xVOMdUGIbRPjGEntDgTcYUo9hsHavXU75MIUogJ1Tx2G7HwiqgmYYP3r
         UlBgBLgQFF67V9yJ6jmNSAxUgR1+zQMAds+8A7E9RukqPFGnZkfBhfcB7WwlB0ltJnc4
         lsuyAr05U28ctccNnudNPuNHJt39vaulC+HRyrrPumPpHDJONhYL6qA6tV3NsEf+MQOa
         ZtNEeao3Q+NcMFKUGg5B/kF844oyREuhcGz1+lopOrNIrMY9Y0yTIXoeYE94sJvO8q8L
         f+6XA3bdV/wFB8wu7GGXYiWOyP+BgDpkcYzYzYvGt6FWI9iHX8opHT8H9xy0TK01vT7I
         68XA==
X-Gm-Message-State: AOAM532y2wolMmqI0BrQBoJCeboIoMvplug9CjSRc9Cf03gYGsO22x8A
        J/totXgSG9imxbdIpWnAttnOrA==
X-Google-Smtp-Source: ABdhPJy+R/8tuQgdgWpNSHa2PErQxpdaxVaI2dnWesYu836FngbTUWRUj1PTnBOFY/744Cgi5LQNSw==
X-Received: by 2002:a63:7e10:: with SMTP id z16mr10880619pgc.263.1612055018549;
        Sat, 30 Jan 2021 17:03:38 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id 14sm3081438pgp.83.2021.01.30.17.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 17:03:37 -0800 (PST)
Date:   Sat, 30 Jan 2021 17:03:37 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        ckoenig.leichtzumerken@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [bug] 5.11-rc5 brought page allocation failure issue
 [ttm][amdgpu]
In-Reply-To: <4ce29a7e-f58a-aeb4-bef-34a7eada70d0@google.com>
Message-ID: <e0c2c823-5f-efe8-cd87-6dd6cc33a33@google.com>
References: <CABXGCsNazWZQGfSnFgQ_K5_H9uBQ=8gBdFORXrU1FEMGMohO2w@mail.gmail.com> <4ce29a7e-f58a-aeb4-bef-34a7eada70d0@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1482994552-1916433268-1612055017=:606041"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1482994552-1916433268-1612055017=:606041
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 30 Jan 2021, David Rientjes wrote:

> On Sun, 31 Jan 2021, Mikhail Gavrilov wrote:
> 
> > The 5.11-rc5 (git 76c057c84d28) brought a new issue.
> > Now the kernel log is flooded with the message "page allocation failure".
> > 
> > Trace:
> > msedge:cs0: page allocation failure: order:10,
> 
> Order-10, wow!
> 
> ttm_pool_alloc() will start at order-10 and back off trying smaller orders 
> if necessary.  This is a regression introduced in
> 
> commit bf9eee249ac2032521677dd74e31ede5429afbc0
> Author: Christian König <christian.koenig@amd.com>
> Date:   Wed Jan 13 14:02:04 2021 +0100
> 
>     drm/ttm: stop using GFP_TRANSHUGE_LIGHT
> 
> Namely, it removed the __GFP_NOWARN that we otherwise require.  I'll send 
> a patch in reply.
> 

Looks like Michel Dänzer <michel@daenzer.net> already sent a patch that 
should fix this:
https://lore.kernel.org/lkml/20210128095346.2421-1-michel@daenzer.net/
--1482994552-1916433268-1612055017=:606041--
