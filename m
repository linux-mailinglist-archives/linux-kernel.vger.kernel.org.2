Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6387F39F0F1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 10:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhFHIbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 04:31:25 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54229 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230251AbhFHIbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 04:31:24 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 74FB05C01B4;
        Tue,  8 Jun 2021 04:29:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 08 Jun 2021 04:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=sJR1BfXDgHAxQcb8/qOH+5uYho2
        XvNsGvo069G6YfgI=; b=pVRjYDhH9udlTa4Ep85qvkr6rORNtrAKRv0CXB2dq2x
        OqxN7FjN7Qmf47+yLNFdJ9Yd+ROKtlYi/k3JhfPdGfRMgwpaws3j/QHtSoBZRCYE
        BJ93Zg/FgDA74Ro6ZXsDA/WruaiC/G/TCkEv1snBoiicLDU1wrviJjgZMbVXUXwD
        Qmbvlzo6vgFkL7fv1XRHvjFJw1iJ4Eub6NE5yQLdlWlg90KW1vp4bkpg9Tq+lH3F
        gMzyDRC9yjRKEi3zuW8ZtXjb2oYIfGhWblC2sD7HcpgOGqwojVHKVAqhTqRTmPcK
        YCQ2E3hwx4ea+JItaChzAH027ycHnXblncxUWGntrBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=sJR1Bf
        XDgHAxQcb8/qOH+5uYho2XvNsGvo069G6YfgI=; b=QMOlqdr5mXs2aIFwgYhPJJ
        TtThdoADN5QJatnZMQbsrdu50yVmmtegKoxiwHUbCZkG5zI3qkvJAo2Kj/9Ruioi
        wxQyYeNIyMi1tGFu1AgKvuZQqSyGM4Gyl/RXWArfswEaKac+LhGWuM90giOmEf+5
        atE0sQxunrPANL4i5z1WGcTAQEmWaJHR3VpsZawhlbV56RkcLDmM1zNSZGiHLEym
        Y+dmtBnx4oeS+YHWYAstdGMXz79LnfvsqAn+jKv/z3Ha30+EfcwSJaL4bE08LzvG
        WcleQ/LnwMyCQBCePV0clsccz0XJmW6qLAXQtXGDPURWSODliVKYOWELZ2GscfdA
        ==
X-ME-Sender: <xms:ayq_YOw0i6LtfwYZWBq2tr4KwYVPsGMX8h4SxhQXImktqob-wSShxA>
    <xme:ayq_YKSsVwAioyRGvRpD3A78pkIc9oo1fuaWLqEPne8VkKrL87jI4tD5k7QR4cdb4
    VQV2EOiyE-r0g>
X-ME-Received: <xmr:ayq_YAUyAEHsBRdhaFbS2ERhtW1tmwMjlSFgpo5Lvh_Fvak8H0SiIoVmqRiETQHKSOFWjqb_S0aPONvBbue1Lhn9DEBuhAU8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtledgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepueelledtheekleethfeludduvdfhffeuvdffudevgeehke
    egieffveehgeeftefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:ayq_YEg2hZHw5YkhGOlfRqueGq5ZmnwEfHxemVHMWDLuG3QUKRAXNw>
    <xmx:ayq_YACRIFtF2DHACLDL6gLoPWltBTdNh-oCRS6omZ9R9XHivftMIQ>
    <xmx:ayq_YFJZCjwzEIXq3hU4cf6V3wsLfaATththbfwAqUWxeIGhflU0AA>
    <xmx:ayq_YD8SyHosH_5zL3IgiuNYjJAWUCZX7VCnMOA0HiRy8RLr1yUsCQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jun 2021 04:29:30 -0400 (EDT)
Date:   Tue, 8 Jun 2021 10:29:29 +0200
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, stable-commits@vger.kernel.org
Subject: Re: Patch "btrfs: zoned: fix parallel compressed writes" has been
 added to the 5.12-stable tree
Message-ID: <YL8qaQCO3tebJXhv@kroah.com>
References: <20210608011346.E33E461263@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608011346.E33E461263@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 09:13:46PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     btrfs: zoned: fix parallel compressed writes
> 
> to the 5.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      btrfs-zoned-fix-parallel-compressed-writes.patch
> and it can be found in the queue-5.12 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Sasha, for some reason your stable-commits messages are not cc:ing
everyone on the patch, is that on purpose?

Anyway, I'll drop this as there is a build warning introduced by it
which is why I dropped it the first time around.

thanks,

greg k-h
