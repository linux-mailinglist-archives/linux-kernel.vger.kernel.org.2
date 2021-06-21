Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D9C3AF14B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhFURGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbhFURGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:06:17 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CE9C08ED6D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:45:55 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x21so4729300qtq.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1idqoQuvymBsBQAvv2q4seH7J1czRDhztw/KvBhqig=;
        b=hfhbQW9odLh/zR2d8D9OJm5iCfviL/O71DddJSwyHN/G/uo2GDxuQ/WxmL1vZGWsAq
         1eW2B4e+R4yz89hU1c943ySI2tA5hkP3CWZ8Vn5GIgJd2MrGjnIyKCE0JGprpu9xzJEI
         /Qdt9eEia57hC7zqtA/W4jTETaf4NWPZi4QnFe+XJlH/q69j4P+8amSg+DkZ7NI02B2G
         2GhFa/+jrji66IZcOdThxHZIjiHuJcN0q2KxFx4PuXqa/Ie9VVaiQlAm+McpcVFpOAPl
         zEWgltEPaCWjWuLFd0DJGRMwquvO70oNxLDTa38wr394ttQ25Uw+LEm3fovb40wbveru
         DVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1idqoQuvymBsBQAvv2q4seH7J1czRDhztw/KvBhqig=;
        b=Wr7mEhxdOO08HKx6t86/kwt3r2JDaCmVyGG3RPzdyJCWZX33vjuATufEJTHHU71cfi
         46t9qoYz5TBvBKgQO4d1p9EV2a3qn4Zt1Lw9ivVQfkqRNuQzTYK1YlTET9EXyq+IB815
         r8byh9DFS0yZIGS9XybrA/7ccd45sZM1hDw75+LO5vRNmfeEmvI0HCvI1wnViyUegLHd
         sQWIC122cmuiUK74svxywUALbh8aiPMpmgxI6DhRQORblREexuwNzvTTx57zxHzZt01Y
         pLSXSD160qdv5IEVz98p9+/EwyvGRyH8yfXYeKNEaBuGonHiXJQhe42v8BSk+20l7HnP
         u6KA==
X-Gm-Message-State: AOAM530eNQLl3rc80VvlVDVCjdwzKDzt6Lsjf4T9nSTqdPov4Hzw3JRI
        rGaAgVblPU1nEfVpC2g3FrBf9ETg79hIV0cUYv76nw==
X-Google-Smtp-Source: ABdhPJzfEquR2QO+umOic9DAn0AdD1jVWAYZuPfiKJt/sgNTwqZqw6QblJjx9+vfS5OsjUDZCV6WMfryL7AvY8Kj96c=
X-Received: by 2002:ac8:7412:: with SMTP id p18mr292907qtq.49.1624293954415;
 Mon, 21 Jun 2021 09:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <9D4A658A-5F77-4C33-904A-126E6052B205@linux.vnet.ibm.com>
 <CAFpoUr3g5t3Z0BtW4-jnYomc3cdY=V5=Zt94-C+fHOjGWa107w@mail.gmail.com>
 <CAKfTPtC=aXasuSNvn+A3152-4xoOTWROhJpZAVq6RLh1Hacpng@mail.gmail.com>
 <CAFpoUr2o2PVPOx+AvatjjUvqPTyNKE3C6oXejyU3HVMmtCnzvQ@mail.gmail.com>
 <6D1F875D-58E9-4A55-B0C3-21D5F31EDB76@linux.vnet.ibm.com> <CAFpoUr0iWFTq2grtnX_EH6KnZLZQCg1o6_yv1gfDK8WdbHmUCA@mail.gmail.com>
 <CAFpoUr3Wy9raHx+Dc0S8TB_Xi=E+Epsh_pA3DEFZP4eKf7s07A@mail.gmail.com> <20210621162243.GA29874@vingu-book>
In-Reply-To: <20210621162243.GA29874@vingu-book>
From:   Odin Ugedal <odin@uged.al>
Date:   Mon, 21 Jun 2021 18:45:15 +0200
Message-ID: <CAFpoUr1hyAeFSCvyJU4SKjtEKn6Hq1RLuu1eZPhRt1SaAq7=TQ@mail.gmail.com>
Subject: Re: [powerpc][5.13.0-rc7] Kernel warning (kernel/sched/fair.c:401)
 while running LTP tests
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Odin Ugedal <odin@uged.al>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        open list <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

man. 21. jun. 2021 kl. 18:22 skrev Vincent Guittot <vincent.guittot@linaro.org>:
> I would prefer that we use the reason of adding the cfs in the list instead.
>
> Something like the below should also fixed the problem. It is based on a
> proposal I made to Rik sometimes ago when he tried to flatten the rq:
> https://lore.kernel.org/lkml/20190906191237.27006-6-riel@surriel.com/
>
> This will ensure that a cfs is added in the list whenever one of its  child
> is still in the list.

Oh, yeah, that is a much more elegant solution! It fixes the issue as well!

Feel free to add this when/if you submit it as a patch:
Acked-by: Odin Ugedal <odin@uged.al>

Odin
