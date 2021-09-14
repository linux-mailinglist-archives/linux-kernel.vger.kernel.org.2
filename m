Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451FB40AAD3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhINJ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:29:23 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9039 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhINJ26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:28:58 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H7yf15pmBzW1Hg;
        Tue, 14 Sep 2021 17:26:33 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 14 Sep 2021 17:27:32 +0800
Subject: Re: [PATCH v2] mm/page_isolation: fix potential missing call to
 unset_migratetype_isolate()
To:     Michal Hocko <mhocko@suse.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, <vbabka@suse.cz>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210913115125.33617-1-linmiaohe@huawei.com>
 <YT9AS6I1Th14mCxh@dhcp22.suse.cz>
 <e1e772b8-b9a7-0182-c469-73f32cda005e@redhat.com>
 <6cb372ff-0b68-2143-913e-04ab3e6b4160@huawei.com>
 <YT9LPoSSTJbmF3eF@dhcp22.suse.cz>
 <1d0e15ab-4a1f-0820-26c2-4b9949164dfa@huawei.com>
 <YUBJ3eA0a+Vk1wm4@dhcp22.suse.cz>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3a8857fd-d4f2-7743-d2e8-8580145d32e7@huawei.com>
Date:   Tue, 14 Sep 2021 17:27:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YUBJ3eA0a+Vk1wm4@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/14 15:06, Michal Hocko wrote:
> On Tue 14-09-21 11:09:47, Miaohe Lin wrote:
> [...]
>> So even the Fixes tag should be removed ?
> 
> I would keep that one there. Fixes tag is useful to frame the scope of
> the fix. For example when somebody is backporting the commit mentioned
> in the Fixes tag then a) a lot of follow up patches with Fixes can tell
> you this won't be an easy ride and you might want to reconsider risks
> vs. benefit b) it helps to collect follow up fixes more easily.
> 
> That is a different story from cc: stable which just collects patches
> and push them to all consumers of the stable branch if they apply.
> 
> To conclude, the Fixes tag is a generaly useful tag to bind patches
> together and let people evaluate how important that is while Cc stable
> is an indication that a fix is serious enough to push to all stable
> users.
> 

I see. Many thanks for your detailed explanation! :)
