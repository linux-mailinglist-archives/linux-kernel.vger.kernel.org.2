Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB47315C02
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhBJBQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbhBIWXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:23:36 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50846C0698DC
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 13:34:10 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id v24so30652411lfr.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 13:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=OfVrerl2HtWECQl9+6bkSwn1VpHwMszkx7FXanUnXsg=;
        b=W4DFOv5EV9mh7EqgMVbRE9Kk5eSvrr28NMYLzAEwPmHOQjs1Xifv2LTTXcULih6c29
         AfMQ7h1xoBS8+rPYf9oXPpKtNHdTCEkae51YsM28uZKHmEbWDRVHFhT0aold01r5MDki
         W4dq6gnFBes06ascpwzDCyy8gtDzLwinlqqO3wVvqS7waK3c5Ow2c0bCiLni6P5O3buR
         WXocAmZSYzn6DFPiRlPeWzVCmyHCY9UUTjn87I85/4l0odXEbQ/3ukTSj++w9IXJoeDu
         xKDjvCWvWg4+SFl5jQn2Eb6grf2YcthRtScnxsHplhxYlhlCZZhafpW+ANiJY3QfEcaU
         8SFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OfVrerl2HtWECQl9+6bkSwn1VpHwMszkx7FXanUnXsg=;
        b=C9eZYEoasGM6A2lcr8cBv9a2Vdyp0HCQweQ3UgYhaeBiUleWJk3GDEK9y02lGPTzlo
         34t2ETkcYyXNk1KeoYQYtEgsQ0SiglNu78yeYkqb7DDXGRZh9AYeR6hriOdefAmGzgmM
         +YzpX9C47+bgeTGeOKMWavJT70cxy9Lc81ucN/TIEnwnrim4rTL0zjwjSu5zAVR4ztvE
         wEMBhk9o27E3xnN34lA3ttKloUpV5YXQCRl+OMrd1JzDbKF75tj4UG9YQEDUrQZYZb3M
         /QHcJ31Mse3hZNZ1orD8ZXYfP9xQvJGE+bgUeX05uwuEdddGIWQ7fdFz75NN0CikHw0r
         /+tw==
X-Gm-Message-State: AOAM532t+X+acmnjWdcMmdqup0xj5ZsMPTCh+Begk3gsmfo6GWp2KOgC
        X2cGUkxnsDWmj1X6+fh6FejAkNdl1jvvUGS2
X-Google-Smtp-Source: ABdhPJyTo0SuZyGFOfCejtJ3fyiVFTWri+S0XlmBO13IAh2SP4Y59EbqfvF6Nq6y3XlDSvMNTxWXlg==
X-Received: by 2002:a19:24d5:: with SMTP id k204mr6550793lfk.126.1612906448808;
        Tue, 09 Feb 2021 13:34:08 -0800 (PST)
Received: from wkz-x280 (h-236-82.A259.priv.bahnhof.se. [98.128.236.82])
        by smtp.gmail.com with ESMTPSA id w17sm1352421lfu.280.2021.02.09.13.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:34:08 -0800 (PST)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     Mickey Rachamim <mickeyr@marvell.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: RE: [EXT] Re: [PATCH net-next 5/7] net: marvell: prestera: add LAG support
In-Reply-To: <BN6PR18MB158781B17E633670912AEED6BA8E9@BN6PR18MB1587.namprd18.prod.outlook.com>
References: <20210203165458.28717-1-vadym.kochan@plvision.eu> <20210203165458.28717-6-vadym.kochan@plvision.eu> <20210204211647.7b9a8ebf@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com> <87v9b249oq.fsf@waldekranz.com> <20210208130557.56b14429@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com> <YCKVAtu2Y8DAInI+@lunn.ch> <20210209093500.53b55ca8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com> <BN6PR18MB158781B17E633670912AEED6BA8E9@BN6PR18MB1587.namprd18.prod.outlook.com>
Date:   Tue, 09 Feb 2021 22:34:07 +0100
Message-ID: <87h7ml3oz4.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 20:31, Mickey Rachamim <mickeyr@marvell.com> wrote:
> Hi Andrew, Jakub, Tobias,
>
> On Tuesday, February 9, 2021 7:35 PM Jakub Kicinski wrote:
>> Sounds like we have 3 people who don't like FW-heavy designs dominating the kernel - this conversation can only go one way. 
>> Marvell, Plvision anything to share? AFAIU the values of Linux kernel are open source, healthy community, empowering users. With the SDK on the embedded CPU your driver does not seem to tick any of these boxes.
>
> I'll try to share Marvell's insight and plans regarding our Prestera drivers;
>  
> We do understand the importance and the vision behind the open-source community - while being committed to quality, functionality and the developers/end-users.
>
> We started working on the Prestera driver in Q2 2019. it took us more than a year to get the first approved driver into 5.10, and we just started.
> Right at the beginning - we implemented PP function into the Kernel driver like the SDMA operation (This is the RX/TX DMA engine). 
> Yet, the FW itself - is an SW package that supports many Marvell Prestera Switching families of devices - this is a significant SW package that will take many working years to adapt to the Kernel environment.
> We do plan to port more and more PP functions as Kernel drivers along the way.

This is very encouraging to hear. I understand that it is a massive
undertaking.

> We also are working with the community to extend Kernel functionality with a new feature beneficial to all Kernel users (e.g. Devlink changes) and we will continue to do it.
> By extending the Prestera driver to in-kernel implementation with more PP features - we will simplify the FW logic and enables cost-effective solutions to the market/developers.

Until that day arrives, are there any chances of Marvell opening up CPSS
in the same way DSDT was re-licensed some years back?

Being able to clone github.com/Marvell-switching/prestera-firmware (or
whatever) and build the firmware from source would go a long way to
alleviate my fears at least.

In such a world, I at least have a chance of debugging any issue all the
way to the bottom of the stack. It would also make it possible for the
community to help out with the porting effort.

> Regards,
> Mickey.
