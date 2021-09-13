Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49BC409C58
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345091AbhIMSgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43687 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241450AbhIMSgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631558107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5isvOFNgXlqIatGmtfTkUEKNgVy1/GCmO2C5vtiGe3M=;
        b=Q+ko2pgeWQHh2iiOUPgfH+DXQia+fIJvRzuTgMBQTO3oGX/8zjL1K2U6aKTm3YI0JQjUbG
        2WqG8QwCRKRVQi8TSph+vvAZdDw3K3+CjGJdxjOdfjXffcIU/VjW2z47yMvYELgA8VwsfQ
        Pxded/YSPX+xNV7uTbd3FrPv1BpefKo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-5WdFyACgPrmh2q2auVp8cg-1; Mon, 13 Sep 2021 14:35:06 -0400
X-MC-Unique: 5WdFyACgPrmh2q2auVp8cg-1
Received: by mail-qk1-f200.google.com with SMTP id x19-20020a05620a099300b003f64d79cbbaso41869185qkx.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5isvOFNgXlqIatGmtfTkUEKNgVy1/GCmO2C5vtiGe3M=;
        b=P36a5R3I2VgXmGD/GkdrztdGFq29VxYSz42CS61/AqEAnWKj/V/BhLwCu9+oLayoiT
         pBp8YXI/wtr3ENZ8GPSOm6+Ma0HlEWMZgdh+NdK/nwk8IXCphMS29LMXJ/zRIhLDLTeb
         UdeTi1g9Pbl2zaUfgawV00RpdTZsd0NLjeGeIOWYRbuKJavLEFR16w6CIFeQHKOB91nl
         H7zSrqcjxzo5sXUJ6EWrGXnQ1YUHc3H941CiqX1hLtA6SWvtSzmemIfQHf3zwHTUOtmY
         IPE6suc/6PcTj6/P0AN7tja+s5l7Gdi3K/MNHSvteIC0kwsU3tJqfvnjo0rypvXHH2W3
         nj/A==
X-Gm-Message-State: AOAM532C6qAPGmgGQgeB+wHy6Z91+PeNfcFHZhKpTvV+7HiWtNOYovdp
        me+ylrthYQ38AvkP+frp1r71q+shIZ9F8cAeJ/PwNsY8leKEuCmOwWmM1u1Cndejw7BgqDXe1Rn
        pyYZ2e5qkuSX6PG0aceAC8XfkYy1J3Z2PSxbzmcJV3Pu0zQbU+ZQuAQVlyAftUUSXhtR3uDlC
X-Received: by 2002:a0c:9046:: with SMTP id o64mr932413qvo.47.1631558105406;
        Mon, 13 Sep 2021 11:35:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1BG3KBsCosg0JD7e56jd8qkejQSMVo43bSnz3aaYPBYSfqDJsr5X6s1a3atd41gOJN0ooJg==
X-Received: by 2002:a0c:9046:: with SMTP id o64mr932378qvo.47.1631558105055;
        Mon, 13 Sep 2021 11:35:05 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id x27sm4623407qtm.23.2021.09.13.11.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 11:35:04 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/2] cgroup: Fix incorrect warning from
 cgroup_apply_control_disable()
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Juri Lelli <juri.lelli@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210910024256.7615-1-longman@redhat.com>
 <YT+TA6ItnF9xM3cR@slm.duckdns.org>
Message-ID: <125c4202-68d1-1a4e-03d6-2b18f0794ba4@redhat.com>
Date:   Mon, 13 Sep 2021 14:35:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YT+TA6ItnF9xM3cR@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/21 2:05 PM, Tejun Heo wrote:
> Hello,
>
> On Thu, Sep 09, 2021 at 10:42:55PM -0400, Waiman Long wrote:
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index 881ce1470beb..e31bca9fcd46 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -3140,7 +3140,16 @@ static void cgroup_apply_control_disable(struct cgroup *cgrp)
>>   			if (!css)
>>   				continue;
>>   
>> -			WARN_ON_ONCE(percpu_ref_is_dying(&css->refcnt));
>> +			/*
>> +			 * A kill_css() might have been called previously, but
>> +			 * the css may still linger for a while before being
>> +			 * removed. Skip it in this case.
>> +			 */
>> +			if (percpu_ref_is_dying(&css->refcnt)) {
>> +				WARN_ON_ONCE(css->parent &&
>> +					cgroup_ss_mask(dsct) & (1 << ss->id));
>> +				continue;
>> +			}
> This warning did help me catch some gnarly bugs. Any chance we can keep it
> for normal cases and elide it just for remounting?

The problem with percpu_ref_is_dying() is the fact that it becomes true 
after percpu_ref_exit() is called in css_free_rwork_fn() which has an 
RCU delay. If you want to catch the fact that kill_css() has been 
called, we can check the CSS_DYING flag which is set in kill_css() by 
commit 33c35aa481786 ("cgroup: Prevent kill_css() from being called more 
than once"). Will that be an acceptable alternative?

Cheers,
Longman

