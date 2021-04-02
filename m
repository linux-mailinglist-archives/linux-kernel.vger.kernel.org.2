Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8DF352857
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbhDBJQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233718AbhDBJQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:16:05 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F07A61008;
        Fri,  2 Apr 2021 09:16:01 +0000 (UTC)
Date:   Fri, 2 Apr 2021 10:16:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/32] MAINTAINERS: update invensense,mpu3050.yaml
 reference
Message-ID: <20210402101612.44eaccd4@jic23-huawei>
In-Reply-To: <1c99edf0f5c78e78bbec71fa2a5d7bc6087edddd.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
        <1c99edf0f5c78e78bbec71fa2a5d7bc6087edddd.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Apr 2021 14:17:31 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Changeset 749787477ae4 ("dt-bindings:iio:gyro:invensense,mpu3050: txt to yaml format conversion.")
> renamed: Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.txt
> to: Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 749787477ae4 ("dt-bindings:iio:gyro:invensense,mpu3050: txt to yaml format conversion.")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5110f47ebf85..ce675a0b3819 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9414,7 +9414,7 @@ INVENSENSE MPU-3050 GYROSCOPE DRIVER
>  M:	Linus Walleij <linus.walleij@linaro.org>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.txt
> +F:	Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.yaml
>  F:	drivers/iio/gyro/mpu3050*
>  
>  IOC3 ETHERNET DRIVER

