Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB43D352897
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbhDBJXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:23:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234496AbhDBJXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:23:07 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BDED60FF3;
        Fri,  2 Apr 2021 09:23:03 +0000 (UTC)
Date:   Fri, 2 Apr 2021 10:23:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/32] MAINTAINERS: update st,vl53l0x.yaml reference
Message-ID: <20210402102314.2508d39f@jic23-huawei>
In-Reply-To: <c315ff7435bb4382b9c729a6242d098befb7796d.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
        <c315ff7435bb4382b9c729a6242d098befb7796d.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Apr 2021 14:17:39 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Changeset b4be8bd1c6a2 ("dt-bindings:iio:proximity:st,vl53l0x yaml conversion")
> renamed: Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> to: Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: b4be8bd1c6a2 ("dt-bindings:iio:proximity:st,vl53l0x yaml conversion")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied,

Thanks,

Jonathan

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 54c469933f66..d6708b3fdbd9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17171,7 +17171,7 @@ ST VL53L0X ToF RANGER(I2C) IIO DRIVER
>  M:	Song Qiang <songqiang1304521@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> +F:	Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
>  F:	drivers/iio/proximity/vl53l0x-i2c.c
>  
>  STABLE BRANCH

