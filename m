Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F743447B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhCVOqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbhCVOq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:46:29 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1F2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:46:29 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id l13so12453753qtu.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LwwnXFrLJnjJK1iTIncYeeyDCl9ARKzeYZnwE7/jyYA=;
        b=KsBF+YAnPzSXjFXRnm6tVwPLjHs3YhsYQl5RyLcz5tzGNkY/Q6qBhoK8AmhSheWK25
         TZwkVUmS9tM/PRPFRrbpM2u4Cyn3gSkyYIWpnUDwuOm3Ged3K+IAlFW24waNNUZ6FuN3
         1XK493tlGJ+LAuWEFx8FRyISCiYgUQ1ISjWoNGoCALsyG2YzzSyp2TOzQ7DdyciI+Efk
         JrZgXDCDkwogxShrQGeugyK85vvPCDi/mp6CG/ZQWHaImSOGpiy6dZp6TlasGD+9DwWb
         yWHXxLdMeGpIBYGSuHzcfmDbAXsIMlGEWd6sDMF+DPFIbHaoXZm0r25XoI+VAB/6Hnkf
         vJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LwwnXFrLJnjJK1iTIncYeeyDCl9ARKzeYZnwE7/jyYA=;
        b=qyvGCT4C5bWcCEu8wROMNF805NzP6eazdpgzZtVEkDYblkQbsH19GADDvT1ojC9jDk
         jcBYM+bVh+/Io2UcHToaLreKwUtNdWzWnCes0ojGO2smrpfNMJ/r5G7ixBn2DHBxg6eo
         KDb5vthSB7msSr/erxlm/NV+TKNW50KB8WI30Ceq6TtcQK4AMUk5KS9F9S6hiSYpiYiv
         bsbLVg25mTbEbjUKpUAgcT2XRjFSjTJtYSAH8sQNZ1/Ixo5OqC3RR5nSwV3XhWjsqsfe
         Luf8QywxtYbL0N9hsc5F8FDW4yJue6JbdTuszNJeNeZ+LkUKX1dSby2oTCHG31Fcy+sf
         ++mg==
X-Gm-Message-State: AOAM531nAAmwefekfLnq+yvjpKtifsx5vE+iA8jSU8DoQ0o88RgfRo5F
        CfStUYSx0mM/8jATolOrHpWxEA==
X-Google-Smtp-Source: ABdhPJyUMaJBj7uazV7Won79dwd1MktbU4kfxK+q/Fp3fbR1HGtEeJy0mla0kyQ+l4HPupZufpwPQw==
X-Received: by 2002:a05:622a:174f:: with SMTP id l15mr197686qtk.197.1616424388400;
        Mon, 22 Mar 2021 07:46:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:b54e])
        by smtp.gmail.com with ESMTPSA id z11sm11229785qkg.52.2021.03.22.07.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:46:28 -0700 (PDT)
Date:   Mon, 22 Mar 2021 10:46:26 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com
Subject: Re: [PATCH v5 1/7] mm: memcontrol: slab: fix obtain a reference to a
 freeing memcg
Message-ID: <YFitwmmLFA24cofE@cmpxchg.org>
References: <20210319163821.20704-1-songmuchun@bytedance.com>
 <20210319163821.20704-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319163821.20704-2-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 12:38:14AM +0800, Muchun Song wrote:
> The rcu_read_lock/unlock only can guarantee that the memcg will not be
> freed, but it cannot guarantee the success of css_get (which is in the
> refill_stock when cached memcg changed) to memcg.
> 
>   rcu_read_lock()
>   memcg = obj_cgroup_memcg(old)
>   __memcg_kmem_uncharge(memcg)
>       refill_stock(memcg)
>           if (stock->cached != memcg)
>               // css_get can change the ref counter from 0 back to 1.
>               css_get(&memcg->css)
>   rcu_read_unlock()
> 
> This fix is very like the commit:
> 
>   eefbfa7fd678 ("mm: memcg/slab: fix use after free in obj_cgroup_charge")
> 
> Fix this by holding a reference to the memcg which is passed to the
> __memcg_kmem_uncharge() before calling __memcg_kmem_uncharge().
> 
> Fixes: 3de7d4f25a74 ("mm: memcg/slab: optimize objcg stock draining")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Good catch! Did you trigger the WARN_ON() in
percpu_ref_kill_and_confirm() during testing?
