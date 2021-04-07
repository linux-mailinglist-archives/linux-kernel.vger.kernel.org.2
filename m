Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEC7356957
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350890AbhDGKVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:21:18 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2783 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237262AbhDGKVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:21:14 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFgGM2QzQz686lg;
        Wed,  7 Apr 2021 18:13:47 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 7 Apr 2021 12:20:47 +0200
Received: from localhost (10.47.92.157) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 7 Apr 2021
 11:20:46 +0100
Date:   Wed, 7 Apr 2021 11:19:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "Lee Jones" <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/19] dt-bindings:iio:adc: update
 dlg,da9150-gpadc.yaml reference
Message-ID: <20210407111922.00003831@Huawei.com>
In-Reply-To: <79ece2a12759a375bfa0d492e2931f48acc11e39.1617783062.git.mchehab+huawei@kernel.org>
References: <cover.1617783062.git.mchehab+huawei@kernel.org>
        <79ece2a12759a375bfa0d492e2931f48acc11e39.1617783062.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.157]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2021 10:20:50 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Changeset e13b686b18e3 ("dt-bindings:iio:adc:dlg,da9150-gpadc yaml conversion")
> renamed: Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt
> to: Documentation/devicetree/bindings/iio/adc/dlg,da9150-gpadc.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: e13b686b18e3 ("dt-bindings:iio:adc:dlg,da9150-gpadc yaml conversion")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/devicetree/bindings/mfd/da9150.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/da9150.txt b/Documentation/devicetree/bindings/mfd/da9150.txt
> index 763e0b639a82..b7afa39d6260 100644
> --- a/Documentation/devicetree/bindings/mfd/da9150.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9150.txt
> @@ -19,7 +19,7 @@ Required properties:
>     further information relating to interrupt properties)
>  
>  Sub-devices:
> -- da9150-gpadc: See Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt
> +- da9150-gpadc: See Documentation/devicetree/bindings/iio/adc/dlg,da9150-gpadc.yaml
>  - da9150-charger: See Documentation/devicetree/bindings/power/da9150-charger.txt
>  - da9150-fg: See Documentation/devicetree/bindings/power/da9150-fg.txt
>  

