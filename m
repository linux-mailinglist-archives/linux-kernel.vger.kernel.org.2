Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470483E85FE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 00:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbhHJWRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 18:17:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42895 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234315AbhHJWQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 18:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628633797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VrRk7NCVii511LC/4CvFm5xJa8XwB6LLB3JAlYEY82g=;
        b=YBaL/mT1pO6EiTuk3WUAeESt+q56Pl6tOaSVdP9HK3a1zBiUE3p1LRinE5siSNxCOR94QW
        QiOqeB3QcwRzxJV+PJLY5KGbMxR7OH3AttfwgkRkYp9XY/+3th1ISW/JNqP3mEk8Q78VlZ
        Gg9P+p7J5V6Ke519BkBGNyk3pyCFtzA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-J9M-h3Y8OOuz_XeRY8ghrQ-1; Tue, 10 Aug 2021 18:16:36 -0400
X-MC-Unique: J9M-h3Y8OOuz_XeRY8ghrQ-1
Received: by mail-qk1-f197.google.com with SMTP id o6-20020a05620a0546b02903d22e7d9864so49320qko.16
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 15:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VrRk7NCVii511LC/4CvFm5xJa8XwB6LLB3JAlYEY82g=;
        b=cUeZnWpCAVHZZXTqZCcKDrLiWJgB5Gyn5ZihkRlP24b00TExLUKvXNkMc/XhT9pF9Q
         ytqHKAVOEgFbyukhq7S5cZvUf4RaPZlwVtc6tzULeYt3NdwyHunralRQgCgjV/tx3aRf
         t8hhNA0zxR0j/gRbfmvlZWBQr1LpGHY6BfeJwVTK8XjCDC8sWGaOp8d5tS9GkF7Gz+H0
         yJ9AFoyYabyVYFM/i3+BTflBcatecYrY4Ak+8yep8c23lSaUIS5HVVug1598T2MRnseW
         jehxtWamFwAwC8dTERFXXBRe9LYQcfNtgDA4Lx1RJ+v5DvtWvsmUbcwM8ZqV0yIxiuXu
         VTdg==
X-Gm-Message-State: AOAM532YprNmaJeG3l5sVbu46RHGDA1reQ17l4vCohbppufjTgIIH5pb
        ZZ5H/EeqAUXcJSpgXPWgxej3cYWos9LRzN7w0lB0BdMeygHYqRn2HXFCnPPosLmn0rIjoDbtTGz
        NcCaiLeFZvwsrdV9qXoDPKEag
X-Received: by 2002:a05:620a:c04:: with SMTP id l4mr30231781qki.86.1628633795647;
        Tue, 10 Aug 2021 15:16:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8xd1Ugstiha5cp1gVzbEgYKr80s3xO9Xb9Zbynmxdxx5oVp5ZEnUtzXZQKhLUK3hpzjvifw==
X-Received: by 2002:a05:620a:c04:: with SMTP id l4mr30231759qki.86.1628633795444;
        Tue, 10 Aug 2021 15:16:35 -0700 (PDT)
Received: from ?IPv6:2601:184:4180:af10::540e? ([2601:184:4180:af10::540e])
        by smtp.gmail.com with ESMTPSA id l145sm1619955qke.92.2021.08.10.15.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 15:16:35 -0700 (PDT)
Subject: Re: [PATCH v3] vm_swappiness=0 should still try to avoid swapping
 anon memory
To:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <llong@redhat.com>, Michal Hocko <mhocko@suse.com>,
        hakavlad@inbox.lv
References: <20210809223740.59009-1-npache@redhat.com>
 <YRKa0yzEDALtvSZO@cmpxchg.org>
 <a7afc485-9036-8f09-e582-f2eb45620670@redhat.com>
 <CALvZod5L+cyON5qRX3eSdHbo+-H7VDQeFuYYNqpK5diCcv9OMw@mail.gmail.com>
From:   Nico Pache <npache@redhat.com>
Message-ID: <cbdbeae9-010e-ca11-eeab-44fa7d78c83a@redhat.com>
Date:   Tue, 10 Aug 2021 18:16:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CALvZod5L+cyON5qRX3eSdHbo+-H7VDQeFuYYNqpK5diCcv9OMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/21 5:17 PM, Shakeel Butt wrote:
> On Tue, Aug 10, 2021 at 12:24 PM Nico Pache <npache@redhat.com> wrote:
>>
>>
> [...]
>>>
>>> I'm wondering how you're getting anon scans with swappiness=0. If you
>>> look at get_scan_count(), SCAN_FRACT with swappines=0 should always
>>> result in ap = fraction[0] = 0, which never yields any anon scan
>>> targets. So I'm thinking you're running into sc->file_is_tiny
>>> situations, meaning remaining file pages alone are not enough to
>>> restore watermarks anymore. Is that possible?
>>
>> Yes DEACTIVATE_ANON is enabling the file_is_tiny case in shrink_node(). That is what im trying to prevent in the swappiness=0 case.
>>
> 
> Can you please explain how DEACTIVATE_ANON is enabling the file_is_tiny case?


You're right. Just did a second pass... I misinterpreted the assignment to
file_is_tiny. This is not the case that is causing the issue. So back to the
SCAN_FRACT case. From my testing the refaulting still seems to be causing the
issue; however, to your point in earlier discussions, if swappiness=0 then the
get_scan_count *should* be 0.
So my patch does solve the issue by preventing the shrink_list from deactivating
the anon, but it may be hiding some other issue that is the ultimate cause.

Thanks for pointing that out!
-- Nico

