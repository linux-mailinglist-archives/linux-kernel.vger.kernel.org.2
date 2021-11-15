Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DE744FE5E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 06:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhKOFbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 00:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhKOFaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 00:30:55 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA61C061766
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 21:27:59 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so17508062otj.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 21:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0KUIHUy0806Q9hFGnixEypWdxlkA7g/t33VhtSh3NxY=;
        b=T5BF7cluYfzR+FFJGYkCES/IViLHVwEcH12gc/Za84BlP91pqYX4Uyg/ataE1B88WP
         GwhdmkP7kyU4tAYs2S66rPjjyDhxDh/cpnOPFGXbZw/4CyAYRVmiNIryNGO1LFSAo/7V
         8WKf+rVNX0E1MrJg7Hr7P5pqa8xpO1lV35O5IaGFEEYgIQO1hTgKPUpQJcciT7WdYVnZ
         v2k9e4gZOGHcPwHqduVGTL9oHESirlSsVSx+kOvkFuqyKdz37tzZ3wLKDdiVJK3m5yOQ
         DZ/cnJfI4fP/PDmSojwUMRjnkaBQApl/LjWPNpLs9dwDPe+cF2RMi3eV0Es2VdtLpZPe
         Ewxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0KUIHUy0806Q9hFGnixEypWdxlkA7g/t33VhtSh3NxY=;
        b=3SXBNm3NwKR8iH6VChWoNJU/mWSnTAmLSnDIiDsO3i+SM+5XabkN5Sv98OPXXTCnOE
         4ku1RzuY2ZWlp5k8QxTaldI3dhMF6cD9t1u3M3LdUA8ZS0tPxZtk5nK2U00VEW7iFgmc
         4m+Sv2Ljk4lLeMOyhh+j0wvCaZxx7yAH0pRw0q/6aKjTye5UCDsFZsjagjdTF4Kv3zLB
         4QQPDkrWBzENuOa21DBaw56o7GY/LaBwlAgSpCe/55JLQobo2sNLva3groExcoaEnUML
         eRAJp2GkR2VhW12K0i/fQ3yl8Vtw4YyvQ9VF3l4eW/HbGTTfmaPeMrkXW/x6awjWf8+R
         BGaA==
X-Gm-Message-State: AOAM532EHiZatGlUIC5o4t+BQIW2Qtyhu7S5x8Ryt5k1ih9tA4SNXXQw
        NL3LxRtr4f0JsfRI8a+Aex3bTksjqcaD15p++E5Hww==
X-Google-Smtp-Source: ABdhPJz+8GraqEO2LELBEFZ6CWfkCmRPhByZYhHbjvLczVCjTtq+ZNfhCFgUS7jPO9KW3Qk64kAKMKVqV5+XfgFbSDY=
X-Received: by 2002:a05:6830:34a0:: with SMTP id c32mr30343456otu.379.1636954078482;
 Sun, 14 Nov 2021 21:27:58 -0800 (PST)
MIME-Version: 1.0
References: <20211110105922.217895-1-bhupesh.sharma@linaro.org>
 <20211110105922.217895-14-bhupesh.sharma@linaro.org> <5fe9bb9f-ded6-1aa4-347f-ef5cd0b21358@linaro.org>
In-Reply-To: <5fe9bb9f-ded6-1aa4-347f-ef5cd0b21358@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 15 Nov 2021 10:57:47 +0530
Message-ID: <CAH=2Ntzd9SvepuFU6LGsrnZJ=Ef1WDMsgASESqRcCsAkaCmGjw@mail.gmail.com>
Subject: Re: [PATCH v5 13/22] dma: qcom: bam_dma: Add support to initialize
 interconnect path
To:     Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        stephan@gerhold.net, Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On Fri, 12 Nov 2021 at 16:02, Vladimir Zapolskiy
<vladimir.zapolskiy@linaro.org> wrote:
>
> Hi Bhupesh,
>
> On 11/10/21 12:59 PM, Bhupesh Sharma wrote:
> > From: Thara Gopinath <thara.gopinath@linaro.org>
> >
> > BAM dma engine associated with certain hardware blocks could require
> > relevant interconnect pieces be initialized prior to the dma engine
> > initialization. For e.g. crypto bam dma engine on sm8250. Such requirement
> > is passed on to the bam dma driver from dt via the "interconnects"
> > property.  Add support in bam_dma driver to check whether the interconnect
> > path is accessible/enabled prior to attempting driver intializations.
> >
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > [Make header file inclusion alphabetical and use 'devm_of_icc_get()']
> > Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>
> please let me ask you to swap your and Thara's sob tags above, there is
> a rule applicable to all cases dealing with someone's else changes:
>
>  From Documentation/process/submitting-patches.rst:
>
>    Any further SoBs (Signed-off-by:'s) following the author's SoB are from
>    people handling and transporting the patch, but were not involved in its
>    development. SoB chains should reflect the **real** route a patch took
>    as it was propagated to the maintainers and ultimately to Linus, with
>    the first SoB entry signalling primary authorship of a single author.

Sure, I will fix it in v6.

Regards,
Bhupesh
