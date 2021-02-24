Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BDA3240D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238497AbhBXP3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbhBXOy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:54:26 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09E8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:53:45 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id z5so1489101pfe.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BI8tzk0bTa3w11ruMEPTU8t0ne9enBgfWEJ0ImBJsEA=;
        b=TA1T8dIkRQrmL+2z52ArQzQ7YLPMbNMS4BPXwoDyQjWviLUJUKtXfvJGJ4XPCUBD8h
         rH8V6ApP6uBZzAmVkSZ8jXs9X9htA7atNy2ULoie9NF/lIJq5+JHVlI9GiMexLgUdh5Z
         sExX4j++PBMz/d+qA1BcquZniW252SvKL523Fsio6++OZjQ6GIZKJELdKA9qyYRq6uiH
         UsblNSPu7hXwgPkWJgP4MIzg2oeBMuru4QF8OFhM6IJedYHUqiDrHW8qScPfyiqNvVOq
         6uaxjXI4/SfKUpgmMmnt7bspJknb5Q49aHQktZRQ/hgjdYY6GBNO22DULKmaFt7cdH8K
         fiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BI8tzk0bTa3w11ruMEPTU8t0ne9enBgfWEJ0ImBJsEA=;
        b=sfHNg/Rbv6vyLn7HaUabIWWBqayxhZr4TbpM11YmS6ek91RSFvBaMtbM9e+7sNDCNi
         zpX+MU/dGw908r9DIRLtmAbYXZ0D/vT0E2VBp88S8IKd1KT+n9SzZHxnlz8DQuR5KYbU
         z5Czi2TZk5K1YxQh3fm5x10zvtATi0H8J7r48mDD7UNvAJdHceE2PjPe4uSB2CvCI+6M
         uUiaqa1g/rZeOdkqqLkoUgzOroC3TvX9K5XEMJPsmKxmZ+NI8iFRpEgabMRrFK1IwnA1
         o0BxsvN35+52pI0JivDIXgj83WPeV48eu9ZWFX1tx4M3xcdBd77IWAanemL5UDrHDOrC
         Hjzw==
X-Gm-Message-State: AOAM532+/Ua+QOWgg85i3xpfE76BvSkJX9fz1h1CXXWlELrfq1Cov3Xk
        KkGqD77zAhOLkn5mbU5Cz9T3OFhajhgL8DyYdqcPSw==
X-Google-Smtp-Source: ABdhPJwrgFEiH2Ascm/wxKiYFBShzYRAAgGfjnPMoJbqNsWJxHoZMh+ezqbCWJloaKg6y2qCJ+oWOWWROotNI+bu2WE=
X-Received: by 2002:aa7:9281:0:b029:1ec:48b2:811c with SMTP id
 j1-20020aa792810000b02901ec48b2811cmr32041815pfa.18.1614178425423; Wed, 24
 Feb 2021 06:53:45 -0800 (PST)
MIME-Version: 1.0
References: <20210217112122.424236-1-robert.foss@linaro.org>
 <20210217112122.424236-13-robert.foss@linaro.org> <32b2cd1d-e41a-4571-ac4f-4ec055b3f6cb@linaro.org>
In-Reply-To: <32b2cd1d-e41a-4571-ac4f-4ec055b3f6cb@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 24 Feb 2021 15:53:34 +0100
Message-ID: <CAG3jFysEkRNXsaXudXd9msLPU3RiFcPpAgS6ecbOjeVfdwpb4A@mail.gmail.com>
Subject: Re: [PATCH v5 12/22] media: camss: Remove per VFE power domain toggling
To:     Andrey Konovalov <andrey.konovalov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        angelogioacchino.delregno@somainline.org,
        MSM <linux-arm-msm@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Marek <jonathan@marek.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andrey,

>
> On 17.02.2021 14:21, Robert Foss wrote:
> > For Titan ISPs clocks fail to re-enable during vfe_get()
> > after any vfe has been halted and its corresponding power
> > domain power has been detached.
>
> OK.
>
> > Since all of the clocks depend on all of the PDs, per
> > VFE PD detaching is no option for this generation of HW.
>
> But this patch removes camss_pm_domain_on/off calls from
> vfe_get/put() for all the SOCs, not only for sdm845.
> And this looks like a regression (higher power consumption)
> for all the generation1 devices.

Yeah, that is a serious problem with the approach I picked here. The
power difference shouldn't be huge however, since the best case
scenario savings of the previous implementation was being able to
power down 1 VFE when the other one is working. If none of the VFEs is
working, nothing is powered up both in the previous implementation &
using this patch.

>
> Is it possible to handle gen1 and gen2 hardware differently,
> so that gen1 continued to use camss_pm_domain_on/off as
> before?

I hesitated going down this gen1/gen2 split here, due to how deep into
the common code some of this functionality is. Let me have another
look at this though, not having a power regression for gen1 devices
would definitely be preferable.
