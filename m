Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD27F4245FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 20:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbhJFS0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 14:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbhJFS0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 14:26:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0000C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 11:24:24 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so3110597pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 11:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7H/DPJoWMp11tmUoPKSZMQxmcZJGqCLHjQqOxlkRT3I=;
        b=JG/yky1tdDSKqvCvLBDptJd6qpCbJk/pCGNJdvJqZCaNkuwtgO8Qcc53jj4oEh+bVI
         Y3SkLqQq4cKC7q0QZpPuNzG+M8X2j8l/IFom9760x7KzzcvF2WYleCx8dF9vUIRUKYPD
         Pr00IFbquO++J1KP3uf96wTDf/XVEBiQqfLMunzqSkZ4oTOG3WTf+hv7vjGVVS6lfUTJ
         9N3531JVgATjf1E0x/bax8PmJliIbHkS5ieVenjBOxeQ73K4lyErXAf3uYE55NIf0Iag
         rs6Zs3Q2CD4weHPYYUkfnRVShQk8XkXeoGF0+ItEnTyWNzxm7G4mtp+l81P69cjNXMPB
         4WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7H/DPJoWMp11tmUoPKSZMQxmcZJGqCLHjQqOxlkRT3I=;
        b=36PZcnaMllX8dHQUODHtJ0kuptc8wGywIcc3vGdF2tkgwIO8oe5AM9x4eI3q/dKDIE
         hxnXvUzsbvW4diRW79bcM5ZxKOWSQu51Wqfs8oxrXpkQ0C4PNO7ECmhIinCSxN+j6qx0
         IQjvzVWDljPtMHc7MqQ2bZiIqn0TvJGfgE0NPmU/FzFUPaau4FeufmY5y9Bih1W92Cim
         v10OXii1SfFAxkkezphvTLzxk7Y4l4N80D4+mDe9jKalgh+lktaeKzYidBgfTKtNvugq
         ePJwacErHbsVa2x+kFCL/GZ/D+pmWzhHhciz2QkYITkHtHnt3upcSMWyCVizN66iycpU
         YaAw==
X-Gm-Message-State: AOAM532nEBZHZ3RCfRkJVLbzuf9/D5ZKJFdTuBD78Hrzg56l04eHjHzc
        m7jToACRnLP/7SPG+qmvaUtM
X-Google-Smtp-Source: ABdhPJysFUYu3grPoRZB/ukVEQ0LvQQELodUHWFXUGYINOwkWLYtdIvPWLtAW0ZjczNSHWD6nINBDA==
X-Received: by 2002:a17:90b:946:: with SMTP id dw6mr248431pjb.49.1633544664308;
        Wed, 06 Oct 2021 11:24:24 -0700 (PDT)
Received: from thinkpad ([117.202.189.72])
        by smtp.gmail.com with ESMTPSA id u74sm12366435pfc.87.2021.10.06.11.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 11:24:23 -0700 (PDT)
Date:   Wed, 6 Oct 2021 23:54:19 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Robert Marko <robimarko@gmail.com>,
        Kathiravan T <kathirav@codeaurora.org>, agross@kernel.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: ipq8074: add SMEM support
Message-ID: <20211006182419.GC33862@thinkpad>
References: <20210902214708.1776690-1-robimarko@gmail.com>
 <YUf3aKn78+41Cb/G@builder.lan>
 <CAOX2RU5b46H7nqm6G4mHLSqEhGiWktwWjUKF5w10Ut+AdKea-A@mail.gmail.com>
 <632a7d28c23a8497d35ea009bfe89883@codeaurora.org>
 <CAOX2RU5+jeXiqz8oss8Sd-BWa059uAv5xu=7nx_YF4RYpG2S6w@mail.gmail.com>
 <YUurqDL/S15RziCQ@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUurqDL/S15RziCQ@builder.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 05:18:16PM -0500, Bjorn Andersson wrote:
> On Wed 22 Sep 15:23 CDT 2021, Robert Marko wrote:
> 
> > On Tue, 21 Sept 2021 at 08:24, Kathiravan T <kathirav@codeaurora.org> wrote:
> > >
> > > On 2021-09-20 14:55, Robert Marko wrote:
> > > > On Mon, 20 Sept 2021 at 04:52, Bjorn Andersson
> > > > <bjorn.andersson@linaro.org> wrote:
> > > >>
> > > >> On Thu 02 Sep 16:47 CDT 2021, Robert Marko wrote:
> > > >>
> > > >> > IPQ8074 uses SMEM like other modern QCA SoC-s, so since its already
> > > >> > supported by the kernel add the required DT nodes.
> > > >> >
> > > >> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > >>
> > > >> Thanks for your patch Robert.
> > > >>
> > > >> > ---
> > > >> >  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 28 +++++++++++++++++++++++++++
> > > >> >  1 file changed, 28 insertions(+)
> > > >> >
> > > >> > diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> > > >> > index a620ac0d0b19..83e9243046aa 100644
> > > >> > --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> > > >> > +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> > > >> > @@ -82,6 +82,29 @@ scm {
> > > >> >               };
> > > >> >       };
> > > >> >
> > > >> > +     reserved-memory {
> > > >> > +             #address-cells = <2>;
> > > >> > +             #size-cells = <2>;
> > > >> > +             ranges;
> > > >> > +
> > > >> > +             smem_region: memory@4ab00000 {
> > > >> > +                     no-map;
> > > >> > +                     reg = <0x0 0x4ab00000 0x0 0x00100000>;
> > > >> > +             };
> > > >> > +     };
> > > >> > +
> > > >> > +     tcsr_mutex: hwlock {
> > > >> > +             compatible = "qcom,tcsr-mutex";
> > > >> > +             syscon = <&tcsr_mutex_regs 0 0x80>;
> > > >>
> > > >> Since it's not okay to have a lone "syscon" and I didn't think it was
> > > >> worth coming up with a binding for the TCSR mutex "syscon" I rewrote
> > > >> the
> > > >> binding a while back. As such qcom,tcsr-mutex should now live in /soc
> > > >> directly.
> > > >>
> > > >> So can you please respin accordingly?
> > > >
> > > > Sure, can you just confirm that the:
> > > > reg = <0x01905000 0x8000>;
> > > >
> > > > Is the whole TCSR range as I don't have docs?
> > >
> > > Robert,
> > >
> > > TCSR_MUTEX block starts from 0x01905000 and has size 0x20000 (128KB)
> > 
> > Thanks, Kathiravan,
> > TSCR mutex with MMIO reg under it works, but there is some weird probe
> > ordering issue.
> > 
> > For whatever reason, SMEM will get probed only after MTD does and this
> > will cause issues
> > if SMEM parser is used as it will return -EPROBE_DEFER but the MTD
> > core does not really
> > handle it correctly and causes the device to reboot after failed parsing.
> > 
> > Now, I have no idea why does this variant which uses MMIO regmap probe
> > so much later?
> > 
> 
> Mani, do you have any input related to the probe deferral of the SMEM
> partition parser, because SMEM not yet probed?
> 

Sorry, missed this earlier. I did face the probe deferral issue before and
submitted a small series for fixing that:

https://lore.kernel.org/linux-mtd/20210302132757.225395-1-manivannan.sadhasivam@linaro.org/

These 2 patches are in mainline now. Robert, can you make sure that you have
these 2 patches in your tree?

Thanks,
Mani

> Thanks,
> Bjorn
