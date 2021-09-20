Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057F7410FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 09:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhITHEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 03:04:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40294 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbhITHEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:04:21 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632121373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PyM/RfJt0D4t8AyTheIl5UBEkGQN9Z7Je9+vK9jPaBE=;
        b=bCnhREcfGejQYrSDL6iBTTOLkn6c+kCWfi4UZ/+4AuAhJlkfc2v5ge9uutcbRaS90rx7oE
        P73f/epC2dBxGvKbiB3CzW4g/EypwbGCpoSHKhh+ESIU/hPND18NVjo90AkwRICUPi31Zh
        bR02bWodFXMIHE0z1GmG66hvS7iMV/A3J7Y7dMn1nwJgi0pZiTmhNPcd8owwjY4W8/i5iR
        /hzGKQ2GXybK8nAV8ZiIXM8P/8bULmQjOxJwNtWvEvdccDjsFzqSo89B3XkYGoXpU0UxiJ
        iXoS7qYc0He2eBTukZdpXWWNjtqdqK/Ttl4q2TKV2zh8hZp73E5Ci6eUGs2qmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632121373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PyM/RfJt0D4t8AyTheIl5UBEkGQN9Z7Je9+vK9jPaBE=;
        b=+Bo+8Euft3f4goj3Z1zauLuEkIa0dEqj7XvrB179V6+nFEZMqdwdwDJbNhVIMNJFXS8gef
        ZGclBbEbeJHDdjBg==
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] mm/migrate: fix CPUHP state to update node demotion order
In-Reply-To: <20210918025849.88901-1-ying.huang@intel.com>
References: <20210918025849.88901-1-ying.huang@intel.com>
Date:   Mon, 20 Sep 2021 09:02:52 +0200
Message-ID: <87lf3r7mqr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18 2021 at 10:58, Huang Ying wrote:
> @@ -72,6 +72,7 @@ enum cpuhp_state {
>  	CPUHP_SLUB_DEAD,
>  	CPUHP_DEBUG_OBJ_DEAD,
>  	CPUHP_MM_WRITEBACK_DEAD,
> +	CPUHP_MM_DEMOTION_OFFLINE,

Please keep the _DEAD convention in that section. The plugged CPU is
already gone.

>  	CPUHP_MM_VMSTAT_DEAD,
>  	CPUHP_SOFTIRQ_DEAD,
>  	CPUHP_NET_MVNETA_DEAD,
> @@ -240,6 +241,7 @@ enum cpuhp_state {
>  	CPUHP_AP_BASE_CACHEINFO_ONLINE,
>  	CPUHP_AP_ONLINE_DYN,
>  	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
> +	CPUHP_AP_MM_DEMOTION_ONLINE,

Are there any ordering requirements of these states vs. other CPU
hotplug states?

If not, then please use the dynamically allocated states.

If so, then please add a comment:

+	/* Must be before CPUHP_XXX and after CPUHP_YYY */
+	CPUHP_MM_DEMOTION_OFFLINE,

Thanks,

        tglx
