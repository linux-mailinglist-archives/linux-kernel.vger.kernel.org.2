Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1883409D58
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243356AbhIMToG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242877AbhIMToF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:44:05 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58340C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:42:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v2so2644939plp.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 12:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vfK/1h9QsUFCkVSDS838FPeS8MNkiZ5ITQXUKp/fEoc=;
        b=gnZjn1peutkcFGHrbl+EvIvj3MVzt6NF2XejDwjSLdZsr1JwRZX37aYu8hpINGLIte
         9s2XV12tlatZGnJ16IuAY4yiVZbSJtCzOvJhH9HmdgucHqacf2hIvUoB9E8CGXg0oV+l
         zXqOSfQWbjrN7fnRucE7bPiz/9pFiobuTyKuM+46E+vnINgrjdekPrkM1YGd8BNinsbB
         Sp7ZaVo2mB/55o7Hih2/qHCL2sDeXRW2BFPs3eqm/ZjbFWwhWB67noPGU9CLdOGHCLsu
         rXopYBWv666ssVHTySfRIBFWRAH2TLnjITC5U0emsfkF06g5DixShylS7dbB3WfhdKU4
         hQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vfK/1h9QsUFCkVSDS838FPeS8MNkiZ5ITQXUKp/fEoc=;
        b=MzgXX3sBMMiGKysZdELW0SzSy43XldONO7QV/ev9OuoUfDPu53Be/umke0m/uza8bJ
         MZj7ryTMlWMwEDctVAzXP06KstVabl5Ymgv2q0E9nAmXj5+G0WD6k/yX6phrNCzoJD6w
         w1YIpJYMM/FhtDBgv7TtrBwIlFN5VNi0uT/OGNmn3euv1QxSoR98uELm+OGgwGxqFcFL
         eUnLu0dhmdLBaVMyQMwd99WKzaS689wWPfvauGZYFxSh50Lv09aVYBhg3xr6K1Nfd6CV
         /TvmojF8yE4aA2TtVVh0ackFO7wMUv2zz5NcqJPUOGXiTQqbdXg1PFSWrvPOtLooTl7W
         OzFw==
X-Gm-Message-State: AOAM530e2LWAjDPXm3/hmFOll1M7QenBWrl4SVsiRxx5rUk9TARzeyXY
        /5s4gG4LsT377nvmSiVqj1RPalZP66Q=
X-Google-Smtp-Source: ABdhPJxdH+GSCsRwPAmdvdU0wBkmkttJzaWrnnoKbWQhOL8+ok29XYaQSUFzAp3Z3aYFr9gIFbu5+A==
X-Received: by 2002:a17:90b:33c8:: with SMTP id lk8mr1255361pjb.241.1631562168700;
        Mon, 13 Sep 2021 12:42:48 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id p5sm8003697pfp.218.2021.09.13.12.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 12:42:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Sep 2021 09:42:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Feng Tang <feng.tang@intel.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [memcg] 45208c9105: aim7.jobs-per-min -14.0% regression
Message-ID: <YT+ptg1Lf1kGLyUX@slm.duckdns.org>
References: <20210902215504.dSSfDKJZu%akpm@linux-foundation.org>
 <20210905124439.GA15026@xsang-OptiPlex-9020>
 <CALvZod77aP7qdwc5FkaZJf4FikeD0NwSuoJB4N94Uf0yqZFQpQ@mail.gmail.com>
 <20210907033000.GA88160@shbuild999.sh.intel.com>
 <CALvZod6M_sySPM1KaWzb=tkLxXJksVDrSheckXaiBpMC3cNeqw@mail.gmail.com>
 <20210912111756.4158-1-hdanton@sina.com>
 <20210912132914.GA56674@shbuild999.sh.intel.com>
 <CALvZod4VbdSux5RaQuhqbC7ENm39UbdkJF8LhYedbFwHKyJgfw@mail.gmail.com>
 <CALvZod7Oa7q=P0gzfA3F26bHPrNz+F-d6G9qKpSiHy9g=msM_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7Oa7q=P0gzfA3F26bHPrNz+F-d6G9qKpSiHy9g=msM_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Sep 13, 2021 at 12:40:06PM -0700, Shakeel Butt wrote:
> I did one more experiment with same workload but with system_wq
> instead system_unbound_wq and there is clear difference in profile:
> 
> With system_unbound_wq:
> -    4.63%     0.33%  mmap  [kernel.kallsyms]  [k] queue_work_on
>      4.29% queue_work_on
>       - __queue_work
>          - 3.45% wake_up_process
>             - try_to_wake_up
>                - 2.46% ttwu_queue
>                   - 1.66% ttwu_do_activate
>                      - 1.14% activate_task
>                         - 0.97% enqueue_task_fair
>                              enqueue_entity
> 
> With system_wq:
> -    1.36%     0.06%  mmap  [kernel.kallsyms]  [k] queue_work_on
>      1.30% queue_work_on
>       - __queue_work
>          - 1.03% wake_up_process
>             - try_to_wake_up
>                - 0.97% ttwu_queue
>                     0.66% ttwu_do_activate
> 
> Tejun, is this expected? i.e. queuing work on system_wq has a
> different performance impact than on system_unbound_wq?

Yes, system_unbound_wq is putting the work item on the global shared
workqueue while the system_wq is per-cpu, so on a loaded system, overhead
difference showing up isn't too surprising.

Thanks.

-- 
tejun
