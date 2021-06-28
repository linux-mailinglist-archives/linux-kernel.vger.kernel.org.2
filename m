Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553213B5EB3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 15:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhF1NJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 09:09:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26067 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233114AbhF1NJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 09:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624885616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Wsog/UA6NQRm36wrbUHXM3ftcSt/9+OFEW6vcsabAY=;
        b=RiR40TU4jrtl9rNUACuQNyx3biuO0jOUfjOJYa6ZdFJNcIR0kwK6zXRf2i3JB2TrDYifVN
        0FV9Ko9m9P8GhPRbog+ijE+UScWmqlp/0xhj/bYB6w8PgRoJMkNhtEGDh0NoqEpJHxOz9G
        7oYHPVAH1UquSbN7FuPBdlf2OObnwZ4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-1xDeNJ_DNvCraDb0N4pDzw-1; Mon, 28 Jun 2021 09:06:53 -0400
X-MC-Unique: 1xDeNJ_DNvCraDb0N4pDzw-1
Received: by mail-qv1-f70.google.com with SMTP id y35-20020a0cb8a30000b0290270c2da88e8so17492676qvf.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 06:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3Wsog/UA6NQRm36wrbUHXM3ftcSt/9+OFEW6vcsabAY=;
        b=iazA5JC7NVpqGrU2Ja3pHUETe1WLhyQSce+OY21ZOtW/U59hRp9BepQ8ZZHzxKVZ84
         79zdvh6tzfMUpEj8ZHgK+yneGh0TvBGodUtPuzt6sVjk3+O4F6Xl6quaZYpuGXlP96tr
         0KzV2JF9m0QJXZ00IwyntMacKyjRjY1I7ysMCbAI6P1i1Xb2rNMV7q1FMegW8sPUYdXE
         Z1YPEkGRpqqmNz19ye5pbY2fLHBgW8YCVuK1dGWDWjAccpv9QpdzmnqMWRCucathlVGF
         F1uav+j5E7Kb0510HiFF0b/5eqKXE/S+PD4ZpJDBoIK0QntDsVXFEqNOStc/Iap7XWo9
         XopQ==
X-Gm-Message-State: AOAM532H2IUsYj6Va8ZBSSA9i99L/wEjSwxGUqK1jQ70PErXXySYgRbJ
        LWcPMgufel6GgCZ35t29XPt2RIyXS0NMK5Thi2RZBne69rjMcGbT64LeFJIxrbCeN6juwap3+25
        Eq1QAK4h5UYuQpm5Yi8kvFDGf
X-Received: by 2002:a37:9986:: with SMTP id b128mr25711687qke.485.1624885612616;
        Mon, 28 Jun 2021 06:06:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUlJHxYKkE1I0xN1vBM5amAltWfY9ckZGLT37Njz1aTkLclF02YuG2OEJBVFBBcLl/BywiTA==
X-Received: by 2002:a37:9986:: with SMTP id b128mr25711669qke.485.1624885612428;
        Mon, 28 Jun 2021 06:06:52 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id h128sm10222579qkc.94.2021.06.28.06.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 06:06:51 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 2/6] cgroup/cpuset: Clarify the use of invalid
 partition root
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20210621184924.27493-1-longman@redhat.com>
 <20210621184924.27493-3-longman@redhat.com>
 <YNcHOe3o//pIiByh@mtj.duckdns.org>
Message-ID: <6ea1ac38-73e1-3f78-a5d2-a4c23bcd8dd1@redhat.com>
Date:   Mon, 28 Jun 2021 09:06:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YNcHOe3o//pIiByh@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/21 6:53 AM, Tejun Heo wrote:
> Hello, Waiman.
>
> On Mon, Jun 21, 2021 at 02:49:20PM -0400, Waiman Long wrote:
>>   1) A partition root can't be changed to member if it has child partition
>>      roots.
>>   2) Removing CPUs from cpuset.cpus that causes it to become invalid is
>>      not allowed.
> I'm not a fan of this approach. No matter what we have to be able to handle
> CPU removals which are user-iniated operations anyway, so I don't see why
> we're adding a different way of handling a different set of operations. Just
> handle them the same?

The main reason for doing this is because normal cpuset control file 
actions are under the direct control of the cpuset code. So it is up to 
us to decide whether to grant it or deny it. Hotplug, on the other hand, 
is not under the control of cpuset code. It can't deny a hotplug 
operation. This is the main reason why the partition root error state 
was added in the first place.

Normally, users can set cpuset.cpus to whatever value they want even 
though they are not actually granted. However, turning on partition root 
is under more strict control. You can't turn on partition root if the 
CPUs requested cannot actually be granted. The problem with setting the 
state to just partition error is that users may not be aware that the 
partition creation operation fails.  We can't assume all users will do 
the proper error checking. I would rather let them know the operation 
fails rather than relying on them doing the proper check afterward.

Yes, I agree that it is a different philosophy than the original cpuset 
code, but I thought one reason of doing cgroup v2 is to simplify the 
interface and make it a bit more erorr-proof. Since partition root 
creation is a relatively rare operation, we can afford to make it more 
strict than the other operations.

Cheers,
Longman

