Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA85F3492FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhCYNVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:21:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:55852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhCYNVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:21:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B723DAC16;
        Thu, 25 Mar 2021 13:21:21 +0000 (UTC)
Date:   Thu, 25 Mar 2021 14:21:19 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Wang Wensheng <wangwensheng4@huawei.com>
Cc:     akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        rui.xiang@huawei.com
Subject: Re: [PATCH] mm/sparse: Add the missing sparse_buffer_fini() in error
 branch
Message-ID: <YFyOT/1j95uON6/9@localhost.localdomain>
References: <20210325113155.118574-1-wangwensheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325113155.118574-1-wangwensheng4@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 11:31:55AM +0000, Wang Wensheng wrote:
> sparse_buffer_init() and sparse_buffer_fini() should appear in pair, or
> a WARN issue would be through the next time sparse_buffer_init() runs.
> 
> Add the missing sparse_buffer_fini() in error branch.
> 
> Fixes: 85c77f791390 ("mm/sparse: add new sparse_init_nid() and sparse_init()")
> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE L3
