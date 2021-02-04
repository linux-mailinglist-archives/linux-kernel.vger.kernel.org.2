Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F197130D89D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbhBCL02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbhBCLYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:24:23 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEBEC061788
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 03:23:43 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e12so5043251pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 03:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RnlKEoqL6Uqu9RS0As6U8cIWvU/IELkyhrvevpKdgbw=;
        b=UCJf7UQE4VrPAHUTxOeE0IsNKU7wvCbx6VNRvt7n1unumgU7/r9krB7H9HQ61DJiq+
         rnu5L10YfSJBjuiZ3N1FUsO3PkE9uYMpjMw/S29sRWVd3poQWAQv55ENSei9Qw6cz9fa
         72ShS/6wQajSwGt31iYAFb57X45dXvNZrdCqQl57Wndd8w67cVNN2SVhJaDdiD/d0UQ1
         oyZpzeGoACyQVnDntN6hG2HHs6omTr2dyLZRvner+OzUl66HeiZHqQbK/nXFMJy8KwAr
         /jEwW4qxdj5DTG+jZPsN7itsc07ZVORplhBsVcObF66SU/pBhWlN1zDU6BCe7jzAgOMA
         OKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RnlKEoqL6Uqu9RS0As6U8cIWvU/IELkyhrvevpKdgbw=;
        b=sQKe/VDg7b5UxK5F9+8C2eNS2SMBMS44+IxgTrv2VPAMovIChMb/KWp3ZreyXCDK8E
         JSKIOOqGLq6hYNkfylFndit+/DDJAzS4R+xip2FoW8aO6DoEBB3kJJjtEiMpl4FQd4vh
         vQ885us4MxpGrOSZu3YeWi84sfJI0DdqjS1inQmJzJjunW3wG/DwgBCxb5cD+F0SyWo/
         j4N+2jTW6PdfoyKlmZDNI+hQdwDndfL8wrOQ1xOl38Glbsq1vemJkgCfgykqXyhwkGAf
         0YjWvUMWYbuTOBGabtSmCxbxytdl4rumJBNI/tB5kWgmzkNXkf2St4lxKP9bDfMjTJQi
         5ZWQ==
X-Gm-Message-State: AOAM530xixIaq/Vk3vYVgsHxCrYAa4ynl4wxkob6lIw6D4QavCSs+wDf
        o7IUFAlw7ny/XrbrS+qwC0J4S5x7wqlcCJZFot+iwQ==
X-Google-Smtp-Source: ABdhPJx4nQQVdUgmUlxyoMXLNsuDGqeQE8pvJ48nGJ398xMHkV8QhPQ2xHWO0IiNyMsiTwLSd+9zeJn/fk9UacodvKA=
X-Received: by 2002:a17:90a:9414:: with SMTP id r20mr2615124pjo.222.1612351422042;
 Wed, 03 Feb 2021 03:23:42 -0800 (PST)
MIME-Version: 1.0
References: <20210127144930.2158242-1-robert.foss@linaro.org>
 <20210127144930.2158242-16-robert.foss@linaro.org> <1612027420.831924.1419424.nullmailer@robh.at.kernel.org>
In-Reply-To: <1612027420.831924.1419424.nullmailer@robh.at.kernel.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 3 Feb 2021 12:23:30 +0100
Message-ID: <CAG3jFytNc39y4XR4j-b8mrxjUQPmoejJA6NZfszib2ZO3V_CFA@mail.gmail.com>
Subject: Re: [PATCH v3 15/22] dt-bindings: media: camss: Add qcom,
 sdm660-camss binding
To:     Rob Herring <robh@kernel.org>
Cc:     michael@walle.cc, leoyang.li@nxp.com,
        linux-media <linux-media@vger.kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Anson.Huang@nxp.com, Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Marek <jonathan@marek.ca>, shawnguo@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        agx@sigxcpu.org, Tomasz Figa <tfiga@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, MSM <linux-arm-msm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        angelogioacchino.delregno@somainline.org, max.oss.09@gmail.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Will Deacon <will@kernel.org>, Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jan 2021 at 18:23, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, 27 Jan 2021 15:49:23 +0100, Robert Foss wrote:
> > Add bindings for qcom,sdm660-camss in order to support the camera
> > subsystem on SDM630/660 and SDA variants.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >
> > Changes since v2
> >  - Rob: Add new line at end of file
> >  - Rob: Remove redundant descriptions
> >  - Rob: Add power domain description
> >  - Rob: Make clock-lanes a constant
> >  - Rob: Rework to conform to new port schema
> >  - Add max & minItems to data-lanes
> >  - Remove ports requirement - endpoint & reg
> >  - Added Angelo as binding maintainer
> >  - Removed Todor as binding maintainer
> >
> >
> >  .../bindings/media/qcom,sdm660-camss.yaml     | 398 ++++++++++++++++++
> >  1 file changed, 398 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/media/qcom,sdm660-camss.example.dts:21:18: fatal error: dt-bindings/clock/qcom,mmcc-sdm660.h: No such file or directory
>    21 |         #include <dt-bindings/clock/qcom,mmcc-sdm660.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.lib:344: Documentation/devicetree/bindings/media/qcom,sdm660-camss.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1370: dt_binding_check] Error 2

This is expected and mentioned in the cover letter due to a dependency
on an as of yet unmerged mmcc-sdm660 series.

>
> See https://patchwork.ozlabs.org/patch/1432255
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>
