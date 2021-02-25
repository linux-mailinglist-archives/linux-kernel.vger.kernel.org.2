Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673B93258BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhBYVgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbhBYVgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:36:48 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E99C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:36:08 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id t9so4314525pjl.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=/U0ItIv10awr48o0Xr67ORIR0R4cpmrKcS939Ry0u60=;
        b=aM51O6VgHioWd7XkWW6peAD4fP73FQxRl9onjbsDlp5Blv8GVDlbHlQ+bVRRjiux/q
         VIxiQcJR41IkzBS8pG7heU8OynV6hjepxqvlstpyFvUkQWJhAnBl+a6tpRtBk+ZyE13j
         zVdDJdwPN3PqFz/Ss1XlFCxH4TSZowvWFTJivJL+xB/l89cEcHmp/rYKIVkSu4LT8hga
         5nSYNt+3RUeWL1/NWf0uHLE+a5HhUal3ERbcabQPkwbKuVJfkwuRGqyfFarm3LfwfI8M
         Mj5tmQZmj/xixxD5TIyQNEkHBfKvZEGwiP/SS9Cz6oyw1sHAzZLiS2+UfBZj5WuIOQA8
         iO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=/U0ItIv10awr48o0Xr67ORIR0R4cpmrKcS939Ry0u60=;
        b=Y63tqZS7ZRUfoDH/obMq9iY27YUy7Ej4JWEUPzINXktfzlvgr7WzEDx0w95wLCc7zr
         dOYMQq/4OtvrqywdXOxbAJXAW+fIF+T+aeMYPsZf1g1Zamg/njUBjFsO+g37piDxVRJb
         uu/t81vpj0cQ3MCfypU9XaDdbZ7c3mxETiJJ8Rtc3RPMZy9kqHgVcOqwoFjbMPOpw49b
         0H4cHiaYw7QyFAQmgFJNvyEy1httCakrtTUTUjstMSy5Y7DPo/fdxa2wNFf0wIlKQHwc
         l4KvqHo8tDyWtRLj1Wa+UF/vqMovgC55m2jKPdQF1KbnA/SQFoAtDoZhlvw8K8BXt+er
         5zoQ==
X-Gm-Message-State: AOAM5313nA3xB3C0RjnyPpDF1Vl3++fEA8yn2PrSODa924O6pZawFOL0
        ya4RXSBelaPktkYzReWAaWTuNQ==
X-Google-Smtp-Source: ABdhPJx9m++KLr1Vney+yZ57/jgY0SoHkKVpS8hWdbbOKP+8KR9VogqbH4ylR1ahD/dOaJ4IAJ2uqQ==
X-Received: by 2002:a17:90a:4a06:: with SMTP id e6mr362628pjh.141.1614288968138;
        Thu, 25 Feb 2021 13:36:08 -0800 (PST)
Received: from [2620:15c:17:3:a902:4bab:58a0:3f05] ([2620:15c:17:3:a902:4bab:58a0:3f05])
        by smtp.gmail.com with ESMTPSA id 142sm600208pfz.196.2021.02.25.13.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 13:36:07 -0800 (PST)
Date:   Thu, 25 Feb 2021 13:36:06 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Shakeel Butt <shakeelb@google.com>
cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: enable memcg oom-kill for __GFP_NOFAIL
In-Reply-To: <20210223204337.2785120-1-shakeelb@google.com>
Message-ID: <f9a2aff-727b-445c-f6bd-613fc8725a@google.com>
References: <20210223204337.2785120-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021, Shakeel Butt wrote:

> In the era of async memcg oom-killer, the commit a0d8b00a3381 ("mm:
> memcg: do not declare OOM from __GFP_NOFAIL allocations") added the code
> to skip memcg oom-killer for __GFP_NOFAIL allocations. The reason was
> that the __GFP_NOFAIL callers will not enter aync oom synchronization
> path and will keep the task marked as in memcg oom. At that time the
> tasks marked in memcg oom can bypass the memcg limits and the oom
> synchronization would have happened later in the later userspace
> triggered page fault. Thus letting the task marked as under memcg oom
> bypass the memcg limit for arbitrary time.
> 
> With the synchronous memcg oom-killer (commit 29ef680ae7c21 ("memcg,
> oom: move out_of_memory back to the charge path")) and not letting the
> task marked under memcg oom to bypass the memcg limits (commit
> 1f14c1ac19aa4 ("mm: memcg: do not allow task about to OOM kill to bypass
> the limit")), we can again allow __GFP_NOFAIL allocations to trigger
> memcg oom-kill. This will make memcg oom behavior closer to page
> allocator oom behavior.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: David Rientjes <rientjes@google.com>
