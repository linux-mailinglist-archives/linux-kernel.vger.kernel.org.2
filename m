Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCED6454F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 22:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240794AbhKQVss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 16:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhKQVsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 16:48:47 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1318EC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:45:49 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so3758116pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 13:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6HfC/V5zGfOM+1t3XoG3cpoCqx+ssyiS7c+Gxv7qozA=;
        b=F+q30p4Y76froPX0XA1ihFisMw43+joRuN5IH2SyXRArk7qHDtpyu1pc+4YqErjhWk
         PqEsI0VhERsMKFMI7P6wdu2ydEP6nZ/xE8rxWG5XMDVlyk2Iko4D6e3RBxZCxmuvDVeR
         RRFkowR71RRpoeeoXnnyvgECmXSvrGAU1QcoXPtydYGjaDhTMUsaaegdaegrkml+c+/y
         W/72KwVAUQG4b63I+JuwYzrnWlwPFk62nGxuDR9AWgDZOnbbVK9M62xG/YqYNNm418E/
         s9Eosarb0ipaLFEUP6kxBAbAgGdEE66miN8f0caiMLUJeM/j/vsPyCDsHjBdIQecBaMN
         9Rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=6HfC/V5zGfOM+1t3XoG3cpoCqx+ssyiS7c+Gxv7qozA=;
        b=D/Ug00C5sz9khoqehSvqSmR6EIBqJP4PXJskVAuMyhQJf2LAN7WcqSBADU6U6Mnsce
         vLWUC6crqVcQKGvtZKKPEOKaXa6Do6x2YAW7QIFFoSSgODxlhZG1OxWUlli0L9phYeME
         /mFLTLoUtlwt+w6/gCh6pOxOjrIat60HuhSW6TXQ8wNlY5Y7KvKmPSVGODX7AWZ9igMX
         fAGYD4sJketrnL8pBWCQ7cexI8VkXlm4rha/0WKSGP94yYjfVkc3xz59aeTorUVayHfn
         Rake4F753OYXwZYzciJJ6CJcoT6ESUt1YSw5ZJv5IqNCdf9xi6Tgd4B5W+y5RNJx1TiQ
         DZ0A==
X-Gm-Message-State: AOAM531r3JETDrFe37hjUkJaQPnCVhUc+txzEffaZOxazoS8q3ajmYFh
        VcD2ENh1kMM0OXfjY05GJnA=
X-Google-Smtp-Source: ABdhPJxSPgenizbt8TzdNf09XaH5ugQvMS/cED34+lIsA8r2chhWDU9W+CRF2+AyBGvY4P9HiqAaaw==
X-Received: by 2002:a17:90a:5d8e:: with SMTP id t14mr3582695pji.95.1637185548284;
        Wed, 17 Nov 2021 13:45:48 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id v15sm299208pfu.195.2021.11.17.13.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 13:45:47 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 17 Nov 2021 11:45:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] kernfs: release kernfs_mutex before the inode
 allocation
Message-ID: <YZV4CtJnH+ngOcxi@slm.duckdns.org>
References: <20211116194317.1430399-1-minchan@kernel.org>
 <YZQLWq7WMSRF2xCM@kroah.com>
 <YZQkQcrldGFwqV/r@google.com>
 <YZSk3DECnnknOu5T@kroah.com>
 <YZSu/HiHDZxo9Wpa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZSu/HiHDZxo9Wpa@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Nov 16, 2021 at 11:27:56PM -0800, Minchan Kim wrote:
> A app launching involves dma_buf exports which creates kobject
> and add it to the kernfs with down_write - kernfs_add_one.
> 
> At the same time in other CPU, a random process was accessing
> sysfs and the kernfs_iop_lookup was already hoding the kernfs_rwsem
> and ran under direct reclaim patch due to alloc_inode in
> kerfs_get_inode.
> 
> Therefore, the app is stuck on the lock and lose frames so enduser
> sees the jank.

So, one really low hanging fruit here would be using a separate rwsem per
superblock. Nothing needs synchronization across different users of kernfs
and the locking is shared just because nobody bothered to separate them out
while generalizing it from sysfs.

Thanks.

-- 
tejun
