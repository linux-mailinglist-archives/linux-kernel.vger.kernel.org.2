Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5AB352832
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbhDBJIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235161AbhDBJIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:08:32 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A34D360FF3;
        Fri,  2 Apr 2021 09:08:29 +0000 (UTC)
Date:   Fri, 2 Apr 2021 10:08:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/32] MAINTAINERS: update dpot-dac.yaml reference
Message-ID: <20210402100840.21be3bdd@jic23-huawei>
In-Reply-To: <efda999adce3332dc1b5c20a998f3824c1cc1b0f.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
        <efda999adce3332dc1b5c20a998f3824c1cc1b0f.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Apr 2021 14:17:26 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Changeset 06d2ff6fe11e ("dt-bindings:iio:dac:dpot-dac: yaml conversion.")
> renamed: Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
> to: Documentation/devicetree/bindings/iio/dac/dpot-dac.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 06d2ff6fe11e ("dt-bindings:iio:dac:dpot-dac: yaml conversion.")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied.

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1985d75d59c7..52ce258fab37 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8753,7 +8753,7 @@ M:	Peter Rosin <peda@axentia.se>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-iio-dac-dpot-dac
> -F:	Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
> +F:	Documentation/devicetree/bindings/iio/dac/dpot-dac.yaml
>  F:	drivers/iio/dac/dpot-dac.c
>  
>  IIO ENVELOPE DETECTOR

