Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3FB340277
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 10:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCRJum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:50:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:33444 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhCRJuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:50:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D2AA5AD4A;
        Thu, 18 Mar 2021 09:50:38 +0000 (UTC)
To:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-3-osalvador@suse.de> <YFIOTTC7wgXHQRpy@dhcp22.suse.cz>
 <20210317143827.GA20965@linux> <YFIZVvQllaZHDgzW@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v5 2/5] mm,compaction: Let
 isolate_migratepages_{range,block} return error codes
Message-ID: <843f68e7-6fe6-54e7-976b-af8647482ac1@suse.cz>
Date:   Thu, 18 Mar 2021 10:50:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFIZVvQllaZHDgzW@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 3:59 PM, Michal Hocko wrote:
> On Wed 17-03-21 15:38:35, Oscar Salvador wrote:
>> On Wed, Mar 17, 2021 at 03:12:29PM +0100, Michal Hocko wrote:
>> > > Since isolate_migratepages_block will stop returning the next pfn to be
>> > > scanned, we reuse the cc->migrate_pfn field to keep track of that.
>> > 
>> > This looks hakish and I cannot really tell that users of cc->migrate_pfn
>> > work as intended.

We did check those in detail. Of course it's possible to overlook something...

The alloc_contig_range user never cared about cc->migrate_pfn. compaction
(isolate_migratepages() -> isolate_migratepages_block()) did, and
isolate_migratepages_block() returned the pfn only to be assigned to
cc->migrate_pfn in isolate_migratepages(). I think it's now better that
isolate_migratepages_block() sets it.

>> When discussing this with Vlastimil, I came up with the idea of adding a new
>> field in compact_control struct, e.g: next_pfn_scan to keep track of the next
>> pfn to be scanned.
>> 
>> But Vlastimil made me realize that since cc->migrate_pfn points to that aleady,
>> so we do not need any extra field.

Yes, the first patch had at asome point:

	/* Record where migration scanner will be restarted. */
	cc->migrate_pfn = cc->the_new_field;

Which was a clear sign that the new field is unnecessary.

> This deserves a big fat comment.

Comment where, saying what? :)

