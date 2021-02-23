Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CCA322CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 15:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbhBWOuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 09:50:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:57888 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232725AbhBWOuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:50:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614091763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ab6TNhKlXjlpvvl10dRHtjgP7K/ABqxgf//XIKLZ2qc=;
        b=tiOTBO6xsx1FlWVx+tFCbzDuTZcZUzURYWmL1HzkEGVdTcAq8fpTF8xeogH9v1HKXeZX2+
        DjY7iWuO5uEat7bz0e2bWwBlmq3viZsvEpVW4VMHnaB42iIlHd5TwMvtfBi+Ctvcf++IvY
        rzfHLRamGzYYrzcYKkWVuA3JAaGdD+k=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 175E8AF42;
        Tue, 23 Feb 2021 14:49:23 +0000 (UTC)
Date:   Tue, 23 Feb 2021 15:49:22 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     willy@infradead.org, andriy.shevchenko@linux.intel.com,
        david@redhat.com, linmiaohe@huawei.com, vbabka@suse.cz,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com, joe@perches.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] vsprintf: dump full information of page flags in pGp
 fix
Message-ID: <YDUV8kqgK0fCgpOf@alley>
References: <20210223055124.75882-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223055124.75882-1-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-02-23 13:51:24, Yafang Shao wrote:
> The name of the flag should be printed using default_str_spec.
> There's no difference in the output after this change because the string is
> printed as-is with both default_dec_spec and default_flag_spec.
> 
> This patch is a followup of the patchset
> "mm, vsprintf: dump full information of page flags in pGp" [1]
> 
> [1]. https://lore.kernel.org/linux-mm/20210215155141.47432-1-laoar.shao@gmail.com/
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: David Hildenbrand <david@redhat.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
