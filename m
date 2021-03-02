Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1329932A1CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836259AbhCBG7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 01:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577069AbhCBFlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 00:41:03 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C64C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 21:29:47 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id z128so19140594qkc.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 21:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=N1mhTziR/Fv3ciKYiN8cwOfkgc4AF06adljZoGJan/o=;
        b=PZYYS1/0gcD51P2V0wWx3V23xsHFKnN7WQELz25uu/eD8plH/lA+Ev1Cw4Zg8q5EaX
         ilLeGw6tumS5BoCgp1SQCE9iNceG+ts9tjEXZNrPLgFY406wVZlVD4hDRro5JR/ZnKzo
         cTM54LHGFtsCxsq93cpw2rjZvrIVbv4JBdjv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=N1mhTziR/Fv3ciKYiN8cwOfkgc4AF06adljZoGJan/o=;
        b=TB7Lw6y5j3QstNgpB6iU9JmWqqU697ABjGKVtLRVazhKV/bBFaO+ONCLDmzeW7FJHc
         799XpQs749oNpgr0NnhBFRjQNGJ97C1LN8Y2pSCBXR7e6agvzxRlL2d31/iZo2TzyJuZ
         VAnXrdxPIm+HRYujadtByhQouuTQtNqaK9S2KFXRqZiH4ni60C3/xvdHrPZaNkVVPOLF
         yNdEtoieP/dKCGAFEAHyPCXPbLipQwAwlthC1DsuwTQgq95dZMRpGd9GQAqLvCZeU0QQ
         swT5ZKzQrZR7CCmz7BOYVptWVmUfYxzlE/AXyrsVWIOptdU2WIMPnvTEiNQhTXbepJCQ
         kaJQ==
X-Gm-Message-State: AOAM531qtEZMiP3rDy79lkWcjUDRxYFruFy/3Ph7ctgak/KhMPVeQm2X
        Y4LgBmg0a/cp5xWH3jsGjen9t85mjyvS6Q==
X-Google-Smtp-Source: ABdhPJw2GajLBm17GL37jpL33pNL2rehhBUnbWjuzBFsOkCDkG7uqSGN8ynkxjREyLzxZa2JjByUSg==
X-Received: by 2002:a37:a48c:: with SMTP id n134mr18652455qke.490.1614662986458;
        Mon, 01 Mar 2021 21:29:46 -0800 (PST)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id z2sm12967194qkg.22.2021.03.01.21.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 21:29:45 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Tue, 2 Mar 2021 00:29:44 -0500 (EST)
To:     "Liang, Kan" <kan.liang@linux.intel.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [perf] perf_fuzzer causes crash in intel_pmu_drain_pebs_nhm()
In-Reply-To: <32888c33-c286-c600-66cb-8b1b03beeb8b@linux.intel.com>
Message-ID: <ae72b937-6a1b-cf61-353f-eeec9dfb8557@maine.edu>
References: <61a56699-aab4-ef6-ed8d-a22b6bf532d@maine.edu> <7170d3b-c17f-1ded-52aa-cc6d9ae999f4@maine.edu> <YCVE8q4MlbcU4fnV@hirez.programming.kicks-ass.net> <32888c33-c286-c600-66cb-8b1b03beeb8b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2021, Liang, Kan wrote:

> https://lore.kernel.org/lkml/tip-01330d7288e0050c5aaabc558059ff91589e67cd@git.kernel.org/
> The patch is an SW workaround for some old CPUs (HSW and earlier), which may
> set 0 to the PEBS status. It adds a check in the intel_pmu_drain_pebs_nhm().
> It tries to minimize the impact of the defect by avoiding dropping the PEBS
> records which have PEBS status 0.
> But, it doesn't correct the PEBS status, which may bring problems,
> especially for the large PEBS.
> It's possible that all the PEBS records in a large PEBS have the PEBS status
> 0. If so, the first get_next_pebs_record_by_bit() in the
> __intel_pmu_pebs_event() returns NULL. The at = NULL. Since it's a large PEBS,
> the 'count' parameter must > 1. The second get_next_pebs_record_by_bit() will
> crash.
> 
> Could you please revert the patch and check whether it fixes your issue?

I've reverted that patch and my test-case no longer triggers the issue.

I'll restart a longer fuzzing run to see if any other issues turn up.

Thanks,

Vince
