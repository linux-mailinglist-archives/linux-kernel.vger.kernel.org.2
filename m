Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4A1329FC4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574529AbhCBDrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:47:20 -0500
Received: from ms.lwn.net ([45.79.88.28]:40810 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235877AbhCAVU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:20:57 -0500
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4F0962B8;
        Mon,  1 Mar 2021 21:20:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4F0962B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1614633606; bh=l4qaMOIFJPi87PZtng+nOYR5Z8yYgHYIN56dlYv4y+E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KzsfCvaL4KuFXej/+GVa/PnctspANHhOdRj1YF3HJfEEWxMFe3DxDVfOrj3vqWiYk
         wDRk9qSWa13AibLeew2AYJgz9Rd9ZeL7C5Js6w9pdhw9md1z6n1atEfM8ddmYZJVPT
         KEiu0YJ7PygLixmXnYo2DmqxIpEqpuVlr45ktmSIrhQeR3MYkNIC5F93xqOyJVEF7e
         X1OEd5nZ0CwGV1pXWEUS6669AkDjZ6Rk0N69C047NV9C/c6Qkmjt+Vj9aFG/B05TJD
         PljtIXpwPphQND0la+2/kABwbR+7u/IZEujQeLqtHC9CQ2PfMJGjz4tfHdsv//xe8I
         gWG/ebqfZKbsw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Yang Shi <shy828301@gmail.com>, hannes@cmpxchg.org,
        mhocko@suse.com, guro@fb.com, shakeelb@google.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: memcontrol: add description for oom_kill
In-Reply-To: <20210226021254.3980-1-shy828301@gmail.com>
References: <20210226021254.3980-1-shy828301@gmail.com>
Date:   Mon, 01 Mar 2021 14:20:05 -0700
Message-ID: <87y2f63722.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Shi <shy828301@gmail.com> writes:

> When debugging an oom issue, I found the oom_kill counter of memcg is
> confusing.  At the first glance without checking document, I thought it
> just counts for memcg oom, but it turns out it counts both global and
> memcg oom.
>
> The cgroup v2 documents it, but the description is missed for cgroup v1.
>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  Documentation/admin-guide/cgroup-v1/memory.rst | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
> index 0936412e044e..44d5429636e2 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -851,6 +851,9 @@ At reading, current status of OOM is shown.
>  	  (if 1, oom-killer is disabled)
>  	- under_oom	   0 or 1
>  	  (if 1, the memory cgroup is under OOM, tasks may be stopped.)
> +        - oom_kill         integer counter
> +          The number of processes belonging to this cgroup killed by any
> +          kind of OOM killer.

Applied, thanks.

jon
