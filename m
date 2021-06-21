Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2B23AE622
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 11:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhFUJj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 05:39:26 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54139 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhFUJjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:39:25 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id E82B05C012A;
        Mon, 21 Jun 2021 05:37:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 21 Jun 2021 05:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=O/YbqcgeOWAmky8t+eyQabmB9KX
        hgeHInO/1tw24SnY=; b=quNsZPXc33lUvO0ivWIn2F7fn9oDrtRv1TQooxldEYf
        a/Z695n0YbT6V2BMh1CVdRBgRWuMIxYGIEtgsT+5Zw7u+tr5utSSutLDBfgZoOKs
        VNgfnmC1BZaeaWKphOQgeoe7R16g8sh6vkgcS5ZyfylyzA0G4yi+73cfx7+PcVv7
        dKNVdfy8R/Yu9/kJEkfS52jhDI+/uzICCu8l7Mptegmh7F5NlyetCh5FuiLNYXzu
        xp/mi+2bsKPla5JNbEv4g8zd7vHHSlPRLiuhLNoZd4F8S5Eyce56yXh1964FoKzq
        Avf0313TF9iz9ZLSHpXwm0Dt2AWNypI04Kftlhil2mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=O/Ybqc
        geOWAmky8t+eyQabmB9KXhgeHInO/1tw24SnY=; b=NCpsGM1qomlnHc/K1T7qt9
        lIGtRQ6r5RJH6E5Xor3EEFBNRrBvIgi57qyH40Fsj7xePZf7U0m/+X11t4pTZnp5
        3pUmqeDFwPqFjQY5xr+gtxIXruTcD5V48hsP1GOQiU068QHFTbbacmIzWRwdoOn3
        Z14/cnndzfduFIPazEoSPRXXKuiZct64gekzIT/Ht1lhVOFdRAcVK8Uyji9oK2He
        ul4+ZCUvuMCs0eClu9U9fpt+/9I2upUKHQE37xmeBZzU+fW2jqDOekf8k072xHqd
        N+5mB41t6OFgx+lh4bPep2wnNbrPs2l5+/lLuP7CimncJItpQ0LogBeJyROOnwHw
        ==
X-ME-Sender: <xms:xV3QYMpVhpOc2_IFGP6qZ-m3zzKXKFdgLD3ZwC3HKzR_xzcZI1dwyQ>
    <xme:xV3QYCofdAsqFqM0GTEprlLhKJrwqGON-SVkuf9jkSraHhp37M-K-rz6AESk-_FkC
    0hpqVzNHVr57g>
X-ME-Received: <xmr:xV3QYBNZiVJBVlhwcl6TwTq4VYIe-fcjRtN5fzq8BhKh6I_-WcN9kO2W2xS08zpDI6D-9_J00Zx7uamNFVkErZqiIGFWhWMV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeefledgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepueelledtheekleethfeludduvdfhffeuvdffudevgeehke
    egieffveehgeeftefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:xV3QYD5r6WbUUeZKi98pURLKqvhrDCKLpCD6a1AYAFVvZklSx-uxWg>
    <xmx:xV3QYL4hKGUJ_5pvCeMdLmnh2NAIHBx877vWDxke92l1_5EhEC8xfg>
    <xmx:xV3QYDiudYB5bWAnicc7o1ClHs1fRolywauP6mduztHSgCJU56qAjg>
    <xmx:xl3QYO3r0-Bu3KsutGIJaCLTFaFeASl9puVpWYv5zirJacjebl99PQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jun 2021 05:37:09 -0400 (EDT)
Date:   Mon, 21 Jun 2021 11:37:07 +0200
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     n-horiguchi@ah.jp.nec.com, stable-commits@vger.kernel.org
Subject: Re: Patch "mm: hwpoison: introduce memory_failure_hugetlb()" has
 been added to the 4.9-stable tree
Message-ID: <YNBdw27AuaHqhgme@kroah.com>
References: <20210618114819.BDE5F613D1@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618114819.BDE5F613D1@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 07:48:18AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     mm: hwpoison: introduce memory_failure_hugetlb()
> 
> to the 4.9-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      mm-hwpoison-introduce-memory_failure_hugetlb.patch
> and it can be found in the queue-4.9 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 

This breaks the build, so I am now dropping it.

thanks,

greg k-h
