Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7723DD5F3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 14:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbhHBMse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 08:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbhHBMsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 08:48:33 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16986C061760
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 05:48:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id e25-20020a05600c4b99b0290253418ba0fbso10960361wmp.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 05:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VKO11xsjor8r4pTLuSQbHnxU20k9vn9Taln/7g7m6Zw=;
        b=hb8n4SuM+gu0M2h9LExOU03wp4PUoMWWRa+qt3mjhGTaDa+Hy6REkHW0Z399LvgjQi
         ZsXDRmSr8Nbs/+JMibOrSVEGQrQ8lMdsyRhsKJ7A6t+StKAYUmtdZf8xq14EOID4GV4b
         G9cZ8Bxyae8oXAoGJIaydxpDfc0vZ+OpcVMbQksN14KWb5VNj2kjDR8RXlNw41Fzuzve
         uqEW6+lVJaSWpYRf5rdFoVmmg9INircKqa81u4dbbayqeCOuiEgb2m13v94heOudkRnE
         nj3ux7Ia+/sn/wCYFGpWv9rV/07cIZhmLGUp9vnhQJCB0v30QAugw9qQ2EUrBxMGx4Re
         ZYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VKO11xsjor8r4pTLuSQbHnxU20k9vn9Taln/7g7m6Zw=;
        b=W0e64l9xtl6GLVOn6EXDQx6iH7uH/7FXE2JL85fU4ks4GMk6OmhhUwPnQZDNVirl6Z
         7PG+mtMW7VwTGTuzea8BPH+GOh9XfpXwz+Y8he5NVtlKgZEMcwPIzE1KyLQEiCAh2pf8
         ThZFgb/aVbvv7EW8o7MRTZpc1QIWm70QQL6TcCrkt1tq8HaSgB23Brp6CaEQm5ZIC2Kf
         mM7oNt0ObQZhzfKTMZMM7+Hg4BCdIh67KuC5NSVwxypoc09LA118L8qcNEsY3rnf7ID8
         eN0A8VvrwyElTIN7wofc/PPQSNK2/LOaQVla6ZID3XrwepJ8NXT0JTnz0kggkcDxRuT1
         yqaQ==
X-Gm-Message-State: AOAM530cljLxs7ctNdfrigjyvOBmc6NTawBMKcJh+Ux7CvZTOg3ICPIi
        DD045NGKuJV0HT8I5ALKxFYNBThC422wACXO9JCy2A==
X-Google-Smtp-Source: ABdhPJxlnx05eCshGODl7C718NCFPREwOuEZ3qujJdnK+0XbqWzHiOeDNCIiqfMR/bixn70mBq1vitNkK7o9qGsV/y8=
X-Received: by 2002:a05:600c:4fd1:: with SMTP id o17mr13207741wmq.131.1627908502651;
 Mon, 02 Aug 2021 05:48:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210721090706.21523-1-james.clark@arm.com> <20210721090706.21523-4-james.clark@arm.com>
 <20210731074343.GG7437@leoy-ThinkPad-X240s> <CAJ9a7Vj_KhV+v6VU+EQN5t818VS9jvf3v3-2JbwVMOHZbi3gcg@mail.gmail.com>
 <20210802120545.GJ7437@leoy-ThinkPad-X240s>
In-Reply-To: <20210802120545.GJ7437@leoy-ThinkPad-X240s>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 2 Aug 2021 13:48:12 +0100
Message-ID: <CAJ9a7VjhBViNuCf6sdixNYwcU6OMuGL2ccST=vCeojef6fcbJw@mail.gmail.com>
Subject: Re: [PATCH 3/6] perf cs-etm: Save TRCDEVARCH register
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Al Grant <al.grant@arm.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
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

Hi Leo,

On Mon, 2 Aug 2021 at 13:05, Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Mike,
>
> On Mon, Aug 02, 2021 at 12:21:31PM +0100, Mike Leach wrote:
>
> [...]
>
> > > Here I think the right thing to do is to support newer revisions for
> > > ETMv4, and then based on the revision it creates a decoder with
> > > supporting ETE feature.  For a more neat solution, if the perf tool
> > > passes the "correct" revision number to the OpenCSD decoder, it should
> > > can decode trace data with ETE packets.  In this way, the ETE decoding
> > > can be transparent for perf cs-etm code.
> > >
> >
> > The OpenCSD decoder separates the ETMv4 decoder from the ETE decoder -
> > for the reasons given above.
>
> Thanks for explanation.
>
> > Additionally the ETE decoder and the ETMv4 decoder required different
> > sets of ID registers to correctly set up the decoder.  For example,
> > for ETMv4 the version is extracted form TRCIDR1, for ETE the version
> > in TRCIDR1 is set 0xFF, and thus needs TRCDEVARCH to extract the
> > revision. It is likely that later updates to ETE will require an
> > additional TRCIDR register to be saved.
>
> Okay, for ETMv4.x and ETE, finally I think we need to rely on TRCDEVARCH to
> decide the tracer version based on the architecture number (arch 4 or 5)
> and revision number.
>
> > Choosing the base type of decoder in this way is how the library can
> > support ETMv3, EMTv4, ETE, STM, PTM etc - and while some of those
> > protocols use TRCIDR1 and TRCDEVARCH - not all do.
> >
> > It would in theory be possible to have the OpenCSD library
> > "autodetect" the type of decoder needed based purely on a set of ID
> > registers. But this set of ID registers would be far larger than the
> > ones currently used, and would require modifcation to a lot of the
> > existing device drivers to ensure they were accessible via sysfs. This
> > register set includes the ID registers that are currently used to
> > identify the component on the AMBA bus and match to the correct
> > driver, plus additional CoreSight management registers. This would
> > also create a dependency between decoder creation and ID numbers - in
> > the same way that each new ETM4.x part number has to be added to the
> > ETM4.x device driver.
> >
> > Such a system would require a significant update to the OpenCSD
> > infrastructure, and is not planned at this time.
>
> It's fine for me not introducing significant change in OpenCSD.
>
> If so, I understand your suggestion in another email to add a new magic
> number and a new protocol (this patch set has added the new protocol
> CS_ETM_PROTO_ETE) for creating ETE decoder.
>
> Just confirm one thing which is a bit confused me: for ETMv4.5 or any
> newer ETM IPs, should the perf tool keep the existed way to create the
> ETMv4 decoder?  Or there have updating is required for decoder to
> support the extended packets?
>

Where the trace device is identified as an ETMv4.x, then perf will
continue to create an ETMv4.x decoder as it does now. The OpenCSD
ETM4.x decoder will track any needed updates for the ETM4.x series.

Only where the trace device is ETE, there will be the new magic number
and different ID registers be used - so the call to OpenCSD will
request an ETE decoder to be created.

The register value structures supplied to OpenCSD on decoder creation,
differ between ETM4.x and ETE.

Regards

Mike


> Thanks,
> Leo



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
