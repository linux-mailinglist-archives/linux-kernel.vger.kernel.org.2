Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88843C6E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 12:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbhGMK1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 06:27:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235143AbhGMK1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 06:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626171886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JvbuSZrGZ9Jk3BD9ASj2i3CbMWG+JLthLiSXwWolRg0=;
        b=Y9pv05D7IORlmkMwZbxd/VrP9JlMXT/qfnAcHVv1lX7C+HW9IMk7pEl+bSsu5LF7dNpH7P
        hOEkOB/lSlzRW/aFTMp6ltLiHd2+8hTgr7It6rCPPd7VqCeccozs0tDJ9FWF2GIr4lFe0u
        /6v95L6Y5QWmaiQeF5uJKZwcivAO/Zk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-A52O3RR9MnC-uspE7CGbNg-1; Tue, 13 Jul 2021 06:24:43 -0400
X-MC-Unique: A52O3RR9MnC-uspE7CGbNg-1
Received: by mail-wr1-f72.google.com with SMTP id t8-20020a05600001c8b029013e2027cf9aso4471289wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 03:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JvbuSZrGZ9Jk3BD9ASj2i3CbMWG+JLthLiSXwWolRg0=;
        b=hzeer8C1sycxPPueGDF+0ubrOi4VnHlPV2+Bk+XTl0pdG4crQ+coSLrc81k9AxFfGG
         ZUaabjV5ZKhxRWnLoGtMJR83aeA6Bes3wYyuRfqNsdNf+u0/h47olMCsCHS72yw0HLaa
         r2lH1GzxviCrQPm7V4urjmRgpGdCkdAlfK7b6ajQ0YM6mSgJksqvMIlNkOOU5JzQSsK1
         TzAiZc2Gi+yE64rfqKqRWDb5+1XHNg9+/ueyQdLgm1lJ0kDsvPx+FbK1enREmVkqj3uk
         u0SNvgUCLgyKIEwlwMlBYQAxFNvsErBn0jsSv2EKMkBRuyPm88h9+S3cBf8WtFwE7knF
         CGUw==
X-Gm-Message-State: AOAM530icaPTPP+c5TpH3ndL4ljGCGbJUbfXs79xB0BcPXWsj+bq8BJ4
        pFINj+VdfPxypoVy+2o4KnzhioqATZLpJobEbMbUqrZlVO2SrJo9EJTTzjRy8v6mNi7V7vnu4w5
        cllBtzlY1oQV+ADE4zZz8Io2z
X-Received: by 2002:adf:fac7:: with SMTP id a7mr4715904wrs.384.1626171882436;
        Tue, 13 Jul 2021 03:24:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPBC3S8XqrN/M3kx3rNVsTpnqRoze7fkOO2hnGdgl7MEbRTdlY3uI8kf1MQIEw69FaSCJplQ==
X-Received: by 2002:adf:fac7:: with SMTP id a7mr4715893wrs.384.1626171882305;
        Tue, 13 Jul 2021 03:24:42 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id t22sm15773085wmi.22.2021.07.13.03.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 03:24:41 -0700 (PDT)
Subject: Re: [PATCH 1/2] mm: remove pfn_valid_within() and
 CONFIG_HOLES_IN_ZONE
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210713080035.7464-1-rppt@kernel.org>
 <20210713080035.7464-2-rppt@kernel.org>
 <7300dfe1-0c6a-ae2e-2c48-c885248ec263@redhat.com>
 <YO1pT1bjMfldbQKg@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <4367d5e4-4f03-6d99-f19b-9d32b71f227d@redhat.com>
Date:   Tue, 13 Jul 2021 12:24:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YO1pT1bjMfldbQKg@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.07.21 12:22, Mike Rapoport wrote:
> On Tue, Jul 13, 2021 at 11:51:46AM +0200, David Hildenbrand wrote:
>> On 13.07.21 10:00, Mike Rapoport wrote:
>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>
>>> After recent changes in freeing of the unused parts of the memory map and
>>> rework of pfn_valid() in arm and arm64 there are no architectures that can
>>> have holes in the memory map within a pageblock and so nothing can enable
>>> CONFIG_HOLES_IN_ZONE which guards non trivial implementation of
>>> pfn_valid_within().
>>>
>>> With that, pfn_valid_within() is always hardwired to 1 and can be
>>> completely removed.
>>>
>>> Remove calls to pfn_valid_within() and CONFIG_HOLES_IN_ZONE.
>>>
>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>
>> There is currently the discussion to increase MAX_ORDER, for example, to
>> cover 1GiB instead of 4MiB on x86-64. This would mean that we could
>> suddenly, again, have holes insides MAX_ORDER - 1 pages.
>>
>> So I assume if we ever go down that path, we'll need something like this
>> again.
> 
> It depends whether pageblock_order will be also increased. PFN walkers rely
> on continuity of pageblocks rather than MAX_ORDER chunks, so if
> pageblock_order won't change, there won't be need to check for pfn_valid()
> inside a pageblock.

I'm pushing for letting pageblocks stay untouched, so good to know!

(we still have this crazy special case of pageblocks > MAX_ORDER - 1 
right now, which I think we should just eliminate)

-- 
Thanks,

David / dhildenb

