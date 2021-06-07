Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F5539E778
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhFGT14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:27:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230261AbhFGT14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623093963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eU90PvjGBQF8BuOqGnUoWfXY1UtDhke3fFrOYzGsR24=;
        b=Uaey4sIntv9EBgyJBlHSdaoLU9rIbwpXSpDxMLyWGeEZXzM1VE+hbO+VnwKm1oVcot3J+1
        kxTgS5g9k11aWzU/7P+MenoiPIK4ZFmv9bqubR7pjAbKVu0xWNM/e8ki3852FpILkdVXPB
        cm0rlQQoy17udu+hRq0ea5apNLZXhGA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-ZCaxDGdmMDia8Ztd5FccRw-1; Mon, 07 Jun 2021 15:26:02 -0400
X-MC-Unique: ZCaxDGdmMDia8Ztd5FccRw-1
Received: by mail-qk1-f200.google.com with SMTP id h4-20020a05620a2444b02903aacdbd70b7so1636441qkn.23
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 12:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eU90PvjGBQF8BuOqGnUoWfXY1UtDhke3fFrOYzGsR24=;
        b=m4JnBA6f7vbN6/zDVIXkM1qijJkffWercaHx3jzFFartDHt4pukkYGGr5ZVQy9YiPn
         I7pNGN6MWoQY6Upyts7NNXPx7VIgu6S1z78pKZV8YcK6R02E/MsDtsf0SwNZEQ8X60dx
         PvRBAokvfov5ZsmKhTUh5WSvuWzPbZTYHCq3KNsT3tAkd3I+vJaFXOHB49wI7nhdtfhD
         0EiXhHsKuzlg2YWV7knXoZHgBsO8L0tqzP8qvAlkWICvR6W1oLHVC41OiyI/jYS35vDb
         tRwY1Yv443gGz4L22KEZnyO7fs35Jh8XTqWbMKdTvXCqfcsUXInk/1gtaIv+h+tYs90h
         6V3g==
X-Gm-Message-State: AOAM532F6gCi+T1P4gFZvJz2OiwCnZ0c/ne6fvBPpLzsp0m/FzOcKtc0
        dl0oYlgROLx+Sg2S8EMuwFZtMHgM1zFolWyNE8Nwm8tx1uaXsZdch9BX+DmPx143ZxESuleWqDA
        EL09k6cf/KkZpI8lPQkp+QS5EHmWA43MgdhgodYyTTYN0espeygBTxYLi//ZTjoGBGqccEGyg
X-Received: by 2002:a05:620a:15d3:: with SMTP id o19mr5786820qkm.481.1623093961625;
        Mon, 07 Jun 2021 12:26:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZi83q/sfX/8gA49Zy7oHLgVwWIdpsRKcJNIFrvESkm2O0Nqb/vZ6pfIfSPT43Ij103Tf4xQ==
X-Received: by 2002:a05:620a:15d3:: with SMTP id o19mr5786784qkm.481.1623093961324;
        Mon, 07 Jun 2021 12:26:01 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id h2sm10828007qkf.106.2021.06.07.12.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 12:26:00 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
To:     Michal Hocko <mhocko@suse.com>, Aaron Tomlin <atomlin@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        llong@redhat.com, linux-kernel@vger.kernel.org
References: <20210607163103.632681-1-atomlin@redhat.com>
 <YL5tBQ3utMzUkHF3@dhcp22.suse.cz>
Message-ID: <8a6b57d1-b8dd-bf67-92c8-0421623f54ea@redhat.com>
Date:   Mon, 7 Jun 2021 15:26:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YL5tBQ3utMzUkHF3@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/21 3:01 PM, Michal Hocko wrote:
> On Mon 07-06-21 17:31:03, Aaron Tomlin wrote:
>> At the present time, in the context of memcg OOM, even when
>> sysctl_oom_kill_allocating_task is enabled/or set, the "allocating"
>> task cannot be selected, as a target for the OOM killer.
>>
>> This patch removes the restriction entirely.
> This is a global oom policy not a memcg specific one so a historical
> behavior would change. So I do not think we can change that. The policy
> can be implemented on the memcg level but this would require a much more
> detailed explanation of the usecase and the semantic (e.g. wrt.
> hierarchical behavior etc).

Maybe we can extend the meaning of oom_kill_allocating_task such that 
memcg OOM killing of allocating task is only enabled when bit 1 is set. 
So if an existing application just set oom_kill_allocating_task to 1, it 
will not be impacted.

Cheers,
Longman

