Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC2E35D2DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 00:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343597AbhDLWGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 18:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237667AbhDLWGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 18:06:12 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29108C061756
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:05:54 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g8so23868308lfv.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=jH4Dq0F+yoXtpQ3onWqK6eCEd8OoEMOOUOlWjB7z4D4=;
        b=BILQc/0tsDArqLNwp9spGoPTeS7yKR1clyyzE+QT9KGDSe2Bb4jRRLs4m1BeKFFAdZ
         yii3g/I28Wx/CzrYOKFYjrmlKgg8xGj9hnNUv1plQDmkAIDShOqdp0TkPHLqjWDp/F2T
         JRUAAD+GC1bbfVuvjAYk5ADj6neIS+tZ6IhieJTXffwDFYjuLX0B1UIVjsSuKi+W3moN
         n5w5zt8mX8chAaTEL8AsZwghjn5htfQ6QZk2KVXNV4Rojfsm3Q1bvd07Afy6d0L5Y8dH
         njDGs2841NFIe5UNSgusEFgfecy87nQ6lSFTXNfGEUhFyulhiV56GxbnSyQ3q7unY4cP
         rwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=jH4Dq0F+yoXtpQ3onWqK6eCEd8OoEMOOUOlWjB7z4D4=;
        b=FRVvfokBOEocAMDWs3GILuqRZJztC+eZuQAk2wRf/6wqmpX98SYWeRekXK0g4YJ8EC
         604ZAFdp+XeCfRCxgw7YTAnQcZ17tu4WAyomFfuWoVLduK6XaGWQ7yqf0KZnpUXeSgWP
         VjE8Nvk7l7HHWU51BWUM8qaqT0EWCXTbbdtLzWBsXDxixjUJ5UmHfje0Vlc46hfzGOgW
         JRme9oia8YiYOcDVNu1S30S134P4LhsBzbppF6qb5h7ODWj7ubJX5dKcrxP8dIP0eTBe
         rDIws4KSnD8D9IsRRwxeEoYYZh8RzQT7vVR4ZYOXXES+V61xIr52UgCr+We3A1+0NiaP
         qQ4A==
X-Gm-Message-State: AOAM533E/wmQlz0Fn0YZmSwnr0V4bQy8nwpmfmY+v7MYD5AoURDIIiBn
        3eHfdOgZDCKd9BTWxKhWHJe2yOasErxEiGYC
X-Google-Smtp-Source: ABdhPJyA3htC3t+NeClVI4FRC8HNeu4yeLzO3v9xQub7lB8Fl8SQeoHh8Z+alwpDhQDsquA4HKB3Uw==
X-Received: by 2002:a19:8682:: with SMTP id i124mr20169517lfd.406.1618265152251;
        Mon, 12 Apr 2021 15:05:52 -0700 (PDT)
Received: from wkz-x280 (h-90-88.A259.priv.bahnhof.se. [212.85.90.88])
        by smtp.gmail.com with ESMTPSA id q3sm3021374ljp.62.2021.04.12.15.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 15:05:51 -0700 (PDT)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     Marek Behun <marek.behun@nic.cz>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Ansuel Smith <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Eric Dumazet <edumazet@google.com>,
        Wei Wang <weiwan@google.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Taehee Yoo <ap420073@gmail.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        zhang kai <zhangkaiheb@126.com>,
        Weilong Chen <chenweilong@huawei.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Di Zhu <zhudi21@huawei.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/3] Multi-CPU DSA support
In-Reply-To: <20210412235054.73754df9@thinkpad>
References: <20210410133454.4768-1-ansuelsmth@gmail.com> <20210411200135.35fb5985@thinkpad> <20210411185017.3xf7kxzzq2vefpwu@skbuf> <878s5nllgs.fsf@waldekranz.com> <20210412213045.4277a598@thinkpad> <8735vvkxju.fsf@waldekranz.com> <20210412235054.73754df9@thinkpad>
Date:   Tue, 13 Apr 2021 00:05:51 +0200
Message-ID: <87wnt7jgzk.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 23:50, Marek Behun <marek.behun@nic.cz> wrote:
> On Mon, 12 Apr 2021 23:22:45 +0200
> Tobias Waldekranz <tobias@waldekranz.com> wrote:
>
>> On Mon, Apr 12, 2021 at 21:30, Marek Behun <marek.behun@nic.cz> wrote:
>> > On Mon, 12 Apr 2021 14:46:11 +0200
>> > Tobias Waldekranz <tobias@waldekranz.com> wrote:
>> >  
>> >> I agree. Unless you only have a few really wideband flows, a LAG will
>> >> typically do a great job with balancing. This will happen without the
>> >> user having to do any configuration at all. It would also perform well
>> >> in "router-on-a-stick"-setups where the incoming and outgoing port is
>> >> the same.  
>> >
>> > TLDR: The problem with LAGs how they are currently implemented is that
>> > for Turris Omnia, basically in 1/16 of configurations the traffic would
>> > go via one CPU port anyway.
>> >
>> >
>> >
>> > One potencial problem that I see with using LAGs for aggregating CPU
>> > ports on mv88e6xxx is how these switches determine the port for a
>> > packet: only the src and dst MAC address is used for the hash that
>> > chooses the port.
>> >
>> > The most common scenario for Turris Omnia, for example, where we have 2
>> > CPU ports and 5 user ports, is that into these 5 user ports the user
>> > plugs 5 simple devices (no switches, so only one peer MAC address for
>> > port). So we have only 5 pairs of src + dst MAC addresses. If we simply
>> > fill the LAG table as it is done now, then there is 2 * 0.5^5 = 1/16
>> > chance that all packets would go through one CPU port.
>> >
>> > In order to have real load balancing in this scenario, we would either
>> > have to recompute the LAG mask table depending on the MAC addresses, or
>> > rewrite the LAG mask table somewhat randomly periodically. (This could
>> > be in theory offloaded onto the Z80 internal CPU for some of the
>> > switches of the mv88e6xxx family, but not for Omnia.)  
>> 
>> I thought that the option to associate each port netdev with a DSA
>> master would only be used on transmit. Are you saying that there is a
>> way to configure an mv88e6xxx chip to steer packets to different CPU
>> ports depending on the incoming port?
>>
>> The reason that the traffic is directed towards the CPU is that some
>> kind of entry in the ATU says so, and the destination of that entry will
>> either be a port vector or a LAG. Of those two, only the LAG will offer
>> any kind of balancing. What am I missing?
>
> Via port vectors you can "load balance" by ports only, i.e. input port X
> -> trasmit via CPU port Y.

How is this done? In a case where there is no bridging between the
ports, then I understand. Each port could have its own FID. But if you
have this setup...

   br0    wan
   / \
lan0 lan1

lan0 and lan1 would use the same FID. So how could you say that frames
from lan0 should go to cpu0 and frames from lan1 should go to cpu1 if
the DA is the same? What would be the content of the ATU in a setup
like that?

> When using LAGs, you are load balancing via hash(src MAC | dst mac)
> only. This is better in some ways. But what I am saying is that if the
> LAG mask table is static, as it is now implemented in mv88e6xxx code,
> then for many scenarios there is a big probability of no load balancing
> at all. For Turris Omnia for example there is 6.25% probability that
> the switch chip will send all traffic to the CPU via one CPU port.
> This is because the switch chooses the LAG port only from the hash of
> dst+src MAC address. (By the 1/16 = 6.25% probability I mean that for
> cca 1 in 16 customers, the switch would only use one port when sending
> data to the CPU).
>
> The round robin solution here is therefore better in this case.

I agree that it would be better in that case. I just do not get how you
get the switch to do it for you.
