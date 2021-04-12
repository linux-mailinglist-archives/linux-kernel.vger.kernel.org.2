Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB40F35BAB8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbhDLHUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:20:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:60764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236851AbhDLHUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:20:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 253BCAEB9;
        Mon, 12 Apr 2021 07:19:44 +0000 (UTC)
Date:   Mon, 12 Apr 2021 09:19:41 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, shy828301@gmail.com,
        weixugc@google.com, rientjes@google.com, ying.huang@intel.com,
        dan.j.williams@intel.com
Subject: Re: [PATCH 03/10] mm/migrate: update node demotion order during on
 hotplug events
Message-ID: <20210412071936.GA27818@linux>
References: <20210401183216.443C4443@viggo.jf.intel.com>
 <20210401183221.977831DE@viggo.jf.intel.com>
 <YG7Sc3i54IV6KyPn@localhost.localdomain>
 <20210409101400.GA32159@linux>
 <fb51273c-12e5-f47f-064b-86f5b30b1072@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb51273c-12e5-f47f-064b-86f5b30b1072@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 08:59:21PM +0200, David Hildenbrand wrote:
 
> The only way to add more System RAM is via add_memory() and friends like
> add_memory_driver_managed(). These all require CONFIG_MEMORY_HOTPLUG.

Yeah, my point was more towards whether PMEM can come in a way that it does
not have to be hotplugged, but come functional by default (as RAM).
But after having read all papers out there, I do not think that it is possible.

-- 
Oscar Salvador
SUSE L3
