Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7A4409C73
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbhIMSpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237448AbhIMSpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631558628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OKdsRWhIXlSCrgUgGa+HhaGl2OaUxiJnSQvdeXqf6UE=;
        b=JMowOCbihVtn0ivkLTaxiousPze93c+MheeHYLBcnVcbcNdsQxy6IthSE39gFuQ21tfag1
        9tQp9cakp+eZc1zgiq7nvS2+nOLtpuCLsAx18k/1xl4e44YiU36xiXEeQ3bQ3wwZbVZiK/
        LbtidOvNlhDaXEDNzlTUZBQAt6GtpfQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-9UeZixOXOt2vmJ0vAZvATw-1; Mon, 13 Sep 2021 14:43:47 -0400
X-MC-Unique: 9UeZixOXOt2vmJ0vAZvATw-1
Received: by mail-qv1-f71.google.com with SMTP id r18-20020a056214069200b0037a291a6081so57002861qvz.18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OKdsRWhIXlSCrgUgGa+HhaGl2OaUxiJnSQvdeXqf6UE=;
        b=38WSkUSF7oqJ9BrowBBikKYN0rUSIAasxWuW5F3z8ni2dOgkV5zjYWNfNqb1hU0VaS
         VRwrSJM/sRm96GBLhCRUxVZ33d0GT+4Wf7rPOazGQdaVTwVL2BGgyDO74FVWaOMxhEu9
         db/Wck4zHVeUbyXOEDfrJiAGc6j8YA0HW4+7JlOfqLlBHhclHyFji+g4xNF4eXUFinRb
         pkuj039QmUL97E1iho4B95rzPssz87nKNZDbUVVBfJgr2RVwsxdoQPcXHXM9PJLt9glv
         Uvtq+SbHKbPKF77vP4ApkIAAzKOcp2v0x+VvFptBJ9CnTIlzwS6Y6A7+EBqVlByT1dZk
         xANA==
X-Gm-Message-State: AOAM531iWHjSGlIx5x6TKlWxjOmRq0PDO9duXUs8HdQLqx7mmhF/W4nl
        EmGq4ooAv50LE7hOiJ3EyEePrXKJnmOY+9zRyOx8WD4xePyEbUYl30w470WgGd4Wc+HG981KRt2
        apye/ML0GUhx3ucoHneNwl3JWABFDriZRvo4c0t9GUuwtD9wDnif4zTtAzx+fw2cndO30yyBM
X-Received: by 2002:ac8:7cb:: with SMTP id m11mr1021603qth.72.1631558626443;
        Mon, 13 Sep 2021 11:43:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKxndgvzyGJGQ3o05LZa4ph1JAJQ0BZY7zvoNP+DJGboWxmtfsTlSOxc8Or1oGTq/fvcUUiw==
X-Received: by 2002:ac8:7cb:: with SMTP id m11mr1021583qth.72.1631558626164;
        Mon, 13 Sep 2021 11:43:46 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id g8sm5833725qkm.25.2021.09.13.11.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 11:43:45 -0700 (PDT)
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
 <125c4202-68d1-1a4e-03d6-2b18f0794ba4@redhat.com>
Message-ID: <dbb1a221-b3d2-5086-e47b-8a2c764d60ad@redhat.com>
Date:   Mon, 13 Sep 2021 14:43:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <125c4202-68d1-1a4e-03d6-2b18f0794ba4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/21 2:35 PM, Waiman Long wrote:
> On 9/13/21 2:05 PM, Tejun Heo wrote:
>> Hello,
>>
>> On Thu, Sep 09, 2021 at 10:42:55PM -0400, Waiman Long wrote:
>>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>>> index 881ce1470beb..e31bca9fcd46 100644
>>> --- a/kernel/cgroup/cgroup.c
>>> +++ b/kernel/cgroup/cgroup.c
>>> @@ -3140,7 +3140,16 @@ static void 
>>> cgroup_apply_control_disable(struct cgroup *cgrp)
>>>               if (!css)
>>>                   continue;
>>>   - WARN_ON_ONCE(percpu_ref_is_dying(&css->refcnt));
>>> +            /*
>>> +             * A kill_css() might have been called previously, but
>>> +             * the css may still linger for a while before being
>>> +             * removed. Skip it in this case.
>>> +             */
>>> +            if (percpu_ref_is_dying(&css->refcnt)) {
>>> +                WARN_ON_ONCE(css->parent &&
>>> +                    cgroup_ss_mask(dsct) & (1 << ss->id));
>>> +                continue;
>>> +            }
>> This warning did help me catch some gnarly bugs. Any chance we can 
>> keep it
>> for normal cases and elide it just for remounting?
>
> The problem with percpu_ref_is_dying() is the fact that it becomes 
> true after percpu_ref_exit() is called in css_free_rwork_fn() which 
> has an RCU delay. If you want to catch the fact that kill_css() has 
> been called, we can check the CSS_DYING flag which is set in 
> kill_css() by commit 33c35aa481786 ("cgroup: Prevent kill_css() from 
> being called more than once"). Will that be an acceptable alternative? 

Something like

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 881ce1470beb..851e54800ad8 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3140,6 +3140,9 @@ static void cgroup_apply_control_disable(struct 
cgroup *cg
                         if (!css)
                                 continue;

+                       if (css->flags & CSS_DYING)
+                               continue;
+
WARN_ON_ONCE(percpu_ref_is_dying(&css->refcnt));

                         if (css->parent &&

Cheers,
Longman

