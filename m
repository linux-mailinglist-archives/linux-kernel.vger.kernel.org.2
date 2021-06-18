Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569853AD4D5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 00:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhFRWMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 18:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbhFRWMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 18:12:12 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B268C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 15:10:02 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id o20so8691743qtr.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 15:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w4YiW4egPKdJECyPLrd6+VyczjYedyk/bEQ3LwbFh40=;
        b=kmgSmV1OQ5ftiq3+FvkzWjJQjPfeXPWXuZKSvT4MZJG4eugkNddA22USVB2l1Oscfa
         +w0Icj+IBTHRwhBa4kuvqXd97RFLazXj0fzsDSxeymKntKOlLCU+ClW68Gx8OVE4K4TR
         qLvxc2MGZKOKgfdqWSVacIeOAPQn4TwoKY/V0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4YiW4egPKdJECyPLrd6+VyczjYedyk/bEQ3LwbFh40=;
        b=GeKCdpVm4rzAhC/sETQYGzZcQdiX5NiQ4uKomA4Der7gRTnBqwVxtGRlnezwijVULh
         JCfNzDcMyRGf11emYCA/TYN1+ay41B/hxdHC5lm/K1/QGaN9IikN6Ia/jWeTQL0H+XVj
         7G19qIf+BMwDtdxhYHZh/cfVdnNQ55dJHJAj68eGaLiyjVj7O3zcuYHZ+d3FQQIPkH3+
         DpMM7e5VkFXpXABx4RDRjvmUhmbh/wCLzsYg22VrrBTcxpALt786b6Dn3P7Owq8biH8S
         XPNM9w5tY1arjAyQaSDBRbiG7UJ43SPYOHrEUP8L6LvtbgKnCoNyiE4XoA23/uU4XyGq
         vYVA==
X-Gm-Message-State: AOAM531bw+L8DLuMKFlD84z+luV0ikdKldq+Duge9ZE7cADKXILmcL/q
        kwVab4aPAQppa5rQxgsga3okkzrwZUqcEw==
X-Google-Smtp-Source: ABdhPJyhRimtRN+lyOYWLDcaMaN06DzdfBdcGVXho0nHlGFk/Dui/QgNGgAi/N73suq3Te5DWuh0cg==
X-Received: by 2002:ac8:5c12:: with SMTP id i18mr12410703qti.40.1624054201392;
        Fri, 18 Jun 2021 15:10:01 -0700 (PDT)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id h12sm4789598qkj.52.2021.06.18.15.10.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 15:10:00 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id c138so14578067qkg.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 15:10:00 -0700 (PDT)
X-Received: by 2002:a25:bcb:: with SMTP id 194mr17381339ybl.32.1624054200300;
 Fri, 18 Jun 2021 15:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623981933.git.saiprakash.ranjan@codeaurora.org> <150fc7ab1c7f9b70a95dae1f4bc3b9018c0f9e04.1623981933.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <150fc7ab1c7f9b70a95dae1f4bc3b9018c0f9e04.1623981933.git.saiprakash.ranjan@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 18 Jun 2021 15:09:48 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WA_mBnxv-D3YOYUkDAAcYgktFgnw2zeTkMneqFxBg=yg@mail.gmail.com>
Message-ID: <CAD=FV=WA_mBnxv-D3YOYUkDAAcYgktFgnw2zeTkMneqFxBg=yg@mail.gmail.com>
Subject: Re: [PATCHv2 2/3] iommu/io-pgtable: Optimize partial walk flush for
 large scatter-gather list
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 17, 2021 at 7:51 PM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Currently for iommu_unmap() of large scatter-gather list with page size
> elements, the majority of time is spent in flushing of partial walks in
> __arm_lpae_unmap() which is a VA based TLB invalidation invalidating
> page-by-page on iommus like arm-smmu-v2 (TLBIVA) which do not support
> range based invalidations like on arm-smmu-v3.2.
>
> For example: to unmap a 32MB scatter-gather list with page size elements
> (8192 entries), there are 16->2MB buffer unmaps based on the pgsize (2MB
> for 4K granule) and each of 2MB will further result in 512 TLBIVAs (2MB/4K)
> resulting in a total of 8192 TLBIVAs (512*16) for 16->2MB causing a huge
> overhead.
>
> So instead use tlb_flush_all() callback (TLBIALL/TLBIASID) to invalidate
> the entire context for partial walk flush on select few platforms where
> cost of over-invalidation is less than unmap latency

It would probably be worth punching this description up a little bit.
Elsewhere you said in more detail why this over-invalidation is less
of a big deal for the Qualcomm SMMU. It's probably worth saying
something like that here, too. Like this bit paraphrased from your
other email:

On qcom impl, we have several performance improvements for TLB cache
invalidations in HW like wait-for-safe (for realtime clients such as
camera and display) and few others to allow for cache lookups/updates
when TLBI is in progress for the same context bank.


> using the newly
> introduced quirk IO_PGTABLE_QUIRK_TLB_INV_ALL. We also do this for
> non-strict mode given its all about over-invalidation saving time on
> individual unmaps and non-deterministic generally.

As per usual I'm mostly clueless, but I don't quite understand why you
want this new behavior for non-strict mode. To me it almost seems like
the opposite? Specifically, non-strict mode is already outside the
critical path today and so there's no need to optimize it. I'm
probably not explaining myself clearly, but I guess i'm thinking:

a) today for strict, unmap is in the critical path and it's important
to get it out of there. Getting it out of the critical path is so
important that we're willing to over-invalidate to speed up the
critical path.

b) today for non-strict, unmap is not in the critical path.

So I would almost expect your patch to _disable_ your new feature for
non-strict mappings, not auto-enable your new feature for non-strict
mappings.

If I'm babbling, feel free to ignore. ;-) Looking back, I guess Robin
was the one that suggested the behavior you're implementing, so it's
more likely he's right than I am. ;-)


-Doug
