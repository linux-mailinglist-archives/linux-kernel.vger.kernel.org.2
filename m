Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC993419DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 20:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbhI0STc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 14:19:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38402 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236009AbhI0STa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632766672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=guROg9SA+ZOzGxG9ucYCki57yHW/wFcgZSDoIXaT1T0=;
        b=brjePgeOMHoBP5yObSSX3JvynDBoI5P+eJSQsgYLdOmFiboDUDZ0Yyk2tnqNor8+b+cMxG
        IEPA1poXaNrUT9ThrhmtER5qPtGGErI0rZlIuVenPpLbk/DEQLLff50v053MfdCSe3w1fS
        8TVbaK3d9aT/glScS1J1PeqPtJRKimk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-D6pWbg8_Nn2vV-MG34gfcg-1; Mon, 27 Sep 2021 14:17:51 -0400
X-MC-Unique: D6pWbg8_Nn2vV-MG34gfcg-1
Received: by mail-qv1-f69.google.com with SMTP id h18-20020ad446f2000000b0037a7b48ba05so73378723qvw.19
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=guROg9SA+ZOzGxG9ucYCki57yHW/wFcgZSDoIXaT1T0=;
        b=RtQAT65C734q/2Uqkw0A2k7VV9J9TWWOsaLKTchX0ElukoF+sw+DfJOK/Uzf1ZJ+dB
         WybC/YsbiqPtiS9XGhfKXhqLXf5NDiD7oDMtsP9Y9KIDL0exUKW3IkYpmoICLjXjh+Vj
         3+0h3A2GF6DwJtA1n6kFRmC8wFKhTC77cvF5sYT9g28kmNhc9i0EwxJFIE3mt9gpU6LR
         IqrU4aJOh3TklVElDHYOV9Lai6wBSg3mRGgQbQQHjdcuJ7bjr7yRG1QPAfwaS33piR1i
         01v84CnGcNAKdXa7rrzgRhCFdGO9d2619Qp9Z/YpbYlInhIq1HadEVchYelZzkVd2tVe
         m8GA==
X-Gm-Message-State: AOAM5334brErflnmg7JehLc6+RAIJuhm3V2jnPKlUofYujBVwrMQHwX9
        1yt/VvCyoBks7oXBQNhojohCryriYVGjmgu02eC1OZy4gSdkEC9VDm8jfie3umt9z5zQYNsaOhs
        OPKl1DaVqHRHuYL/Vlf1MKmYB3dxGjyNE6TNojfblFkKfUJNZdpp77NPKFAFuSlEPcW/mmkHc
X-Received: by 2002:a05:6214:90:: with SMTP id n16mr108547qvr.1.1632766670221;
        Mon, 27 Sep 2021 11:17:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAcErAypAcTzFVeS75W29mvSJ9LfPG6V9q4fM4qN+yoKzgG7YGOwIop7dwyINrHTQQV+zNVA==
X-Received: by 2002:a05:6214:90:: with SMTP id n16mr108513qvr.1.1632766669896;
        Mon, 27 Sep 2021 11:17:49 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id j184sm13396850qkd.74.2021.09.27.11.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 11:17:49 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] cgroup/debug: Fix lockdep splat with "%pK" format
 specifier
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210927025807.26918-1-longman@redhat.com>
 <YVH0uKGGmRjrIlFy@slm.duckdns.org>
Message-ID: <4f4f5a8c-7488-5ea6-0f1b-6ac95c259b4a@redhat.com>
Date:   Mon, 27 Sep 2021 14:17:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVH0uKGGmRjrIlFy@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/21 12:43 PM, Tejun Heo wrote:
> Hello,
>
> On Sun, Sep 26, 2021 at 10:58:07PM -0400, Waiman Long wrote:
>> The lockdep splat is caused by the fact that the debug controller use the
>> "%pK" format specifier to print out address of cset's with css_set_lock
>> held. Under some circumstances, the use of "%pK" format specifier may
>> acquire the selinux_ss.policy_rwlock.
>>
>> To avoid this possible deadlock scenario, we have to abandon the use of
>> the "%pK" format specifier and just use "%p" to always hash the cset
>> addresses. The actual cset addresses aren't that important as long as
>> they are unique for matching purpose.
> Isn't the right thing to do here making the selinux rwlock an irqsafe one?
> It's a bit crazy to have printf specifier to have restrictive locking
> requirements.

I just realize that upstream had get rid of the policy_rwlock since 
v5.10 and use RCU instead. So this patch isn't applicable then.

My original thought was that policy_rwlock were referenced over 60 times 
in security/selinux/ss/services.c whereas we only use a few %pK format 
specifier in the debug controller. Anyway, it is moot now.

Sorry for the noise.

Cheers,
Longman


