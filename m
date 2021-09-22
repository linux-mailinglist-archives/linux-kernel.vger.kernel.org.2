Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FD041415F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 07:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhIVFzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 01:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbhIVFzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 01:55:17 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6C8C061575
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 22:53:47 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 17so1542476pgp.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 22:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=U6KVi1cZOA3tVJVuR4dHF2fGXFULYok1hSIcSWvXcEs=;
        b=q1AvDwzuIpcrPBYGBvBpwRkws3Hv7Xa2VpfVLpO23tW5dXLPZGLWwvNyZUBeewKkEF
         xgBQUElKnUgG654Yc4sBhOrISTsDkyOZYMMNA/H+k7DWMkHmg4lVsXDVw8j3gt4kitiQ
         oTJss3GmCPvmLvSg9lf+SDmN4Z2p7sZrEJ0Y3KnytTvGwVL0i0pMz+1NrQAriUpgwSm6
         7NINTo7Vju8MeO3Xc17zCWLIdcCLrlGFGfAvFySa50lSiOcW4cMgd5NxOmqZwm6hYinr
         BUAobm8hTwZfj7VdwCy81i5m4RvyN59MIzAXhXQ/g1HJw1g+i4VW9c63e/3baxiENb20
         /PuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=U6KVi1cZOA3tVJVuR4dHF2fGXFULYok1hSIcSWvXcEs=;
        b=Qxe4PlpByiddgCw2bHBOpMwlp6F1peKGVyrHK5JAzlplOBmvIbkfTFZQxMDq0Zq+Jn
         gjW6UkJsHIC7z/PgQ12tY3djo8VvNKvVWKASpXe0ewQNB94114ZdGSFTZvLe4sov89N7
         hINk+BIqi49wsPXBQTiPS81Dag+lfoDHBOE/sQNxXxEmKhKdykwpyAY6drBPGWhQJEG2
         nJBBMgEeNUMZ5cBM60Xbg30T6xh540uZH0ByxMISvoVihMO6LVcABTVG8biBp7E+Cj6s
         0EPeOModJwEiCVlQy7L8C8lUN+Fpwp2JgwNTPDeN6IZhXhJxxnc3Q1J4laQYfC+gB4j2
         Y45w==
X-Gm-Message-State: AOAM531JK5H5KrS9V/I/MjVsO9IX0d8QWbW/ZfU1bO03WKBcw26DujH0
        K7F9wlheL6Z1KInNpfTFamk=
X-Google-Smtp-Source: ABdhPJxkCPEwR+pM7apHrMCAovASIHlrsmG2b3QpsqrMiOYU7BqRuuRBZfq67/CB8rvJbUaqmMnoBQ==
X-Received: by 2002:a63:df05:: with SMTP id u5mr30825449pgg.323.1632290027122;
        Tue, 21 Sep 2021 22:53:47 -0700 (PDT)
Received: from [192.168.30.21] ([173.248.225.217])
        by smtp.gmail.com with ESMTPSA id q1sm896036pjq.5.2021.09.21.22.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 22:53:46 -0700 (PDT)
Subject: Re: [PATCH 1/1] mm/migrate: de-duplicate migrate_reason strings
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     akpm@linux-foundation.org, almasrymina@google.com,
        dave.hansen@linux.intel.com, khandual@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        minchan@kernel.org, osalvador@suse.de, pasha.tatashin@soleen.com,
        weixugc@google.com, willy@infradead.org,
        yang.shi@linux.alibaba.com, ying.huang@intel.com, ziy@nvidia.com
References: <20210922041755.141817-1-jhubbard@nvidia.com>
 <20210922041755.141817-2-jhubbard@nvidia.com>
From:   Weizhao Ouyang <o451686892@gmail.com>
Message-ID: <90e7cefd-5ca0-f284-8c96-743e0f5ef8f4@gmail.com>
Date:   Wed, 22 Sep 2021 13:53:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210922041755.141817-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/9/22 12:17, John Hubbard wrote:
> In order to remove the need to manually keep three different files in
> synch, provide a common definition of the mapping between enum
> migrate_reason, and the associated strings for each enum item.
>
> 1. Use the tracing system's mapping of enums to strings, by redefining
> and reusing the MIGRATE_REASON and supporting macros, and using that to
> populate the string array in mm/debug.c.
>
> 2. Move enum migrate_reason to migrate_mode.h. This is not strictly
> necessary for this patch, but migrate mode and migrate reason go
> together, so this will slightly clarify things.
>
> Cc: Weizhao Ouyang <o451686892@gmail.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/migrate.h      | 19 +------------------
>  include/linux/migrate_mode.h | 13 +++++++++++++
>  mm/debug.c                   | 20 +++++++++++---------
>  3 files changed, 25 insertions(+), 27 deletions(-)

LGTM.
And, maybe rename the migrate_mode.h?

Reviewed-by: Weizhao Ouyang <o451686892@gmail.com>

Thanks,
Weizhao
