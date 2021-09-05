Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FDF4011C3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 23:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbhIEVZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 17:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbhIEVZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 17:25:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78333C061757
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 14:24:35 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 192-20020a1c04c9000000b002f7a4ab0a49so2710365wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 14:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=saO2PLp8tH6FyRu31V4/jVR5ahw84Vxja4MZDC54Af0=;
        b=HuGLq9krOAyeDLV8Id9e23NIi1mJ+xi7hLyyoim9gjVlzT3rl1OnPjr7somRcCbXZA
         gTHmhNMWe81BFhBXEvxvrs1TCLqlsu2cDioqfIyjc//U5y6+DhOLrIiJbuca+NIE/O0C
         mx5DVlxoi3plKYC1mshL5LTLh2NI1uXxPCAkguAn7h3tmzxW0/9mWkTi+DFUW01ZgSWs
         9KAu0H/D9BBaY3pHZEkD61ph5P1fshXNt6k9c+9MzKnoOTccC9Gk3BcCJp4uctgo0gGw
         y55iGlT9w7VGEmjyXR9g6E1MVhf29Y8kNK572S03dLoepRsY+dwTwB5UB4vxHfkie7Ob
         e/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=saO2PLp8tH6FyRu31V4/jVR5ahw84Vxja4MZDC54Af0=;
        b=qyUhmK3bWu72lw5NYRFwDOfQzZkrKNBFKKjzRomWCFPq+hkFxFdv7tBGyP8HuquPQO
         Dtj16Kl2l1SR2Kei4VXc8/wLGW9ha0n3KuF/Le2a3Bzo7xj7qp38u1bYBVQ7K21vg45j
         NEOfTFRv6BH91fRnVbwgXbTp2/7p2AaORSi0sUjOrVJRkjIJizc712L9lIA1kqc7j5tN
         Rm1GqcPzOvDdrkr4MGMQnmXUhiEGC5eoIeuJZb89PcYdIH/pca/Vk4eQK7U8OZHfAKD2
         TgvLOWy+Lh2T6JwXDvBR9I0ZdnKeLOEW7lI7HP6FrJqYgT+TFYFJqYzYTBwrMgsJfsho
         6GHQ==
X-Gm-Message-State: AOAM530jTFN711tAbaKdE3/V7jzFJQkj5vTbUS31VlB78Zp+4mADauBU
        v/Bog2aLbFNae3bG3Jh5IcKA4TWJ9Yva31IV4D+uHQ==
X-Google-Smtp-Source: ABdhPJzhDU211jqNtf99d4ch91XmC2+g1ndKtKy3gMf9afmnU8co4OtbBjLSdnPFybOWMwelWwCfAkTng1vDItm0TKI=
X-Received: by 2002:a7b:c387:: with SMTP id s7mr8454749wmj.26.1630877074069;
 Sun, 05 Sep 2021 14:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210806134109.1182235-1-james.clark@arm.com> <20210806134109.1182235-3-james.clark@arm.com>
 <d2379e72-a285-c63f-8c32-806e412458a3@arm.com> <YTIB7aNBErDCK+sf@kernel.org>
In-Reply-To: <YTIB7aNBErDCK+sf@kernel.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Sun, 5 Sep 2021 22:24:23 +0100
Message-ID: <CAJ9a7VjdFM+w0p-tJbkx2MDQPwetrau1amasa4ju2_3iLrXLfg@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] perf cs-etm: Initialise architecture based on TRCIDR1
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sept 2021 at 12:07, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Fri, Sep 03, 2021 at 09:55:37AM +0100, Suzuki K Poulose escreveu:
> > On 06/08/2021 14:41, James Clark wrote:
> > > Currently the architecture is hard coded as ARCH_V8, but from ETMv4.4
> > > onwards this should be ARCH_AA64.
> > >
> > > Signed-off-by: James Clark <james.clark@arm.com>
> > > ---
> > >   tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 16 +++++++++++++++-
> > >   1 file changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > index 187c038caa19..787b19642e78 100644
> > > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > @@ -126,6 +126,20 @@ static int cs_etm_decoder__gen_etmv3_config(struct cs_etm_trace_params *params,
> > >     return 0;
> > >   }
> > > +#define TRCIDR1_TRCARCHMIN_SHIFT 4
> > > +#define TRCIDR1_TRCARCHMIN_MASK  GENMASK(7, 4)
> > > +#define TRCIDR1_TRCARCHMIN(x)    (((x) & TRCIDR1_TRCARCHMIN_MASK) >> TRCIDR1_TRCARCHMIN_SHIFT)
> >
> > minor nit: Please add a blank line here
>
> Fixed it
>
> > > +static enum _ocsd_arch_version cs_etm_decoder__get_etmv4_arch_ver(u32 reg_idr1)
> > > +{
> > > +   /*
> > > +    * For ETMv4 if the trace minor version is 4 or more then we can assume
> > > +    * the architecture is ARCH_AA64 rather than just V8.
> > > +    * ARCH_V8 = V8 architecture
> > > +    * ARCH_AA64 = Min v8r3 plus additional AA64 PE features
> >
> > Does this need to be >= 3 then, to be accurate ?
> >
> > The comment "reads", minimum v8.3 and any additional features.
> >
> > Otherwise looks good to me.
>

Behaviour correctly matches OpenCSD decoder requirements.

Reviewed-by: Mike Leach <mike.leach@linaro.org>



> Didn't have enough coffee, I think, can you please provide this as a
> patch? :)
>
> - Arnaldo



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
