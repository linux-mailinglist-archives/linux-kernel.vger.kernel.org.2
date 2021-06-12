Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE8E3A4C68
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 05:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhFLDam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 23:30:42 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:54880 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhFLDal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 23:30:41 -0400
Received: by mail-pj1-f45.google.com with SMTP id g24so6709361pji.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 20:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wMbJzEFA4rizeAED4h0yeaNqBh4tC+L5roFT//ohrj0=;
        b=X5FQFhk4+/SkVAlz4VPwkLe6H0Ir6Dir/Hy625SgB2RA0op3Kd/4UsRqRLCbAKCoOx
         DuV67LDfpukyDdxC8Sv6272FEQqvkMjjjwRYm+M6Ck/g4NXuWx/3aMIBX9NTLSp3kXFf
         8y21X5nKs4ZtFw4Hzdx/0f2/j8FD1OeA8/tsF2JatUOrGExLVPhnKBQXaSrg2ZUIrAuM
         2U01NxNYsn70PIaNHN+XSl+HepOqAqvuBXf5aEOT0ffP+aadqkAJ7FGtkWiefLBhbDAL
         csMZ4qWtK2g2/2BzDzdd7jCZPiyeJpys5Xg5xNnz7BMavZkBxz01MhkKOBWDJl7XqVwj
         MKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wMbJzEFA4rizeAED4h0yeaNqBh4tC+L5roFT//ohrj0=;
        b=Dsj7KdunngBX5RDWHckKraS47qcgD3hjU/VxXoXf89/HNVAibNDf0ayoEqc/pFMZF/
         y2mourZ/2jtxCEEcO+KfQtnVCs3gRrLE99WG5kuJ9cbp2loUfu5cpYs2tGnXzQHs0DKF
         otxABBnIYyRVqe2tROCh1Yo+/ENgNMBLdLuHVsU5B+F9NA2cjVE3pfg/a8pi4WtKKwPp
         gfoT2PaAMqnW4lkcgVdv5iiai46r3IeQPthBiW1GX84sqTQkn3ycnS6DQqphOTz867JY
         uFTTlWOyF4wq0fK9QIGm1XZ3MN8xpOHc/ifYMa39bZogOqgF7GkaOu1mL0jLESW/dO45
         qzRA==
X-Gm-Message-State: AOAM531Bh3EZKCoup4iZWjRtK9Jq8mk0nsmWiHJlFxjaTEeUOM4r8/EO
        wUg8sDK152hwKw3pTp3Mue1FCQ==
X-Google-Smtp-Source: ABdhPJytUShYTPDharDBywS2Z7+9/SAE4GGzuMWqdRZhU84lmAt50glv7oQXNpqThsQEZhK1FhfJ7w==
X-Received: by 2002:a17:90a:f291:: with SMTP id fs17mr12148977pjb.8.1623468447896;
        Fri, 11 Jun 2021 20:27:27 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id c130sm6176886pfc.51.2021.06.11.20.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 20:27:27 -0700 (PDT)
Date:   Sat, 12 Jun 2021 11:27:21 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Denis Nikitin <denik@google.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
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
Message-ID: <20210612032721.GB36748@leoy-ThinkPad-X240s>
References: <20210528161552.654907-1-leo.yan@linaro.org>
 <CAOYpmdEvkSZaei-_SWrUC4YJ7rOUOoOaxM7+qc6dw=P+b_ivgA@mail.gmail.com>
 <5cf3effb-fccc-9385-6328-6d1e2e5ccdf3@arm.com>
 <CAOYpmdE=pSaDGOm+4iCh611DXVD766eCr5dACQ+TgOnSO=4EOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOYpmdE=pSaDGOm+4iCh611DXVD766eCr5dACQ+TgOnSO=4EOA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 01:31:41AM -0700, Denis Nikitin wrote:
> Hi Suzuki,
> 
> On Thu, Jun 10, 2021 at 9:04 AM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >
> [...]
> >
> > Are you able to confirm if the patch 3 alone fixes the above issue ?
> > I am not convinced that Patch 1 is necessary.
> >
> 
> Yes. "perf cs-etm: Remove callback cs_etm_find_snapshot()" alone fixes
> the issue.

Based on current testing result, we should give high priority for
patches 2 and 3.

The patch 1 is controversial for how to handle the trace data kept
in multiple AUX buffers; essentially it's up to how we understand the
snapshot definition.  I confirmed Intel-PT and CoreSight have the same
behaviour for capturing trace data from multiple AUX ring buffers when
snapshot occurs.

I'd like to leave patch 1/3 out, and resend it if we get conclusion.
At the meantime, @Denis, if you have observed any profiling result
(or profiling quality) difference caused by patch 1, the feedback would
be very valuable.

Thanks a lot for Denis' testing and insight review from Suzuki!

Leo
