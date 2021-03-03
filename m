Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDA832C321
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353188AbhCDADi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388010AbhCCUXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:23:44 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDE9C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 12:23:03 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id a9so10869931qkn.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 12:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=aYIGK66WS1KcA2ZXHhqfbQI3240kSMVHBkovtDH7WnQ=;
        b=Sby88J53BdDHPl6ryOwymuczmGeC0Ehpj6baNLJ6q/E5MmpUsDOdP2DMoW8TLlOS0P
         MzWA1qomUvAC5p5+h4tsfyyugqNKhG+BgsowZzvpMPgaBAynHYPKMoD/8uQdVnzl8YG8
         1G7bY84o2wPITS5nbto1j+Q6zTNATzfmxb6oQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=aYIGK66WS1KcA2ZXHhqfbQI3240kSMVHBkovtDH7WnQ=;
        b=ewb1AUsCbvJiXyxFkYLaJMKspa38V9gnFUxUWEsvY4mJQYfLy/JahyPsJORiB5pU9f
         ajPSfi/hvIwNtAGox5C18UdaVdOEEz39nT5aEbWJA5XC2dxb2hDDofuct2NCEA7cbhJm
         qJLID8e97Yhe67BrUj54i8q0tLoT4MD0Q6mIgO6jPO9zS1LGyqxY9IHIvZ6qwnD5VcH5
         gOeMOkqZYIM1h53q7kHxxZq8VqywugVRKrjpsi8NaLSB66BKcMHyoKfxF8yhKATeFcej
         5jP8Rvbre3SFgMG10owtUApivMzvtLelb/znZVVMX+02GvWwznd+JCBdNVLSftIingue
         xJRQ==
X-Gm-Message-State: AOAM531wh6TdumXiK4Nkf+jOq2gL2sNKClrVvnoW3VFJItnUsdv4uBxU
        f0TgEopmRd91hoWP0HnUoZUPfw==
X-Google-Smtp-Source: ABdhPJxR94rnbvC/WKPK655xYGFt/+PWcp5ZWzXl2hB/jE6DrwAw+yMmCwRZ1d8KtF7N2Cwnswy3wA==
X-Received: by 2002:a37:5088:: with SMTP id e130mr789061qkb.321.1614802982849;
        Wed, 03 Mar 2021 12:23:02 -0800 (PST)
Received: from macbook-air-2.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id p12sm15764423qtw.27.2021.03.03.12.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 12:23:02 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Wed, 3 Mar 2021 15:22:57 -0500 (EST)
To:     "Liang, Kan" <kan.liang@linux.intel.com>
cc:     Stephane Eranian <eranian@google.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [perf] perf_fuzzer causes unchecked MSR access error
In-Reply-To: <9df5f72d-a959-fe46-400a-7dca6c596478@linux.intel.com>
Message-ID: <a8cebd2-a0fe-2ade-30d6-d592b3423db@maine.edu>
References: <61a56699-aab4-ef6-ed8d-a22b6bf532d@maine.edu> <7170d3b-c17f-1ded-52aa-cc6d9ae999f4@maine.edu> <YCVE8q4MlbcU4fnV@hirez.programming.kicks-ass.net> <32888c33-c286-c600-66cb-8b1b03beeb8b@linux.intel.com> <6c1f8e-f81-a781-e594-368e7adef0c0@maine.edu>
 <CABPqkBRp17EMqgoO3LTC-hTkpbv2njFO-Kkf-RifrSksdGfEaA@mail.gmail.com> <9df5f72d-a959-fe46-400a-7dca6c596478@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021, Liang, Kan wrote:

> We never use bit 58. It should be a new issue.
> Is it repeatable?

yes, it's repeatable.  

(which I'm glad to see because it looks suspiciously like a memory bit 
flip)

Though since it's a WARN_ONCE I have to reboot each time I want to test.

If I get a chance I'll try to come up with a reduced test case but 
probably won't have time for that today.

Vince


