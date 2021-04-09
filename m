Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97683359459
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhDIFK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:10:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:38108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhDIFK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:10:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 907C5B23F;
        Fri,  9 Apr 2021 05:10:45 +0000 (UTC)
Date:   Fri, 9 Apr 2021 07:10:42 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/8] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <YG/h0v2Kqd+xdlz3@localhost.localdomain>
References: <20210406111115.8953-1-osalvador@suse.de>
 <20210406111115.8953-5-osalvador@suse.de>
 <YGzEe1XH0kGgwsxp@localhost.localdomain>
 <89dcbcd749f1993303749f2c46220144@suse.de>
 <20210408220518.ea64131255e1b5732a05e57a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408220518.ea64131255e1b5732a05e57a@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 10:05:18PM -0700, Andrew Morton wrote:
> Yes please.

I just sent v7 with that yesterday [1]

Hope David/Michal finds some time to review patch#4 as that is the only
missing piece atm.

[1] https://lkml.org/lkml/2021/4/8/546


-- 
Oscar Salvador
SUSE L3
