Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A875408591
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 09:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237740AbhIMHrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 03:47:04 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:58175 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237568AbhIMHrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 03:47:03 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1C871320091C;
        Mon, 13 Sep 2021 03:45:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 13 Sep 2021 03:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=vp1TwAwoIia3Z45qI/h70zXwsU6
        wq8hxLAETGLLNoDw=; b=onrE6ufDUIO5mXqT+S9INT9Z6vNIGBu1EDWO2HC1+nn
        lL2/+1yQen1hrOxyYuOHD9C+Z8QG0XkXQyLdBXuzvOOXWVfZQEqcpu4pvQocgcLF
        rPudavwuDr2RYhKtsa8LyiK36bdBro+XCT0HZkalfhgYaYNA5lshOIuCt45pEAni
        1kKzGKLBE5DC3LF5fP8ex48e45alwuMzTFcIZs8ppsFp0FXOqaAm3oI0nHNm8Eph
        7t6rLIG6DgETSXN6QfY7xHwyR12KYMv3WbrOWqb2KcnV/vAH03rqCZXVbVkD+473
        XMmibCJYjQqOR61x2+XtNlEFnUd/kKlBS2OIT16qnCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=vp1TwA
        woIia3Z45qI/h70zXwsU6wq8hxLAETGLLNoDw=; b=HB/siB4DE+UkSVJ8iB8D6O
        eor9miep7r69Nb2i9mwP+RgAuOxSEB08gM3MdiL5wdMv/QI4TG+dfVlqvsuVhPLk
        ZoRvp8P6i0/jhQ2VtolAcXkcvQdfjRI7s23UOY4FAyhHGAf1pufWTL3OPTWMiorS
        MZv3ZRZJy3OQWoJPDa/tvtrlVahb7IA5gDB+4DfDAw0vgZn9fXxExfc7T/2WvXmq
        YbBblhto+R1b3O6ZBcM04lK9RnT/kq/BRrVXmxQt0PwhvERT1LtlQ7c/jRNeD1r6
        Hu3ZEE/MbkgxCaPWmnk7/0IvaOXWMgRIBZq1mjto7CVEXuujERKmpW2cpaSGLpCg
        ==
X-ME-Sender: <xms:qgE_YURU4aYS5S53Uh3aMfDDGaVYM97wn2J3ALjjtZg_2ypD9XTXYA>
    <xme:qgE_YRwVTG5izCiC0Cv66M5egGDf7DVqKFFhVG1a7GZpNvVEvMbSfGr-Pe2IOT7-7
    w1gSvEWJXFznA>
X-ME-Received: <xmr:qgE_YR19jAYVHKjecy1hJZAYBBiVfNV9xONfCL2Rjp4Y8_EAjEi99vema4oYPfr0KcSxaNIB3PlpC3tjj_jtgndh__QQf6VH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegiedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeeuleeltdehkeeltefhleduuddvhfffuedvffduveeghe
    ekgeeiffevheegfeetgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:qgE_YYC_2MMIaWfF00c2Uqx6FszcKPuAP3r1CkfFfvCgcH2bOk_vmg>
    <xmx:qgE_YdhNmuVHuOu_2jelsl3AatMfuAfX3-Jiw___agnbH84zXGLodw>
    <xmx:qgE_YUrRqfiwwOWAYesHsG49Jmtx7T-VWNra8mK4oRaoMz6UzhwsLw>
    <xmx:qgE_Ydfx5fTswp_nnRZ2RW_0Rlo6T2YviVYxtIlg5Rs0XiiFw0wYkQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Sep 2021 03:45:46 -0400 (EDT)
Date:   Mon, 13 Sep 2021 09:45:42 +0200
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     colin.king@canonical.com, stable-commits@vger.kernel.org
Subject: Re: Patch "6lowpan: iphc: Fix an off-by-one check of array index"
 has been added to the 4.9-stable tree
Message-ID: <YT8Bpu12FuzW5sqy@kroah.com>
References: <20210913032220.5147A600D4@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913032220.5147A600D4@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2021 at 11:22:19PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     6lowpan: iphc: Fix an off-by-one check of array index
> 
> to the 4.9-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      6lowpan-iphc-fix-an-off-by-one-check-of-array-index.patch
> and it can be found in the queue-4.9 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 68c66a31cc9a38a26a89f9594945390a09355728
> Author: Colin Ian King <colin.king@canonical.com>
> Date:   Mon Jul 12 13:14:40 2021 +0100
> 
>     6lowpan: iphc: Fix an off-by-one check of array index
>     
>     [ Upstream commit 9af417610b6142e826fd1ee8ba7ff3e9a2133a5a ]
>     
>     The bounds check of id is off-by-one and the comparison should
>     be >= rather >. Currently the WARN_ON_ONCE check does not stop
>     the out of range indexing of &ldev->ctx.table[id] so also add
>     a return path if the bounds are out of range.
>     
>     Addresses-Coverity: ("Illegal address computation").
>     Fixes: 5609c185f24d ("6lowpan: iphc: add support for stateful compression")
>     Signed-off-by: Colin Ian King <colin.king@canonical.com>
>     Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
> index 24915e0bb9ea..2a05c5b5005b 100644
> --- a/net/6lowpan/debugfs.c
> +++ b/net/6lowpan/debugfs.c
> @@ -176,7 +176,8 @@ static int lowpan_dev_debugfs_ctx_init(struct net_device *dev,
>  	struct dentry *dentry, *root;
>  	char buf[32];
>  
> -	WARN_ON_ONCE(id > LOWPAN_IPHC_CTX_TABLE_SIZE);
> +	if (WARN_ON_ONCE(id >= LOWPAN_IPHC_CTX_TABLE_SIZE))
> +		return;
>  
>  	sprintf(buf, "%d", id);
>  

Not the correct return type for this tree, or the 4.14 tree, so dropping
it from those queues as it adds a build warning.

thanks,

greg k-h
