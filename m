Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC4A32F507
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 22:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhCEVA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 16:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCEVAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 16:00:21 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24744C06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 13:00:21 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id z128so3371926qkc.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 13:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=La3mwDa8nISUh2U9bi9oHzPu358czH3TeQ0ByYgJZqY=;
        b=VfhA/pXDD661QUgX1Mxa4DhK6hKrLISfubA84eRcP5m7HrACNGN9aEnYTpgLPqDTKl
         g4TbBNYRDsU/94H2jOc7T/WxPyFqm19l9G7+Q1geXVCnQcSU5+0ssJYshieCtlZBKv8G
         ZhfXtpPkowYLxrCPZDBq+iHGWe+2Ke52zeeoRbeMAElVHx7F1isMeyzGcS7h/D6oaDkV
         Ro/dMjTsOIUEVp7J0fkdOfo9OM7pFGQuyPmXZK2etHIsJqi+AAuIWwkhelx/s2kSoHn5
         0GHaF5UMUWdWwHNA8bAi9C2HW1FxI9M8Ef6GARBBntVKOnNojeQRWUUzzV0DCeMyIcnc
         o4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=La3mwDa8nISUh2U9bi9oHzPu358czH3TeQ0ByYgJZqY=;
        b=gUAk9e1LdHumnWK45p+bl+nh2FguNy2PJPr5xGnI4CZu91WEs+dRFm1NrtUUJVB4BN
         Un7ogVHlrl5Ej/Xc40ZDNDQpRD3sl2mzCqkGuBJBIktV95qpn1mnNm8auH1vVvwbYjjy
         nq5qR/sO+1gvZJrauDLlm8KEbAuf6ihZU9dGFOy9fHoIx1lWrxgmMhDPc0D9I+n71IDJ
         SGqHxDDoBSf/FBwqYR7h6A3QpjzHF911RvapZ5Sopd41XbsOUvPWzUlZa1lc1zB7E7Ob
         zC4yhQYuA6i+bSc0Egd2MyFmt3HY/xeo5VTEk94MyFiI2dfH2CAQAxrsl4nvz7tnFHSS
         HugA==
X-Gm-Message-State: AOAM5304RcUokSV1ZOQMAF5iVIHqULTDZsGSDXnUa4qQDMo4lFSbui5c
        E1vHsY02G/QQGsVpj8S2fgGx++RvVAaiPQ==
X-Google-Smtp-Source: ABdhPJxzOw3dJnmPVcIA9UuDAQ5evSE+9f2gbj+kUUGfQGp8XckRO4m6bZqcEJymjnerKacRpyQ5iA==
X-Received: by 2002:a05:620a:108f:: with SMTP id g15mr11227500qkk.298.1614978020436;
        Fri, 05 Mar 2021 13:00:20 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id h75sm2653603qke.80.2021.03.05.13.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 13:00:19 -0800 (PST)
Date:   Fri, 5 Mar 2021 16:00:19 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] memcg: charge before adding to swapcache on swapin
Message-ID: <YEKb4/MAVv8zDPNw@cmpxchg.org>
References: <20210304014229.521351-1-shakeelb@google.com>
 <alpine.LSU.2.11.2103042248590.18572@eggly.anvils>
 <YEJbZi+tpSATjsT/@cmpxchg.org>
 <CALvZod4iVF1tg8H-zcUVp6Kf+L9jeJBF62hNHuLNKrdcxyJXYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4iVF1tg8H-zcUVp6Kf+L9jeJBF62hNHuLNKrdcxyJXYQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 08:42:00AM -0800, Shakeel Butt wrote:
> On Fri, Mar 5, 2021 at 8:25 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> [...]
> > I'd also rename cgroup_memory_noswap to cgroup_swapaccount - to match
> > the commandline and (hopefully) make a bit clearer what it effects.
> 
> Do we really need to keep supporting "swapaccount=0"? Is swap
> page_counter really a performance issue for systems with memcg and
> swap? To me, deprecating "swapaccount=0" simplifies already
> complicated code.

Now that you mention it, it's probably really not worth it.

I'll replace my cleanup patch with a removal patch that eliminates
everything behind swapaccount= except for a deprecation warning...
