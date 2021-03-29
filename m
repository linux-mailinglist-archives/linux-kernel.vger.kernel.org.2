Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAABC34C2B9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 07:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhC2E6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 00:58:02 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:55873 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229557AbhC2E5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 00:57:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 736C810D6;
        Mon, 29 Mar 2021 00:57:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 29 Mar 2021 00:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=WCwmXBfwxR9OCpKt/xBBrd/PVQA
        peqoERiYWkeKCig4=; b=bXslO2k30r4ICu09YniX1STBeLugylhfRRmtAEqj50m
        eI8KKhGizrPpyLKaVrZDQNSpZZ0ZKPdNAM0FBchdWi3sFLDBWwn1c65QJ6poIvE4
        X9J6H1jyuOfdz4lwbED8THPriX34qBg2tbXvE+CoBMuaTPzwGFZ4HT4xKG+TPwsc
        4xN6ODAS2Y/hld1kXbZP4Uw0JGoeqhId65029YPNxVozbXE6Ebfn7/BxAsV3ig7S
        o9VfdSmrlXUWJp806d2qroM4jqKxVYV2U/Q4eenBF2SkubKEQXpSDNbNy0t4xZ37
        9dgf/7vFk9yNI1sB7C4nFJldvzyK630vML9tBKS7eRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=WCwmXB
        fwxR9OCpKt/xBBrd/PVQApeqoERiYWkeKCig4=; b=ZoxRb5dCmQMgdQeO8KxntH
        X5p/bq9VwJzdwE9p36BbUlkLqz1PJZdXNNaf+D6Xvy1tgxJxlydlC12oLMqNY8uH
        vcHJLt7kt4/Yng0x1CKNATAbhYWqFAeh5BQkOpkmsLgaLweulPJBqnVhbnREO+3J
        ISfNe6n/DA22E2eMiligdT4fJEVuc3iu0+ak+OI4WNKp2p7ODr0tvbrct+q1cQCA
        ZCqtuGCZ2oPkl070N6M5D8nAKZwJcAzSTjj8vgTybw0WppkVWlBN2nzZsEjWgmuw
        wrwyMaLUTK5q0jeDIMqM+R9toJO/USJt6aJikbaGwQ6xlER5X1HJj9E5e+cfkLVg
        ==
X-ME-Sender: <xms:Q15hYMSjDLWShGvZF_G4W9wtBBesLvRovzJE8_UR2dqSsWlfOoJqUg>
    <xme:Q15hYJzuKaru4j-jG03H61HX2Pm-p8goYRTVTj8TUx8FxXg7qFK-VNCr90jR7CJku
    rHoYgThMN-OjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehjedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeefueeuke
    ekteejieeitdfftefhhfeihffgteeludetvdelhefgvdehtddtffelgfenucffohhmrghi
    nhepghhithhhuhgsrdgtohhmnecukfhppeekfedrkeeirdejgedrieegnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghh
    rdgtohhm
X-ME-Proxy: <xmx:Q15hYJ0Ya1eAwfFKxZb-L_bzHQs3wA25YJEUw1BCWT6vr-y7x-1sxw>
    <xmx:Q15hYAD1VYyA_cu9azo9qKZRyV3CeYeoiZFzlGwlNyhA7Zap2WNiHQ>
    <xmx:Q15hYFgV-xIps-tZI2s_OE8BUW7mEdc6ipnyN9p5P46uFbkACFHInA>
    <xmx:RF5hYFaglv6T8cNDwl0AtKcDmbAsFHhmxOLq2CLBgK0QHVe5YHyvMQ>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4750D24005B;
        Mon, 29 Mar 2021 00:57:39 -0400 (EDT)
Date:   Mon, 29 Mar 2021 06:57:37 +0200
From:   Greg KH <greg@kroah.com>
To:     Fawad Lateef <fawadlateef@gmail.com>
Cc:     kernelnewbies <kernelnewbies@nl.linux.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Compiling kernel-3.4.xxx with gcc-9.x. Need some help.
Message-ID: <YGFeQUuAaKgeaqCA@kroah.com>
References: <CAGgoGu77PEEAJped5bnw4q8rFeDMebL92YWGDGFfNp_ZAnpJ8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGgoGu77PEEAJped5bnw4q8rFeDMebL92YWGDGFfNp_ZAnpJ8Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 10:20:50PM +0200, Fawad Lateef wrote:
> Hi
> 
> I am using an Olimex A20 SOM with NAND and due to some binary blob for
> NAND driver, I am stuck with the sunxi kernel 3.4.xxx version. (Repo
> here: https://github.com/linux-sunxi/linux-sunxi)

Please work with the vendor that is forcing you to use this obsolete and
insecure kernel version.  You are paying for that support, and they are
the only ones that can support you.

> I am currently using buildroot-2016 and gcc-5.5 for building the
> kernel and every other package needed.
> 
> Now the requirement is to move to the latest version of gcc-9.x, so
> that we can have glibc++ provided by the gcc-9.1 toolchain.
> 
> Main problem for moving to later versions of buildroot is the kernel
> 3.4 which we couldn't to work with gcc-6 a few years ago _but_ now the
> gcc-9.1 requirement is mandatory so now have to look into compiling
> linux-3.4 with gcc-9.1 or above.
> 
> Now I need some help.
> 
> -- Is it realistic to expect 3.4 kernel compiling and boot
> successfully with gcc-9.1?

No.  It took a lot of work and effort just to get the 4.4.y kernel to
work with that gcc version.

Again, please work with the company that you are already paying for
support from, they can do this for you.

good luck!

greg k-h
