Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DF533C15C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhCOQNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:13:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48915 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231430AbhCOQMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615824774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9tv0GM2oC39o6MkVF4mnc0ECnf5N4im4uXOgj1tjro=;
        b=E+iiKeH785mihoo5Z81lAOrDuIpwbLhp2QMisY4cTLRVkhSkuhV7qyiBaGqyELZrSQIdyG
        +10zl2E6fujhXXW20gyXcpAu4bC7SQoBwpbO1mv0ZIf1SqgRqpIngVhBBITL5PXaOTY1yD
        BQpMker56l3Z+xoUTbmV1YjkXvJiV7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-ki3mcl07ORW1Zypj0biDKw-1; Mon, 15 Mar 2021 12:12:50 -0400
X-MC-Unique: ki3mcl07ORW1Zypj0biDKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56B2C760C0;
        Mon, 15 Mar 2021 16:12:47 +0000 (UTC)
Received: from [10.36.112.200] (ovpn-112-200.ams2.redhat.com [10.36.112.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5E4F60C0F;
        Mon, 15 Mar 2021 16:12:41 +0000 (UTC)
Subject: Re: [PATCH] kswapd: no need reclaim cma pages triggered by unmovable
 allocation
To:     Michal Hocko <mhocko@suse.com>
Cc:     zhou <xianrong_zhou@163.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@suse.de, willy@linux.intel.com, rostedt@goodmis.org,
        mingo@redhat.com, vbabka@suse.cz, rientjes@google.com,
        pankaj.gupta.linux@gmail.com, bhe@redhat.com, ying.huang@intel.com,
        iamjoonsoo.kim@lge.com, minchan@kernel.org,
        ruxian.feng@transsion.com, kai.cheng@transsion.com,
        zhao.xu@transsion.com, zhouxianrong@tom.com,
        zhou xianrong <xianrong.zhou@transsion.com>
References: <20210313083109.5410-1-xianrong_zhou@163.com>
 <64f8c03f-7fd9-2e03-6b90-67e2a5a45b9d@redhat.com>
 <YE+Gs13F8nV1Z1/d@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <defed0ac-c99a-f2c0-a82a-3e11f1eca150@redhat.com>
Date:   Mon, 15 Mar 2021 17:12:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YE+Gs13F8nV1Z1/d@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.21 17:09, Michal Hocko wrote:
> On Mon 15-03-21 16:46:33, David Hildenbrand wrote:
>> On 13.03.21 09:31, zhou wrote:
> [...]
>>> This optimization can avoid ~3% unnecessary isolations from cma
>>> (cma isolated / total isolated) with configuration of total 100Mb
>>> cma pages.
>>
>> Can you say a few words about interaction with ZONE_MOVABLE, which behaves
>> similar to CMA? I.e., does the same apply to ZONE_MOVABLE? Is it already
>> handled?
> 
> No, the movable zone shouldn't be affected as the reclaim is zone aware.
> The problem is that CMA doesn't belong to any particular zone. This is
> something Joonsoo worked in the past and I believe following up on that
> work has been recommended last time a similar/same approach like this
> patch was proposed.

Okay, thanks - that's what I expected.

-- 
Thanks,

David / dhildenb

