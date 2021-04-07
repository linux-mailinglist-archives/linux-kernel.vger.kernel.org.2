Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D632357633
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbhDGUjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:39:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:34236 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231462AbhDGUis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:38:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E242FB0BA;
        Wed,  7 Apr 2021 20:38:37 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 07 Apr 2021 22:38:37 +0200
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
In-Reply-To: <YGzEe1XH0kGgwsxp@localhost.localdomain>
References: <20210406111115.8953-1-osalvador@suse.de>
 <20210406111115.8953-5-osalvador@suse.de>
 <YGzEe1XH0kGgwsxp@localhost.localdomain>
User-Agent: Roundcube Webmail
Message-ID: <89dcbcd749f1993303749f2c46220144@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-06 22:28, Oscar Salvador wrote:
> Heh, it seems I spaced out today.
> 
> We need a few things on top:
> 

Should I send a new version with the fixup included?
I think it would ease the review but I do not want to spam.


-- 
Oscar Salvador
SUSE L3
