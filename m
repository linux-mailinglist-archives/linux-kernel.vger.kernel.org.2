Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9E4326421
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhBZOe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhBZOeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:34:18 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DCBC061756
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 06:33:38 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v15so8799215wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 06:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IhezNL16J7Th24xbSsx4YTV98HHNpYtn/0HBhefr0V4=;
        b=eslLXHut7tNA3RhWZmCcUY1v+p6KPXdk9Fi5tCTXMsDAPV/2mJjIC8LHuceGvSbA6K
         oxcCxlWgyq/Kzqlnzwm54bww0IFxJIg/I2c8u1i1g2Jt0SnA/9d1zY+nGODBXlC+j3WA
         S9tw3Dzt6Jq/2NN5KM/HE7b+O8S2QQOae8nBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IhezNL16J7Th24xbSsx4YTV98HHNpYtn/0HBhefr0V4=;
        b=czbxDvKkIH0+IDscCzYBW2YJE6L+WodF+NBMcjrm1UEA9JSWzRhuKLfYIjKSvzdxRT
         jynfSfr+fUoCt1MsbOeWmLr2aaPORg11pfZNByUZhy7fGI7jF8W0AHz0bNiJZ5IrP6gy
         9UO9hUmPgimHT3+AWJ5t4pVKD9EfwPuHDTE4jzyeprJmhJczFqdU3hqwOvgGR7TNaQbQ
         hlHmLoKfdhhoc1NFtAaRkDohm3lLSa6K9PJfXbW7vyj6jw6uqGDBdNhYDtoPLZn/FvHc
         qybFImkreifusJePNxLBg74/ETcMUsLZGTCs4EegYTcraRcPzGIhUcCbU3Nsm4QCxxcB
         c9zg==
X-Gm-Message-State: AOAM531C6T7qTMlOnE7Oko2tpjxkDr6Kx4PgEmmvJ3InvNxpm/BeV7qI
        wGr9dcwJGF94XPsZlmMsJFdQwQ==
X-Google-Smtp-Source: ABdhPJwDK3CF3SWBwEUCcV2yoITN/VX/sNO223Q6WaZadO5gz8/IYFES7//jVGgasK4kXjrj+ZXMHw==
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr3551877wri.373.1614350017275;
        Fri, 26 Feb 2021 06:33:37 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:87b5])
        by smtp.gmail.com with ESMTPSA id l15sm6422733wru.38.2021.02.26.06.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 06:33:37 -0800 (PST)
Date:   Fri, 26 Feb 2021 14:33:36 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Yang Shi <shy828301@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@suse.com, guro@fb.com,
        shakeelb@google.com, akpm@linux-foundation.org, corbet@lwn.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: memcontrol: add description for oom_kill
Message-ID: <YDkGwN2rQ5lI6LnE@chrisdown.name>
References: <20210226021254.3980-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210226021254.3980-1-shy828301@gmail.com>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Shi writes:
>When debugging an oom issue, I found the oom_kill counter of memcg is
>confusing.  At the first glance without checking document, I thought it
>just counts for memcg oom, but it turns out it counts both global and
>memcg oom.
>
>The cgroup v2 documents it, but the description is missed for cgroup v1.
>
>Signed-off-by: Yang Shi <shy828301@gmail.com>

Thanks.

Acked-by: Chris Down <chris@chrisdown.name>

>---
> Documentation/admin-guide/cgroup-v1/memory.rst | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
>index 0936412e044e..44d5429636e2 100644
>--- a/Documentation/admin-guide/cgroup-v1/memory.rst
>+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
>@@ -851,6 +851,9 @@ At reading, current status of OOM is shown.
> 	  (if 1, oom-killer is disabled)
> 	- under_oom	   0 or 1
> 	  (if 1, the memory cgroup is under OOM, tasks may be stopped.)
>+        - oom_kill         integer counter
>+          The number of processes belonging to this cgroup killed by any
>+          kind of OOM killer.
>
> 11. Memory Pressure
> ===================
>-- 
>2.26.2
>
>
