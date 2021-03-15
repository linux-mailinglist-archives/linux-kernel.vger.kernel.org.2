Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044ED33B2D9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhCOMef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:34:35 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:35833 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229553AbhCOMeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:34:09 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id C4F45C8D;
        Mon, 15 Mar 2021 08:34:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 15 Mar 2021 08:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=o+4lJg+LgBsZLDEeRX2OAY/izVd
        RhejlQr3StKZ3QuE=; b=qF1fr2TZm6+PolWdhpk9GOd+txSvVtACIAjs5XI7ETa
        svWGXV95feIF8bte1YW//g+h3TCzuoOI0hr8gWfLpauxSXe+36eSli0vs9S5FcWO
        zP2jqr3JpYo22+53QOPkzS3NRmJaGCTEBB4vUpdBg0gC0zD98eanO9uZkWcia3Ex
        3ULrcKIFvuYaHw2xzKTITP03bgb9j/t+IEZeYKsv6ndFlOLJZZqUd80XMDWPAirJ
        9g44pdJZOC0bI9dtndacwMxd1n8p0PzktfX6awZvcK7WNRLVGKtTIEyAgtmloLXk
        npAmg37F1dJVSPj0sekYwrN5oyknVPVI9avsDFFEEiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=o+4lJg
        +LgBsZLDEeRX2OAY/izVdRhejlQr3StKZ3QuE=; b=Gov5Hbw9364M4YQ2+RG+Hb
        Gpv0OrY9zW6dqPKsSWyLKhhrQCsKfvAPCsHo0K1UNXBhy+jrvWjBT9u6sKfedFAG
        +iq/kfx7zxUg1vvHfn6pAj2D0ahgJGvpargfp5iOfWpWJvMpJHsu9gWcYAvv9fam
        RpsNDWBYqm9y2doki8368UC3/5v6vAbkBXCot+rVz0rGnBpCb2zK1RECdU44NoGX
        +0P8l7oflQqcU3JNJSeFh/lqGtCmagR30LtxefXUMu8ij8trVYNV6lNvVt/u1MqZ
        9QioUDYYnuVcxC1Sjcy+rFfoPE5h4Fouf1TVqLxKZJC/d7ePnGFiP8YX5DLLJs1Q
        ==
X-ME-Sender: <xms:O1RPYHB2WA-CeTD7si9_ly2Et2Pbek0NqG9Aut43qZ03UttI8GGdMA>
    <xme:O1RPYPh4dc5lDsZ82xQm3Mx6wW-Te-sqdYByoiyu9Fd8U7bUv77meOwJGqV1kmye_
    IgV8XZBX5lnJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvledggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepueelledtheekleethfeludduvdfhffeuvdffudevgeehke
    egieffveehgeeftefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:O1RPYL_SyG_1y4sFCdatHYxffhoO9rjLREGbHfMtJaDhlOFnbVCOVw>
    <xmx:O1RPYL9KEpFQ4CdJTFaqOfo06SvjAikNPmccBtK3BZl2ytyTVu17KA>
    <xmx:O1RPYEBasH_h7Jp_lYBrn6_7yQylKBrwyjNy6iDkOWUGgDaX7rvnYQ>
    <xmx:O1RPYHLpBxxIkk2MVZzIVtzRgOlgHc8WDQVGo0dezTJ0zjZoMUEU3w>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 02CAA1080067;
        Mon, 15 Mar 2021 08:34:02 -0400 (EDT)
Date:   Mon, 15 Mar 2021 13:34:01 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     baijiaju1990@gmail.com, stable-commits@vger.kernel.org
Subject: Re: Patch "net: bonding: fix error return code of bond_neigh_init()"
 has been added to the 5.11-stable tree
Message-ID: <YE9UOR65S2/PplBC@kroah.com>
References: <20210315031050.F13F264E2E@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315031050.F13F264E2E@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2021 at 11:10:50PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     net: bonding: fix error return code of bond_neigh_init()
> 
> to the 5.11-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      net-bonding-fix-error-return-code-of-bond_neigh_init.patch
> and it can be found in the queue-5.11 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Your scripts are not cc:ing everyone on the s-o-b: chain of a patch :(

Anyway, dropping this as I already added and then dropped it as it is
being reverted.

thanks,

greg k-h
