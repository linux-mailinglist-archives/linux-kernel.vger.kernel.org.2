Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDF435289A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbhDBJYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:24:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhDBJYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:24:38 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C45E160FD9;
        Fri,  2 Apr 2021 09:24:34 +0000 (UTC)
Date:   Fri, 2 Apr 2021 10:24:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/32] MAINTAINERS: update ti,dac7612.yaml reference
Message-ID: <20210402102446.7ac6d921@jic23-huawei>
In-Reply-To: <04039b6991838f0107a42ccb0d9774cb8873a61a.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
        <04039b6991838f0107a42ccb0d9774cb8873a61a.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Apr 2021 14:17:41 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Changeset 8b74e06b0f4d ("dt-bindings:iio:dac:ti,dac7612 yaml conversion")
> renamed: Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
> to: Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 8b74e06b0f4d ("dt-bindings:iio:dac:ti,dac7612 yaml conversion")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied,

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6b0a6f251e6b..2f63ebd2cfc8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17907,7 +17907,7 @@ TEXAS INSTRUMENTS' DAC7612 DAC DRIVER
>  M:	Ricardo Ribalda <ribalda@kernel.org>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
> -F:	Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
> +F:	Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
>  F:	drivers/iio/dac/ti-dac7612.c
>  
>  TEXAS INSTRUMENTS DMA DRIVERS

