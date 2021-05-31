Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36FB3953D3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 04:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhEaCE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 22:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhEaCEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 22:04:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F39C061574
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 19:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=2Q8I/cC0qpb/aUVz8t8n7eOqgjvoGavTRPRf78kTwuA=; b=uzEG5j8XFl4vDxy1sDXKFQaiNP
        j1Zo2I1m53vvefGy2jlC+JY10u+Vc1gV7O9d2UOnqOXMiK1FGt1NRhRArgGajx7W4MueEKKsSXHKJ
        UG5C3htzZd+JzKlrzIhi0e3AkSI1/9QXRvgwMU4C9vz1fmhI3LScrbomZmPudwIUjSFn2htvV/TL7
        GmM3t8QIZOld3kl1qE116wh656TN2jfQYV2CVj2CW4wzZWd8XF+nzhMkyG/INLk8FztpGtEp3fSqE
        ql6+oQsVuKXGv/thG2HrbOnRjwCioWa59RLVZyNre0uoQbcdK1WE4yzS/rsfpGggvfI4xFIxXqT2Z
        XdgOy81w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lnXG8-008Yid-R0; Mon, 31 May 2021 02:02:30 +0000
Date:   Mon, 31 May 2021 03:02:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Bixuan Cui <cuibixuan@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/mmap_lock: fix warning when CONFIG_TRACING is
 not defined
Message-ID: <YLRDtBCPAYajOSqa@casper.infradead.org>
References: <20210531015527.49785-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210531015527.49785-1-cuibixuan@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 09:55:27AM +0800, Bixuan Cui wrote:
> Fix the warning: [-Wunused-function]
> mm/mmap_lock.c:157:20: warning: ‘get_mm_memcg_path’ defined but not used
>  static const char *get_mm_memcg_path(struct mm_struct *mm)
>                     ^~~~~~~~~~~~~~~~~

That seems like the wrong way to fix the warning.  Why not put it
under an appropriate ifdef?

> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
>  mm/mmap_lock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 03ee85c696ef..ec7899b08690 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -154,7 +154,7 @@ static inline void put_memcg_path_buf(void)
>   * The caller must call put_memcg_path_buf() once the buffer is no longer
>   * needed. This must be done while preemption is still disabled.
>   */
> -static const char *get_mm_memcg_path(struct mm_struct *mm)
> +static const char __maybe_unused *get_mm_memcg_path(struct mm_struct *mm)
>  {
>  	char *buf = NULL;
>  	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
> -- 
> 2.17.1
> 
> 
