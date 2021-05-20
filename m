Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC30338B4E2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 19:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbhETRIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhETRID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 13:08:03 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C6AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:06:41 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id i19so6784270qtw.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K7PsYJ63dL59j+Dd8NJqcKhEcRQRpXueEm7j8EFqrA4=;
        b=oWjDfk1bKNd8MZ91d3wohIdY8MGPtMVO2eb7XVY71Z2cwLmi62OAnCvhLJbXPJNt25
         vQsBTcZ4qaCZ3hHgUZw98Eyg/dny4GcAmA/g2AyM26qTFpl6vkmkDynBpCoefdWOzvnr
         HqiV00s2SZf1E3MIUx5jhtHF9DVN3H4H3V2mL7qZjzTrlyVxawTbqgjND20+D4EWUN54
         N3gWfoF8yGeFWSSyX8EjUW2ptN+PaHRxDeKwRvc/oYHdlSr0/B0q0mOI3UBwMa1I7ww5
         qvywOXvi08KahlwBAswlM+ZCsDgZ7pYyK221oq3Qy+x5V7AnzKfvOAoIfHPjzdh4dN7a
         xlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=K7PsYJ63dL59j+Dd8NJqcKhEcRQRpXueEm7j8EFqrA4=;
        b=oKsC1ciBvm7i0UmVT0c6K792OLfbhgN3q1382Q9XW01ms6SkRUmdlEisGQ0AptblRB
         rQs8GVlZN0Tmn3VhmMTQzpYB29qGNKOVvhEqJwi53D9f6WkdiwtOlHJU1eZ74JTZBRqy
         uYYjFYTXN/mgsZIOss4Giu9R0rGcS6qeIQrcIC5Fp2B1zidRdiSTvi2R5Pg5UitjF9tb
         FkR582vnyTXVEBvyN+sVcnDIM0SSM3InsIR7jAD1cxhbXCgpqsDfD7Qa7hnR3NLsMt95
         fLPLxLqnHgNmby4bPP1mnfnaY7xu/PmUQI5bFik/9IuFvetcJi9J/9xr2PyX/6045vJl
         M5Sw==
X-Gm-Message-State: AOAM531P4IVkqjIJnSwXdII6qoF5eLwEgnfws3RbbkqmE8HCNT/6C6Hq
        vN2OQZml5iQAYYJRsxY02pw=
X-Google-Smtp-Source: ABdhPJwAciyhZPiEeP/2nOG5VEGPLlZSUy9Mec/Sdo0i7QWWBaYDqhLDTaTsCmCmadUw6hR2yOVOaw==
X-Received: by 2002:ac8:5f90:: with SMTP id j16mr6272151qta.329.1621530395843;
        Thu, 20 May 2021 10:06:35 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id z9sm2300517qtf.10.2021.05.20.10.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 10:06:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 20 May 2021 13:06:34 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        dtcccc@linux.alibaba.com, juri.lelli@redhat.com,
        khlebnikov@yandex-team.ru, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@redhat.com, odin@uged.al, odin@ugedal.com,
        pauld@redhead.com, peterz@infradead.org, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com,
        vincent.guittot@linaro.org, xiyou.wangcong@gmail.com
Subject: Re: [PATCH v5 2/3] sched/fair: Add cfs bandwidth burst statistics
Message-ID: <YKaXGpMIjJTwF9Ce@slm.duckdns.org>
References: <20210520123419.8039-1-changhuaixin@linux.alibaba.com>
 <20210520123419.8039-3-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520123419.8039-3-changhuaixin@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 08:34:18PM +0800, Huaixin Chang wrote:
> When using cfs_b and meeting with some throttled periods, users shall
> use burst buffer to allow bursty workloads. Apart from configuring some
> burst buffer and watch whether throttled periods disappears, some
> statistics on burst buffer using are also helpful. Thus expose the
> following statistics into cpu.stat file:
> 
> nr_burst:   number of periods bandwidth burst occurs

nr_bursts

> burst_time: cumulative wall-time that any cpus has
> 	    used above quota in respective periods

burst_usec may be more in line with other fields in that file.

Thanks.

-- 
tejun
