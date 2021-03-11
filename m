Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF7F33729B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhCKMbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbhCKMa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:30:56 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C58C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:30:55 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id cx5so2444583qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bpKQhfKbNOf9URva/nSmRApPfgMUfNZ5yVoPtbSlC/Q=;
        b=hyOG914C52esB98Y6REX8gcw2n2nveTRbaqHUv2QnAbTGAkUof8DtyMcFswIRCINMo
         /hGCXZwlDIJdy1fJFrC4BisRutmXEpf5vFSIqRfgDjSaVvD0ohhRv2SNSjysP+qCRq4y
         vgyEes6PIXbqxrvsiiNOXXehK0sotURvFs4Y13MnNCGEYITZWGNRhGbqZinmFxVE43TT
         zTLUJX4laK2F8GZKgSYU+SO9Ckr2B6kvr1+j+15aku1TowhwRNzhaDSU0dTnSxkeLaGj
         Zx0rXhC35K7NazktW+Xyh7idGx96C1OJ0E9DmvEUMBxaqhlLqQnWlIyqcPOcsNMCHChJ
         ZZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bpKQhfKbNOf9URva/nSmRApPfgMUfNZ5yVoPtbSlC/Q=;
        b=BG4pAvhr8o57GcVJElVDlfxaOdOvpRYHWNNo99uuXEkPZEiIuPc1xJGYoML1/K+Y42
         9264NbB+GM84qX9LtkSJ8xe0GfRDYUYPaewouQOoFdUGCVeOUB9I9dGQoilViTJTb2IG
         ni6nK1X5PC7Gw3qucSI+QIVkpjSFYSTBAjqGtCSmmgu3pIm3aFjs8azik+nNLTQayS1d
         CLVE7A1HRJsArZzYjlaR4Ct4E1cdMRH64+3SzSazssZs3HAA3rxV5Aynex+//tkO6Wfh
         5UoLSM7okylwAhHnRpNv3wUQsMka5MK01kFMFUk0zkpTQKKOsQzba95e2C9D8V/RDKGQ
         ReQQ==
X-Gm-Message-State: AOAM530G+3xn36JVsAfcVOr9TiissC8EAQawUmEq66PR4e1nhZOaoxYN
        6iQMrLa9F7MQHF1Kww2TrRgFBA==
X-Google-Smtp-Source: ABdhPJx6obP4t+MkBKuDVOsMzDRE1yOu5ShhHE7hcGxG2ide2qdrCj/cMc/BXdtiHH8T17fwBSMigQ==
X-Received: by 2002:a0c:b49f:: with SMTP id c31mr7370723qve.35.1615465855170;
        Thu, 11 Mar 2021 04:30:55 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:e6d2])
        by smtp.gmail.com with ESMTPSA id e96sm1572446qtb.60.2021.03.11.04.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 04:30:54 -0800 (PST)
Date:   Thu, 11 Mar 2021 07:30:53 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com
Subject: Re: [PATCH v3 1/4] mm: memcontrol: introduce
 obj_cgroup_{un}charge_pages
Message-ID: <YEoNfYvbMHw4ifyc@cmpxchg.org>
References: <20210309100717.253-1-songmuchun@bytedance.com>
 <20210309100717.253-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309100717.253-2-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 06:07:14PM +0800, Muchun Song wrote:
> We know that the unit of slab object charging is bytes, the unit of
> kmem page charging is PAGE_SIZE. If we want to reuse obj_cgroup APIs
> to charge the kmem pages, we should pass PAGE_SIZE (as third parameter)
> to obj_cgroup_charge(). Because the size is already PAGE_SIZE, we can
> skip touch the objcg stock. And obj_cgroup_{un}charge_pages() are
> introduced to charge in units of page level.
> 
> In the later patch, we also can reuse those two helpers to charge or
> uncharge a number of kernel pages to a object cgroup. This is just
> a code movement without any functional changes.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
