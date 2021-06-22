Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462153B055D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhFVNAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbhFVNAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:00:34 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4A0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:58:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 13-20020a17090a08cdb029016eed209ca4so2215643pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f9OF9+cTsV76jYHHpwVoZLDcZqPbxO7qKYzofSgo8Pg=;
        b=OFpxtQm5vLGwlFw+Me/BiyK4F1HGQ8R+ScFVH7VPPr9O6v+UFQ0giHLU6qr0zmDIiE
         EeBmtWHlaJhb20ucnFYs4oSmXHRtnGaXSyLjmyX9kOVzSyWlImVG9yDcQwkjcx/UwjzT
         7XMgfiR4OXKa3i03c6fhDVJxFPfLHc4MwVF3WwJ/TUmjy4s/cPJw7SHu4mer/2Oblf/I
         t//Is8QJagddM2Qe6zyv14oXp88+5Z2DXGHe6ssdL6mwomllfQf3hqx+Uf0xcC8nabf5
         wWVlYJ7UHGTIgPZPA/A3Kjp7H+deAehv5gYmrA+SOMGqE59ZukWnVnpRVlUbwWjEFud9
         kPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f9OF9+cTsV76jYHHpwVoZLDcZqPbxO7qKYzofSgo8Pg=;
        b=nyxzxaJS+jrTy/yOyTtO61B9e1MAH/MSAfnea8nJC2kLvzm41djkKsMlDTOMPfdTOs
         cvlJzxMX2qqyHdwFaUPQTEBFBCU0ZyFQmrnixnq750QnpcgauwbYwOehWR4XAtiwGFJf
         56X3bOAN+Gf+n14Rnn/xtMbPAGeDItwTvlKRS3mfQQGbMpiOO7R2J8nbq3xWKpjmjNYZ
         Yk+KTscwb/jSDrkyjTfGNlfYYRD6vk0iiMYFSjfSjOxqqkUtfrxqWRLPmG6hpYsIF+7c
         r9Aj+fjO+bowIW2wgbvpaInI5i1AkLACx3SKnDYhTWMtZ+oQlST0zKN9lLGDY73xDqAm
         of2A==
X-Gm-Message-State: AOAM5321tSOb4w9QTFpkjcA1lqeAkeM+2Qh4k+LSEuXMNCp4RC4f9CD8
        TDXDCnjCPs1TNvgYWsuGbflUtw==
X-Google-Smtp-Source: ABdhPJwkdJz6qeGI/28xb2HvyjTPB3JsW/4fcQ3R7ItNNOrcmiGKsx5LiXIznOKMKFruA1ui4k4vYg==
X-Received: by 2002:a17:90b:247:: with SMTP id fz7mr3877637pjb.137.1624366698531;
        Tue, 22 Jun 2021 05:58:18 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id u1sm17984196pfu.160.2021.06.22.05.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 05:58:17 -0700 (PDT)
Date:   Tue, 22 Jun 2021 20:58:11 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Denis Nikitin <denik@google.com>
Cc:     Suzuki K Poulose <Suzuki.Poulose@arm.com>,
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
Subject: Re: [PATCH v1 0/3] coresight: Fix for snapshot mode
Message-ID: <20210622125811.GB297306@leoy-ThinkPad-X240s>
References: <20210528161552.654907-1-leo.yan@linaro.org>
 <CAOYpmdEvkSZaei-_SWrUC4YJ7rOUOoOaxM7+qc6dw=P+b_ivgA@mail.gmail.com>
 <5cf3effb-fccc-9385-6328-6d1e2e5ccdf3@arm.com>
 <CAOYpmdE=pSaDGOm+4iCh611DXVD766eCr5dACQ+TgOnSO=4EOA@mail.gmail.com>
 <20210612032721.GB36748@leoy-ThinkPad-X240s>
 <CAOYpmdGW0U9u7zW3G6jyhZA23Uk1kd5gT00e9+g4O=k=WybDGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOYpmdGW0U9u7zW3G6jyhZA23Uk1kd5gT00e9+g4O=k=WybDGA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

On Sun, Jun 20, 2021 at 10:21:57PM -1000, Denis Nikitin wrote:

[...]

> > I'd like to leave patch 1/3 out, and resend it if we get conclusion.
> > At the meantime, @Denis, if you have observed any profiling result
> > (or profiling quality) difference caused by patch 1, the feedback would
> > be very valuable.
> 
> I evaluated AutoFDO profiles with benchmarks but I was only focused
> on the system-wide mode. And as I understood patch 1 fixes the issue
> in non system-wide mode.

Yes, patch 1 doesn't work for the system-wide mode.  In the system-wide
mode, CoreSight driver has its own reference counter to only allow the
last CPU to fill trace data to AUX buffer.

> Currently I'm OoO so I won't be able to do further evaluation.

No problem, thanks for the feedback!

Leo
