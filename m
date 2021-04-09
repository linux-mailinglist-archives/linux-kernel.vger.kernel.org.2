Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56798359BC4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 12:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbhDIKQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 06:16:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:35950 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234358AbhDIKOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 06:14:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65BF4AF03;
        Fri,  9 Apr 2021 10:14:07 +0000 (UTC)
Date:   Fri, 9 Apr 2021 12:14:04 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        shy828301@gmail.com, weixugc@google.com, rientjes@google.com,
        ying.huang@intel.com, dan.j.williams@intel.com, david@redhat.com
Subject: Re: [PATCH 03/10] mm/migrate: update node demotion order during on
 hotplug events
Message-ID: <20210409101400.GA32159@linux>
References: <20210401183216.443C4443@viggo.jf.intel.com>
 <20210401183221.977831DE@viggo.jf.intel.com>
 <YG7Sc3i54IV6KyPn@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG7Sc3i54IV6KyPn@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 11:52:51AM +0200, Oscar Salvador wrote:
> I am not really into PMEM, and I ignore whether we need
> CONFIG_MEMORY_HOTPLUG in order to have such memory on the system.
> If so, the following can be partly ignored.

Ok, I refreshed by memory with [1].
From that, it seems that in order to use PMEM as RAM we need CONFIG_MEMORY_HOTPLUG.
But is that always the case? Can happen that in some scenario PMEM comes ready
to use and we do not need the hotplug trick?

Anyway, I would still like to clarify the state of the HOTPLUG_CPU.
On x86_64, HOTPLUG_CPU and MEMORY_HOTPLUG are tied by SPM means, but on arm64
one can have MEMORY_HOTPLUG while not having picked HOTPLUG_CPU.

My point is that we might want to put the callback functions and the callback
registration for cpu-hotplug guarded by its own HOTPLUG_CPU instead of guarding it
in the same MEMORY_HOTPLUG block to make it more clear?

-- 
Oscar Salvador
SUSE L3
