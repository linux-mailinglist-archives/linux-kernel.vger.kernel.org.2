Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC1F42CA1C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 21:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbhJMTeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 15:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231725AbhJMTeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:34:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EC9861205
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 19:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634153518;
        bh=I/2CgLAJMkMSOwsk84BPKoW2tEY0CQSRXkhHcU4catA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jc0h2Eox3PHwnp3y6+KwW6rc676RHlq60iUsVFXvyJHUONF/8+wCv7kMGDfeBO6y2
         GPWS6SQjmff55/E2i5cD+Mr+zO2Lc2RJtbmuK2gvzy9DVngY7rraVzc2fWIZu48k5n
         Hb/TJU+tzAqr9CdFN5toxT+Ro+jTM7SSURe7MClO3xVhI8Fo+65ezKIVGHEuq6DMSA
         XX/bdFqngmGFumE/JlnHOo4fkkrU49VLgYcUWhe29veD59gis/TgtncvUIuc4uEzAY
         ZQRhPkwEVgfZXLz2moilx6A7+n6PQRDbm5MOSzqJGV7f01iMZXu6204a9IFiOs5sfU
         RP5Pr6L7xjDpw==
Received: by mail-wr1-f53.google.com with SMTP id g25so11910330wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:31:58 -0700 (PDT)
X-Gm-Message-State: AOAM530346VOAzIX3li0J5N7Go9aE0Xg1CURNHSZo1J9MrABcynVYCjx
        CcdqQBMvJ/GIHVsY7ZLlE/6Y3B4cmj+f+gKEF/Q=
X-Google-Smtp-Source: ABdhPJwcHRsa/5PmSl69f+dfHjeFIK64+QOndFfYOm6WuQn3kJkoiwT4wmudegInJ/4TOeZwKrZ/YtLZ+k7ty3IYRl4=
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr1223250wmg.35.1634153516635;
 Wed, 13 Oct 2021 12:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211012151841.2639732-1-arnd@kernel.org> <20211013075803.GB6701@willie-the-truck>
 <CAK8P3a1GaQ1kjkjOP09eTUu6MR+RjhSDU9s-49MPQ1FSOMUDEg@mail.gmail.com> <20211013162024.GA7134@willie-the-truck>
In-Reply-To: <20211013162024.GA7134@willie-the-truck>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 13 Oct 2021 21:31:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0aLKv76AjuLO4kMa3hDj8LwsGxGhGToX935pdfsr15KQ@mail.gmail.com>
Message-ID: <CAK8P3a0aLKv76AjuLO4kMa3hDj8LwsGxGhGToX935pdfsr15KQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm: fix ARM_SMMU_QCOM compilation
To:     Will Deacon <will@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Alex Elder <elder@linaro.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 6:20 PM Will Deacon <will@kernel.org> wrote:
> On Wed, Oct 13, 2021 at 10:33:55AM +0200, Arnd Bergmann wrote:
> > On Wed, Oct 13, 2021 at 9:58 AM Will Deacon <will@kernel.org> wrote:
> > > On Tue, Oct 12, 2021 at 05:18:00PM +0200, Arnd Bergmann wrote:

> > I was hoping you and Joerg could just pick your preferred patch
> > into the iommu fixes tree for v5.15.
> >
> > I currently have nothing else pending for my asm-generic tree that
> > introduced the regression, but I can take it through there if that helps
> > you.
>
> I also don't have any fixes pending, and I don't see any in Joerg's tree so
> it's probably quickest if you send it on yourself. Is that ok?

Sure, no problem. I ended up adding it to the arm/fixes branch of the
soc tree, as I just merged some other fixes there, and it seems as good
as any of the other trees.

      Arnd
