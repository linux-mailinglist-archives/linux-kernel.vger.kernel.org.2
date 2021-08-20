Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A72B3F2E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240874AbhHTOd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbhHTOd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:33:28 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ACBC061757
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 07:32:50 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id e15so7628397qtx.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e0wrVGt7kFkQ7/wtYNAWRBgRnWXShvbh13I5Ys01L+E=;
        b=CJ7ZuJeCdchRl4XgOXd49TxFXsziyfoAObxQJTDcAhjeYeuNnMWGvlkddsUNs7Yy3q
         tM56eXxmJgNjYtz4wl/f8KseperUdZgrpGVf4lEnEqbHV1bUVN0z9lt4OODWEKREvdlT
         TF+IZKaReYT67Em58muNv8ChnbvR+loV5nFVSM71QZGQQDw8E1Oh3Trsr8HX0Y8eJRVH
         CgymNCiT29qApJReU16s0Vr4h0ea8sv9HXXEwuRckCmzH8u5niys1+qSkMslwPUm7oNN
         3y4asbHkuiLCSqW62K/s0cLlm5z0e0XtYBZT+lAFbxc8onwoZfWAsWC7gOw5AIfOkc7o
         nzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e0wrVGt7kFkQ7/wtYNAWRBgRnWXShvbh13I5Ys01L+E=;
        b=mbKWkmvukjuYcK5Jt68bHrQqyZXze8PVDynxh0zRRjeSDWY24XF2v9ztdwAHHH1eEl
         +HxROd1zxPY7hSk7jTt/QD9prSzC1saj1Dd+a1n2nw5w6BoEaT8vOKTgqWtxW7gy3ZD9
         +Z1gMQKH/8KpGmAW62c5GO6FUD3s8e0LDuJNgfWV2JXCRKreu1qhBUQicbAj9Ccfae33
         3Zdev1RAyhH1ZTTZ8+XM/unSB7ie51hQNGKCgfCgnGIFtui3SGlhbi1m1LeaB8cK8ayq
         ur1N4552H8hmCwZxgefBUTdTDKKOTla3y2zuH/QM5MojhXb3EQC4f6+dnuDQA0duvVij
         nE4g==
X-Gm-Message-State: AOAM531MUGAbrwIg5aL6YTNgghQt6Beu74taj8EBUSdRk7yUWftmLmpZ
        Sav0EhmZk2zFxEWigDVelfJE6g==
X-Google-Smtp-Source: ABdhPJwmdH6rF/yxxbcSNY8JaS0SkaULXIuYiJrw1kTXkGwDrlKXUC7BypHhSOicY9n0ZG/pqAFTrg==
X-Received: by 2002:ac8:7f06:: with SMTP id f6mr7901829qtk.262.1629469969475;
        Fri, 20 Aug 2021 07:32:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id i18sm622187qke.103.2021.08.20.07.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 07:32:48 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mH5Zg-001ri3-25; Fri, 20 Aug 2021 11:32:48 -0300
Date:   Fri, 20 Aug 2021 11:32:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Doug Ledford <dledford@redhat.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Oded Gabbay <ogabbay@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC] Make use of non-dynamic dmabuf in RDMA
Message-ID: <20210820143248.GX543798@ziepe.ca>
References: <20210818074352.29950-1-galpress@amazon.com>
 <CAKMK7uGZ_eX+XfYJU6EkKEOVrHz3q6QMxaEbyyD3_1iqj9YSjw@mail.gmail.com>
 <20210819230602.GU543798@ziepe.ca>
 <CAKMK7uGgQWcs4Va6TGN9akHSSkmTs1i0Kx+6WpeiXWhJKpasLA@mail.gmail.com>
 <20210820123316.GV543798@ziepe.ca>
 <0fc94ac0-2bb9-4835-62b8-ea14f85fe512@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fc94ac0-2bb9-4835-62b8-ea14f85fe512@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 03:58:33PM +0300, Gal Pressman wrote:

> Though it would've been nicer if we could agree on a solution that could work
> for more than 1-2 RDMA devices, using the existing tools the RDMA subsystem has.

I don't think it can really be done, revoke is necessary, and isn't a
primitive we have today.

Revoke is sort of like rereg MR, but with a guaranteed no-change to
the lkey/rkey

Then there is the locking complexity of linking the mr creation and
destruction to the lifecycle of the pages, which is messy and maybe
not general. For instance mlx5 would call its revoke_mr, disconnect
the dmabuf then destroy the mkey - but this is only safe because mlx5
HW can handle concurrent revokes.

> That's why I tried to approach this by denying such attachments for non-ODP
> importers instead of exposing a "limited" dynamic importer.

That is fine if there is no revoke - once revoke exists we must have
driver and HW support.

Jason
