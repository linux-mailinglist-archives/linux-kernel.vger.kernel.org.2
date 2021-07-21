Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B4F3D11CE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 17:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbhGUOW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 10:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239431AbhGUOTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:19:06 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383BBC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 07:59:43 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id d9so2689977ioo.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 07:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XI+Dx3h7cED2ymBlyHrrhom6GxHUNS25otSbDCgTdfM=;
        b=StuwqrCNBxAbvlaItriRISqUD2bCPrwte93gRcZgZRTpbgma1yt3VbTMnXPiMYOT5A
         wS66/RgcYikmz21fweGdngLUbmyoAe3hK5pFRTh9jZlus1fm+U7mop8//e75VPGWFshD
         W8lmHS5IsP0PyTYfCpXsxiFt/RTFuRO/9WKS2MLzRnX0d/YB8Ox7xseTNkhOdAz1bq1z
         zicnkCWJKkJMNBQBYp1XGtf4+RTBQnIySSHou9FUDsOFmMV17QmHE3vNZCpvw36297uy
         MDhIhNVEtFGBXPtXDJqQA99PsjO8xZhZ4/sfFnw8K/7aSKLBw6O/H8VV6NECw9vx6eez
         31Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XI+Dx3h7cED2ymBlyHrrhom6GxHUNS25otSbDCgTdfM=;
        b=ax3vjNeztn7DkHGk0HJYvA74t0+14qieeII1IcvJH0BY47jG4vfxYra1iB53lbIu4N
         c/62dv4/nO+irnTpCgCDcDo6H4if6nLHgVbzNiHGzgbwcaMzc1isas7tiEyahNZvrwGP
         HzTJIQMOkwNCkAM4FUE3jtUF67f0HDJIWw9Kraehgw1znqjtoJz1mDdqQtJd42XcT4qa
         j2e8BL2sxl8urB6+eOfaqyljn/ztuTn6JrzuQbGqQVcIjagPls7UZTgvFlCDaTFaAsH+
         PGYg3xdQcQdMJq/vzg9mUCsHNRAWBgY3/qtCHNXcTslDsoMTGVuGM01oYrpvVi24TMzb
         KFWg==
X-Gm-Message-State: AOAM531Zy2JnKv02489hKiIfmy0EJVIL9Xo7IryWBjy7SH9h/ylBHs1K
        SrIFNZVRFgdMNTkRv8DeLd8noQ6sL84eYQXDnq+sZQ==
X-Google-Smtp-Source: ABdhPJxWig2ftKvDrXZ52oVv1Tgm9j7Gynu/T56MHNUX8Y4w0mTDu5mLA7JxdJDhGzDmynKXL3lild0by9DMwauSDc4=
X-Received: by 2002:a02:380b:: with SMTP id b11mr31300909jaa.83.1626879582678;
 Wed, 21 Jul 2021 07:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210721090706.21523-1-james.clark@arm.com>
In-Reply-To: <20210721090706.21523-1-james.clark@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 21 Jul 2021 08:59:31 -0600
Message-ID: <CANLsYkyjQi9+qM7mzWw+nxD_G36oRbN8Q8K2Vyo0rvsSnJQ90w@mail.gmail.com>
Subject: Re: [PATCH 0/6] Support ETE decoding
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Al Grant <al.grant@arm.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

I have received this set but won't be able to look at it for quite some time.

Thanks,
Mathieu

On Wed, 21 Jul 2021 at 03:07, James Clark <james.clark@arm.com> wrote:
>
> Decoding ETE already works because it is a superset of
> ETMv4, but if any new packet types are found then they will be
> ignored by the decoder. This patchset creates an ETE decoder
> which can output the new packets and saves a new register that
> is required. No new packet types are handled by perf yet, as this
> can be added in the future.
>
> This set applies on top of "perf cs-etm: Support TRBE
> (unformatted decoding)" on perf/core.
>
> James Clark (6):
>   perf cs-etm: Refactor initialisation of decoder params.
>   perf cs-etm: Initialise architecture based on TRCIDR1
>   perf cs-etm: Save TRCDEVARCH register
>   perf cs-etm: Update OpenCSD decoder for ETE
>   perf cs-etm: Create ETE decoder
>   perf cs-etm: Print the decoder name
>
>  tools/build/feature/test-libopencsd.c         |   4 +-
>  tools/perf/arch/arm/util/cs-etm.c             |  13 +-
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 151 ++++++++----------
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.h |   8 +
>  tools/perf/util/cs-etm.c                      |  54 ++++++-
>  tools/perf/util/cs-etm.h                      |   6 +-
>  6 files changed, 147 insertions(+), 89 deletions(-)
>
> --
> 2.28.0
>
