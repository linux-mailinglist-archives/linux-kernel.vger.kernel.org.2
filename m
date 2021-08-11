Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8453E9786
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhHKSTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44779 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230189AbhHKSTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628705948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANzdLIOaIJbxnr8pVh5jQkoQ6kMweZt9tE4el1kTVKE=;
        b=Bz/Go6X0ygVjsyOErv3mQMjBt0xevFutupCoiTowmt3wlFRFFeVGEx/hELvR8hCS1XuTGv
        Goon8oRvFKb4laJZXCbr18qUYzbiYt7e5pxjkfycX0edbVYrHMchbOZiMCKuqJISpTZSe4
        J905Ip3gyZlMkoYakXj24FLeB5x0X20=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-Yw_8MSOnOSWlR0qDvPIMmA-1; Wed, 11 Aug 2021 14:19:07 -0400
X-MC-Unique: Yw_8MSOnOSWlR0qDvPIMmA-1
Received: by mail-qv1-f72.google.com with SMTP id u6-20020ad448660000b02903500bf28866so1744739qvy.23
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 11:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ANzdLIOaIJbxnr8pVh5jQkoQ6kMweZt9tE4el1kTVKE=;
        b=WkzxCIyMgKrIFi0zRz+/kPlZhw3cH3VthwN3DK4fI3hXrLcONogFOJABv7GtWedIwx
         cbtGFUd7VaXKX8RcZmj10FzmI7uxp/ucYo5rif7akRTKKLOZeEA/wGH/VF/vVuYBr1MB
         VxsSNJ+uZovWnet9zgiGjArXGOLwl/W/rTo/t1mcGKk6bUVMmW9BLlF3kfiwBJDD63KZ
         nyNdhTdjl3Zz48nr56s67XnrN86T3wRp8py4sTGbb0wRF4EmjnL2R/Y0zANk99LUzyEl
         tl+L748SKag+vmlRHzFJE/cjshfbPFBig9xQWW6yNPGuZEXVbGp9O+o+FV9JEfnTNzHv
         actg==
X-Gm-Message-State: AOAM531GjzZUGMWjSwe4GWKe60iWBuCOHYgJBG8C/zsqZc+gpjxMyul+
        5MUiYAImQkMhbphPYIKCcQysq68EFiMkW5odI+VJNZ8YtRJ+sa2QYkKIdB2nFGjPkHRx5MvTkiT
        MnrSJ3csxCmuhwh3Mq2m+hMSH
X-Received: by 2002:a05:620a:b4f:: with SMTP id x15mr326534qkg.436.1628705946986;
        Wed, 11 Aug 2021 11:19:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyItQRa+ugH8/MfKjbw8BhyNTooZz1XicdSsFFEontpDk1YQ4tO1FOw+vSvhWCsxBi7gnVOSQ==
X-Received: by 2002:a05:620a:b4f:: with SMTP id x15mr326513qkg.436.1628705946825;
        Wed, 11 Aug 2021 11:19:06 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id m197sm13035877qke.54.2021.08.11.11.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 11:19:06 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
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
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20210811030607.13824-1-longman@redhat.com>
 <20210811030607.13824-6-longman@redhat.com>
 <YRQTy7eo5jOlHTc6@slm.duckdns.org>
Message-ID: <26180e1d-1fa9-f175-66f8-297cf0685a11@redhat.com>
Date:   Wed, 11 Aug 2021 14:19:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRQTy7eo5jOlHTc6@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 2:15 PM, Tejun Heo wrote:
> Hello,
>
> On Tue, Aug 10, 2021 at 11:06:06PM -0400, Waiman Long wrote:
>> +	Poll and inotify events are triggered whenever the state
>> +	of "cpuset.cpus.partition" changes.  That includes changes
>> +	caused by write to "cpuset.cpus.partition" and cpu hotplug.
>> +	This will allow a user space agent to monitor changes caused
>> +	by hotplug events.
> It might be useful to emphasize that this is the primary mechanism to
> signify errors and thus should always be monitored.

Sure, will do that in the next version.

Cheers,
Longman

