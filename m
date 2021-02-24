Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D3D324573
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 21:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbhBXUmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 15:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbhBXUmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 15:42:32 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C209C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 12:41:46 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id b14so3625267qkk.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 12:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EwNM4IQrP65m3pBxQdPq3PIkStWcpBTasxWsf7+C0lo=;
        b=oynA0tAUXRRCGRxkmQGoFtzMRLvf+22xVNOkpXfaZ3ShiECJzsBik78xQsBCe2C7Ey
         uv/GVxd8ChE9O5nHMvqVZBh+PuvvYDYAENDW5HjbHyecOl9ca+i361mperXkFpE/ckHp
         AbJGwXquplMfFHdrnYcGkVAYrgUneo/hCd91ApPj9Fe/mDlLz3fNjPoou6lbl+UPqc26
         LoT5jV/vczsQTsBXcNmR1HX7Xqu3ITA//sVu5lz8AM1TIivwA9pWY1IrRD+of6J0s4lE
         SRKdT2CGdxuUGNRCrXK5YBk4EyH3UAVXqS/agvlVNAUqVFt2Q9cT27TzExcL7mR0aJFt
         je4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EwNM4IQrP65m3pBxQdPq3PIkStWcpBTasxWsf7+C0lo=;
        b=Qby3LWD3AFtDknogADGbatb2uqtXTC/XsozOFwQE52eL+t1TOtjev9ZZd+kZcGW7pp
         p7cOMqMv8lC7LXtgNqhcIoqvt1wXpqEzjnX4sLJmsI7RKwneDHA9qgggZqBOzv/vyvi3
         n/Si1MbU5nRl04CubRVeu9C1edyqtDnLAZZlRpJ4bmTTTYUr+zSq/ejyn8pdUiYEZmKw
         b+GDNmeA0jpkaQ19gD2Ilf5RAMBfZAxac6F2YppJVZGIMynxXWBMSUu/5DCgcPnaORZE
         xvHrrZOSRDwm3TL0xKmi6Tt3vueLwnoXYrWYMb3yt4BYA5EcyvsbqtKOjTU7ZcUqWySf
         +06Q==
X-Gm-Message-State: AOAM530656SSYbG9RRDmpstfixoQIHV+O+zcDfy79e4VChGOipkD67dg
        Y82D519yK+mwjp3epLSdBgC3pZkcivwjUw==
X-Google-Smtp-Source: ABdhPJzPS1yWCPSlG7/+kI7/ZUfr3RkdEDSt24AmwG/AErCzG1jrWZb7GS3fFAgUS97mURwqQfPsCw==
X-Received: by 2002:a37:4d09:: with SMTP id a9mr17091263qkb.469.1614199305734;
        Wed, 24 Feb 2021 12:41:45 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id l128sm2315474qkf.68.2021.02.24.12.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 12:41:45 -0800 (PST)
Date:   Wed, 24 Feb 2021 15:41:44 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: cleanup root memcg checks
Message-ID: <YDa6CPuLBPwclYp6@cmpxchg.org>
References: <20210223205625.2792891-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223205625.2792891-1-shakeelb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 12:56:25PM -0800, Shakeel Butt wrote:
> Replace the implicit checking of root memcg with explicit root memcg
> checking i.e. !css->parent with mem_cgroup_is_root().
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
