Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB123DDBD3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbhHBPES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbhHBPER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:04:17 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3EEC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 08:04:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so381247pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 08:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yiSzLcQ0rhOIXQmQUtFOQni0Knr7gzxgnUdxPIGlb9E=;
        b=qy5muWMpt8CyrPZNcGzlwQ/P0JOr6WF2X5Wl/G2/JL8lCo7Fwty634eROAUdnI8GEj
         GDUhY6/5X9pws1LIHd+Y44OfBc24JTgaXVBOMxnjMRyDrhtKqlm20ojuQatI1DD2ISXs
         sSPOpRRPJIB6VpDX1zY0vU8H0CtALnG/xfPwENyUa4+zr2vG9pc/K+oteBgaIXcq8O+V
         M/x6XVmYoxXoIgE/EmGLJKGtrSKtt3ytVGq86s2siSRArLU5rzWCStmeXevKoXQTDCkB
         gfr/C5g4oBSF7MLLO5QzLc+tJ5iXohBgicV4EYa/flkkirzeVyUSVaUyx9XZaXJPJCme
         N0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yiSzLcQ0rhOIXQmQUtFOQni0Knr7gzxgnUdxPIGlb9E=;
        b=fLnqcBT+Uv99FlUvtRnzbjO/bQlqQRM7oKhEpDaQtAgHT3+/1x0lkft9vjGvTmC6nf
         mosq34tzmTXkcc/ROuYRz3GVxpak4QSJEReeWDULIM7XILNcIuo5/6+MtOw2PZGr6j+v
         ajWEpo4sAJBgJ2yOxjem6esnkT7CYNyI0UcnSFh+vb9+zqF63qCl2tkwm/ffxoBFB6QL
         KzxjIBLXF0fd5f6vXKRta+QgLXUftXIOvLYQNmlsARMkM5H+msu8LdWW5k1Wt3PzzuEC
         9klXehaIT/ic/tTcWeWamvxNliYZR9pWUHjUUT32tMyfWb4rRdaYFvbEQkxser6QXiut
         +HjA==
X-Gm-Message-State: AOAM532VBkSJejGptLh08Ly+ICwLd2LadU3ukY+z31uz7RlCSZGMCK7H
        mkdP6SXlxzQ9MI90QBuvqw1laA==
X-Google-Smtp-Source: ABdhPJzZHuUn7iOZsYBKZHpMq4l2BjSdfpJhqdhI22Oh2DN6YyiuFJ8rQOQFXH7v94qV8xUYvaZpEQ==
X-Received: by 2002:a05:6a00:8c1:b029:3a3:b86a:302f with SMTP id s1-20020a056a0008c1b02903a3b86a302fmr17730218pfu.31.1627916647020;
        Mon, 02 Aug 2021 08:04:07 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id n35sm13390514pgb.90.2021.08.02.08.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 08:04:05 -0700 (PDT)
Date:   Mon, 2 Aug 2021 23:03:58 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
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
Subject: Re: [PATCH 2/6] perf cs-etm: Initialise architecture based on TRCIDR1
Message-ID: <20210802150358.GA148327@leoy-ThinkPad-X240s>
References: <20210721090706.21523-1-james.clark@arm.com>
 <20210721090706.21523-3-james.clark@arm.com>
 <CAJ9a7Viap53OgrM2e_DU4+oymFB41jspbKbvEVFQWROt7ifuXw@mail.gmail.com>
 <20210731060312.GB7437@leoy-ThinkPad-X240s>
 <CAJ9a7VhdLaP3rkXwscAQpVe+jSgcx02WjY=RmiBkaCB6ObGTjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7VhdLaP3rkXwscAQpVe+jSgcx02WjY=RmiBkaCB6ObGTjQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Mon, Aug 02, 2021 at 03:04:14PM +0100, Mike Leach wrote:

[...]

> > > > +#define TRCIDR1_TRCARCHMIN_SHIFT 4
> > > > +#define TRCIDR1_TRCARCHMIN_MASK  GENMASK(7, 4)
> > > > +#define TRCIDR1_TRCARCHMIN(x)    (((x) & TRCIDR1_TRCARCHMIN_MASK) >> TRCIDR1_TRCARCHMIN_SHIFT)
> > > > +static enum _ocsd_arch_version cs_etm_decoder__get_arch_ver(u32 reg_idr1)
> > > > +{
> > > > +       /*
> > > > +        * If the ETM trace minor version is 4 or more then we can assume
> > > > +        * the architecture is ARCH_AA64 rather than just V8
> > > > +        */
> > > > +       return TRCIDR1_TRCARCHMIN(reg_idr1) >= 4 ? ARCH_AA64 : ARCH_V8;
> > > > +}
> > >
> > > This is true for ETM4.x & ETE 1.x (arch 5.x) but not ETM 3.x
> > > Probably need to beef up this comment or the function name to emphasise this.
> >
> > Yeah, I think it's good to change the function name.  Eventually, this
> > function should only be used for ETM4.x and ETE.
> >
> > Another minor comment is: can we refine the arch version number, e.g.
> > change the OpenCSD's macro "ARCH_AA64" to "ARCH_V8R4", (or
> > "ARCH_V8R3_AA64"), this can give more clear clue what's the ETM version.
> >
> 
> The purpose of these macros is to inform the decoder of the
> architecture of the PE - not the version of the ETM.
> 
> These OpenCSD macros are defined by the library headers
> (ocsd_if_types.h) and not the perf headers.
> These have been published as the API / ABI for OpenCSD and as such
> changing them affects all OpenCSD clients, not just perf.

I understand these macros are defined in OpenCSD lib as APIs, since I
saw these macros have not been widely used in perf tool (e.g.
ARCH_AA64), so this is why I think it's good to take chance to refine
the naming conventions.

> This PE architecture version is used along with the core profile to
> determine which instructions are valid waypoint instructions to
> associate with atom elements when walking the program image during
> trace decode.
> 
> From v8.3  onwards we moved away from filtering on specific
> architecture versions. This was due to two factors:-
> 1. The architectural rules now allow architectural features for one
> increment e.g. Arch 8.4, to be backported into  the previous increment
> - e,g, 8.3, which made this filtering more difficult to track.
> 2. After discussion with the PE architects it was clear that
> instructions in a later architect version would not re-use older
> opcodes from a previous one and  be nop / invalid in the earlier
> architectures. (certainly in the scope of AA64). Therefore
> the policy in the decoder is to check for all the instructions we know
> about for the latest version of architecture, even if we could be
> decoding an earlier architecture version. This means we may check for
> a few more opcodes than necessary for earlier version of the
> architecture, but the overall decode is more robust and easier to
> maintain.
> 
> Therefore for any AA64 core beyond v8.3 - it is safe to use the
> ARCH_AA64 PE architecture version and the decoder will handle it.

I have no objection for current approach; but two things can cause
confusions and it might be difficult for maintenance:

- The first thing is now we base on the bit fields TRCIDR1::TRCARCHMIN
  to decide the PE architecture version.  In the ETMv4 spec,
  TRCIDR1::TRCARCHMIN is defined as the trace unit minor version,
  so essentially it's a minor version number for tracer (ETM) but not
  the PE architecture number.  But now we are using it to decide the
  PE architecture number (8.3, 8.4, etc...).

- The second thing is the macros' naming convention.
  E.g. "AA64" gives me an impression it is a general naming "Arm Arch 64"
  for all Arm 64-bit CPUs, it's something like an abbreviation for
  "aarch64"; so seems to me it doesn't show any meaningful info for PE's
  architecture version number.  This is why I proposed to use more
  explict macro definition for architectures (e.g. ARCH_V8R3, ARCH_V8R4,
  ARCH_V9R0, etc).

If we really want to use ARCH_AA64, it's better to give some comments in
the code.

Thanks a lot for shared the background info.

Leo
