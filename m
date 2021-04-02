Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56A735284D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhDBJMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhDBJMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:12:18 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8A0461008;
        Fri,  2 Apr 2021 09:12:15 +0000 (UTC)
Date:   Fri, 2 Apr 2021 10:12:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/32] MAINTAINERS: update current-sense-shunt.yaml
 reference
Message-ID: <20210402101228.246416be@jic23-huawei>
In-Reply-To: <49371c37a988ffcae9188cbe4735e6eab920b2e0.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
        <49371c37a988ffcae9188cbe4735e6eab920b2e0.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Apr 2021 14:17:29 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Changeset ce66e52b6c16 ("dt-bindings:iio:afe:current-sense-shunt: txt to yaml conversion.")
> renamed: Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
> to: Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: ce66e52b6c16 ("dt-bindings:iio:afe:current-sense-shunt: txt to yaml conversion.")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied.

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c7168833da8f..71950316c736 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8796,7 +8796,7 @@ M:	Peter Rosin <peda@axentia.se>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.yaml
> -F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
> +F:	Documentation/devicetree/bindings/iio/afe/current-sense-shunt.yaml
>  F:	Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
>  F:	drivers/iio/afe/iio-rescale.c
>  

