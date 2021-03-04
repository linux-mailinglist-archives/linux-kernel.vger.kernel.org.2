Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5F532D721
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbhCDPvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhCDPvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:51:20 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C1AC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 07:50:40 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id d9so7502515qvo.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 07:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MapHiXi24mjJZdy/2wDbyhjMmaseZPMyC4xG/z7Ouxs=;
        b=I4jrHvQFEZOSaF6TjibrKqWLMdg2l5JjLExBkIK5mbO+xQMyPEiw7LmRoiXrbYxYva
         He37cZi/fRI3IXOLplKSYmLA0xgf4p1G4AqtwFHaOFtkxrIR7IXgBClqeOOUtjAgjywp
         YwgbI/3FfqP/kvGO2KG4P7KquVcbraMfWSMSeAB24ZIBxGiVTKa0Fecjb2SZax5Br+9H
         Jvu73/kDqORRMZ4FD5Q4iYHwi+xv+9V2l/k6X/2dkM/KW4INh9xkrRr97P8ZnHPrlmvy
         OIP5yRoUkJAwMmNGyMXttsCgrHOICnSe6QzEYJl0qAodyYNPI6W+wNv5C4tHf+FI5DOE
         HDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MapHiXi24mjJZdy/2wDbyhjMmaseZPMyC4xG/z7Ouxs=;
        b=toMsQj5fnknkA8PlLjMUtQmpffXeFEsF1VCyWbkdoERXYhWkl5w9Y47d4sVtXP46mA
         qTQgCCEDeoefXBcbOTYiZkq/ouLr74zimPhh0cfFdTvfLCNmdF9PopXM4qVDXjpIkNUS
         AqTR6NNV+WgLxwWxEsSO6fp7wUf2ZUtogn0TT2VhXCRCTSTw6ZaiDboAEAsTOS1a7Ka1
         Ey8PIX9bO4iAt7tGQlj4ZcAXbvO9pjmG4WZ3lHhYjzGJQfTOU/CsQ3wSsYYcqzV5ivYK
         KMUS2CiJROVVz+IT5nUs10Z63Rn/h2P2j3lUHGDy+pG6gqScL+F5uZo1r9m5m7TPvbCe
         W+Aw==
X-Gm-Message-State: AOAM532g+5lYVG+TJwsafmwUhOq+yso9o8+04rt0NBk7qjp/GYh+Sa+Q
        /8W6tY8c3kN8JVrbrXC5InmGjw==
X-Google-Smtp-Source: ABdhPJwIa0kHiKfDU4pFwLact/A9Vnhx+wjpRnC6dCywCmLSkLf062YFP6RerlN6bWQDCryN2LnN9A==
X-Received: by 2002:a0c:c342:: with SMTP id j2mr4301296qvi.41.1614873039572;
        Thu, 04 Mar 2021 07:50:39 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:b28e])
        by smtp.gmail.com with ESMTPSA id e15sm3461925qtp.58.2021.03.04.07.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 07:50:39 -0800 (PST)
Date:   Thu, 4 Mar 2021 10:50:37 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zhou Guanghui <zhouguanghui1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mhocko@suse.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, npiggin@gmail.com, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, guohanjun@huawei.com,
        dingtianhong@huawei.com, chenweilong@huawei.com,
        rui.xiang@huawei.com
Subject: Re: [PATCH v2 1/2] mm/memcg: rename mem_cgroup_split_huge_fixup to
 split_page_memcg
Message-ID: <YEEBzQCJFMyMy/7U@cmpxchg.org>
References: <20210304074053.65527-1-zhouguanghui1@huawei.com>
 <20210304074053.65527-2-zhouguanghui1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304074053.65527-2-zhouguanghui1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 07:40:52AM +0000, Zhou Guanghui wrote:
> Rename mem_cgroup_split_huge_fixup to split_page_memcg and explicitly
> pass in page number argument.
> 
> In this way, the interface name is more common and can be used by
> potential users. In addition, the complete info(memcg and flag) of
> the memcg needs to be set to the tail pages.
> 
> Signed-off-by: Zhou Guanghui <zhouguanghui1@huawei.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
