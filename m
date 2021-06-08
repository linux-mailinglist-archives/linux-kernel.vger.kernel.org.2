Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C49239F0F4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhFHIbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:31:52 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48685 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229556AbhFHIbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:31:51 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id DD4B95C019E;
        Tue,  8 Jun 2021 04:29:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 08 Jun 2021 04:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=8bCkpTdcGGFLusto1lDzqfwgm88
        Wweu677Xf+YwU81A=; b=k9XL4fIIVysjDHrP1KCYTDjAhIrJnRTB2fqE1wBhZa6
        vu5hqCIiIxM4dxK4wuA89tQpoz2rMW7agWPBPoRxTnYOg1JheYrgVSuwjkT5+iCv
        0jfY6rTZ5hunZGWmM6TgdvwvGp1eXpdFTBtsiLeXW8WzyWEwOgYG+1MBoynpSw17
        Pc68OwAQ/EwHsht5k7v2JF4WETEBwR48ogLnyy9gpXWJGwxdDxIylasz2lgIX/kR
        /zRQxXYe40iYkkClyvz7uphfPOtl62Sn5GncmvRoW00H8Nyg2sPoF0TJb+YzHg+f
        2zAkhmJfet3az0iYYK8N4FihbgYgmiD2Amqdc1+bUqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8bCkpT
        dcGGFLusto1lDzqfwgm88Wweu677Xf+YwU81A=; b=IUhjQI9gk4/BL1p2DT6oUp
        aGHKxUVZci0N1kh4KBS+0UkYKdZmD60CyYJNpvK/xmd+k/O8xzbvEOjxTUPOdDK6
        BFQ8nO11VWIItrXYdixVGnnYh3IIVIdFpobmnd5pcZcteLjaeghzO51TYtUcdfva
        6Ze88VOUaridMdBJwow4wSt/9YGkwCZCNZG+lxj+eC71I/FJtFX97t5iWE/yE8cD
        pQgypGZn9XOwUX8eatghyjs35z/0J6XeGc9HlrsiZOEeS77feJltTj+Sz1Nf0h1G
        /QeEc1L0bDU9jKRAgD5u00w2OlhNs3dkqH+TwurP37NE43Us+bMjYsrD2wT1jlxw
        ==
X-ME-Sender: <xms:hiq_YBxotsNyI10Xyk-KrZl51TpbibHcLidoB2HhijFIZWG8jAFfLA>
    <xme:hiq_YBSY-b9w2lDsgk0KHK2WGEgXA2misvGk6Xft0Q26PXX5nNeb79bKHb1bgr0jC
    ISVY4YKCR4dqQ>
X-ME-Received: <xmr:hiq_YLUQuH1A4GtfyL6u7jZD76NBI30PkqMWrA6OmQJPkEw3WzlvS5zEojtUy_4lTIB75_ZYwaSk5sWJJV-CAl-2ZwbFf04y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtledgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepueelledtheekleethfeludduvdfhffeuvdffudevgeehke
    egieffveehgeeftefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:hiq_YDgnIYgzOR1djtI5Qgxj4aRO-dsjJNCXv--OsDfoPwl0Gp5M7g>
    <xmx:hiq_YDDHPbN6Lbrjj0kUfzJGrRCbpFKzbFtdA25oidsne-j-WlAEqQ>
    <xmx:hiq_YMKLaZOMXeHP_58YCNFHLKsE0mQqDDEMCoS7nLNBsKCGBqMm8g>
    <xmx:hiq_YO-xaLXlKTnUS552ANm5fcjc8HoQ0g2k9xguXRcojvEZHEuONg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jun 2021 04:29:58 -0400 (EDT)
Date:   Tue, 8 Jun 2021 10:29:56 +0200
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     wqu@suse.com, stable-commits@vger.kernel.org
Subject: Re: Patch "btrfs: fix compressed writes that cross stripe boundary"
 has been added to the 5.12-stable tree
Message-ID: <YL8qhIfzLkrIOD5N@kroah.com>
References: <20210608011352.05C646124C@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608011352.05C646124C@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 09:13:51PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     btrfs: fix compressed writes that cross stripe boundary
> 
> to the 5.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      btrfs-fix-compressed-writes-that-cross-stripe-bounda.patch
> and it can be found in the queue-5.12 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 6ac90347d410797dff70ea412aacb446f898b366
> Author: Qu Wenruo <wqu@suse.com>
> Date:   Tue May 25 13:52:43 2021 +0800
> 
>     btrfs: fix compressed writes that cross stripe boundary
>     
>     [ Upstream commit 4c80a97d7b02cf68e169118ef2bda0725fc87f6f ]

This is also dropped as it depended on the other btrfs patch :(

thanks,

greg k-h
