Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1F534097C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 17:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhCRQAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 12:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhCRQAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:00:19 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891E1C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 09:00:19 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id c17so5335867ilj.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 09:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wUijfwg+uIfKfZvAaaXdkGTXi/eEZcihpR4YJOsQcao=;
        b=x4gGUgw/3leBjfQHr9OOg+OpXui02/U/2GUZyNPrOGO0bY2mPIcrTwKHXxWy9qZ4EM
         7tvKJoaDcaSG9p354Dma+Y4AEo8dHqedWnCovZGA9AcGBEzqN1WJImRhBoawGR0IWW7w
         uHHXneMsob/NSsiZjL1y4DtteY0j8oseFc2oEsyAuvIEdazYmMNQyS+DEX6e5v6xED9l
         qW63lH5JdKzrpPTBfitQt28mJ+iazG3qO+Qrqn4n86reF2TRsB5gSf3r8QoJEZYF5etR
         TjWV3pyO9o+TCsXcMIGXdrMgtnxKLFg17mpOFDiOwR2qzDnqT235xki7H3U4Mj9MZnB7
         DR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wUijfwg+uIfKfZvAaaXdkGTXi/eEZcihpR4YJOsQcao=;
        b=H8IbHuNd0CPhPuwqlZYzAwikTUbhmDMYK/uoIjC/pzO78kkbsffag1nlbVK2b691+E
         ebDtzeMCEXOp3XIcSNTpiSFNG1gdPN0viz8lY5B58AbeAceHL5bNuf8/2XB6CtxIqEM4
         1QpR2hHTE+EaSyHwN/ojOtaOVODXkxH7eUZrFI4Ah68xLW2BJvW5UeXwgIGTy8tha0cP
         ry5gN+OwflbpXAAZBvFgNv5InDGXwJw5cx6xfNxJuw08t8rmZKxhgOtHl1JrKvsj9xg5
         4cQuNQG3Z5iQkD7SNUL5UB2fNfsfobPKet1UZ0YBKIZTlFROle5ux0G69hRtINJ2YVTh
         P+oA==
X-Gm-Message-State: AOAM5306N8UJCDrUahSJS24cxurldQxmbnXkabCZhfyygitMz6YgqdRM
        slG8CQXGTLZfODjmOmGlVZrUug==
X-Google-Smtp-Source: ABdhPJxlHExmFB6rIshjX3M+428ad5PJKaQtEKKzbesPb669+u9AuEgwT7KfkFuTEC8MiGGHQRN92A==
X-Received: by 2002:a92:4b0b:: with SMTP id m11mr3097091ilg.156.1616083218822;
        Thu, 18 Mar 2021 09:00:18 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f15sm1292869ilj.24.2021.03.18.09.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 09:00:18 -0700 (PDT)
Subject: Re: [PATCH v10 0/3] Charge loop device i/o to issuing cgroup
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
References: <20210316153655.500806-1-schatzberg.dan@gmail.com>
 <7ca79335-026f-2511-2b58-0e9f32caa063@kernel.dk>
 <CALvZod6tvrZ_sj=BnM4baQepexwvOPREx3qe5ZJrmqftrqwBEA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8c32421c-4bd8-ec46-f1d0-25996956f4da@kernel.dk>
Date:   Thu, 18 Mar 2021 10:00:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALvZod6tvrZ_sj=BnM4baQepexwvOPREx3qe5ZJrmqftrqwBEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/21 9:53 AM, Shakeel Butt wrote:
> On Wed, Mar 17, 2021 at 3:30 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 3/16/21 9:36 AM, Dan Schatzberg wrote:
>>> No major changes, just rebasing and resubmitting
>>
>> Applied for 5.13, thanks.
>>
> 
> I have requested a couple of changes in the patch series. Can this
> applied series still be changed or new patches are required?

I have nothing sitting on top of it for now, so as far as I'm concerned
we can apply a new series instead. Then we can also fold in that fix
from Colin that he posted this morning...

-- 
Jens Axboe

