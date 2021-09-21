Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC46412F52
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 09:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhIUHYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 03:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22598 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230101AbhIUHYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 03:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632209002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YfQmolrBACizgcgNsJjMXDd0gcVd36hCMTnBNcp8NrU=;
        b=fzy1Kyl6ol1X3dHzf6OQ46IXOMZzb+X6d7CbMU12OsQl5L/YBxLxfUOByYgHoircrEUNyD
        Gv9LVKsL4xZllbpJ13ydrKahLIT0xE9XGq0GuruHdNkHg5++jeDAhl8cP8vZgPy2ixQvNp
        jifIMUwwxjUtJWtB7JOf8ncN99MUqVM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-XCDie6p6N4ihUMZHjmeZvQ-1; Tue, 21 Sep 2021 03:23:20 -0400
X-MC-Unique: XCDie6p6N4ihUMZHjmeZvQ-1
Received: by mail-wr1-f72.google.com with SMTP id m18-20020adfe952000000b0015b0aa32fd6so8039660wrn.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 00:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YfQmolrBACizgcgNsJjMXDd0gcVd36hCMTnBNcp8NrU=;
        b=gf0BsQ+ZZstXld4SC5VX0DKoSLzVLBEGE8U12vvowJkwVZIXznna3DD+KyxYyv81Xh
         2Adwvvi2IM5B84VGPkgOlgTIwfQf9Z798wWktWHrcVOsIFso6FZRkwVr6227LtX911ic
         seZt03noO4ePqDVnsaMpU8RR4sD8ghuqHsEGGF2xaeSCoKiLIllSyF3rDb/uwQqY/j8z
         8WaYThFM3oZYB0UXcUd179MTAhUscAxoADwW9+19pTCUbPFuqjjehCliRmBLggUKpr+h
         bXHt6Lx4o9sJ15QxaEaB+Twr4NizYrEIQm0yuIGDmbJCA3UT4DtqMWjZZ6dSOpu+NGfL
         O7Jg==
X-Gm-Message-State: AOAM531cxcFSPmWtWkT1mD6BD9b4AC2PLntALW1TA11uDfX5FUJoUHUU
        FfAoYJJdlkYpMpN/SjaeDT0m8qhYyb+zgX1RNeTE5Wba4DSQf++TsitKrvwVWdECxWJHYiE/xUW
        hf4vHjUiLbZgYrlIX9YsWrjXS
X-Received: by 2002:a5d:5229:: with SMTP id i9mr33076554wra.373.1632208999651;
        Tue, 21 Sep 2021 00:23:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmKDz9cFkpPUpySnhcuXL9I6N5VzfCkNBihCb2cf/pAFc0UAmd1Q4UanO7vkIdNFwERK6qQg==
X-Received: by 2002:a5d:5229:: with SMTP id i9mr33076534wra.373.1632208999447;
        Tue, 21 Sep 2021 00:23:19 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c63b7.dip0.t-ipconnect.de. [91.12.99.183])
        by smtp.gmail.com with ESMTPSA id g205sm1956447wmg.18.2021.09.21.00.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 00:23:19 -0700 (PDT)
To:     Dave Hansen <dave.hansen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, oliver.sang@intel.com,
        mhocko@suse.com, weixugc@google.com, osalvador@suse.de,
        rientjes@google.com, dan.j.williams@intel.com, gthelen@google.com,
        yang.shi@linux.alibaba.com, akpm@linux-foundation.org
References: <20210917223504.C140445A@davehans-spike.ostc.intel.com>
 <20210917223505.F817CB6B@davehans-spike.ostc.intel.com>
 <87k0jeog7r.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <2d7e4078-f9c0-7511-0bab-de5dab25b45d@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/2] mm/migrate: optimize hotplug-time demotion order
 updates
Message-ID: <4e3d98eb-e8b9-90a8-638c-e19a5367df99@redhat.com>
Date:   Tue, 21 Sep 2021 09:23:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2d7e4078-f9c0-7511-0bab-de5dab25b45d@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.21 23:37, Dave Hansen wrote:
> On 9/17/21 5:55 PM, Huang, Ying wrote:
>>> @@ -3147,6 +3177,16 @@ static void __set_migration_target_nodes
>>>   	int node;
>>>   
>>>   	/*
>>> +	 * The "migration path" array is heavily optimized
>>> +	 * for reads.  This is the write side which incurs a
>>> +	 * very heavy synchronize_rcu().  Avoid this overhead
>>> +	 * when nothing of consequence has changed since the
>>> +	 * last write.
>>> +	 */
>>> +	if (!node_demotion_topo_changed())
>>> +		return;
>>> +
>>> +	/*
>>>   	 * Avoid any oddities like cycles that could occur
>>>   	 * from changes in the topology.  This will leave
>>>   	 * a momentary gap when migration is disabled.
>> Now synchronize_rcu() is called in disable_all_migrate_targets(), which
>> is called for MEM_GOING_OFFLINE.  Can we remove the synchronize_rcu()
>> from disable_all_migrate_targets() and call it in
>> __set_migration_target_nodes() before we update the node_demotion[]?
> 
> I see what you are saying.  This patch just targeted
> __set_migration_target_nodes() which is called in for
> MEM_ONLINE/OFFLINE.  But, it missed MEM_GOING_OFFLINE's call to
> disable_all_migrate_targets().
> 
> I think I found something better than what I had in this patch, or the
> tweak you suggested: The 'memory_notify->status_change_nid' field is
> passed to all memory hotplug notifiers and tells us whether the node is
> going online/offline.  Instead of trying to track the changes, I think
> we can simply rely on it to tell us when a node is going online/offline.
> 
> This removes the need for the demotion code to track *any* state.  I've
> attached a totally untested patch to do this.
> 

Sounds sane to me (although I really detest that status_change_nid... 
interface).

I was just about to ask "but how does this interact with !CONFIG_NUMA" 
... until I realized that having a single node go completely offline is 
rather unrealistic ;)

-- 
Thanks,

David / dhildenb

