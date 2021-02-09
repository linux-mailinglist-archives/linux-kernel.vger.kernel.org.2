Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE107315B76
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbhBJAmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbhBIVHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 16:07:21 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE14EC06121D
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 11:14:27 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id e18so23817176lja.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 11:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QiJbgc9uHQ4f7W9ot8GPf8bOPMHTjKS9chqsEgTJBXQ=;
        b=aNt936Uv5Pvb6XQyxVTyRfAnfZ4ie1FmlBY1FQeJsxtYKLmNSiV6vXfHjBBMUbV1TF
         vAdVGuFF2gxHUeArYS7K5dGfF5h9bjgRekHi6vlCTWcU3fPjS+U2MHDsHr+ozwL7SaEr
         D0tJffRY9XfrfIe6l7575nvi9Us1sSmKobpXfhcU7+t4peARscWC84AkXKcgs7uKjTRs
         0SSxSTq1Wo7YMDuK44FS1hFJ5EyTt3oI1Ts4V2szLeRF7iP95Q1cbNDBlzrDeEwzzBNt
         yTBDNRbD8kKBKhH68sI9SGjK+ZZFSclPWx4KvW2I5tXDqVTZEUP3nC4Gufdt6z9QnDO+
         f9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QiJbgc9uHQ4f7W9ot8GPf8bOPMHTjKS9chqsEgTJBXQ=;
        b=VtL1+55858SU7QeNT61HT/Ik+JnSKJTDvxSOdbxkSF6Replegaqh6Yz/kCkJGv6ykp
         uUyNX8LC961dwHNk8n1QxAymfUyionOuWVwcT3Ja4WpNsAAv1XHZfyHKeptwBHtfjVGw
         SYs8XWqJGvLCFs39xK8H6F/PehMS/hRDXcRdVC3V+DqOssc7ozKZM78WKile5ATkROYE
         0xYJlSbgGv3pTZ8YYGATsGBwsTi+L0flSIuFPdFU2loA8/MEY7gUODTecugjoNZSwWkd
         xGPOk+MvJPm2I0MzXMeKhZwmvVhxkuxLzeHuXZhg/3bTjHdLgPhX8vlT6jBEZa/gyiEr
         alBw==
X-Gm-Message-State: AOAM531WcBSrqy0cab2dPaUZcnbmfkXCjvnB0TnUcXIrieS+X68nuas6
        QMSslSZCZN1RJbeQas7Y7lCO160KXSLGjTQKJjQvRQ==
X-Google-Smtp-Source: ABdhPJxA1PuqJnhzJJquwIJYOw1w6vzUPL6lOhcqipVzLiGXTT0J1IbS4/X7mBrqEmgsqlRWSB6ZGIU8jyhW4WcwhSQ=
X-Received: by 2002:a2e:9801:: with SMTP id a1mr16086206ljj.122.1612898065894;
 Tue, 09 Feb 2021 11:14:25 -0800 (PST)
MIME-Version: 1.0
References: <20210209174646.1310591-1-shy828301@gmail.com> <20210209174646.1310591-2-shy828301@gmail.com>
In-Reply-To: <20210209174646.1310591-2-shy828301@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 9 Feb 2021 11:14:14 -0800
Message-ID: <CALvZod5GW=zk0hq+_qqV1KGxz7MJ_RKctj6H=uS7bxHdhxOWrw@mail.gmail.com>
Subject: Re: [v7 PATCH 01/12] mm: vmscan: use nid from shrink_control for tracepoint
To:     Yang Shi <shy828301@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 9:47 AM Yang Shi <shy828301@gmail.com> wrote:
>
> The tracepoint's nid should show what node the shrink happens on, the start tracepoint
> uses nid from shrinkctl, but the nid might be set to 0 before end tracepoint if the
> shrinker is not NUMA aware, so the traceing

tracing

> log may show the shrink happens on one
> node but end up on the other node.  It seems confusing.  And the following patch
> will remove using nid directly in do_shrink_slab(), this patch also helps cleanup
> the code.
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
