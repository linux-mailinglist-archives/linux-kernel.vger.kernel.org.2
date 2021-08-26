Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694E53F8656
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242091AbhHZLZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:25:20 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54525 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241887AbhHZLZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:25:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 563305C010B;
        Thu, 26 Aug 2021 07:24:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 26 Aug 2021 07:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=UPZvmZ84G77Qx4CifDEkh4l1ylt
        7rvplH4zNzCLTs+s=; b=FnXInOrifiX19VL2S1fsOC7AVywns7c8VWTvVJJ66/K
        tWV+7Wez0hxHQda/29DhxfK5stLoTk0SoD93v59fs2sJDLL/wp4+Uq3AhoerDlVx
        eHUPaZHWVW7c4AZVdSlELIaKW50Mt+ldVANcZNnJ5Phk4EtQ6fZRjVt5vQSJfVtO
        grZMCrsWsr8ytM+umf83xMKLQkeTrMziuft83HW/nHwpFvapDyfUprtfqpET2c1N
        exNbq51xRf+5lqouT2xOWN+ZHZNhRnPAiPh52XmH8JHccwWpgYpqb9XFG+Tp8+Oh
        LGzqCKe1OmVG7lo2kCLLPo3mTSuueUUb/WyGdlxMukg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=UPZvmZ
        84G77Qx4CifDEkh4l1ylt7rvplH4zNzCLTs+s=; b=MeLqUS3MebkEh0XvueDL9Q
        AqWwejt1cf7hGDmIPISudI8IvBfhjMAblyVTGa+5v+968JQ4GBaO4BziVOPm1DeZ
        zCs1h18Y1on6QDGBk9azcd/Hzq7PrZKVcOxq1H74BTSgH57L5NMRuKYJr0TAGgRb
        9hxTzpPpoWBj1jkTTBZh1CCVES/QyTYJ58mVLValhZPEV+cZAZ0H/tPkw/0jf8nI
        AoszUHRt+K6ynZF2MNdKW/heCXx8JfftRmqlGDKyqE89ux9QOsdg+xZkEqOk9PkG
        LVn/yQDwUPMEhqCx8wCnFJ0/08Vci8MHhd/GibM15IIXvWBCV+6ze6fL+5cHeDjg
        ==
X-ME-Sender: <xms:7XknYY1OUTxNJ6wmiM02To7mAlZ3BJWpK9hrS3mXzyr09S8mP4TcjA>
    <xme:7XknYTE8I7ODi0dsxkAGLMNJ2IHFSpP4uA8QUvuqQLZqVz-ScNbzfyG-Iv1QzPp-K
    7idyskG-yT8zQ>
X-ME-Received: <xmr:7XknYQ7_oOBfxO9qfPOLTzrFdaZNRIrTVueesQOrCquCjC0c_-vAZGEa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudduuddgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:7XknYR2ZftOrGYatIt3q508pXOY61FD8Ve4utsxPIJ_5OopVbmDhCQ>
    <xmx:7XknYbEDd1OJdaRORnLMbEJsI_I0jb5p-IvS2av5IUf1YtdFMbeUAA>
    <xmx:7XknYa80EN0k5exKt8ACFUVVJnnLQfpZoyMkjY04Rnzo82tmu6idzg>
    <xmx:7nknYRbH5VRq2HKDq9YAFdla2YEBgN_8C8QdUA9CAvy-wJ2Knh6Vjg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Aug 2021 07:24:28 -0400 (EDT)
Date:   Thu, 26 Aug 2021 13:24:04 +0200
From:   Greg KH <greg@kroah.com>
To:     Niklas Lantau <niklaslantau@gmail.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Usb: Storage: usb: Fixed coding style issue
Message-ID: <YSd51EXv3eBiLi7V@kroah.com>
References: <20210821121630.29318-1-niklaslantau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210821121630.29318-1-niklaslantau@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 02:16:30PM +0200, Niklas Lantau wrote:
> Fixed coding style issue. Removed not needed braces.

That is not easy to parse.

And it is written either "USB" or "usb", never "Usb".

thanks,

greg k-h
