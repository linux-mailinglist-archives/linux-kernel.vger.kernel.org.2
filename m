Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C4835A706
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 21:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbhDITYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 15:24:12 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:33614 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbhDITYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 15:24:05 -0400
Received: by mail-oi1-f178.google.com with SMTP id l131so1806248oih.0;
        Fri, 09 Apr 2021 12:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MQqD6gWB326bthxdqPI7x0UXTb8QIxMOCYJ3J9+fpMA=;
        b=ncw9JY+B4bSdduW6+c0EE2lvlccIDKz/4/eMMFR775JM3FFJLr2dYsIcrEdoliUhwx
         FC3SM4aVWWuwYiTMFxYLJE7F3GLBUhBaz+J2fexcrmmB2Tef5T3YPQdXL3E97lDBbY61
         amx4sWVBWN0iGzHcMe2fqhZDQmj3HcpiwPU20hrpPYjQXk/269y/EsrJ+klgGcVquy9Z
         I2rXt19cnHCkY8Zx4+55R+FdPKYWmYUHaPtdsv5p5k+CH76omMIZmKe8S8NqKXjeOaC2
         OrLWl4Gh/6O61c6EyD7w7eSdbG/+0diK5xSGQbnZIBiVZqSFFqFGnubg1V2YYRcp2WTF
         n69w==
X-Gm-Message-State: AOAM533YFKGjqoC2pRmAcmN5NJHmu2pisR7W9mYoc8BxY5xbH/tR9Xjy
        wz3a/rivYnURPwejxS8g7g==
X-Google-Smtp-Source: ABdhPJx7ViQwbxEzQydfo3qyoXxLsThL8fidPMuOtbl0kk1wuE+o4B0/kEuip7+IVpyWaKDEVTixrA==
X-Received: by 2002:aca:37c1:: with SMTP id e184mr5581302oia.136.1617996231377;
        Fri, 09 Apr 2021 12:23:51 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b9sm686685ooa.47.2021.04.09.12.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 12:23:50 -0700 (PDT)
Received: (nullmailer pid 3995789 invoked by uid 1000);
        Fri, 09 Apr 2021 19:23:44 -0000
Date:   Fri, 9 Apr 2021 14:23:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 3/8] dt-bindings:iio:adc: update
 motorola,cpcap-adc.yaml reference
Message-ID: <20210409192344.GA3995741@robh.at.kernel.org>
References: <cover.1617972339.git.mchehab+huawei@kernel.org>
 <3e205e5fa701e4bc15d39d6ac1f57717df2bb4c6.1617972339.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e205e5fa701e4bc15d39d6ac1f57717df2bb4c6.1617972339.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Apr 2021 14:47:47 +0200, Mauro Carvalho Chehab wrote:
> Changeset 1ca9d1b1342d ("dt-bindings:iio:adc:motorola,cpcap-adc yaml conversion")
> renamed: Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
> to: Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 1ca9d1b1342d ("dt-bindings:iio:adc:motorola,cpcap-adc yaml conversion")
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/motorola-cpcap.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
