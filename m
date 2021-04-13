Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB0935E1B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbhDMOkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbhDMOkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:40:49 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C29C061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:40:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f41so4361871lfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=B0Ze6zSePn8dZkD37LVudsQ716aTcli/ZveubzeD3u8=;
        b=wGLMN6M+fpgYXDaOgMvbsV9YQT3c5dH36ePoA+A+QDzVbBDzGRc6wzf0IuOncaS9aR
         Yl5krVByvJzPZVDcuYfoQgXN267xiPHiBM1eD8a9mSXfwu4HsCmwAU0V+lmINpmkuSst
         3yuK7+gtaatssmw+xAWp2t9Yji/t/BZd1KTTvNDtuNScx9NnXFl/Vwdvl04pPqApfrjA
         TOzSbifIu98RMKZjKWBSTThTTw1Va1/MNsSC8rxUHskOvQffoC22m0S00vga0QcLxh4k
         bVQRwwj4xllY6QWFfJ5HN7zSRsX7Z/ul8pBewtivFYMrniAT0BOg4K1Yiv69tw3hNhM+
         bdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=B0Ze6zSePn8dZkD37LVudsQ716aTcli/ZveubzeD3u8=;
        b=aSzZTWj3LL85v09Wy3alN5p8lCZyVmiNVJJtzqPNL7KRWDSLP3bsl+iX7p6RGLNz4l
         OKw4rzq2ae37lX4ZO9fewtL7dgz2Z4awxKmeJChCOPTcqTdFJlyor/O80U9SjiG64ic1
         iLwV9b9P/5DvXGjiONkbTAX2usby5VTbxPty7WVL5Y2kbD3ZV6RQi4TWNpufGwfIxvhd
         7q76IVaVlu4C/KBBDrK6EeJBYYYqcWMs6z7oVH2IpsBiMRY/GYiu0sZFcl1TnNhSsGvM
         ++GTa/1ZGgLa9cKdxjEmXQ+d32CJNcOu5QrzWbpH05gw45wtJFloJxs/BSuCVuX5/Eyp
         T8Ug==
X-Gm-Message-State: AOAM53008GTqTy1VUsIyjfHbovG6gmSwh9/btsQt6V+j5qNd14lhJPlo
        b7tUQ7Xg1IGzDEUY7QOSTv3tQrriryXO587T
X-Google-Smtp-Source: ABdhPJyyfHteWuNMJ9zxIqN3kTx27GAhgDzcIq80qon/4QXIUL/AtXJmAyix9ycyk0A0nt57CAK53w==
X-Received: by 2002:a05:6512:b9e:: with SMTP id b30mr8084353lfv.278.1618324827516;
        Tue, 13 Apr 2021 07:40:27 -0700 (PDT)
Received: from wkz-x280 (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id q28sm3403883lfo.95.2021.04.13.07.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:40:26 -0700 (PDT)
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
In-Reply-To: <20210413015450.1ae597da@thinkpad>
References: <20210410133454.4768-1-ansuelsmth@gmail.com> <20210411200135.35fb5985@thinkpad> <20210411185017.3xf7kxzzq2vefpwu@skbuf> <878s5nllgs.fsf@waldekranz.com> <20210412213045.4277a598@thinkpad> <8735vvkxju.fsf@waldekranz.com> <20210412235054.73754df9@thinkpad> <87wnt7jgzk.fsf@waldekranz.com> <20210413005518.2f9b9cef@thinkpad> <87r1jfje26.fsf@waldekranz.com> <87o8ejjdu6.fsf@waldekranz.com> <20210413015450.1ae597da@thinkpad>
Date:   Tue, 13 Apr 2021 16:40:25 +0200
Message-ID: <87lf9mjlie.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 01:54, Marek Behun <marek.behun@nic.cz> wrote:
> On Tue, 13 Apr 2021 01:13:53 +0200
> Tobias Waldekranz <tobias@waldekranz.com> wrote:
>
>> > ...you could get the isolation in place. But you will still lookup the
>> > DA in the ATU, and there you will find a destination of either cpu0 or
>> > cpu1. So for one of the ports, the destination will be outside of its
>> > port based VLAN. Once the vectors are ANDed together, it is left with no
>> > valid port to egress through, and the packet is dropped.
>> >  
>> >> Am I wrong? I confess that I did not understand this into the most fine
>> >> details, so it is entirely possible that I am missing something
>> >> important and am completely wrong. Maybe this cannot be done.  
>> >
>> > I really doubt that it can be done. Not in any robust way at
>> > least. Happy to be proven wrong though! :)  
>> 
>> I think I figured out why it "works" for you. Since the CPU address is
>> never added to the ATU, traffic for it is treated as unknown. Thanks to
>> that, it flooded and the isolation brings it together. As soon as
>> mv88e6xxx starts making use of Vladimirs offloading of host addresses
>> though, I suspect this will fall apart.
>
> Hmm :( This is bad news. I would really like to make it balance via
> input ports. The LAG balancing for this usecase is simply unacceptable,
> since the switch puts so little information into the hash function.

If you have the ports in standalone mode, you could imagine having each
port use its own FID. But then you cannot to L2 forwarding between the
LAN ports in hardware.

If you have a chip with a TCAM, you could theoretically use that to get
policy switching to the preferred CPU port. But since that would likely
run on top of TC flower or something, it is not obvious to my how to
would describe that kind of action.

Barring something like that, I think you will have to accept the
unacceptable :)

> I will look into this, maybe ask some follow-up questions.
>
> Marek
