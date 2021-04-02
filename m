Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3177135288F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbhDBJVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhDBJVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:21:32 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D320161008;
        Fri,  2 Apr 2021 09:21:29 +0000 (UTC)
Date:   Fri, 2 Apr 2021 10:21:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/32] MAINTAINERS: update st,lsm6dsx.yaml reference
Message-ID: <20210402102140.1d916db7@jic23-huawei>
In-Reply-To: <e058dc096c39933eb7647a86c57b3489906c89c3.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
        <e058dc096c39933eb7647a86c57b3489906c89c3.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Apr 2021 14:17:38 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Changeset 7a2cf8e91390 ("dt-bindings:iio:imu:st,lsm6dsx: txt to yaml conversion")
> renamed: Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> to: Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 7a2cf8e91390 ("dt-bindings:iio:imu:st,lsm6dsx: txt to yaml conversion")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied,

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97763e68b8e3..54c469933f66 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17142,7 +17142,7 @@ M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  W:	http://www.st.com/
> -F:	Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
> +F:	Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
>  F:	drivers/iio/imu/st_lsm6dsx/
>  
>  ST MIPID02 CSI-2 TO PARALLEL BRIDGE DRIVER

