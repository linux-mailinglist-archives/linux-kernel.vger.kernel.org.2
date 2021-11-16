Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1123452B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 07:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhKPHAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 02:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhKPHAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 02:00:11 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A37C061746
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 22:57:12 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so1124716wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 22:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vkz2WXNampKsraVMcWFQx+aLfkrkcHiDqTXBvmCN+Mk=;
        b=AFMuaqN5O8Gi1xlD/on1yfKZo3FATprdouTekm4jvoNsw/ctQB0//zTSgvRmsQCUhO
         3/4Fi/maWofyKhwVHCNfo3q6PyXGjnpWAmvMFcAqnU+VZ2wMp9zqD7wn/T+O3Wf6mbgX
         EIRsQGbD8Zm8hSftLEjvhun4kKqSqCGJeNGqaee0pGoY0NRLUFpWBLtMWH0rxs2d9dO8
         mGVZtxNN77OZcPck+/pCDyV+9sgohU083nivGRvs7SPD2jSLRssZ5YEg6Fa/UXqgpVuf
         pt/iuigtMnXV723hA6yhUxTYBnsvnVoJfsJsx7w8IOkxEXgVtjvna887N/ObELcq/Vre
         8czQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vkz2WXNampKsraVMcWFQx+aLfkrkcHiDqTXBvmCN+Mk=;
        b=GglsMQsryO+MYorJADmFrIai1HiT1sPNMi1+eNr3+KjuCNFuccP8RmBkF8qKnc+q3z
         PJZ4rDB60OGRxkeHz0dHcGdHQs/no0C/nNCXaZxKf2cu/zuo9nPqygTafA7aEQBQL+xk
         xGwF8d59HEsHfn8HUXkcaWv/v7TWLLxGNEvGozleaAQkPUX52y8fdlizFVbxyPUMoq8w
         SLg+R9/8D/yuJYLTg3nJGplaKfu1Hv4zLWWmAXnawOqFNN9KmH0jiJdSK8rpDMnfmqGg
         TwMwNhipHXpgvaiHwUUQqtvsagIj0UP5d+IMK8qL2V+0Xoju9c7YNMcgqnu8RQ/i8s5l
         2Njg==
X-Gm-Message-State: AOAM530u9v5IupFR4khPQftXuf/3AzE01c4GslxtNwRmEgMIouQdIaYX
        PLr/rLVMQwObESQHrcD4d/Gzuw==
X-Google-Smtp-Source: ABdhPJz+McntGGQqfn6p1r45ov0hVWWwHZJjqPFdCL8OZGN7vJ5/u3ATVk9FTXE+jYQ4kHbb/LMkIA==
X-Received: by 2002:a05:600c:22cb:: with SMTP id 11mr5168641wmg.181.1637045831000;
        Mon, 15 Nov 2021 22:57:11 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id f15sm1604532wmg.30.2021.11.15.22.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 22:57:10 -0800 (PST)
Date:   Tue, 16 Nov 2021 07:57:09 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
        Ido Schimmel <idosch@idosch.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        edwin.peer@broadcom.com
Subject: Re: [PATCH net-next] devlink: Require devlink lock during device
 reload
Message-ID: <YZNWRXzzRYMNhUEO@nanopsycho>
References: <20211109082042.31cf29c3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20211109182427.GJ1740502@nvidia.com>
 <YY0G90fJpu/OtF8L@nanopsycho>
 <YY0J8IOLQBBhok2M@unreal>
 <YY4aEFkVuqR+vauw@nanopsycho>
 <YZCqVig9GQi/o1iz@unreal>
 <YZJCdSy+wzqlwrE2@nanopsycho>
 <20211115125359.GM2105516@nvidia.com>
 <YZJx8raQt+FkKaeY@nanopsycho>
 <20211115150931.GA2386342@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115150931.GA2386342@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Nov 15, 2021 at 04:09:31PM CET, jgg@nvidia.com wrote:
>On Mon, Nov 15, 2021 at 03:42:58PM +0100, Jiri Pirko wrote:
>
>> >Sorry, I don't agree that registering a net notifier in an aux device
>> >probe function is non-standard or wrong.
>> 
>> Listening to events which happen in different namespaces and react to
>> them is the non-standard behaviour which I refered to. If you would not
>> need to do it, you could just use netns notofier which would solve your
>> issue. You know it.
>
>Huh?
>
>It calls the bog standard
>
> register_netdevice_notifier() 
>
>Like hundreds of other drivers do from their probe functions
>
>Which does:
>
>int register_netdevice_notifier(struct notifier_block *nb)
>{
>	struct net *net;
>	int err;
>
>	/* Close race with setup_net() and cleanup_net() */
>	down_write(&pernet_ops_rwsem);
>
>And deadlocks because devlink hols the pernet_ops_rwsem when it
>triggers reload in some paths.
>
>There is nothing wrong with a driver doing this standard pattern.
>
>There is only one place in the entire kernel calling the per-ns
>register_netdevice_notifier_dev_net() and it is burred inside another
>part of mlx5 for some reason..

Yep. I added it there to solve this deadlock.

>
>I believe Parav already looked at using that in rdma and it didn't
>work for some reason I've forgotten. 
>
>It is not that we care about events in different namespaces, it is
>that rdma, like everything else, doesn't care about namespaces and
>wants events from the netdev no matter where it is located.

Wait, so there is no notion of netnamespaces in rdma? I was under
impression rdma supports netnamespaces...


>
>Jason
