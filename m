Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCC33DDACF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbhHBOVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbhHBOVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:21:30 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C24BC04F9EE
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 07:04:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d8so21610030wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 07:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GGcJcVuBMTNniuH6oPjRek2wcyQ76GIx2ijfvVqwMm4=;
        b=yLqyflXhTARsXMrp29c8dXGjJOX7spRoIgWbHXKv/mcem+uWVf8wkF0ahVL51JEcCU
         qpZLnNkmrRM2Dg38QHfp+prX+GSGmzMwU84cKf5DqlzzqIJL7ArTlWgR4E+BnEuy9wKk
         0oYJNSJ8B0ywYxrbaWhO9iGCLOtmglVz9uFLmPzV1P2gU/SD4pRoY15k87GObRFGYKSt
         HiSwE/qjA0SzXWOUw+6l3PNU9WiItn96J4lo3c+jo37HFk7//AvgAU2ApniEgshX7AHC
         ASmYInGUUO4kuf7xxMijxqx+9oKkSKK1GdDXd7fXsMkTwFDF2ZBd89dXhCcIVrkEvuva
         vFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GGcJcVuBMTNniuH6oPjRek2wcyQ76GIx2ijfvVqwMm4=;
        b=AhKjemygvmfSYY2mjNMGySe/+u0ykZ8ErF3Jk1OfbSS91Omi3X3qCpCij8BW3eJtPx
         ynFY/+Ku34Wtjj5/uy2lYGQFEjdDq2ff/yBfFUIh2CPGwN2VoSUc3Aeu6WbtHln/K7db
         emYTYW9pcrjkhn/0IYiIfqqblTQ1CE2zTyiZrlJ3vqvPhlXUQhc+n1oK64MAQFj0FA7U
         1/YAU5x4s0OFAXGJ+Dl+WgXb4GEsFeyL8Q8yoKqEToRWiVnMGSkolx9DhDDV8LJM96Tp
         OWFdHS5IXW4sqsr1pARoZ4i+iwqCvVVGtRc8G9KtO49Ud5QotFpwXxHlNn970iPrJU29
         M0xQ==
X-Gm-Message-State: AOAM533v+5M3CTycyToDWb7OGdgmJ4UwO8Mr5NlvFU+O5aB+HTaBt/8f
        zm8PQN8735a5Bl8uYRus56gqnYFWqlXqh3xcQLhmGw==
X-Google-Smtp-Source: ABdhPJzQSJdFOi2vjtzt+Q7dSNNBb4tr6a/Mwax1tPCV9HLA/5PAckD1yG3py7TliYwlz6aX2/PJIRSJrRPiVzrgIMA=
X-Received: by 2002:adf:fb92:: with SMTP id a18mr17983431wrr.182.1627913064693;
 Mon, 02 Aug 2021 07:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210721090706.21523-1-james.clark@arm.com> <20210721090706.21523-3-james.clark@arm.com>
 <CAJ9a7Viap53OgrM2e_DU4+oymFB41jspbKbvEVFQWROt7ifuXw@mail.gmail.com> <20210731060312.GB7437@leoy-ThinkPad-X240s>
In-Reply-To: <20210731060312.GB7437@leoy-ThinkPad-X240s>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 2 Aug 2021 15:04:14 +0100
Message-ID: <CAJ9a7VhdLaP3rkXwscAQpVe+jSgcx02WjY=RmiBkaCB6ObGTjQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] perf cs-etm: Initialise architecture based on TRCIDR1
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

On Sat, 31 Jul 2021 at 07:03, Leo Yan <leo.yan@linaro.org> wrote:
>
> On Thu, Jul 22, 2021 at 12:10:35PM +0100, Mike Leach wrote:
> > HI James
> >
> > On Wed, 21 Jul 2021 at 10:07, James Clark <james.clark@arm.com> wrote:
> > >
> > > Currently the architecture is hard coded as ARCH_V8, but with the
> > > introduction of ETE we want to pick ARCH_AA64. And this change is also
> > > applicable to ETM v4.4 onwards as well.
> > >
> > > Signed-off-by: James Clark <james.clark@arm.com>
> > > ---
> > >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 14 +++++++++++++-
> > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > index 30889a9d0165..5972a8afcc6b 100644
> > > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > @@ -126,6 +126,18 @@ static int cs_etm_decoder__gen_etmv3_config(struct cs_etm_trace_params *params,
> > >         return 0;
> > >  }
> > >
> > > +#define TRCIDR1_TRCARCHMIN_SHIFT 4
> > > +#define TRCIDR1_TRCARCHMIN_MASK  GENMASK(7, 4)
> > > +#define TRCIDR1_TRCARCHMIN(x)    (((x) & TRCIDR1_TRCARCHMIN_MASK) >> TRCIDR1_TRCARCHMIN_SHIFT)
> > > +static enum _ocsd_arch_version cs_etm_decoder__get_arch_ver(u32 reg_idr1)
> > > +{
> > > +       /*
> > > +        * If the ETM trace minor version is 4 or more then we can assume
> > > +        * the architecture is ARCH_AA64 rather than just V8
> > > +        */
> > > +       return TRCIDR1_TRCARCHMIN(reg_idr1) >= 4 ? ARCH_AA64 : ARCH_V8;
> > > +}
> >
> > This is true for ETM4.x & ETE 1.x (arch 5.x) but not ETM 3.x
> > Probably need to beef up this comment or the function name to emphasise this.
>
> Yeah, I think it's good to change the function name.  Eventually, this
> function should only be used for ETM4.x and ETE.
>
> Another minor comment is: can we refine the arch version number, e.g.
> change the OpenCSD's macro "ARCH_AA64" to "ARCH_V8R4", (or
> "ARCH_V8R3_AA64"), this can give more clear clue what's the ETM version.
>

The purpose of these macros is to inform the decoder of the
architecture of the PE - not the version of the ETM.

These OpenCSD macros are defined by the library headers
(ocsd_if_types.h) and not the perf headers.
These have been published as the API / ABI for OpenCSD and as such
changing them affects all OpenCSD clients, not just perf.

This PE architecture version is used along with the core profile to
determine which instructions are valid waypoint instructions to
associate with atom elements when walking the program image during
trace decode.

From v8.3  onwards we moved away from filtering on specific
architecture versions. This was due to two factors:-
1. The architectural rules now allow architectural features for one
increment e.g. Arch 8.4, to be backported into  the previous increment
- e,g, 8.3, which made this filtering more difficult to track.
2. After discussion with the PE architects it was clear that
instructions in a later architect version would not re-use older
opcodes from a previous one and  be nop / invalid in the earlier
architectures. (certainly in the scope of AA64). Therefore
the policy in the decoder is to check for all the instructions we know
about for the latest version of architecture, even if we could be
decoding an earlier architecture version. This means we may check for
a few more opcodes than necessary for earlier version of the
architecture, but the overall decode is more robust and easier to
maintain.

Therefore for any AA64 core beyond v8.3 - it is safe to use the
ARCH_AA64 PE architecture version and the decoder will handle it.

Regards

Mike

> And a nitpick: how about to change OpenCSD macro "ARCH_V8r3" to
> "ARCH_V8R3" and assign it for ETMv4.3 IPs.
>
> Thanks,
> Leo



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
