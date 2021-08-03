Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1403DF048
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbhHCO3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:29:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51552 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbhHCO32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:29:28 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DB6D0200DC;
        Tue,  3 Aug 2021 14:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628000956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gWrKPIOGbRT7mtmhi4hDLoxX8C67Y8PDNpZrScUS6w0=;
        b=Tim2TPOv9wguBc5UYs/2q3aNxdtCzt3xuEhZQ6YJaKgjtnLcefyBt/RgF/gyMr3w1YuRsC
        Nh6n9M/XEyY1H+pcDuDGEbY6XkcNuJLCKRCljqmtaFJl/Uz/R/p/MjjhzrZ7QJOZf5BbAV
        vnRKrRUB7BylmN7fC25l9lZyCplRvsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628000956;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gWrKPIOGbRT7mtmhi4hDLoxX8C67Y8PDNpZrScUS6w0=;
        b=96Vlx9kN67HaimN52bjyERk0X9UiBMS14sRHqKusL1x1PsoD7dH0on9OhBozpHt+8E7vvO
        uPSy2/IplePRpfCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B3C2813B74;
        Tue,  3 Aug 2021 14:29:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 1oBCK7xSCWElZwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Tue, 03 Aug 2021 14:29:16 +0000
Subject: Re: [PATCH] slub: fix unreclaimable slab stat for bulk free
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Wang Hai <wanghai38@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210728155354.3440560-1-shakeelb@google.com>
 <8c14efe2-69dc-6eab-3cd5-c042576770e7@huawei.com>
 <CALvZod6usxk99KFhQVXGxBadsYpUyQ3QuwfSDa_sbqSLjBEgnA@mail.gmail.com>
 <35a0b75a-f348-d21c-4ff4-fadba0c4db02@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <43cf4e71-4dd4-dc37-a70f-553fe5cba126@suse.cz>
Date:   Tue, 3 Aug 2021 16:29:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <35a0b75a-f348-d21c-4ff4-fadba0c4db02@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/21 4:24 PM, Kefeng Wang wrote:
> 
> On 2021/7/29 22:03, Shakeel Butt wrote:
>> On Wed, Jul 28, 2021 at 11:52 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>>
>>> On 2021/7/28 23:53, Shakeel Butt wrote:
>> I don't have a strong opinion on this. Please send a patch with
>> reasoning if you want WARN_ON_ONCE here.
> 
> Ok, we met a BUG_ON(!PageCompound(page)) in kfree() twice in lts4.4, we are
> still debugging it.
> 
> It's different to analyses due to no vmcore, and can't be reproduced.
> 
> WARN_ON() here could help us to notice the issue.
> 
> Also is there any experience or known fix/way to debug this kinds of issue?
> memory corruption?

This would typically be a use-after-free/double-free - a problem of the slab
user, not slab itself.

> Any suggestion will be appreciated, thanks.

debug_pagealloc could help to catch a use-after-free earlier

> 
>> .
>>

