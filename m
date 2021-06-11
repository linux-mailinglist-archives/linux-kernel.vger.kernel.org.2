Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C593A3E09
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhFKId4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhFKIdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:33:55 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BB2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:31:58 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x73so3863486pfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 01:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cAB/UwhAHDGmcVhvAUE+9+s9TWealeOysnGvocg2cfM=;
        b=XvMSWmDKiDxG6Qw243JTJkuBudsy1ozJ9c441W80PQroqDHCyikMm5WWM+Gi5Klh1M
         u6cDujtRq9g1bM8UMtxnNIbbYbysn5+VBhIbHfTqjQ7Jxpqt/zXTorLt2D59V0LXYWj6
         UAX6TGsPGnzzy3wUTfKLbFonLfUcv+50N9Pu2muJhSflis8PEOSmrQiTCis+CAPXaHM+
         Sc1fDLo7SPOs5/KivpzpN3cbICC+LeRAT/tXFv0b14vNrh+Qc73sSG3KNf8BIWif4nh8
         Jd1qg2+YpDVLeWraB+hxF3c6+p7OX3FDPqJzyW1qu4zagM2H3ytN2JrJirPj/QKHkwpk
         zN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cAB/UwhAHDGmcVhvAUE+9+s9TWealeOysnGvocg2cfM=;
        b=iEqXBFPC75wF+pvc0JZiosi4gU0fubLXSP/SWRifHXDgFY1cizFPLeOgoJ9H2/03A2
         7bEV211TqA7BjNyU9Xkw5Ww9GUY5a8HZpFr96H24tPdhrcj/gm2MgQI7/pjHGe4BqzdZ
         BxiJxPtpF4HfuqMqVQ7yfUuFycc5WZx67hv71AEPAbNFNyhgS57aoHJ5kvIyXbI2FASd
         eREbm47BHcYjCcYtPeXJmVaFQpR3C402trQqFLjZrEQpdVSkg4NIs8sE0OrmyBn2iW2W
         2f51SGT5dxDafsOyIB4DJRdgEqrgmbrIhTmSOkvGX/Bj23lkhrLUtI50lZfCyMoD+ZHe
         D08A==
X-Gm-Message-State: AOAM532xDAM67sqw+P0XS0FXI5K+WX7SiXAKetDk3RgeKlax1ufeeiF0
        3IBHTQTTPhkPTXTGu09JVEzCUE9NXkS/8p/kYI+pIg==
X-Google-Smtp-Source: ABdhPJy6qA08ZUc5JrfN+X7cl1GtOw/GCKpz1T4TlfuBTrwMPPxoSU+x4B07O8Bdden1WqHiwwMmsNCqUbT6tOBxMsI=
X-Received: by 2002:a63:c1e:: with SMTP id b30mr2541490pgl.118.1623400317368;
 Fri, 11 Jun 2021 01:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210528161552.654907-1-leo.yan@linaro.org> <CAOYpmdEvkSZaei-_SWrUC4YJ7rOUOoOaxM7+qc6dw=P+b_ivgA@mail.gmail.com>
 <5cf3effb-fccc-9385-6328-6d1e2e5ccdf3@arm.com>
In-Reply-To: <5cf3effb-fccc-9385-6328-6d1e2e5ccdf3@arm.com>
From:   Denis Nikitin <denik@google.com>
Date:   Fri, 11 Jun 2021 01:31:41 -0700
Message-ID: <CAOYpmdE=pSaDGOm+4iCh611DXVD766eCr5dACQ+TgOnSO=4EOA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] coresight: Fix for snapshot mode
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Thu, Jun 10, 2021 at 9:04 AM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
[...]
>
> Are you able to confirm if the patch 3 alone fixes the above issue ?
> I am not convinced that Patch 1 is necessary.
>

Yes. "perf cs-etm: Remove callback cs_etm_find_snapshot()" alone fixes
the issue.

- Denis

> Suzuki
