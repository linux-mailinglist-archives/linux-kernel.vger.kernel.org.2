Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748763AEAB8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 16:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFUOHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 10:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhFUOG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 10:06:58 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0863C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 07:04:43 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c138so30721998qkg.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u1X7Cpa4D/S7QoW2bbI1iaCX5CSBd0Mm5781yWNnuBQ=;
        b=hP5HE5VcqmklMdBX1AqbXS5mNHCUEcaadxyUtu03tVApOSRUZKkKCJIPf9u6BuZwMU
         y2CvoPFeuM6I46qhZ00FuUZwUXzRFa9y3gYha8CrV77LGcbtC6eqo0bC8ujxCEVT1wEu
         94WGYby+GRstu78enn43oKmu+c5Xu+EFnST6qqwijxtw7L0DMYp0QFPxZnukpRi5r5it
         QLY7LlVhka4DdCLPrw+/aWr82NLeYBH09MGZlH3eYjiSE1NqXonyFGAXBrTVNpfECK18
         sDe27z9ausQ2vbtP2JxQcaOl4xNLYh8PPU0dRtkXbYp5UisE5mzQu3AApXk1Dmw0lf3q
         PU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u1X7Cpa4D/S7QoW2bbI1iaCX5CSBd0Mm5781yWNnuBQ=;
        b=RMn9vzEGKvH6EJf+VXQLEmrsS2b51PWnmsrekAs8zarxod0fSrt2DzqIhxA4mN9u1C
         pwjCcXdvjG0N3a3j6S5HXtYE8Fd/NY8FopLKoXUOkc7tQLQf2/5SmqevH7cAcH/XlTwr
         O1zx/y7GSXimDuXy41FqJOv6SVE00MHq/EbZPYc1vnbbWLW3zF0rQmhJTk92aLKlOUAX
         KaudkoPcTMz2z3T2HIfRvXB3i/qIjXNpPdrMWa3jA8mqvByxHo5N28EVKGm+NHL+w+e2
         DNyQAmrB00rvbRmOQ5syBzsnMuoAS7zrvkw55nk5i77+o3MMlx9g89N4coJNRFVwxRug
         zMEw==
X-Gm-Message-State: AOAM530CCsaRrCS+vXakQK3329o9nVZLjzxvAU1SzkZD2HFCZFh8Mq+7
        W6X9OIJsWvC17tpHQ+F780vl0AvULAZ8xg==
X-Google-Smtp-Source: ABdhPJwPY8AVx3BmkIMaEV3qpcSJtGcIY8InamUwYhLCgoTa1H0ZAPHiESQwfa06qhEmDmgO/juUhQ==
X-Received: by 2002:a37:7987:: with SMTP id u129mr5928820qkc.338.1624284282909;
        Mon, 21 Jun 2021 07:04:42 -0700 (PDT)
Received: from [192.168.1.171] (bras-base-kntaon1617w-grc-24-174-92-115-23.dsl.bell.ca. [174.92.115.23])
        by smtp.googlemail.com with ESMTPSA id s23sm10889299qtq.2.2021.06.21.07.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 07:04:42 -0700 (PDT)
Subject: Re: [PATCH net-next] net/sched: cls_flower: fix resetting of ether
 proto mask
To:     Boris Sukholitko <boris.sukholitko@broadcom.com>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Serhiy Boiko <serhiy.boiko@plvision.eu>,
        Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@resnulli.us, idosch@idosch.org, ilya.lifshits@broadcom.com
References: <20210617161435.8853-1-vadym.kochan@plvision.eu>
 <20210617164155.li3fct6ad45a6j7h@skbuf>
 <20210617195102.h3bg6khvaogc2vwh@skbuf> <20210621083037.GA9665@builder>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <f18e6fee-8724-b246-adf9-53cc47f9520b@mojatatu.com>
Date:   Mon, 21 Jun 2021 10:04:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210621083037.GA9665@builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-21 4:32 a.m., Boris Sukholitko wrote:
> On Thu, Jun 17, 2021 at 10:51:02PM +0300, Vladimir Oltean wrote:
>> On Thu, Jun 17, 2021 at 07:41:55PM +0300, Vladimir Oltean wrote:
>>> On Thu, Jun 17, 2021 at 07:14:35PM +0300, Vadym Kochan wrote:
> 
> [snip excellent problem analysis]
> 
>> So maybe it is the flow dissector we need to fix, to make it give us an
>> additional pure EtherType if asked for, make tc-flower use that
>> dissector key instead, and then revert Jamal's user space patch, and we
>> should all install our tc filters as:
>>
>> tc filter add dev sw1p0 ingress handle 11 protocol all flower eth_type 0x8864 skip_hw action drop
>>
>> ?
> 
> I like this solution. To be more explicit, the plan becomes:
> 
> 1. Add FLOW_DISSECTOR_KEY_ETH_TYPE and struct flow_dissector_key_eth_type.
> 2. Have skb flow dissector use it.
> 3. Userspace does not set TCA_FLOWER_KEY_ETH_TYPE automagically
>     anymore. cls_flower takes basic.n_proto from struct tcf_proto.
> 4. Add eth_type to the userspace and use it to set TCA_FLOWER_KEY_ETH_TYPE
> 5. Existence of TCA_FLOWER_KEY_ETH_TYPE triggers new eth_type dissector.
> 
> IMHO this neatly solves non-vlan protocol match case.
> 
> What should we do with the VLANs then? Should we have vlan_pure_ethtype
> and cvlan_pure_ethtype as additional keys?
> 

I didnt see the original patch you sent until after it was applied
and the cursory 30 second glance didnt say much to me.

Vlans unfortunately are a speacial beast: You will have to retrieve
the proto differently.

Q: Was this always broken? Example look at Toke's change here:
commit d7bf2ebebc2bd61ab95e2a8e33541ef282f303d4

cheers,
jamal
