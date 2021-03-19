Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5475342171
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 17:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhCSQFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 12:05:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:59106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229875AbhCSQFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 12:05:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616169923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a36g8aLbteQ9pFLegRJ3sBALXzwps+mF7k6+dpHHFjg=;
        b=oitYKOhPPSpQ+OV19KNfCxAaGRmecCq2akEwG29vXRbh0x0gxb5uPyCsWlNcSGO+e8blYj
        0c8q6hwH/f061iVxwHFuuhqjvP2wg8gJfAN7+tDazCH3mMEakApw+2/Gxsii2Bu1hyjvwm
        Lg1ecsyUCgX+3Yc4Dk5N4XinKL36pss=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1DDFAC17;
        Fri, 19 Mar 2021 16:05:22 +0000 (UTC)
Date:   Fri, 19 Mar 2021 17:05:21 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     willy@infradead.org, andriy.shevchenko@linux.intel.com,
        david@redhat.com, linmiaohe@huawei.com, vbabka@suse.cz,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com, joe@perches.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v6 resend 0/3] mm, vsprintf: dump full information of
 page flags in pGp
Message-ID: <YFTLwdP8sETTNTiY@alley>
References: <20210319101246.73513-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319101246.73513-1-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-03-19 18:12:43, Yafang Shao wrote:
> The existed pGp shows the names of page flags only, rather than the full
> information including section, node, zone, last cpuipid and kasan tag.
> While it is not easy to parse these information manually because there
> are so many flavors. We'd better interpret them in printf.
> 
> This patchset also includes some code cleanup in mm/slub.c.
> 
> v6:
> - fixes the build failure and test failure reported by kernel test robot
> 
> 
> Yafang Shao (3):
>   mm, slub: use pGp to print page flags
>   mm, slub: don't combine pr_err with INFO
>   vsprintf: dump full information of page flags in pGp
> 
>  Documentation/core-api/printk-formats.rst |  2 +-
>  lib/test_printf.c                         | 90 ++++++++++++++++++++---
>  lib/vsprintf.c                            | 66 +++++++++++++++--
>  mm/slub.c                                 | 13 ++--
>  4 files changed, 149 insertions(+), 22 deletions(-)

The patchset has been pushed into printk/linux.git, branch
for-5.13-vsprintf-pgp. It should appear in linux-next again.

The first two patches are the same as in v5 that has already been
pushed earlier. I probably should have replaced only the last patch
but I rebased everything. It was too easy with the b4 tool. And
it is Friday late afternoon here.

Best Regards,
Petr
