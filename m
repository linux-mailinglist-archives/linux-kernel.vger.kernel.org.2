Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344AA3412A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 03:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhCSCOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 22:14:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33564 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhCSCOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 22:14:05 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616120043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1bUmwIT7zzRxQKD7AqAg3yAd+yDbfSq8cYt6VHdtxGg=;
        b=C3CFK8CzD7cLi8cAVt1ypSv8QOuKIG9jGSgsmyMQGnTleM5YNmMERdytbXhl3u7uWUybgt
        /cRqdi1jMbR8Ls5fxnO0iLDQBC7EEmY4S59NxWw5cvEN83Oez2vp+Hi66jHMrb9XZP3uHB
        ZojhCecS1DILVtwS/W7AYXYZbKU5UbaKhPYFHDaQmiq+FbHu2cdNGkFGaI0iDQnG00v+98
        mes8xRyEIrQsnlB5BK4AjBr/kTl55RAiA9PAVp7rMu7J/ZlEO3IZSxUlXLj/xbv4ODM775
        i4U0upJBTJpo3eGtZACaCouLooBqDyPKtI73JwkzLyj+o1MwUpQqDrGN2TE8tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616120043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1bUmwIT7zzRxQKD7AqAg3yAd+yDbfSq8cYt6VHdtxGg=;
        b=s4n5l41QqrhmdcKg6vaSji0bwDrTX9wgJudZNA79CkgJCDHIG0JLKU6OWR8Fbfi3nXnEHr
        s9cRC0/AiJRWGUAw==
To:     ira.weiny@intel.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Oliver Sang <oliver.sang@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/highmem: Fix CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
In-Reply-To: <20210318230657.1497881-1-ira.weiny@intel.com>
References: <20210318230657.1497881-1-ira.weiny@intel.com>
Date:   Fri, 19 Mar 2021 03:14:03 +0100
Message-ID: <875z1n7uvo.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18 2021 at 16:06, ira weiny wrote:
> From: Ira Weiny <ira.weiny@intel.com>
>
> The kernel test robot found that __kmap_local_sched_out() was not
> correctly skipping the guard pages when
> CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP was set.[1]  This was due to
> CONFIG_DEBUG_HIGHMEM check being used.
>
> Change the configuration check to be correct.
>
> [1] https://lore.kernel.org/lkml/20210304083825.GB17830@xsang-OptiPlex-9020/
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Oliver Sang <oliver.sang@intel.com>
> Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Fixes: 0e91a0c6984c ("mm/highmem: Provide CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org

Thanks,

        tglx
