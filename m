Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037513569B4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346761AbhDGKbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:31:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:49898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234193AbhDGKbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:31:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 14A80B0B3;
        Wed,  7 Apr 2021 10:30:54 +0000 (UTC)
Subject: Re: [PATCH v3] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     vinmenon@codeaurora.org
References: <1617712064-12264-1-git-send-email-faiyazm@codeaurora.org>
 <2e1f1771-0483-d311-7995-404c837372fc@suse.cz>
Message-ID: <623f3165-4bce-8491-c9c4-8eac8404c21a@suse.cz>
Date:   Wed, 7 Apr 2021 12:30:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2e1f1771-0483-d311-7995-404c837372fc@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/21 7:15 PM, Vlastimil Babka wrote:
> On 4/6/21 2:27 PM, Faiyaz Mohammed wrote:
>> alloc_calls and free_calls implementation in sysfs have two issues,
>> one is PAGE_SIZE limitiation of sysfs and other is it does not adhere
>> to "one value per file" rule.
>> 
>> To overcome this issues, move the alloc_calls and free_calls implemeation
>> to debugfs.
>> 
>> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
> 
> Good direction, thanks. But I'm afraid we need a bit more:
> 
> - I don't see debugfs_remove() (or _recursive) used anywhere. When a cache is
> destroyed, do the dirs/files just linger in debugfs referencing removed
> kmem_cache objects?
> - There's a simple debugfs_create_dir(s->name, ...), for each cache while the
> sysfs variant handles merged caches with symlinks etc. For consistency, the
> hiearchy should look the same in debugfs as it does in sysfs.

Oh and one more suggestion. With full seq_file API (unlike sysfs) we should
really do the data gathering (to struct loc_track?) part just once per file
open, and cache it between individual reads.
