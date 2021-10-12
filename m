Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8458742A3C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 14:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbhJLMEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 08:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbhJLMEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:04:09 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144ECC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 05:02:08 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g8so80236008edt.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 05:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jAcPXDzhn5XqOaTwDcEtw2GqEA7kUJwUT0gZY1JmW2E=;
        b=DPbfSiPVobJV2Q4NaUz4Zx8nPPKhVu6lJzZlNHK5+NGhnm7VVxJM15ZtYtoouecq+T
         I2rMiguacPD+JNJXmaQYRwqmIh90Lz06EG2Go8VBTHdd2K2Co3HcWaaBp2EMy/kY7cEy
         f1i0P0hEAeI6wW+/WCP3FKhW8YU873ZrRuk5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jAcPXDzhn5XqOaTwDcEtw2GqEA7kUJwUT0gZY1JmW2E=;
        b=at99S8FTeYozpui2Ew56fOyiQrcGrNKOWg04XjAk+wSjxk0tWxY35cxc0xVF5uUoDY
         oQtsbhl8MJb1H2yyrPejwh+sMyXIdm9cpdZRfd29LXrCLhuPWx1Z/OeKD05Vz/03aDQn
         10CRzIFh3Gz/R6hKl2OB9GQ5OlVLoq3MzxhI0wTkLremKuy8jW0FG429hBNZIv2W9dor
         0fPllAGgLZ9nsMBtqNVB7rn3f7Sy3A7zepymQTq1xKhD+cCX0k1m0U8Rfvt/1ePnL0zc
         nE26Hu/7k2wG/zmCh3PvJw2VlS/MgjyfUn8sv4hqSyBeS91yeIDd85K9LDeO1hNgRamp
         E0og==
X-Gm-Message-State: AOAM5316sJxlz5Pg9cOH7/4rpVK+7KfUQPlGeS42JXltFpEfj5kjBaL7
        YPk7H1DVAxmfpI21Ivo4qGU+oA==
X-Google-Smtp-Source: ABdhPJxVaLcLFS1DQQkiZKIzmjq2hDClhDm1yvv4cdEua6mm59xty7Y5iVaFq2dyZFA3yDIYa/Hxfw==
X-Received: by 2002:a05:6402:1e88:: with SMTP id f8mr37837821edf.346.1634040122488;
        Tue, 12 Oct 2021 05:02:02 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:928c])
        by smtp.gmail.com with ESMTPSA id l23sm4859401ejn.15.2021.10.12.05.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 05:02:02 -0700 (PDT)
Date:   Tue, 12 Oct 2021 13:02:01 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH memcg] mm/page_alloc.c: avoid statistic update with 0
Message-ID: <YWV5OY5I0MhTtsn1@chrisdown.name>
References: <b2371951-bb8a-e62e-8d33-10830bbf6275@virtuozzo.com>
 <29155011-f884-b0e5-218e-911039568acb@suse.cz>
 <f52c5cd3-9b74-0fd5-2b7b-83ca21c52b2a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f52c5cd3-9b74-0fd5-2b7b-83ca21c52b2a@virtuozzo.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin writes:
>Yes, it's not a bug, it just makes the kernel a bit more efficient in a very unlikely case.
>However, it looks strange and makes uninformed code reviewers like me worry about possible
>problems inside the affected functions. No one else calls these functions from 0.

This statement is meaningless without data. If you have proof that it makes the 
kernel more efficient, then please provide the profiles.

As it is I'd be surprised if this improved things. Either the code is hot 
enough that the additional branch is cumbersome, or it's cold enough that it 
doesn't even matter.
