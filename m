Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7259D403DD8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 18:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352180AbhIHQs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 12:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43273 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352277AbhIHQsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 12:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631119635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p3l7Y7l1N9/csPlGKus0BxT6CPyB3A01Tl8K8HxuXxY=;
        b=VIR5gvNnQAW8V8iH4xDCnrReQZJMJ/1CwKyB9k+EWxil37J2g/xfwD12bRpSCwOjUi9bFJ
        RYNHzos2c+BFyFywe2oUB0Ple1pCqghmddfpoQ4r6P7D6rx00zsOolGae8xGZhDk9+tDrz
        KlB/YTR+BtQMqA5s6F3/YB48f7FgnZs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-SNEiw3EEMFCBvvcKet6s5g-1; Wed, 08 Sep 2021 12:47:14 -0400
X-MC-Unique: SNEiw3EEMFCBvvcKet6s5g-1
Received: by mail-lf1-f72.google.com with SMTP id w27-20020a05651204db00b003d8fb25ec90so1001000lfq.19
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 09:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:cc:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p3l7Y7l1N9/csPlGKus0BxT6CPyB3A01Tl8K8HxuXxY=;
        b=fzZA5HIa0Epy0SxDH6oRlOPb+0WBFajSIgFLfh1JKDW2vMisMHLIekP5lAhSbaJWQq
         3urY3GVSMn6zMxxGG7loeBv2y/ESH0u8QGH2L+f/hfGthIOjlexAnh1P+gkTMc20tQro
         D/fzsSa4a1Xx4uQjE4S9A+1Bl2afrty8OhT02BTd0C7rzBZrJZmZbc6XVnxhZCO2mb3G
         87ZSptM1OVjLSh6AZbX5th6TMPcjwF27+jKfdFmjt6/c9GQKxK8hGQcuBbOODUOLXZTs
         Vk3WqbJnWgOtFrz120WWtCSkW8LQm+uvocT1EDRYbB81AziIZcB6iO5XWB9y0HfquOh9
         n5Vg==
X-Gm-Message-State: AOAM5338KPZf0SdBVm8Fo/D2LQEdO4pV55dLWldr08BMoK596QYKH0Ub
        0NbD9pnIrjBebxWfFsPO9b9ynYg1cI6iuLcXFc475sQrxb5sckqmXmAa9DvxRz3zrvtqEZuvN8+
        NpcR/w4LsS5a5ygQ1VYGPPAq2
X-Received: by 2002:a2e:910f:: with SMTP id m15mr3547506ljg.275.1631119633177;
        Wed, 08 Sep 2021 09:47:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFTWvHNVWRZ+KTUbYFsamuGs6F5LPysXkcACIEwI2UNXuXVMv+2i7bRlun3mkelnT3BaLfcg==
X-Received: by 2002:a2e:910f:: with SMTP id m15mr3547494ljg.275.1631119632961;
        Wed, 08 Sep 2021 09:47:12 -0700 (PDT)
Received: from [192.168.42.238] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id b3sm234321lfq.286.2021.09.08.09.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 09:47:12 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     brouer@redhat.com, moyufeng <moyufeng@huawei.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        alexander.duyck@gmail.com, linux@armlinux.org.uk, mw@semihalf.com,
        linuxarm@openeuler.org, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, thomas.petazzoni@bootlin.com,
        hawk@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, akpm@linux-foundation.org,
        peterz@infradead.org, will@kernel.org, willy@infradead.org,
        vbabka@suse.cz, fenghua.yu@intel.com, guro@fb.com,
        peterx@redhat.com, feng.tang@intel.com, jgg@ziepe.ca,
        mcroce@microsoft.com, hughd@google.com, jonathan.lemon@gmail.com,
        alobakin@pm.me, willemb@google.com, wenxu@ucloud.cn,
        cong.wang@bytedance.com, haokexin@gmail.com, nogikh@google.com,
        elver@google.com, yhs@fb.com, kpsingh@kernel.org,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, chenhao288@hisilicon.com
Subject: Re: [PATCH net-next v2 4/4] net: hns3: support skb's frag page
 recycling based on page pool
To:     Jakub Kicinski <kuba@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <1628217982-53533-1-git-send-email-linyunsheng@huawei.com>
 <1628217982-53533-5-git-send-email-linyunsheng@huawei.com>
 <2b75d66b-a3bf-2490-2f46-fef5731ed7ad@huawei.com>
 <20210908080843.2051c58d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <YTjWK1rNsYIcTt4O@apalos.home>
 <20210908085723.3c9c2de2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <77945d26-2961-df8f-d0b5-8ecafafefd7e@redhat.com>
Date:   Wed, 8 Sep 2021 18:47:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210908085723.3c9c2de2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/09/2021 17.57, Jakub Kicinski wrote:
> On Wed, 8 Sep 2021 18:26:35 +0300 Ilias Apalodimas wrote:
>>> Normally I'd say put the stats in ethtool -S and the rest in debugfs
>>> but I'm not sure if exposing pages_state_hold_cnt and
>>> pages_state_release_cnt directly. Those are short counters, and will
>>> very likely wrap. They are primarily meaningful for calculating
>>> page_pool_inflight(). Given this I think their semantics may be too
>>> confusing for an average ethtool -S user.
>>>
>>> Putting all the information in debugfs seems like a better idea.
>>
>> I can't really disagree on the aforementioned stats being confusing.
>> However at some point we'll want to add more useful page_pool stats (e.g the
>> percentage of the page/page fragments that are hitting the recycling path).
>> Would it still be 'ok' to have info split across ethtool and debugfs?
> 
> Possibly. We'll also see what Alex L comes up with for XDP stats. Maybe
> we can arrive at a netlink API for standard things (broken record).
> 
> You said percentage - even tho I personally don't like it - there is a
> small precedent of ethtool -S containing non-counter information (IOW
> not monotonically increasing event counters), e.g. some vendors rammed
> PCI link quality in there. So if all else fails ethtool -S should be
> fine.

I agree with Ilias, that we ought-to add some page_pool stats.
*BUT* ONLY if this doesn't hurt performance!!!

We have explained before, how this is possible, e.g. by keeping consumer 
vs. producer counters on separate cache-lines (internally in page_pool 
struct and likely on per CPU for returning pages).  Then the drivers 
ethtool functions can request the page_pool to fillout a driver provided 
stats area, such that the collection and aggregation of counters are not 
on the fast-path.

I definitely don't want to see pages_state_hold_cnt and 
pages_state_release_cnt being exposed directly.  These were carefully 
designed to not hurt performance. An inflight counter can be deducted by 
above ethtool-driver step and presented to userspace.


Notice that while developing page_pool, I've been using tracepoints and 
bpftrace scripts to inspect the behavior and internals of page_pool.
See[1] and I've even written a page leak detector[2].

In principle you could write a bpftrace tool that extract stats, the 
same way. But I would only recommend doing this for devel phase, because 
these tracepoints do add some overhead.
Originally I wanted to push people to use this for stats, but I've 
realized that not having these stats easy available is annoying ;-)

-Jesper

[1] 
https://github.com/xdp-project/xdp-project/tree/master/areas/mem/bpftrace
[2] 
https://github.com/xdp-project/xdp-project/blob/master/areas/mem/bpftrace/page_pool_track_leaks02.bt

