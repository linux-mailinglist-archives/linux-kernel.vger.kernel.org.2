Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEE3349EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhCZB1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:27:55 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:40945 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhCZB1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:27:24 -0400
Received: by mail-io1-f47.google.com with SMTP id n21so3848520ioa.7;
        Thu, 25 Mar 2021 18:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dRWavZ1UWIootJ3uk+1UUX2VAn0PU+/0Lq/aUm24ZKs=;
        b=lh1G9/iXxulfTnBQE5OfP8XMJAUyGba0qNrIGln0J/cXCHDFSb9BTwToV083CdzuLw
         hkmuVcUIvc1GK0hT0g9k6BvsadP5aYz0+CNu7J8GQsngvGMhLGpvgMoAjlYGyJE1QSWf
         ehoRPSPmgaOhhs/qipdWfBzpK6ojDwhVXibC0lYYw3OcrFkGFPwuIriwbA5jqV2r2FIm
         ZW3PKEcCrN8ibat7XjG5K0U2nSVHHI2pYDVw0bmVsb4ikel422kwIMptkSYyW6C6WqiG
         9ritG9Dp4q8+emH7Ecb3Nq3qMYXhIf/N+tyGNiv26dueLA21fO6+PCrAYHWEbQtiFntc
         D5YA==
X-Gm-Message-State: AOAM530LUyqlibeqFDMNh7Y56xeQ80O64A4PDyzWVNKquOzdHIL8PlFo
        ACn8IWuazkviAPV+hr3fD/3VbFOMrw==
X-Google-Smtp-Source: ABdhPJyabYJGIx9qMfl9XMDQRju4DktdbCBVKNJ11gxwE/sGooH0sTn4mcQfWSnUfqtR3PBBoVzj2g==
X-Received: by 2002:a5d:850c:: with SMTP id q12mr8575181ion.13.1616722044024;
        Thu, 25 Mar 2021 18:27:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y9sm3447664ill.15.2021.03.25.18.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:27:23 -0700 (PDT)
Received: (nullmailer pid 2124356 invoked by uid 1000);
        Fri, 26 Mar 2021 01:27:20 -0000
Date:   Thu, 25 Mar 2021 19:27:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, saravanak@google.com
Subject: Re: [RFC] clk: add boot clock support
Message-ID: <20210326012720.GA2113788@robh.at.kernel.org>
References: <20210316215123.GA3712408@robh.at.kernel.org>
 <20210318210318.144961-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318210318.144961-1-sebastian.reichel@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Saravana

On Thu, Mar 18, 2021 at 10:03:18PM +0100, Sebastian Reichel wrote:
> On Congatec's QMX6 system on module one of the i.MX6 fixed clocks
> is provided by an I2C RTC. Specifying this properly results in a
> circular dependency, since the I2C RTC (and thus its clock) cannot
> be initialized without the i.MX6 clock controller being initialized.
> 
> With current code the following path is executed when i.MX6 clock
> controller is probed (and ckil clock is specified to be the I2C RTC
> via DT):
> 
> 1. imx6q_obtain_fixed_clk_hw(ccm_node, "ckil", 0);
> 2. of_clk_get_by_name(ccm_node, "ckil");
> 3. __of_clk_get(ccm_node, 0, ccm_node->full_name, "ckil");
> 4. of_clk_get_hw(ccm_node, 0, "ckil")
> 5. spec = of_parse_clkspec(ccm_node, 0, "ckil"); // get phandle
> 6. of_clk_get_hw_from_clkspec(&spec); // returns -EPROBE_DEFER
> 7. error is propagated back, i.MX6q clock controller is probe deferred
> 8. I2C controller is never initialized without clock controller
>    I2C RTC is never initialized without I2C controller
>    CKIL clock is never initialized without I2C RTC
>    clock controller is never initialized without CKIL
> 
> To fix the circular dependency this registers a dummy clock when
> the RTC clock is tried to be acquired. The dummy clock will later
> be unregistered when the proper clock is registered for the RTC
> DT node. IIUIC clk_core_reparent_orphans() will take care of
> fixing up the clock tree.
> 
> NOTE: For now the patch is compile tested only. If this approach
> is the correct one I will do some testing and properly submit this.
> You can find all the details about the hardware in the following
> patchset:
> 
> https://lore.kernel.org/linux-devicetree/20210222171247.97609-1-sebastian.reichel@collabora.com/
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/clock/clock-bindings.txt         |   7 +
>  drivers/clk/clk.c                             | 146 ++++++++++++++++++
>  2 files changed, 153 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> index f2ea53832ac6..66d67ff4aa0f 100644
> --- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
> +++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> @@ -32,6 +32,13 @@ clock-output-names: Recommended to be a list of strings of clock output signal
>  		    Clock consumer nodes must never directly reference
>  		    the provider's clock-output-names property.
>  
> +boot-clock-frequencies: This property is used to specify that a clock is enabled
> +			by default with the provided frequency at boot time. This
> +			is required to break circular clock dependencies. For clock
> +			providers with #clock-cells = 0 this is a single u32
> +			with the frequency in Hz. Otherwise it's a list of
> +			clock cell specifier + frequency in Hz.

Seems alright to me. I hadn't thought about the aspect of needing to 
know the frequency. Other cases probably don't as you only need the 
clocks once both components have registered.

Note this could be lost being threaded in the other series.

Rob
