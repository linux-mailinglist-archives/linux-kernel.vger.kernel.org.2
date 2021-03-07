Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE47C3302BA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 16:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhCGPoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 10:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhCGPn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 10:43:58 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A54C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 07:43:58 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id cw15so3439626qvb.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 07:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mS9UpdncXR9MHS9h0T1Gw/f6CT9PrQN5whsC1DFrt58=;
        b=JI4hpgQn2neHm+ucZNu7Sc0ssuhAAXw5z2xpe8MrP9/QGMCL8F2Jrmydi2lGClUwOc
         eaW564aDHdpZSV9xAm1s31EJ9PwQ1cDE42oKanEQMv5J+LdFOd3X/DxdhDr41JHbsQ9r
         jPjuPBI5IwhsAntBnIHdsB6M84CcIxT9dZ3a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mS9UpdncXR9MHS9h0T1Gw/f6CT9PrQN5whsC1DFrt58=;
        b=Kr+GuhJMZS9D//aYfuUrY2F4779CTJ7EWT1NkZ/6wXahQtsHzleVvWQGZ1VpawR/WD
         g2eFc1tcKvNEQvWDX4Gig741z1A90VVm+gnruW9AlasfylGyVqSW199MUGQSDeA3pkvL
         sVvGNDnrfdZR3fWzYUeXJFgYViOScgmXndzx/asAT7cPb6xYbdJH0aDpBB2Ms97dE1gm
         7GjCDvsempzSTQsReBOK+cE17jqqC2GG98JZFI0FeQbNJ5/QFhtkGLUJMcMGIGQEMjkz
         C3MJzQVRBaHPG6hVFm0gZubrUNtTDZRLrvEF/ZVzUpjGoFR1P5u98XuQfKGvf8W4hU9j
         RbLA==
X-Gm-Message-State: AOAM530+jVS5LvEKZkSaWDOPF8E81CDHJ5VqkkW/kCR57d0vebdx/JuB
        MvdKyGy+NyVu7Xdentvk3TbShg==
X-Google-Smtp-Source: ABdhPJyk/u0kCKWpXzQjHEBQuzPQEuAe09XUCapT+8tWJ8cJzeHmYbLVyt7Ra/WmF8Z+gQRtlLxAEQ==
X-Received: by 2002:a05:6214:1c45:: with SMTP id if5mr17365111qvb.9.1615131837280;
        Sun, 07 Mar 2021 07:43:57 -0800 (PST)
Received: from chatter.i7.local (bras-base-mtrlpq5031w-grc-32-216-209-220-18.dsl.bell.ca. [216.209.220.18])
        by smtp.gmail.com with ESMTPSA id d24sm5849982qko.54.2021.03.07.07.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 07:43:56 -0800 (PST)
Date:   Sun, 7 Mar 2021 10:43:54 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ronald Warsow <rwarsow@gmx.de>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: stable kernel checksumming fails
Message-ID: <20210307154354.qbbsy355d5zfubnf@chatter.i7.local>
References: <d58ab27a-78ad-1119-79ac-2a1fbcd3527a@gmx.de>
 <YETm+6sQqek6kY/A@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YETm+6sQqek6kY/A@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2021 at 03:45:15PM +0100, Greg KH wrote:
> > checksumming the downloaded kernel manually gives an "Okay" though.
> > 
> > 
> > is this just me (on Fedora 33) ?
> 
> Fails for me on Arch:
> 
> Verifying checksum on linux-5.11.4.tar.xz
> /usr/bin/sha256sum: /home/gregkh/Downloads/linux-tarball-verify.gZo313NCk.untrusted/sha256sums.txt: no properly formatted SHA256 checksum lines found
> FAILED to verify the downloaded tarball checksum
> 
> 
> Konstantin, anything change recently?

I think it's just cache invalidation problems. I've committed a tiny change to
the script that always grabs that file from the origin servers instead of
going via the CDN.

https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/commit/?id=71e570c5f090b5740e323f98504bf38592785b49

This should sidestep the problem.

-K
