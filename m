Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DC0383600
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 17:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244320AbhEQP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 11:27:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:39070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243042AbhEQPNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 11:13:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A34A9AEBB;
        Mon, 17 May 2021 15:11:53 +0000 (UTC)
Date:   Mon, 17 May 2021 16:11:51 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Yang Shi <shy828301@gmail.com>
Cc:     kirill.shutemov@linux.intel.com, ziy@nvidia.com, mhocko@suse.com,
        ying.huang@intel.com, hughd@google.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 2/7] mm: memory: make numa_migrate_prep() non-static
Message-ID: <20210517151151.GV3672@suse.de>
References: <20210413212416.3273-1-shy828301@gmail.com>
 <20210413212416.3273-3-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210413212416.3273-3-shy828301@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 02:24:11PM -0700, Yang Shi wrote:
> The numa_migrate_prep() will be used by huge NUMA fault as well in the following
> patch, make it non-static.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
