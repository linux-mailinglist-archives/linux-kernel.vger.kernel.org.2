Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362D3441BC2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 14:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhKANef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 09:34:35 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:34611 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhKANec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 09:34:32 -0400
Received: by mail-oi1-f172.google.com with SMTP id w193so24968207oie.1;
        Mon, 01 Nov 2021 06:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eLcsxVzfHQolZIB0ZbYhFO4KAcs8yfy79NWqwxrx0tI=;
        b=zv9P0LNkxYjXbHCySzZSkdUAi7rgVB4KU2CveJNlDHL4XM8K2TLHwNBo12ZRQ2euYp
         qGf8z6tttwgb1GXIP/5ll3bTY3NPrP6VeXXc0WMQZB1Uy28+7o/lyNwQBPGkEuVfj2Sz
         TbjgVpK+5ShRXxJi70wJ0WJ0/9Set2CYB5V/KUX0AEo7KVyPd2Sn25qQ+zEjWwY5sZfZ
         wgYV+J6IfT+dhzs3uNg8YU91tcIBnjlarj9ETjjYVZGUkIcKedrSTSBYu3xBAyj3NEH3
         Y1uBZCU5ilMHa0c7qpFYiU6jqdDLdmy6PlnoNcUvXmivbEv3k/NRJ8BqF0uLy3m+05Vx
         0lcg==
X-Gm-Message-State: AOAM5312+uYPX6L5UPmgbvpEsw6p956FJKoPo7K6yh+UpZUfYTfTLA36
        rOQ3mQEUy+5lDHP0KeyjTA==
X-Google-Smtp-Source: ABdhPJyi2B3TGNdhhoSZVcT2+ar1R4LGVp3YRhTJz4BmGGV6/kl4Fi83W6pKB5mrlIJ8hHGVPYBMDw==
X-Received: by 2002:a05:6808:231e:: with SMTP id bn30mr5597153oib.93.1635773518362;
        Mon, 01 Nov 2021 06:31:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s21sm1680874otp.57.2021.11.01.06.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 06:31:57 -0700 (PDT)
Received: (nullmailer pid 298367 invoked by uid 1000);
        Mon, 01 Nov 2021 13:31:56 -0000
Date:   Mon, 1 Nov 2021 08:31:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] of: unittest: document intentional interrupt-map
 provider build warning
Message-ID: <YX/sTGG/WUqhDzr4@robh.at.kernel.org>
References: <20211030011039.2106946-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211030011039.2106946-1-frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 08:10:39PM -0500, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> A recently implemented dtc compiler warning reports a dts problem
> via a build warning:
> 
>    drivers/of/unittest-data/tests-interrupts.dtsi:32.26-35.6: Warning (interrupt_map): /testcase-data/interrupts/intmap1: Missing '#address-cells' in interrupt-map provider
> 
> The warning will be addressed by a separate patch by suppressing the
> warning for .dts files that include this .dtsi.  This patch documents
> why the warning is due to a deliberately incorrect .dtsi file so that
> no one will fix the .dtsi file to prevent the build warning.
> 
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  .../of/unittest-data/tests-interrupts.dtsi    | 19 +++++++++++++++++++
>  drivers/of/unittest.c                         |  6 ++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/of/unittest-data/tests-interrupts.dtsi b/drivers/of/unittest-data/tests-interrupts.dtsi
> index 9b60a549f502..8c8d267d4d3c 100644
> --- a/drivers/of/unittest-data/tests-interrupts.dtsi
> +++ b/drivers/of/unittest-data/tests-interrupts.dtsi
> @@ -31,6 +31,21 @@ test_intmap0: intmap0 {
>  
>  			test_intmap1: intmap1 {
>  				#interrupt-cells = <2>;
> +				/*
> +				 * #address-cells is required
> +				 *
> +				 * The property is not provided in this node to
> +				 * test that the code will properly handle
> +				 * this case for legacy .dts files.
> +				 *
> +				 * Not having #address-cells will result in a
> +				 * warning from dtc starting with
> +				 * version v1.6.1-19-g0a3a9d3449c8
> +				 * The warning is suppressed by adding
> +				 * -Wno-interrupts_property to the Makefile

s/interrupts_property/interrupt_map/

I'll fix when applying.

> +				 * for all .dts files this include this .dtsi
> +				#address-cells = <1>;
> +				 */
>  				interrupt-map = <0x5000 1 2 &test_intc0 15>;
>  			};
>  
> @@ -46,6 +61,10 @@ interrupts1 {
>  
>  			interrupts-extended0 {
>  				reg = <0x5000 0x100>;
> +				/*
> +				 * Do not remove &test_intmap1 from this
> +				 * property - see comment in node intmap1
> +				 */
>  				interrupts-extended = <&test_intc0 1>,
>  						      <&test_intc1 2 3 4>,
>  						      <&test_intc2 5 6>,
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 8c056972a6dd..04bfef8f67c3 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -1129,6 +1129,12 @@ static void __init of_unittest_parse_interrupts_extended(void)
>  			passed &= (args.args[1] == 14);
>  			break;
>  		case 6:
> +			/*
> +			 * Tests child node that is missing property
> +			 * #address-cells.  See the comments in
> +			 * drivers/of/unittest-data/tests-interrupts.dtsi
> +			 * nodes intmap1 and interrupts-extended0
> +			 */
>  			passed &= !rc;
>  			passed &= (args.args_count == 1);
>  			passed &= (args.args[0] == 15);
> -- 
> Frank Rowand <frank.rowand@sony.com>
> 
> 
