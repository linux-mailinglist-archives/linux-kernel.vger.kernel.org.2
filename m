Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4416390740
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhEYRQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbhEYRQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:16:19 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03125C06138A
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:14:49 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id s19so30954966oic.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UMrYaCknsZ9gnGhoqmMmsH4nd1WboOXoSjeEdSMCQs4=;
        b=ftfvDnRgHPDxriwA4tTcY2o2Q4HsZfPdEYMzQhs5uEikNq96E+dPdgNRChF4bAJ7lt
         gIZJsUoyDg5kzVVfcW2SAZuHlzA2ywibrKjRLmb1/BJdvUzqdxzT+2CUnXkbXHJWEHH7
         xB0fROhXCehX/NqjeOxfHiIwitidswNG9G18cbEMpRk/dFgWYqoeL8lRFhLF/Sy38qjF
         VnZUXQINZKODxvW+VS0gVlR+bGHqfQ4YTKqKrttoa5AhlS/96lVwJ+vjhv8+UfEM9Byi
         fAKYtSxb33+8phZntntIEGv3m44TDaSOfy8Kck0m5A1MWRYVpOdTmq8vbPJkP6OfQwYd
         Ztnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UMrYaCknsZ9gnGhoqmMmsH4nd1WboOXoSjeEdSMCQs4=;
        b=osNon5KVkSKtyiUVpx82mfK587VuySr4ipKX9MX8w1REjbh8pHD0NGk0yOikl1m36N
         cFRu3T/wPkxAvqxcA7RYNvpUrdCdNnwM3PiOgcVKfNjF9dVfssIB5f4wuDcI92BdS0uZ
         phRRi99a7g4j3htvUPZf3bjgXL0Ca+K5GDioa3qo+jsNN9FK+eq8jOJYqSrcfnufrWgR
         HyT1d2Wau8Iozr9eUZzktZhIitrXW5Lh5/oYpchg2bcLWikz8PCxuD5iBRjlWHSBzVyi
         0U+07fSm5F3UAeUCLFJLEdSiIL8ZqJLIHvtUg+HHlYq5FPLkDUQ6JDnmEANxhL7Sh0e0
         i8jA==
X-Gm-Message-State: AOAM5302CzjplIW0K2DFy8V83NK0L7lOYMANZBbiwFo5rQlj+HM0e2GV
        8b1NRkAyHecqmpsMrYNuyS6+AQ==
X-Google-Smtp-Source: ABdhPJwoxAXZyJQSiKouIg7L2awZGjV7IjT/50t/5yu17UNzRYnH2+hZ+ySLcF1jiFYUIX2Jlb3jGg==
X-Received: by 2002:aca:30cd:: with SMTP id w196mr3505764oiw.167.1621962888344;
        Tue, 25 May 2021 10:14:48 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m66sm2805314oia.28.2021.05.25.10.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 10:14:47 -0700 (PDT)
Date:   Tue, 25 May 2021 12:14:45 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, Eric Anholt <eric@anholt.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iommu/arm-smmu-qcom: Skip the TTBR1 quirk for db820c.
Message-ID: <YK0whQrWpehkxTrL@builder.lan>
References: <20210326231303.3071950-1-eric@anholt.net>
 <20210329144729.GB4203@willie-the-truck>
 <CAF6AEGugpEk396DVtWX=W+uf3p-wcgBfCSpSLWGQJE1vKpJ4aw@mail.gmail.com>
 <20210330093432.GB5281@willie-the-truck>
 <CAF6AEGvCCWvmRBhzY4MsdzgwfJ+GF2AUOS-_NTyhM8wtnDzY2Q@mail.gmail.com>
 <20210330153050.GB6567@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330153050.GB6567@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 30 Mar 10:31 CDT 2021, Will Deacon wrote:

> On Tue, Mar 30, 2021 at 08:03:36AM -0700, Rob Clark wrote:
> > On Tue, Mar 30, 2021 at 2:34 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Mon, Mar 29, 2021 at 09:02:50PM -0700, Rob Clark wrote:
> > > > On Mon, Mar 29, 2021 at 7:47 AM Will Deacon <will@kernel.org> wrote:
> > > > >
> > > > > On Fri, Mar 26, 2021 at 04:13:02PM -0700, Eric Anholt wrote:
> > > > > > db820c wants to use the qcom smmu path to get HUPCF set (which keeps
> > > > > > the GPU from wedging and then sometimes wedging the kernel after a
> > > > > > page fault), but it doesn't have separate pagetables support yet in
> > > > > > drm/msm so we can't go all the way to the TTBR1 path.
> > > > >
> > > > > What do you mean by "doesn't have separate pagetables support yet"? The
> > > > > compatible string doesn't feel like the right way to determine this.
> > > >
> > > > the compatible string identifies what it is, not what the sw
> > > > limitations are, so in that regard it seems right to me..
> > >
> > > Well it depends on what "doesn't have separate pagetables support yet"
> > > means. I can't tell if it's a hardware issue, a firmware issue or a driver
> > > issue.
> > 
> > Just a driver issue (and the fact that currently we don't have
> > physical access to a device... debugging a5xx per-process-pgtables by
> > pushing untested things to the CI farm is kind of a difficult way to
> > work)
> 
> But then in that case, this is using the compatible string to identify a
> driver issue, no?
> 

No the compatible addition identifies the hardware, the implementation
then uses this information to know that it needs to behave "differently"
on this platform.

When/if someone decides to add the necessary support in the driver they
can remove the driver quirk, but it doesn't invalidate the specific
compatible.

Regards,
Bjorn
