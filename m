Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11E23527CE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbhDBJE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBJE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:04:57 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 944F160724;
        Fri,  2 Apr 2021 09:04:54 +0000 (UTC)
Date:   Fri, 2 Apr 2021 10:05:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/32] MAINTAINERS: update adi,ad5758.yaml reference
Message-ID: <20210402100503.7d497d48@jic23-huawei>
In-Reply-To: <ca35b929c098163cfda9682ce791572629b763e2.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
        <ca35b929c098163cfda9682ce791572629b763e2.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Apr 2021 14:17:21 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Changeset 1e6536ee349b ("dt-bindings:iio:dac:adi,ad5758 yaml conversion")
> renamed: Documentation/devicetree/bindings/iio/dac/ad5758.txt
> to: Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 1e6536ee349b ("dt-bindings:iio:dac:adi,ad5758 yaml conversion")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Hi Mauro,

Oops. These have been on my todo list for a while to tidy up. I kind
of forgot to check MAINTAINERS whilst doing the conversions.

Ah well, thanks for tidying up.

Applied to the togreg branch of iio.git and pushed out as testing for
autobuilders to probably not notice.

Thanks

Jonathan

p.s. For anything IIO related I'll notice more quickly in general
if linux-iio@vger.kernel.org is cc'd.

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 38d823d72e52..4c8a926ef201 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1141,7 +1141,7 @@ W:	http://ez.analog.com/community/linux-device-drivers
>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
>  F:	Documentation/devicetree/bindings/iio/*/adi,*
> -F:	Documentation/devicetree/bindings/iio/dac/ad5758.txt
> +F:	Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
>  F:	drivers/iio/*/ad*
>  F:	drivers/iio/adc/ltc249*
>  F:	drivers/iio/amplifiers/hmc425a.c

