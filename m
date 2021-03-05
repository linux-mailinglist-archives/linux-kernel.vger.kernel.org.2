Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED0632F03D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 17:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhCEQm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 11:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhCEQmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 11:42:14 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F336CC061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 08:42:13 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id u18so3589525ljd.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 08:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Idz6IhNVmVDwrmS9eS02rzcFdMoaAKDHYFFgO5wjPbU=;
        b=O2TrIrVFHinCDdMspBfmxsGMiJUlgXCqYQ5/0BckQ2Iqy1homQEhVrIQ0XJsIYpaiW
         +YcSkkOPteNMhOlE5U2GaaBp/HMTEYNawtAoNNIkRe/tsVEzJ4PZB1KAAThN973pDjue
         IjS6Zw/SOn6Xkj9MzXByMZP+d6xnuMFtlm3qOV4cT/bLE9T0j7pRISgBlXx8E+WEG+s0
         Ikc8YL/wTRFWi8DIjOcRUcsXe4QWct1oDvtVTIFV9IFP20cP91zKojuI6/SOhAOV27bO
         G/2Lnq7h5vsbliyITp9Bs3FcRyDoP2/5N+/HduaduYJDav5igamHgTT/8kSXaey2iA37
         KhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Idz6IhNVmVDwrmS9eS02rzcFdMoaAKDHYFFgO5wjPbU=;
        b=uWODky6HGFk3z7OVK9eCWJrQ0gOI9IxEZPpmooyK9GolExLYY50ZN5qF+ZjDL93G6N
         +ryoNjef1YrO/rjPLpWD6BIVww76mBoajvrbu2f6osEQWg6uvjLMWXvs8QR00+H5UtI6
         XCjX4qHtvIzIb6Ej1Q7gy7lkmeGQiK/leUNVgHpiVwnMg/NJRPRAxrky9zExciS2sJUL
         Wdzz7aHnoGa9uivbWZyQLuOjvWQkpChg9+pgti5PFKZQoNlBiDBLY6aQ4Nns34FYDXmm
         mQNuCZsGUBlu8lsOP1uvipTkzg5WnLzBTJ+cIt0wN7IgZMeThMYFCtr8YRdY58I4rp0r
         Qzuw==
X-Gm-Message-State: AOAM532YIg98cQmPdwVeCZBYV11ls+8F/LsUV3Nokw89BZ97Z1y3m7T8
        xA6UtYawqEUtefasckWrPnWE68mhoRXLOWJc+6TTFA==
X-Google-Smtp-Source: ABdhPJzGUwk57v52iY1wEp/cPEVzqifiluzS2oM2VVIzq8+D0XPrB/uI8vXaF7jxmAsK+y8S+aaiEC+qngLzzGI2LR0=
X-Received: by 2002:a2e:2f05:: with SMTP id v5mr5701469ljv.279.1614962532286;
 Fri, 05 Mar 2021 08:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20210304014229.521351-1-shakeelb@google.com> <alpine.LSU.2.11.2103042248590.18572@eggly.anvils>
 <YEJbZi+tpSATjsT/@cmpxchg.org>
In-Reply-To: <YEJbZi+tpSATjsT/@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 5 Mar 2021 08:42:00 -0800
Message-ID: <CALvZod4iVF1tg8H-zcUVp6Kf+L9jeJBF62hNHuLNKrdcxyJXYQ@mail.gmail.com>
Subject: Re: [PATCH v3] memcg: charge before adding to swapcache on swapin
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 8:25 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
[...]
> I'd also rename cgroup_memory_noswap to cgroup_swapaccount - to match
> the commandline and (hopefully) make a bit clearer what it effects.

Do we really need to keep supporting "swapaccount=0"? Is swap
page_counter really a performance issue for systems with memcg and
swap? To me, deprecating "swapaccount=0" simplifies already
complicated code.
