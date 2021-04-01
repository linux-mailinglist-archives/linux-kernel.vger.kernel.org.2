Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E3635198A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbhDARyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbhDARlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:41:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06645C08EA7D;
        Thu,  1 Apr 2021 06:30:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so3867290wmq.1;
        Thu, 01 Apr 2021 06:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xkmJRNyHZF6zO/+Ccr4Et1V1ZjM78NEZ05svjz/naMI=;
        b=lILFftuC0IPr3uLEncMP2OrLr9zLpsfw4zdDDm7j/WvMTg4Db4ko0/YIULamJlFGkE
         y+BZXopV/bNZnncS7HNQPDTUOcOum/4KbED+UvkANuDAxpcXKe1e12G1o/jmxWbwYMcf
         eP6vU4RDt7W3qNd3u/u0T7m/mqjicz6H+sJ58bgAcl4H5txfKWEJf9eErSX7BbyyKRMs
         2CAvYaa4b98Yw8cKEgUd2FqQpG0gEaeYsU8BsEM1sn9BkuogXAe5uqI4Hotknm5m8tBl
         /m9NP93JunHEhR+8kzHXvkKsypa3MSEyYzvQNPY+xsxzIu26e0+NXxJZ/DohMz19MwNu
         lj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xkmJRNyHZF6zO/+Ccr4Et1V1ZjM78NEZ05svjz/naMI=;
        b=NQ5R8gTfd/bkXQFSCcNwDEjku+FZGamUrcAVZot9ZyY1COXp5dlzVnZtd52sRo/mvn
         Y/SHTSCwqpHvZ3cobey2kWOApr717MVxTqBQE/pQ8O1Wk24DAHE3OAY1toQitMipXADw
         CxcpyBxg5TzChsP5W9VgxtWnO2TpJKwdZk0hhHIbKUTeIy04p5BgIzgUU+hM9BS+A67x
         ZbS9nG1WSxavBAwTZ2ElnzJ+FMzoDXklA0L1HVxykhW2xpl6imeuHQdeDDmNmgkCGsJz
         JQ/cdqYJsDjGiZLZik7oqYDI0dbwFW62VZELJeGCB8UQiKKava1biurf7mkldwx/YSoV
         FwSA==
X-Gm-Message-State: AOAM531+nmydr0w0abGqDaYPp6asYyzWt1YITxhN4Pb6y6l94HtLt/VR
        1MWGfC58Vcx0q5RK59alLsg=
X-Google-Smtp-Source: ABdhPJyCyaREQFPgcDkUYPNV4ggRYGiB0YNKqwnW2+WJUTFQMJ4jUJs75EA85o1xxpFIvrmPyn/t4g==
X-Received: by 2002:a1c:b006:: with SMTP id z6mr7775346wme.19.1617283852803;
        Thu, 01 Apr 2021 06:30:52 -0700 (PDT)
Received: from arch-thunder.localdomain (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id l15sm8215400wme.43.2021.04.01.06.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 06:30:52 -0700 (PDT)
Date:   Thu, 1 Apr 2021 14:30:50 +0100
From:   Rui Miguel Silva <rmfrfs@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Rob Herring <robh@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/32] MAINTAINERS: update ovti,ov2680.yaml reference
Message-ID: <20210401133050.dmnteppqmtst37f5@arch-thunder.localdomain>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
 <f6474fa072117ec42bef82379abb5df958fab426.1617279355.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6474fa072117ec42bef82379abb5df958fab426.1617279355.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,
Thanks for fixing this.

On Thu, Apr 01, 2021 at 02:17:43PM +0200, Mauro Carvalho Chehab wrote:
> The file name: Documentation/devicetree/bindings/media/i2c/ov2680.yaml
> should be, instead: Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 57226cd8c8bf ("media: dt-bindings: ov2680: convert bindings to yaml")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com>

------
Cheers,
     Rui
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0ee42d68a269..1644b6e9697c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13351,7 +13351,7 @@ M:	Rui Miguel Silva <rmfrfs@gmail.com>
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
>  T:	git git://linuxtv.org/media_tree.git
> -F:	Documentation/devicetree/bindings/media/i2c/ov2680.yaml
> +F:	Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml
>  F:	drivers/media/i2c/ov2680.c
>  
>  OMNIVISION OV2685 SENSOR DRIVER
> -- 
> 2.30.2
> 
