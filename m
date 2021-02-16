Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE46D31CAA1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 13:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhBPMjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 07:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbhBPMjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 07:39:33 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177C3C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 04:38:53 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g3so9412601edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 04:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=rYWyFRrHFzIGgaDiLu+F+sbrD98rWH0OnsH9H9Q3MIc=;
        b=dr6Q2pOMBwUs3H3o/MaUvSXFms7CCjDCs+XTJNrWlYUIeVBvmDqKBGQukIjK/lpxxN
         7BwrmduOI3BW5xh3te0tgcXEEb50P3Fq4qql3XZokIErsf9RhIJDQIyUdf2cIrDAvIw7
         uHxvrkwKnKmpReV8XzaWWxszWSaNoQZZwv8Jj/MUTCrUjNPN2fY4gdzB0O29dOjBhNwO
         gAoKmkvCKMlZN98CknKrvj71fAIrBJk8EEPxWIi8BrkLbt+mAEJ7Uzcniv9ga5YHVia+
         8ytfpv6ll5ki/DxVQRFZp/B9olni93F5pweMveomNZOeChYj3votAzZvecKSVvPLbFYS
         Qspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rYWyFRrHFzIGgaDiLu+F+sbrD98rWH0OnsH9H9Q3MIc=;
        b=EduY5qSdX4a6CSZ3TSwAZB8a9+h39Q3wilVtvZ64EGyiAFWEudqepdIw3HKu8pXOAO
         1mM3LS4T0D297DeaHou9R05N4uD0Tt0mYhrw4bgy3BROCeVW3sBuKlu75dv94o3z0gMv
         cIX89fJtv49g20pifGxaNJb7dOvpgAOxJNubA4nFrMiTWQEV7NBnH7VIXOyGWLMSy07C
         jsb6Cdo/oEg+bKinIHGphpvvClWvrPYO+XQ+Kiiv5cpJsFbbHg3moSS8U9HrbHe9bOoX
         g0N2Kb4YuFf3Xq5OmMUqd/2URs3cmuu5wegL7nxB8+RMhpnnNMfyK9cD1LS6Kl9CXMaL
         oZxA==
X-Gm-Message-State: AOAM5325p3hOyLLsrS2s/keSclKcRiGOfA+ix2r0sBP7Mo7BqVACOHrG
        yYO0GkKhh155D/iA7Ez1HoY=
X-Google-Smtp-Source: ABdhPJwSzVo9ApDpijh+Fal1wzJ3FaDQYCrP6d9W9hk9AyK3wyjmpbSm5MxU5BgyY4Jip3UVE/o0mw==
X-Received: by 2002:a50:ef0f:: with SMTP id m15mr21420162eds.175.1613479131778;
        Tue, 16 Feb 2021 04:38:51 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:37ef:8eac:aaaa:2ece? ([2a02:908:1252:fb60:37ef:8eac:aaaa:2ece])
        by smtp.gmail.com with ESMTPSA id bo12sm13393547ejb.93.2021.02.16.04.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 04:38:51 -0800 (PST)
Subject: Re: [PATCH] mutex: nuke mutex_trylock_recursive
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        will@kernel.org, apw@canonical.com, joe@perches.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20210216082146.69286-1-christian.koenig@amd.com>
 <YCuQXAllh91JEZ+Y@phenom.ffwll.local>
 <YCuaup4u1ZE6crE0@hirez.programming.kicks-ass.net>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e8374454-4c2b-b718-a0fc-0e25662c3f44@gmail.com>
Date:   Tue, 16 Feb 2021 13:38:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YCuaup4u1ZE6crE0@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 16.02.21 um 11:13 schrieb Peter Zijlstra:
> On Tue, Feb 16, 2021 at 10:29:00AM +0100, Daniel Vetter wrote:
>> On Tue, Feb 16, 2021 at 09:21:46AM +0100, Christian König wrote:
>>> The last user went away in the 5.11 cycle.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Nice.
>>
>> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>>
>> I think would be good to still stuff this into 5.12 before someone
>> resurrects this zombie.
> Already done:
>
>    https://lkml.kernel.org/r/161296556531.23325.10473355259841906876.tip-bot2@tip-bot2

One less bad concept to worry about.

But your patch is missing to remove the checkpatch.pl check for this :)

Cheers,
Christian.
