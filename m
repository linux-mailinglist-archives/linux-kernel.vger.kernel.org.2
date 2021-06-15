Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD8B3A7471
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhFOC4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:56:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229649AbhFOC4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623725638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QdYxDbQWiJKAKMyRdXqAnaZNwtk+EcbNLD508mdqaII=;
        b=SnRF/3WapR3gHUhk/TYsu52nKeEZgnGutfGZsSrfuGKIgJgA2HJ17okApRwUsIPxBHzu9i
        WrFYbkIQIfWhQJjV1vlbdEzSbi9GrH0JOdz8j3uwDptla0OwQnvKN1JvXffW3B7xS7zh3z
        z+3zGtN5X0UgTuvwmsCMeOrVM5uiAL0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-yG5WAwQfPSCjVA1vtIzj8g-1; Mon, 14 Jun 2021 22:53:57 -0400
X-MC-Unique: yG5WAwQfPSCjVA1vtIzj8g-1
Received: by mail-qt1-f198.google.com with SMTP id m18-20020a05622a1192b0290247a89f63bcso8652047qtk.20
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QdYxDbQWiJKAKMyRdXqAnaZNwtk+EcbNLD508mdqaII=;
        b=E0rwRYRpTKYbV+L+Hjeityoo8RIlhFiLvCGQOTT5DFSW9/HuY+2jZWPo/mvxn3z2Sg
         er3Hc0YMHuWmvUp6GLHTR95SQSUpfvg06bU9lWXLORfTnkvmutOD6oiWMRTJDQjme59F
         FK0lhvsDXp2B+KdmaWPo4quD9P9uqGYOo3omQzs3t/VGC1LI6qsgpTgn/ZJl2v6lvYUJ
         QCrRjMWtRa1as9zKFR9W3yeefEoiDORqibsZtjCGcAUkWKIjOJ1DVT1pnwVXa9UR7mNe
         V48zGAema9k9HrJJFxkY2/NzXRI+7MHkJOIyxbK6RXmnziVFH2v1qHp3EK0SZoE1bLkG
         VzJg==
X-Gm-Message-State: AOAM532OQjOCI/3rv7WunTr5D3iRHKyTB5onkfKE7/zaB+UAI6hzrbje
        uuEYJXfF4IpGI6uiVjkO/Y1PUvMHcZL2X3+neSCzGSl8TzxoBQxMx6eURCNrtap3EvloT0Zi1ai
        yd0MyW+2HEaw6ON06gtyB80GA
X-Received: by 2002:a05:6214:d8e:: with SMTP id e14mr2632190qve.15.1623725636537;
        Mon, 14 Jun 2021 19:53:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR4D5lIHl7MJuKgEWLvfkxmSWyUHGOXkAt4S7/aewovmlU2fF1+6INdneT3NVj66tHWWQPJA==
X-Received: by 2002:a05:6214:d8e:: with SMTP id e14mr2632175qve.15.1623725636385;
        Mon, 14 Jun 2021 19:53:56 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id b10sm11457721qkh.45.2021.06.14.19.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 19:53:55 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 0/4] cgroup/cpuset: Allow cpuset to bound displayed cpu
 info
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, x86@kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210614152306.25668-1-longman@redhat.com>
 <YMe/cGV4JPbzFRk0@slm.duckdns.org>
Message-ID: <0e21f16d-d91b-7cec-d832-4c401a713b10@redhat.com>
Date:   Mon, 14 Jun 2021 22:53:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YMe/cGV4JPbzFRk0@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/21 4:43 PM, Tejun Heo wrote:
> Hello,
>
> On Mon, Jun 14, 2021 at 11:23:02AM -0400, Waiman Long wrote:
>> The current container management system is able to create the illusion
>> that applications running within a container have limited resources and
>> devices available for their use. However, one thing that is hard to hide
>> is the number of CPUs available in the system. In fact, the container
>> developers are asking for the kernel to provide such capability.
>>
>> There are two places where cpu information are available for the
>> applications to see - /proc/cpuinfo and /sys/devices/system/cpu sysfs
>> directory.
>>
>> This patchset introduces a new sysctl parameter cpuset_bound_cpuinfo
>> which, when set, will limit the amount of information disclosed by
>> /proc/cpuinfo and /sys/devices/system/cpu.
> The goal of cgroup has never been masquerading system information so that
> applications can pretend that they own the whole system and the proposed
> solution requires application changes anyway. The information being provided
> is useful but please do so within the usual cgroup interface - e.g.
> cpuset.stat. The applications (or libraries) that want to determine its
> confined CPU availability can locate the file through /proc/self/cgroup.

Thanks for your comment. I understand your point making change via 
cgroup interface files. However, this is not what the customers are 
asking for. They are using tools that look at /proc/cpuinfo and the 
sysfs files. It is a much bigger effort to make all those tools look at 
a new cgroup file interface instead. It can be more efficiently done at 
the kernel level.

Anyway, I am OK if the consensus is that it is not a kernel problem and 
have to be handled in userspace.

BTW, do you have any comment on another cpuset patch that I sent a week 
earlier?

https://lore.kernel.org/lkml/20210603212416.25934-1-longman@redhat.com/

I am looking forward for your feedback.

Cheers,
Longman

