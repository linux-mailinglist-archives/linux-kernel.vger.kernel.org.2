Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2FE34E96A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhC3NlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:41:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50325 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232122AbhC3Nkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:40:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C7A485C01AC;
        Tue, 30 Mar 2021 09:40:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 30 Mar 2021 09:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=PgqQ+TOld/OxOM8Y/n2i1xVQ8aX
        qkcUE/IGdzCD0AtQ=; b=phiGY17eOSTbM/3Vdf00uuzqDGoohCfQMMNcgPN/1Gb
        d0aAxkiJtv7E4vYdVPlPIwaQuJbf696Rbi+i5I6HXEUaG9ksH93UBTo9qygf5VkA
        BbYzydooL70uXA/quR+dPwp9ln8sl2r4YayLkCOK/CdVxZrtrVCd6mRx7DY3M4Pg
        fEjF0NliWze/80L/3qJTzVDz82sRpVZNiyU6Iu2Yy3uYsAErjHYTefOEY7k7X96F
        h1+PGJoERFcmBIHAaCWKl6GAZNV9rqQyi/YNXsOVCLqMStvpM0umBb0QeXNBCYZa
        OuZiBgXVvHTrfk7TxwFB91gCK2wk8o38IOTV+Bb/Ujw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=PgqQ+T
        Old/OxOM8Y/n2i1xVQ8aXqkcUE/IGdzCD0AtQ=; b=GLCzeldaKaQw+PvqmhzU1h
        LNhNgWF2D7lQndKMZx1/O1T1/kpSMST9cg0euCh8/g08SqLO94nVe47oCyNFVZvd
        R2BTmvnVVjPz9diblO03RS9jYdyfpWVF46S0NiKlXYIb8LxWqm8Mj0qXc9dBIbab
        woLV6nDj0LTBaGJYqEx5FxPf4xrDkgF2zS5XGfIyxTKX629vanejXyAQzP0qqgjV
        TYErsvM2iB+g1Tc4jMN8+gdUR7xAU9PLajnI1VVg1LOEnqw60tKcCTRcfZPlf95Q
        iD+6m4yyGQiWPFt8yQObGD4yWT9E/GBII4HPxsfNW6TZLTxwxx9opj4xWd6JT7zw
        ==
X-ME-Sender: <xms:VypjYILq3EqhWp9w68vhCCBsChOiMKTAhovfe-w2e86nHXGqaUv07w>
    <xme:VypjYFB6ts3rBNKSTfqu0eMAyF3I3F732LMhomWlSSslEVoH_FF7xNKtgE55tzzBA
    zmtPPoPuycYvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeitddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:VypjYIep4rdc7LplqFQk8ncvIJ18QLx78aD-cGb3acPu3y7M0lpAJQ>
    <xmx:VypjYE2oxcttssGjJyTnT1md8AbjfM7hl0EWBjm4ZFa0C94gZvIaDg>
    <xmx:VypjYPiM-1b6TWLqMHrA7GKhOM-RlFImXaGmTFlcktfYRE-Ga20Evg>
    <xmx:VypjYJKP0tCJZjIvzX1CwN5MgxF1eHYDfyF7f91DUA2xPccnSEWvzg>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 350BF1080057;
        Tue, 30 Mar 2021 09:40:39 -0400 (EDT)
Date:   Tue, 30 Mar 2021 15:40:37 +0200
From:   Greg KH <greg@kroah.com>
To:     Fawad Lateef <fawadlateef@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Compiling kernel-3.4.xxx with gcc-9.x. Need some help.
Message-ID: <YGMqVc+DyVyT9DtW@kroah.com>
References: <CAGgoGu77PEEAJped5bnw4q8rFeDMebL92YWGDGFfNp_ZAnpJ8Q@mail.gmail.com>
 <YGFeQUuAaKgeaqCA@kroah.com>
 <CAGgoGu76FOJd74oVgnu5Sa3GKaHHyLTH+=hP+mLGzS+79Z26fA@mail.gmail.com>
 <CAK8P3a24aFvCUeZiDE6jCTKm0hrPVc34sNYOPpZJkh_5HpgDSw@mail.gmail.com>
 <CAGgoGu5xT6sADCpj7J7tJMfsw1WU4BA=3YB8SGS-+kf+P4xyNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGgoGu5xT6sADCpj7J7tJMfsw1WU4BA=3YB8SGS-+kf+P4xyNw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 03:23:10PM +0200, Fawad Lateef wrote:
> So can I still use kernel-3.4 compiled with gcc-5.5, and boot full
> user-space with gcc-9.1?

Yes, of course.

> I was expecting it to be possible but might not work due to
> incompatibility? As I know that when I tried to compile buildroot-2019
> (with latest version of openssl and others) it needs kernel headers
> and then I likely can't use 3.4 kernel.

buildroot might be different, as that is how you are building your whole
system, but there is no dependency on the kernel and userspace to use
the same version of the compiler.  Otherwise everyone would have to
rebuild the world for every time they updated their kernel, this isn't
the BSDs :)

thanks,

greg k-h
