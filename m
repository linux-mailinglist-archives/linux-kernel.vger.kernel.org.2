Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CA035287B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbhDBJTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:19:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234940AbhDBJTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:19:00 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78E3D61008;
        Fri,  2 Apr 2021 09:18:57 +0000 (UTC)
Date:   Fri, 2 Apr 2021 10:19:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/32] MAINTAINERS: update pni,rm3100.yaml reference
Message-ID: <20210402101908.3c48479e@jic23-huawei>
In-Reply-To: <d9090dc18907b4c534bf12a47e47a96ed1d3b45a.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
        <d9090dc18907b4c534bf12a47e47a96ed1d3b45a.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Apr 2021 14:17:36 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Changeset f383069be33e ("dt-bindings:iio:magnetometer:pni,rm3100: txt to yaml conversion.")
> renamed: Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> to: Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: f383069be33e ("dt-bindings:iio:magnetometer:pni,rm3100: txt to yaml conversion.")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Applied

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 89ed435ca6c3..636b29fd2d4b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14445,7 +14445,7 @@ PNI RM3100 IIO DRIVER
>  M:	Song Qiang <songqiang1304521@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> +F:	Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.yaml
>  F:	drivers/iio/magnetometer/rm3100*
>  
>  PNP SUPPORT

