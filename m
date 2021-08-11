Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6313E89F9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 08:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhHKGAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 02:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234325AbhHKGAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 02:00:37 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07111C061765
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 23:00:14 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z2so3306846lft.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 23:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NG7EO83tBKeNTEFEHN9ieuTKfnHQTbaF/AKGvcd8be8=;
        b=f6L9ZIlZjFCUlUCCwkVomaDzQDnr7ztMlV/LbgVnUtndHH/NiO07nhpzaeOeO+n0NG
         yoHxxPztCZBLdWgIRfSJL1Hsuu7h58QM/RkTW4YsZM5kbfI834t6qextbSz5KgM2Iqcm
         hG++NSHUfrNW5xyBbaOIcJNZVZueLKfQif8dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NG7EO83tBKeNTEFEHN9ieuTKfnHQTbaF/AKGvcd8be8=;
        b=gNfboAV/dZDTlWr+2vkM300J0hC4r24OvcH5t0hs/sLM5pTnBnEWYDhH/EOcXvSjgi
         3VNcm7FSurRpBpbLvDSfHiveZF+7CzsPYV6AgbW7i1SgQoJVK/d81WbbwQhVyHPsdsl8
         VTWGA65EpPqj0teNu+fM+BfHRVnGdXZ+E9DrxySrHzUCRuffbjs5+RUWfIgNicQsH5/A
         +OFtUAJzrTOBeXYb9zEUleVNcKFTxoKNDQHRvUfeiToqkiJIV3McKjpyURt8PF43AGlw
         TR663l562xCUw31IF/XDUB5UfldKfU6QHx/Tm0NO9ISPZxoRdP2r7fEUk+JB+z3ZNs1x
         ibYw==
X-Gm-Message-State: AOAM532F7lMRP+/7dI9143ai+NtpyC3rww/Rtl2hFA265OFMOREqG9zf
        7UJQfCku7OmqdQZYQUZtJDVRMeNJwBDyHikW
X-Google-Smtp-Source: ABdhPJw8W47/eLdRNnXF+gdH5Cudez7ldi5rW2WiXOMzyCodaU4+ubVq4gX1fQhW45lxIhgrJRmidA==
X-Received: by 2002:a19:6e46:: with SMTP id q6mr24120844lfk.399.1628661612118;
        Tue, 10 Aug 2021 23:00:12 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id h9sm2062029ljo.77.2021.08.10.23.00.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 23:00:10 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id x27so3269286lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 23:00:10 -0700 (PDT)
X-Received: by 2002:ac2:43d4:: with SMTP id u20mr899921lfl.377.1628661609883;
 Tue, 10 Aug 2021 23:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210811031734.GA5193@xsang-OptiPlex-9020>
In-Reply-To: <20210811031734.GA5193@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Aug 2021 19:59:53 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiSHHSuSQsCCLOxQA+cbcvjmEeMsTCMWPT1sFVngd9-ig@mail.gmail.com>
Message-ID: <CAHk-=wiSHHSuSQsCCLOxQA+cbcvjmEeMsTCMWPT1sFVngd9-ig@mail.gmail.com>
Subject: Re: [mm] 2d146aa3aa: vm-scalability.throughput -36.4% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 4:59 PM kernel test robot <oliver.sang@intel.com> w=
rote:
>
> FYI, we noticed a -36.4% regression of vm-scalability.throughput due to c=
ommit:
> 2d146aa3aa84 ("mm: memcontrol: switch to rstat")

Hmm. I guess some cost is to be expected, but that's a big regression.

I'm not sure what the code ends up doing, and how relevant this test
is, but Johannes - could you please take a look?

I can't make heads nor tails of the profile. The profile kind of points at =
this:

>       2.77 =C4=85 12%     +27.4       30.19 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.native_queued_spin_lock_slowpath
>       2.86 =C4=85 12%     +27.4       30.29 =C4=85  8%  perf-profile.chil=
dren.cycles-pp._raw_spin_lock_irqsave
>       2.77 =C4=85 12%     +27.4       30.21 =C4=85  8%  perf-profile.chil=
dren.cycles-pp.lock_page_lruvec_irqsave
>       4.26 =C4=85 10%     +28.1       32.32 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.lru_cache_add
>       4.15 =C4=85 10%     +28.2       32.33 =C4=85  7%  perf-profile.chil=
dren.cycles-pp.__pagevec_lru_add

and that seems to be from the chain __do_fault -> shmem_fault ->
shmem_getpage_gfp -> lru_cache_add -> __pagevec_lru_add ->
lock_page_lruvec_irqsave -> _raw_spin_lock_irqsave ->
native_queued_spin_lock_slowpath.

That shmem_fault codepath being hot may make sense for sokme VM
scalability test. But it seems to make little sense when I look at the
commit that it bisected to.

We had another report of this commit causing a much more reasonable
small slowdown (-2.8%) back in May.

I'm not sure what's up with this new report. Johannes, does this make
sense to you?

Is it perhaps another "unlucky cache line placement" thing? Or has the
statistics changes just changed the behavior of the test?

Anybody?

              Linus
