Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6AC452B44
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 08:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhKPHD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 02:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhKPHDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 02:03:09 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33080C061570
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 23:00:13 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id z1-20020a05600c220100b00337f97d2464so1142449wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 23:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kDDIQhyeaHZVVHln44s2CYOC0EEHYbgxYIny7O/lm24=;
        b=kVdfr/2OfTkc8OeSw1qpoj3AVK/zuumfJuhvmcog4PAUuisy+mixJGgg3nvX7wgFfd
         vv38yy6+DNREAPsBwF+osFXf+2yJ8hZFedAZSIsMdtCpQon4DX6Vm5DdVaVP7QRr84yz
         P7RYD8YRYfqHjkwVJnc2iNI9rKhw6lZSbMMEJixQ+EoAZKhiS91sN9qc/wmXXRm9pTCt
         h13JZCrBXX83tv8dmoHMVP/gAQVkO/ui+lsqp4c40VanRowCuz4TUkEzMuEL8a6EVxXx
         lliAFVl2+TPVIFxktrDybmht8ICS/fo0CE6MKqKNBG23uDby1JqoO6ZhsbSKcsjdP9NK
         yeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kDDIQhyeaHZVVHln44s2CYOC0EEHYbgxYIny7O/lm24=;
        b=ZuBmo6LTn5huOBjhJCYBxhL6e2u85NopjHIyNDF/KGamJ36Prhu+gUC/uOtbOAuo7V
         GFbGVPj4Yj5cNXYvv7Hy8hiIThYmokXueQeGZko8HMOCREFroYuhdNL4wbleAm8HGgSq
         8eg9mqRvWRhyFvv0f2VLbSBYUeZMRha70T9hsEcVww//IAcWLEUTimoKZ33aatGyezFK
         HPll0yEYaVQ/NlDlEm2Bho970F9aVoBXdoKx4uYEKiGwU56PmmjjD4crZMQIdPOerEik
         jI4cxpGw63Ld/F95RV1PWk4TSzpczPfWO7B9PP82M17LhDPkotJ+8AQyUXe91tWUqKvR
         HQ4Q==
X-Gm-Message-State: AOAM533VOWdEx/Nw2OjpNEeCimkcEuo0Gw+Y9b0uorUfU45R8VBnfplj
        j5RxxK994UtATO2dLJF3TyRKhQ==
X-Google-Smtp-Source: ABdhPJw7C+2fo8SXqjbpVhxqqnwakghp61fTJUB6C07seLPpdoMrvbocdv5y0wcASDU7M/E+9DiHBA==
X-Received: by 2002:a05:600c:22cb:: with SMTP id 11mr5184735wmg.181.1637046011817;
        Mon, 15 Nov 2021 23:00:11 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id f15sm1613529wmg.30.2021.11.15.23.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 23:00:11 -0800 (PST)
Date:   Tue, 16 Nov 2021 08:00:10 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jiri Pirko <jiri@nvidia.com>, Ido Schimmel <idosch@idosch.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        edwin.peer@broadcom.com
Subject: Re: [PATCH net-next] devlink: Require devlink lock during device
 reload
Message-ID: <YZNW+mtcXe2kjJlY@nanopsycho>
References: <20211109182427.GJ1740502@nvidia.com>
 <YY0G90fJpu/OtF8L@nanopsycho>
 <YY0J8IOLQBBhok2M@unreal>
 <YY4aEFkVuqR+vauw@nanopsycho>
 <YZCqVig9GQi/o1iz@unreal>
 <YZJCdSy+wzqlwrE2@nanopsycho>
 <20211115125359.GM2105516@nvidia.com>
 <YZJx8raQt+FkKaeY@nanopsycho>
 <20211115150931.GA2386342@nvidia.com>
 <20211115072206.72435d60@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115072206.72435d60@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Nov 15, 2021 at 04:22:06PM CET, kuba@kernel.org wrote:
>On Mon, 15 Nov 2021 11:09:31 -0400 Jason Gunthorpe wrote:
>> On Mon, Nov 15, 2021 at 03:42:58PM +0100, Jiri Pirko wrote:
>> > >Sorry, I don't agree that registering a net notifier in an aux device
>> > >probe function is non-standard or wrong.  
>> > 
>> > Listening to events which happen in different namespaces and react to
>> > them is the non-standard behaviour which I refered to. If you would not
>> > need to do it, you could just use netns notofier which would solve your
>> > issue. You know it.  
>> 
>> Huh?
>> 
>> It calls the bog standard
>> 
>>  register_netdevice_notifier() 
>> 
>> Like hundreds of other drivers do from their probe functions
>> 
>> Which does:
>> 
>> int register_netdevice_notifier(struct notifier_block *nb)
>> {
>> 	struct net *net;
>> 	int err;
>> 
>> 	/* Close race with setup_net() and cleanup_net() */
>> 	down_write(&pernet_ops_rwsem);
>> 
>> And deadlocks because devlink hols the pernet_ops_rwsem when it
>> triggers reload in some paths.
>> 
>> There is nothing wrong with a driver doing this standard pattern.
>> 
>> There is only one place in the entire kernel calling the per-ns
>> register_netdevice_notifier_dev_net() and it is burred inside another
>> part of mlx5 for some reason..
>> 
>> I believe Parav already looked at using that in rdma and it didn't
>> work for some reason I've forgotten. 
>> 
>> It is not that we care about events in different namespaces, it is
>> that rdma, like everything else, doesn't care about namespaces and
>> wants events from the netdev no matter where it is located.
>
>devlink now allows drivers to be net ns-aware, and they should 
>obey if they declare support.  Can we add a flag / capability 
>to devlink and make it an explicit opt-in for drivers who care?

Looks kind of odd to me. It is also not possible for netdevice to say if
it should be net namespace aware or not. The driver should not be the
one to decide this.

