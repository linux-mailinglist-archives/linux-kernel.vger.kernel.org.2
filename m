Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EC83DD492
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 13:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhHBLVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 07:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbhHBLVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 07:21:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327B7C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 04:21:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id c9so779661wri.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 04:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/koorird9RI6rxHcMKGWVC8FpqcPw2Bxqajxw8KAm4=;
        b=aiZNE3gCayt228fGCrHvqWoMztXke8LpVWO1FnIygBy/abbs828QBj+IZEAUyXO1RI
         Jm9JuLsbnNsV3CeKbZKE3u2fpsHLWDcB5GriZExIbtLRnn5yx1H+CejY+Tszn3K1jFl+
         2oIhUVVfjNXKm7l2u6UWTLSOvFnoMk9b2sh9S6Jf7tXzLWuHgMav6vYww9Fb0Yl0piIq
         KPLvyAg4X715tfC3kuA8KSOVhNhA4pFBHeEwgcggXr2RHaUcnLCmlCMMvtkAU8ShqMus
         5c5kc8xsTCP3YMQGPqlaCfgPENZM7vSl2noQezCY99cSzsgB6tsXNxCKCpoAd5BXn0Uu
         c0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/koorird9RI6rxHcMKGWVC8FpqcPw2Bxqajxw8KAm4=;
        b=Uk8HjtVE5aoF0JsPkaNCY9/7EtepZa9lnRbQPSTuvhrnAw2CqvMVLeA/cQLJ2AE1jj
         /OtbFa7lquT+KhZ6ConEWdwzEspyaoCD0/iHGi8Hzb2gxNCLpuMzysscWH0lZ4UwPKI5
         2N3VF3tjdZBMayAtcaFB3SEGquUk/ZslFsfEp+VQPBzYksre8p8Gz1CCFl6uk2wK6rVV
         iDJVc86uTa3VcTaORg1VCRAYG1Xl0CmDRo6n3BwiKfZb9eai+S0V6R3WQ1LGQMLTj3w1
         1147Wa2IVlIZupSMGa7mIscf/AgNWSXoE6rwSNWvuvlFRhnnNzvXLNK9p4t7GIE9vCvu
         vOvw==
X-Gm-Message-State: AOAM532vbX5w6Qht8p8OV0nWTCprJ4hln8+8cCu5B75HuOrUWM3klrNI
        jN7Ux0/TAgexuj/yBLfZSFY3vjBHnfBI+56lbW4M9Q==
X-Google-Smtp-Source: ABdhPJw+wl63y5y5TpELUycesptAk3jPx8BJVJfGvYIoyZ5V7Va5STE7ZNvQjhlWpic5NsH+ZoKNK3nykh2tfhfC0CM=
X-Received: by 2002:a5d:67c4:: with SMTP id n4mr16475048wrw.176.1627903302730;
 Mon, 02 Aug 2021 04:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210721090706.21523-1-james.clark@arm.com> <20210721090706.21523-4-james.clark@arm.com>
 <20210731074343.GG7437@leoy-ThinkPad-X240s>
In-Reply-To: <20210731074343.GG7437@leoy-ThinkPad-X240s>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 2 Aug 2021 12:21:31 +0100
Message-ID: <CAJ9a7Vj_KhV+v6VU+EQN5t818VS9jvf3v3-2JbwVMOHZbi3gcg@mail.gmail.com>
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

Hi Leo.

On Sat, 31 Jul 2021 at 08:43, Leo Yan <leo.yan@linaro.org> wrote:
>
> On Wed, Jul 21, 2021 at 10:07:02AM +0100, James Clark wrote:
> > Now that the metadata has a length field we can add extra registers
> > without breaking any previous versions of perf.
> >
> > Save the TRCDEVARCH register so that it can be used to configure the ETE
> > decoder in the next commit. If the sysfs file doesn't exist then 0 will
> > be saved which is an impossible register value and can also be used to
> > signify that the file couldn't be read.
>
> After reviewed the whole patch set, come back to highlight one thing:
> seems to me ETE is only a feature introduced by new ETMv4 revisions; in
> other words, if we support ETMv4.5 or any later revisions, it will
> support ETE feature.
>

The ETE hardware and trace protocol is introduced to support new
architectural features in the PE - principally those associated with
v9 architecture and beyond. It has has additional packet types that
will never appear in any ETM4.x trace sequence.
ETE (and TRBE) are defined as architectural features of the PE - i.e.
FEAT_ETE and FEAT_TRBE read from feature registers on the core.

You are correct in saying that some features in ETM v4.x beyond ETM
4.5 will also appear in ETE, but the reverse is not true - ETE is a
superset of ETMv4.

> Here I think the right thing to do is to support newer revisions for
> ETMv4, and then based on the revision it creates a decoder with
> supporting ETE feature.  For a more neat solution, if the perf tool
> passes the "correct" revision number to the OpenCSD decoder, it should
> can decode trace data with ETE packets.  In this way, the ETE decoding
> can be transparent for perf cs-etm code.
>

The OpenCSD decoder separates the ETMv4 decoder from the ETE decoder -
for the reasons given above.

Additionally the ETE decoder and the ETMv4 decoder required different
sets of ID registers to correctly set up the decoder.  For example,
for ETMv4 the version is extracted form TRCIDR1, for ETE the version
in TRCIDR1 is set 0xFF, and thus needs TRCDEVARCH to extract the
revision. It is likely that later updates to ETE will require an
additional TRCIDR register to be saved.

Choosing the base type of decoder in this way is how the library can
support ETMv3, EMTv4, ETE, STM, PTM etc - and while some of those
protocols use TRCIDR1 and TRCDEVARCH - not all do.

It would in theory be possible to have the OpenCSD library
"autodetect" the type of decoder needed based purely on a set of ID
registers. But this set of ID registers would be far larger than the
ones currently used, and would require modifcation to a lot of the
existing device drivers to ensure they were accessible via sysfs. This
register set includes the ID registers that are currently used to
identify the component on the AMBA bus and match to the correct
driver, plus additional CoreSight management registers. This would
also create a dependency between decoder creation and ID numbers - in
the same way that each new ETM4.x part number has to be added to the
ETM4.x device driver.

Such a system would require a significant update to the OpenCSD
infrastructure, and is not planned at this time.

Regards

Mike


> How about you think for this?  Sorry if I introduce noise due to my
> lack knowledge (and platform) for ETE.
>
> Thanks,
> Leo



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
