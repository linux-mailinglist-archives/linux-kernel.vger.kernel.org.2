Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08A643E9E0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 22:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhJ1Uve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 16:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhJ1Uvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 16:51:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C9EC061745
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 13:49:03 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e4so12349985wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 13:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3IvTfylI/s5zjCUTJoTbfVOltBPWwJQSWlH2bF2QUuk=;
        b=oDbwPY9FhMa5+lI34zwqKLXaGGEJP1uhqTbtRsJgcXK9YE2LdLZaiUk6cnSS0e/z7B
         NGrVlsXfrFTsjnJAwwqdqoPbDLCN13n0CUMg2Hnu9Bl0kC3Ynqw3gDSy7EFkY5hOaWsV
         cF0zEMmnNLEFqZq5usfApABvoY2RR5EkszAaoSGt/8bvwq4noNBArvxJqCHhkqxyKzRr
         TCdGfdedDm8XQDbRwnJRXjlusfgnqW9aWPfo1myOMwH/pLlZhbQeP8c90RfxBdZBXhPs
         3Z9fNnvvkFYCsQbWi5xjsw9AsZDY36nun2WGqIOWEjNfzCfRof3UPiUFd7N2JMgiPi4q
         l/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3IvTfylI/s5zjCUTJoTbfVOltBPWwJQSWlH2bF2QUuk=;
        b=cGkJhC3KfjAwF9IATvDYdT8+AIPwo+fYnhzE9MknR+JybgC1cJxAk2in3Ds+8MUheD
         JO/GFs3rhy7Xx37y5IN15Z8F4GbXQ/St6q3/Y3Rq8m1/0uyxSa48YLoetJ3CKMk4KgVB
         r7qfd7Vo86r2W8JYE838tw/1+oS6GNHu7Q1lcFyPWtwKTTTk5hNRHxCucjq3WGJYVE6D
         oUt5OiIv8zojegEH4rn/R5X7ZTkP3cEdN/HhP5mSILstIhV0IXtOnQ3QGp7ucZg5/h+2
         fHWH4ZjRMosThTs/QQw15L9h1m5xQCyl5T2WE7vWlblX5BDGAw1smmU1h1anP4a46G96
         X/mQ==
X-Gm-Message-State: AOAM5323K1dINQL4QK7FU5QwKNBdqOAiAjdLqRFNzTWfXyzeLTM114uy
        ktGBalxisINLd6iwOeG5ypR+Lg==
X-Google-Smtp-Source: ABdhPJz5CVcMhbABFkm8qYpPeC8ZX0TX4ML2WSs+7463nI9XPEFL1WLEfTk4g3/yjS9ylWLJZoLIFw==
X-Received: by 2002:adf:a78a:: with SMTP id j10mr8764668wrc.231.1635454142409;
        Thu, 28 Oct 2021 13:49:02 -0700 (PDT)
Received: from Jessicas-MacBook-Pro.local (global-5-141.nat-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id m34sm2584987wms.25.2021.10.28.13.49.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Oct 2021 13:49:02 -0700 (PDT)
Received: by Jessicas-MacBook-Pro.local (Postfix, from userid 501)
        id 6C870927B2D0; Thu, 28 Oct 2021 21:48:54 +0100 (BST)
Date:   Thu, 28 Oct 2021 21:48:54 +0100
From:   Jessica Clarke <jrtc27@jrtc27.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Anup Patel <anup.patel@wdc.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        devicetree@vger.kernel.org, Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [v4 10/11] riscv: dts: fu740: Add pmu node
Message-ID: <YXsMtrmuavGAHk8S@Jessicas-MacBook-Pro.local>
References: <20211025195350.242914-1-atish.patra@wdc.com>
 <20211025195350.242914-11-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025195350.242914-11-atish.patra@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 12:53:49PM -0700, Atish Patra wrote:
> HiFive unmatched supports HPMCounters but does not implement mcountinhibit
> or sscof extension. Thus, perf monitoring can be used on the unmatched
> board without sampling.
> 
> Add the PMU node with compatible string so that Linux perf driver can
> utilize this to enable PMU.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> index abbb960f90a0..b35b96b58820 100644
> --- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> +++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> @@ -140,6 +140,9 @@ soc {
>  		#size-cells = <2>;
>  		compatible = "simple-bus";
>  		ranges;
> +		pmu {
> +			compatible = "riscv,pmu";
> +		};

This is a property of the user-replaceable firmware, not a property of
the hardware, so having this in the device tree under /soc, let alone
hard-coded in Linux, is utterly wrong. Why can this not just be probed
like any other SBI interface? The "Probe SBI extension" interface is
precisely for this kind of thing.

Jess
