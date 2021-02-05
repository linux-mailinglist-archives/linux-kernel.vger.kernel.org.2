Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B5131115A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhBER4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBEP2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:28:50 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD14CC06178A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:10:31 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id w11so3764498qvz.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 09:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JSYiUbx9lBanOq4tbekqTAf5PAtDklDUpjXB1f72Qrc=;
        b=tM/dZEUeDe1AgSL5LylGwYfRT5+levhjDv8vOBR8fUAbDaWMIznPnPLamaZYjY3wzT
         g+cjA6pD7ZjdrM2mng9Mhako+BFslrJzcTyReIW3h3o2QgGnwwDoKQzvWVUktPepuyYF
         AQpeiGmjpMs3K7CIzmD/iIjPrJfmglw9FOMLa8DMpRqKtFq4n+aJwjjtM6lqRBeHo15z
         kMc5x+Y/a9DnW6WdEzSjR2PJZoQSYrOzjK7pChRoltFN0rOJYBKH6WVkXPnWme2gn3k3
         YwP8eOjnLw8SSf+taDiSenMwKUeZDxhJoWi9lzmTgxWYD8kMQD8Zdwho7ZOxqfsluBcS
         VKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JSYiUbx9lBanOq4tbekqTAf5PAtDklDUpjXB1f72Qrc=;
        b=dmPr4nDIfQMnv7f72jn3lyOtl261nyS7YUv77sgFO/H6KTMvyXhaGltJYyNVbg5U0u
         M/w9OqbELy1a1I5B7wzYd/O0fvD98wxbIILOEdwU5MSW9ZAU7qEirqFSDKNfOD2OHvLG
         Od9Miu7wC2zv+4XQzXeHw5SJq4kJXAocIJdC3tau7KH0HBhXuAkEPXmMmVPk0UAnQ1mk
         dEHAeILhGZ0pALgPRDW1Vl/2QaGG6hSVkLWPZP2htEMMIua4x+68Gu3kLpkt+USiWdwm
         6XWuiWVBndfoByeqUl9+/kLsvY9nkS9VFLbBEx2b0NALIOU15T8Itu1qijP7Ua2WPKh8
         C7wg==
X-Gm-Message-State: AOAM5328dWOlU+dNFcr9AWL1NhWjoJrHARfunVim+tDBIujPzkPLLzdO
        dVx0JafbzHO25n/o2jnnCeoj0A==
X-Google-Smtp-Source: ABdhPJwfv1gGAdP2jw5xSKMc6JrF213KOE1VJFhtyr1tERfRWP0BI2bHuc1NqNeFBd5A0OMvxYuzDA==
X-Received: by 2002:a0c:e8c8:: with SMTP id m8mr5266723qvo.33.1612545031139;
        Fri, 05 Feb 2021 09:10:31 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id c22sm8495640qtp.19.2021.02.05.09.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 09:10:29 -0800 (PST)
Date:   Fri, 5 Feb 2021 12:10:28 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 7/7] mm: memcontrol: consolidate lruvec stat flushing
Message-ID: <YB18BF8b41RPra5b@cmpxchg.org>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-8-hannes@cmpxchg.org>
 <YB1hhwVybr0x5M2j@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YB1hhwVybr0x5M2j@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 04:17:27PM +0100, Michal Hocko wrote:
> On Tue 02-02-21 13:47:46, Johannes Weiner wrote:
> > There are two functions to flush the per-cpu data of an lruvec into
> > the rest of the cgroup tree: when the cgroup is being freed, and when
> > a CPU disappears during hotplug. The difference is whether all CPUs or
> > just one is being collected, but the rest of the flushing code is the
> > same. Merge them into one function and share the common code.
> 
> IIUC the only reason for the cpu == -1 special case is to avoid
> zeroying, right? Is this optimization worth the special case? The code
> would be slightly easier to follow without this.

Hm, it was less about the optimization and more about which CPU(s)
need(s) to be handled. But it's pretty silly the way it's written,
indeed. I'll move the for_each_online_cpu() to the caller and drop the
cpu==-1 special casing, it makes things much simpler and more obvious.

> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Anyway the above is not really a fundamental objection. It is more important
> to unify the flushing.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks. v2 is different, so I'll wait with taking the ack.
