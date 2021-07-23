Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C5C3D38F2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 12:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhGWKPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 06:15:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42529 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230372AbhGWKPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 06:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627037782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sJzoSvahRJ9+rJQNZV3D9cpQaKJq1s/ffcXYuLzuIZk=;
        b=E76a09qq6TY2JkefgUOzn1aOeja4i+e6uHEAQbrerXxBspPc0wVaBZP2rGmQlaxq2soruq
        05R35oqy7VRJkctzWb+WDCsP+BSWo7/uINZA1iw7MyXPd2Mr649ANh8V0OPJ0uAxtT2Nsf
        axegCYBDQCczTGW4nh8m+hSrD9jwdYc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-Cs5o-ZAiNeOZeIPrlMZXfg-1; Fri, 23 Jul 2021 06:56:21 -0400
X-MC-Unique: Cs5o-ZAiNeOZeIPrlMZXfg-1
Received: by mail-ed1-f70.google.com with SMTP id w17-20020a50fa910000b02903a66550f6f4so501114edr.21
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 03:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sJzoSvahRJ9+rJQNZV3D9cpQaKJq1s/ffcXYuLzuIZk=;
        b=OQgV3IAOnv9cYJh+McGyh1sQpVzAmy4CU//8D3Nk9vU/pKAhBGm19XvVUI4LxU5KlE
         JoLVg7lxSwpD8SowVDPoMIy+WVkPHKj4gddF4Xca1+/voL6jOzKQdiOhtzkDWk7RVtsV
         2j5vNf927I3UbgivWUl7uo/jCrbs/u7QhYP0J7pyS6SPROeHQ6MoiMUIgNzQ8jrmQZdi
         QYebwQPxaWjhKx5Vs6/l9F+kicdwXfYMHGXAiHYqb+/iz+hwW0CZHEfrBfSWybEw/NwL
         5CoDK4MLFmG2EwAbxLSCzQ0WQ1nZQdoiNnvJRiQsbHAF9S7wBz+1XpCnDh5eThdhz0Qt
         VNiw==
X-Gm-Message-State: AOAM533z+7JFhtUFAJhRDv/HHyR6wfLRQwuhkHDAMAueCkCqKd0Vxzsh
        8Z/YuwhoDSsyFJ0kI+8/LZ4LRissHDzWABvYFd9G4jBvstQXru2BehN64yfBzBitdJCnW6ularI
        F/4prDZM2g9KuzD6OWubncqE1
X-Received: by 2002:a17:907:f98:: with SMTP id kb24mr3965385ejc.554.1627037780194;
        Fri, 23 Jul 2021 03:56:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyX3+gu++3vSDW815wa55NOnY7cIAYhWyeDYffoMGfRNHivlcrLx6i0ZhGo4wRJUAYjhtHmMw==
X-Received: by 2002:a17:907:f98:: with SMTP id kb24mr3965372ejc.554.1627037779975;
        Fri, 23 Jul 2021 03:56:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id t15sm10394010ejf.119.2021.07.23.03.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 03:56:19 -0700 (PDT)
To:     Hillf Danton <hdanton@sina.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <20210715102249.2205-1-hdanton@sina.com>
 <20210716020611.2288-1-hdanton@sina.com>
 <20210716075539.2376-1-hdanton@sina.com>
 <20210716093725.2438-1-hdanton@sina.com>
 <20210718124219.1521-1-hdanton@sina.com>
 <20210721070452.1008-1-hdanton@sina.com>
 <20210721101119.1103-1-hdanton@sina.com>
 <20210723022356.1301-1-hdanton@sina.com>
 <20210723094830.1375-1-hdanton@sina.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
Message-ID: <41e2046f-ebbb-9fb2-3b30-1d6edceaaced@redhat.com>
Date:   Fri, 23 Jul 2021 12:56:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723094830.1375-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/21 11:48, Hillf Danton wrote:
> On Fri, 23 Jul 2021 09:59:55 +0200  Paolo Bonzini wrote:
>> First and foremost, I'm not sure what you are trying to fix.
> 
> The change proposed builds the return value without assuming that the
> event count is stable across poll_wait(). If it is unstable then we know
> there are concurrent reader and/or writer who both are ingnored currently.

Concurrent reads or writes have their own wake_up_locked_poll calls. 
Why are they not enough?

>> Second, the patch is wrong even without taking into account the lockless
>> accesses, because the condition for returning EPOLLOUT is certainly wrong.
> 
> Given it is detected that event count was consumed, there is room, though
> as racy as it is, in the event count for writer to make some progress.

For one, you do not return EPOLLIN|EPOLLOUT correctly.

>> Third, barriers very rarely speak for themselves.  In particular what
>> do they pair with?
> 
> There is no need to consider pair frankly. Barriers are just readded for
> removing the seep in the comment. Then the comment goes with the seep.

Then you would need an smp_mb() to order a spin_unlock() against a 
READ_ONCE().  But adding memory barriers randomly is the worst way to 
write a lockless algorithm that you can explain to others, and "there is 
no need to consider pair frankly" all but convinces me that you've put 
enough thought in the change you're proposing.

(Shameless plug: https://lwn.net/Articles/844224/).

> What the comment does not cover is the cases of more-than-two-party race.

But, you still haven't explained what's the bug there.

Paolo

