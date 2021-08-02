Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1258B3DD424
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 12:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhHBKoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 06:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbhHBKoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 06:44:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B8EC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 03:44:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id nh14so12855268pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 03:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sUkGZKiJFUHXdJRo8lZOT7YsQ1JM5hP71TkDPnklmzo=;
        b=rp8Pgy6HQTYz7cVX+UNgdkeJCLvJ9XPoAU3yqZXgbtvgw2Y4zu74wqxijCLER5h3d1
         9IYtRJjXiSsGud5BWvLf3v7KkB5rye6N2lkoW/Pq1IvWe1ZODNYVOkkOC+/zaRsg7CJA
         Rvuuq7ExBEHMZMJomnP1lenpEg0BLIBwh1An0oV1n8JnKD66FgQpYJGTreonjYIVFTpm
         7juis0NnCL5K9sVRVF3Xypev48AHMNw4lN3RRAVkXgFsil6blxy0EHqU5wO7nrylmw39
         ew1wiL5unCFrWDfe7sDk3aeIMjuTVMks4IjWg8/x3JTbd9YTmszZshuLWfMcGC5QdqEg
         W1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sUkGZKiJFUHXdJRo8lZOT7YsQ1JM5hP71TkDPnklmzo=;
        b=A4I0FURgCDWaQ750FdMSPJd8IuEfBNVZF6MiIqpg17u4kLg+J/C+Epal0aHTue/4S3
         1EYZoWb60Tb5VxTFd+9hDC6TZ2G2h2NEG1qHrktfxA+/m2O0TwwUIH5776o7ZTsMbVN9
         N8kR4UZZ8frggIuI5u251TdoXu8JtBHOe473tVT0ZgmbI+9LPPKR1IMLgyoUz9HvRWHT
         KDh6Bvv8fWo69STNymttdBO0cANJ4BMLCdJBso2Wfm80ALqGFysIqyfCMLujkT5OeoE7
         tYvoSGgrt9X8AGXj4U81oNYgOG8vjODWeqAPd2LrLv3ILsTLEZY3H+GLrZoDqOBSgLUQ
         BsyQ==
X-Gm-Message-State: AOAM531E9xOIVpp+SUf5u6vDGh+n5qvKm2PnKoNHJ00KZ6BcD4SSffa1
        ttD9oz0ADaaQ65j8pIH6+Vg=
X-Google-Smtp-Source: ABdhPJz2ikv5xjHbyI2OQRLvHxw/dvvTn8uEDT12ePKFpN2DmxJzLaY3iw0lqtbey0zspJENCX73JQ==
X-Received: by 2002:a63:4f21:: with SMTP id d33mr553007pgb.144.1627901049822;
        Mon, 02 Aug 2021 03:44:09 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id 37sm12731593pgt.28.2021.08.02.03.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 03:44:09 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] locking/lockdep, drm: apply new lockdep assert in
 drm_auth.c
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20210731082458.1962043-1-desmondcheongzx@gmail.com>
 <YQesKIRQKYyTFyxJ@phenom.ffwll.local>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <4d871d0e-3b51-8a21-49e5-1a413bf71d4d@gmail.com>
Date:   Mon, 2 Aug 2021 18:44:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQesKIRQKYyTFyxJ@phenom.ffwll.local>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 4:26 pm, Daniel Vetter wrote:
> On Sat, Jul 31, 2021 at 04:24:56PM +0800, Desmond Cheong Zhi Xi wrote:
>> Hi,
>>
>> Following a discussion on the patch ("drm: use the lookup lock in
>> drm_is_current_master") [1], Peter Zijlstra proposed new lockdep_assert
>> helpers to make it convenient to compose lockdep checks together.
>>
>> This series includes the patch that introduces the new lockdep helpers,
>> then utilizes these helpers in drm_is_current_master_locked in the
>> following patch.
>>
>> v1 -> v2:
>> Patch 2:
>> - Updated the kerneldoc on the lock design of drm_file.master to explain
>> the use of lockdep_assert(). As suggested by Boqun Feng.
>>
>> Link: https://lore.kernel.org/lkml/20210722092929.244629-2-desmondcheongzx@gmail.com/ [1]
> 
> Can you pls also cc: this to intel-gfx so the local CI there can pick it
> up and verify? Just to check we got it all.
> -Daniel
> 

Oops my bad, I missed out the CI for this series. Will resend with the 
proper cc.

Best wishes,
Desmond

> 
>>
>> Best wishes,
>> Desmond
>>
>> Desmond Cheong Zhi Xi (1):
>>    drm: add lockdep assert to drm_is_current_master_locked
>>
>> Peter Zijlstra (1):
>>    locking/lockdep: Provide lockdep_assert{,_once}() helpers
>>
>>   drivers/gpu/drm/drm_auth.c |  6 +++---
>>   include/drm/drm_file.h     |  4 ++++
>>   include/linux/lockdep.h    | 41 +++++++++++++++++++-------------------
>>   3 files changed, 28 insertions(+), 23 deletions(-)
>>
>> -- 
>> 2.25.1
>>
> 

