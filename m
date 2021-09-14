Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B4D40A42D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 05:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbhINDMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 23:12:16 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19969 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbhINDMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 23:12:15 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H7pCw2k2qzbmT6;
        Tue, 14 Sep 2021 11:06:52 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 14 Sep 2021 11:10:57 +0800
Subject: Re: [PATCH v2] mm/page_isolation: fix potential missing call to
 unset_migratetype_isolate()
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
CC:     David Hildenbrand <david@redhat.com>, <vbabka@suse.cz>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210913115125.33617-1-linmiaohe@huawei.com>
 <YT9AS6I1Th14mCxh@dhcp22.suse.cz>
 <e1e772b8-b9a7-0182-c469-73f32cda005e@redhat.com>
 <6cb372ff-0b68-2143-913e-04ab3e6b4160@huawei.com>
 <YT9LPoSSTJbmF3eF@dhcp22.suse.cz>
 <20210913195113.b13142630a5401e8abacc13e@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d88a49cc-9068-bc31-9602-0545ab247cff@huawei.com>
Date:   Tue, 14 Sep 2021 11:10:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210913195113.b13142630a5401e8abacc13e@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/14 10:51, Andrew Morton wrote:
> On Mon, 13 Sep 2021 14:59:42 +0200 Michal Hocko <mhocko@suse.com> wrote:
> 
>> I do realize that the stable tree is in a hoarding mode for quite some
>> years but my general approach has been (in line with the documentation)
>> to mark and backport only fixes that really do matter.
> 
> Me2.  There has to be some risk-vs-reward test to be passed...

Will keep this in mind when I try to cc stable. Thanks.

> .
> 

