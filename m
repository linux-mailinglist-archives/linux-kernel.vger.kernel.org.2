Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9463F1C27
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbhHSPFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhHSPFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:05:09 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4428EC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 08:04:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id d4so13597814lfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 08:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T0b4zMAvEzKfXKZwvIB0eeAlmLIDqdVoJMxNV/NqtBs=;
        b=qoP53fKMhYzr8DPWTxyX4O4kAbrnZ9Wf7TL9vkMQqok0gG+iZiQ87Rleze/VVQLQ8m
         GWJlt6/3FpblM6R0i913uDUiEsIhF6FkeNJd/wxB4mAm/udUFiU8eTi/BztM6nWJ/Aw1
         opjqjd7Rb0avhrUjmwnYT/XIlQtZYCB23D+HlZeKnktJZiMPIG7XCBpGdxiv/Lu/rB40
         zpf/AVrsB2PgcOo85i3hJ/zeDdZSLETW6DREXRYOH4VdiDOe+PxgdffK/ksc7VYZITz6
         2cMBGwdFF8uxDl/28zyuSP4KLKZLcnSwYSni4JQvp5CaqzollHNPVSWX3uBNW3DiMnk9
         lOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0b4zMAvEzKfXKZwvIB0eeAlmLIDqdVoJMxNV/NqtBs=;
        b=slo5nJC6IEbO3pkfe7/0iAHrzg60kt30sQbJw4PKej3A48gDQi3S3LeSV+cEKsU2GX
         Flf11FM+uwqVwZFFnHIFt5pUJnnc0E+9GIafSQ/cowi56zw6WhRtcdJvMxp72gXL6F8D
         dDa/bAJAxAdb6UAkcA+xzG89LqQzOwzLqssDbzaPL2092V+Z4m7G37IfZXnAQxlyDj7e
         9aSlheuU9y22ORqq0lyDktuMaLrfDCABL2gKFZOIHj6oUwHbrQsQj3INevb9ibEp82sU
         ewvs4SyhTPIIYCfzvw2DpAVk9EKmuvAPiHQpaQWB0m+igTUMlxJ4CRSbkP2M1SowMqcQ
         s5RA==
X-Gm-Message-State: AOAM531t1NFU6Hvi52R8xIr2mV4v8UR9/Z6bW969HHCONQJr5u3dJm3y
        xX91u4i/wB1uUJfD/E6jwws8d1RGZ7gaFCzmkS9vRQ==
X-Google-Smtp-Source: ABdhPJzTsjsthfdy+dJ+4wlWH97Y445qIp6Ehyno5agh0QLE3abUhbE9HSyRy+S4tlPERhOOTRJNIm8Qf5RJaWGV4gk=
X-Received: by 2002:a05:6512:3481:: with SMTP id v1mr7630730lfr.299.1629385470682;
 Thu, 19 Aug 2021 08:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210818152457.35846-1-hannes@cmpxchg.org>
In-Reply-To: <20210818152457.35846-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 19 Aug 2021 08:04:19 -0700
Message-ID: <CALvZod5y4WquXhH6BdVAyqMNqxCm=RGkOk-iBkRuW0uQPCz_1g@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: fix missing psi annotation for node_reclaim()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 8:26 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> In a debugging session the other day, Rik noticed that node_reclaim()
> was missing memstall annotations. This means we'll miss pressure and
> lost productivity resulting from reclaim on an overloaded local NUMA
> node when vm.zone_reclaim_mode is enabled.
>
> There haven't been any reports, but that's likely because
> vm.zone_reclaim_mode hasn't been a commonly used feature recently, and
> the intersection between such setups and psi users is probably
> nil. Although, secondary memory such as CXL-connected DIMMS,
> persistent memory etc. and the page demotion patches that handle them
> (https://lore.kernel.org/lkml/20210401183216.443C4443@viggo.jf.intel.com/)
> could soon make this a more common codepath again.
>
> Reported-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
