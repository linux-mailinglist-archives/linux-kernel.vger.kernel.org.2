Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA89935287D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbhDBJUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhDBJUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:20:15 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A04FD60FF3;
        Fri,  2 Apr 2021 09:20:12 +0000 (UTC)
Date:   Fri, 2 Apr 2021 10:20:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/32] MAINTAINERS: update renesas,rcar-gyroadc.yaml
 reference
Message-ID: <20210402102023.62d2b09c@jic23-huawei>
In-Reply-To: <aa999b76bb0b6c3ca4cb0c1a8679c22c91690429.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
        <aa999b76bb0b6c3ca4cb0c1a8679c22c91690429.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Apr 2021 14:17:37 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Changeset 8c41245872e2 ("dt-bindings:iio:adc:renesas,rcar-gyroadc: txt to yaml conversion.")
> renamed: Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
> to: Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 8c41245872e2 ("dt-bindings:iio:adc:renesas,rcar-gyroadc: txt to yaml conversion.")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 636b29fd2d4b..97763e68b8e3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15437,7 +15437,7 @@ RENESAS R-CAR GYROADC DRIVER
>  M:	Marek Vasut <marek.vasut@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
> -F:	Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
> +F:	Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
>  F:	drivers/iio/adc/rcar-gyroadc.c
>  
>  RENESAS R-CAR I2C DRIVERS

