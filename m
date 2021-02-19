Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75C131F86A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 12:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhBSL2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 06:28:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:44124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhBSL1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 06:27:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 451EEACCF;
        Fri, 19 Feb 2021 11:26:42 +0000 (UTC)
Subject: Re: [PATCH RFC 0/1] mm: balancing the node zones occupancy
To:     Charan Teja Reddy <charante@codeaurora.org>,
        akpm@linux-foundation.org, rientjes@google.com, mhocko@suse.com,
        david@redhat.com, mgorman@techsingularity.net, linux-mm@kvack.org
Cc:     vinmenon@codeaurora.org, sudaraja@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <cover.1613661472.git.charante@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1c445421-ddeb-8768-03d0-81537b0d1875@suse.cz>
Date:   Fri, 19 Feb 2021 12:26:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <cover.1613661472.git.charante@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/21 6:24 PM, Charan Teja Reddy wrote:
> I would like to start discussion about  balancing the occupancy of
> memory zones in a node in the system whose imabalance may be caused by
> migration of pages to other zones during hotremove and then hotadding
> same memory. In this case there is a lot of free memory in newly hotadd
> memory which can be filled up by the previous migrated pages(as part of
> offline/hotremove) thus may free up some pressure in other zones of the
> node.

Can you share the use case for doing this? If it's to replace a failed RAM, then
it's probably extremely rare, right.

> We have the proof-of-concept code tried on the Snapdragon systems with
> the system configuration, single memory node of just 2 zones, 6GB normal
> zone and 2GB movable zone. And this Movable zone is such that hot-added
> once and there after offline/online based on the need.

Hm, snapdragon... so is this some kind of power saving thing?

Anyway, shouln't auto NUMA balancing help here, and especially "Migrate Pages in
lieu of discard" (CC'd Dave) as a generic mechanism, so we wouldn't need to have
hotplug-specific actions?

