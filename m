Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76853C3DBE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 17:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbhGKPzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 11:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29895 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236258AbhGKPzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 11:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626018774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SKfILU5fGcQ+5nFo5rpOMOntVrIR33CXwNVLLxwUus4=;
        b=eZu7IczmHZQ9EbwBoKfydx0DuQflMsHlXus3Iy0ckzh6oT0PTflXvpWsGJ4nZFpDnoW84P
        ahcU+XtZ2XkbFNH3InhP2tQ+kKv8Mzyc94p8ZK0sHAXM+30tXC+B/GmZwrf2TCoSBL61W2
        yBFohm+Dx+hB0cmaVx8LIbeuLsqRQ38=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-si7MGkQXMA-1AsCwO3LOUA-1; Sun, 11 Jul 2021 11:52:53 -0400
X-MC-Unique: si7MGkQXMA-1AsCwO3LOUA-1
Received: by mail-ed1-f71.google.com with SMTP id ee46-20020a056402292eb02903a1187e547cso5704414edb.0
        for <Linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 08:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SKfILU5fGcQ+5nFo5rpOMOntVrIR33CXwNVLLxwUus4=;
        b=MnAFuEfkxHono2BNQXSENhkyUU2Pd1mValzXZnDf5ntX/Ng/Dt7S6r+k5+vKcRinXK
         EGnsPP6l4MzaVwQ39viEgEhBPQsrK4Qw0TElzhb2PYBirxwZr1HlgkitW5aO8anJs6dp
         RpAFdwG/rAkcyGBf2iazb7oaXFL7RNsvVxWL7nBslaiMg63qY51kJ+j5v0IhCfnO9N9f
         pi/yWQ65YYF4qRZRH/+Azn82F3rB8NIoKI7V388zWzfzT92utOqutFuOtj1xiwf7Pwar
         FlgAzD7m0OHLHEDlGAJJdIYGJ2h+aw9jzKg4HpMVgzlFDE9d8bxoMrd8SqESlF1wPqQd
         DfFw==
X-Gm-Message-State: AOAM530oK24RsUHfiMocbBw0XKOg0xZdEKYrIe244lcof8UhSbwdhwKx
        sFLRa5jjxr3TP6UZLpjrN9Eux2+cFVbM7lQkQYzSLiDzoCLbLtByPE/uN/X0BcP88he9TaqFP1y
        yGQEn6VDud2p6PE+AMVTXKvep
X-Received: by 2002:a17:906:30d0:: with SMTP id b16mr49175250ejb.495.1626018772094;
        Sun, 11 Jul 2021 08:52:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiHr1C/qaWz5NYQRSYwO/GQ3WUulKu1HoRs0jNjCnsdlb3lmfC2gRiUQTasdihvCIvJJzfKQ==
X-Received: by 2002:a17:906:30d0:: with SMTP id b16mr49175240ejb.495.1626018771902;
        Sun, 11 Jul 2021 08:52:51 -0700 (PDT)
Received: from krava ([5.171.249.81])
        by smtp.gmail.com with ESMTPSA id lc25sm1728424ejc.41.2021.07.11.08.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 08:52:51 -0700 (PDT)
Date:   Sun, 11 Jul 2021 17:52:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 0/4] perf tool: Skip invalid hybrid PMU
Message-ID: <YOsT0NFC53WIku2k@krava>
References: <20210708013701.20347-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708013701.20347-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 09:36:57AM +0800, Jin Yao wrote:
> On hybrid platform, such as Alderlake, if atom CPUs are offlined,
> the kernel still exports the sysfs path '/sys/devices/cpu_atom/' for
> 'cpu_atom' pmu but the file '/sys/devices/cpu_atom/cpus' is empty,
> which indicates this is an invalid pmu. So we need to check and skip
> the invalid hybrid pmu.
> 
> Also we need to update some perf test cases for core-only system.
> 
> Jin Yao (4):
>   perf pmu: Skip invalid hybrid pmu
>   perf tests: Fix 'Parse event definition strings' on core-only system
>   perf tests: Fix 'Roundtrip evsel->name' on core-only system
>   perf tests: Fix 'Convert perf time to TSC' on core-only system

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
>  tools/perf/tests/evsel-roundtrip-name.c |  3 ++-
>  tools/perf/tests/parse-events.c         | 16 ++++++++++------
>  tools/perf/tests/perf-time-to-tsc.c     |  3 ++-
>  tools/perf/util/pmu.c                   |  9 ++++++++-
>  4 files changed, 22 insertions(+), 9 deletions(-)
> 
> -- 
> 2.17.1
> 

