Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7008352808
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhDBJHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:07:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234854AbhDBJHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:07:18 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C641B60724;
        Fri,  2 Apr 2021 09:07:14 +0000 (UTC)
Date:   Fri, 2 Apr 2021 10:07:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/32] MAINTAINERS: update st,hts221.yaml reference
Message-ID: <20210402100602.1673bc1e@jic23-huawei>
In-Reply-To: <a83cf29bbd27b26eb22e0046c41efebf488e7e4d.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
        <a83cf29bbd27b26eb22e0046c41efebf488e7e4d.1617279355.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Apr 2021 14:17:25 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Changeset 9a6ac3138258 ("dt-bindings:iio:humidity:st,hts221 yaml conversion.")
> renamed: Documentation/devicetree/bindings/iio/humidity/hts221.txt
> to: Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 9a6ac3138258 ("dt-bindings:iio:humidity:st,hts221 yaml conversion.")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Applied
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index de9637196526..1985d75d59c7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8287,7 +8287,7 @@ M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  W:	http://www.st.com/
> -F:	Documentation/devicetree/bindings/iio/humidity/hts221.txt
> +F:	Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml
>  F:	drivers/iio/humidity/hts221*
>  
>  HUAWEI ETHERNET DRIVER

