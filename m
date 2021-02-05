Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583EB311B47
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 06:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhBFFDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 00:03:51 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:34611 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbhBFDr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:47:56 -0500
Received: by mail-oi1-f177.google.com with SMTP id h192so9748900oib.1;
        Fri, 05 Feb 2021 19:47:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+M4rD8lhAIwaWja6r8ayIGoRcioSa2ru8gsy3RVn3Ec=;
        b=j3K9yItLD3FwuIHsyb3Ybul5mNJXGIz8hs/l1dIKqv8V/avLLHxr5z/qdCVWPA/1QD
         pS4CNAv2H4avFyobYL/FLAo43KPaHSNiflXDxn7rZbmmiFUtbmz+dKwgKWwKZ2RdQRBV
         VzN06EmK8N/oGyzAET7LxQwhpgfUDi1KfuY4E1V6L0TgyJK5eyjlmOgeewY/RtqV9NgO
         w3z+JTk8ltARgDcJi9Db5eEUjRlAFHJwanQnc3DTpZDOT87tbZzYSDlvpszHTKqakGMw
         EZwfOPwYOffJuPsYyxiDqmS1TPyUcY7ZrztaZ3yd+K+JaP+myHGiVeW1YwJ9plEb/FL3
         VWPg==
X-Gm-Message-State: AOAM532NoAZTupbiwAOBYonBm7AEVxSm5n5HlldUDwTj4hl3Qw0nyZih
        IQCi8Zcl5gTnbxD2mWRziQfL17bZGg==
X-Google-Smtp-Source: ABdhPJwT+do3Tf8ShVWqxdJZu0MSFLTcBAZfVqwvPQ1VqaYfgImnDQkA3Ib6XJKGM1n47zjkuTd86w==
X-Received: by 2002:aca:b255:: with SMTP id b82mr4420318oif.98.1612563238100;
        Fri, 05 Feb 2021 14:13:58 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u73sm2035591oie.30.2021.02.05.14.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 14:13:56 -0800 (PST)
Received: (nullmailer pid 3847968 invoked by uid 1000);
        Fri, 05 Feb 2021 22:13:55 -0000
Date:   Fri, 5 Feb 2021 16:13:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     devel@driverdev.osuosl.org, Yu Chen <chenyu56@huawei.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] phy: phy-hi3670-usb3: move driver from staging
 into phy
Message-ID: <20210205221355.GA3847933@robh.at.kernel.org>
References: <cover.1611052729.git.mchehab+huawei@kernel.org>
 <82ce73ac9a383f0cae0faded5ec6fef2d3417d3c.1611052729.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82ce73ac9a383f0cae0faded5ec6fef2d3417d3c.1611052729.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jan 2021 11:44:43 +0100, Mauro Carvalho Chehab wrote:
> The phy USB3 driver for Hisilicon 970 (hi3670) is ready
> for mainstream. Mode it from staging into the main driver's
> phy/ directory.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/phy/hisilicon,hi3670-usb3.yaml   |  73 ++
>  MAINTAINERS                                   |   9 +-
>  drivers/phy/hisilicon/Kconfig                 |  10 +
>  drivers/phy/hisilicon/Makefile                |   1 +
>  drivers/phy/hisilicon/phy-hi3670-usb3.c       | 668 ++++++++++++++++++
>  drivers/staging/hikey9xx/Kconfig              |  11 -
>  drivers/staging/hikey9xx/Makefile             |   2 -
>  drivers/staging/hikey9xx/phy-hi3670-usb3.c    | 668 ------------------
>  drivers/staging/hikey9xx/phy-hi3670-usb3.yaml |  73 --
>  9 files changed, 760 insertions(+), 755 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
>  create mode 100644 drivers/phy/hisilicon/phy-hi3670-usb3.c
>  delete mode 100644 drivers/staging/hikey9xx/phy-hi3670-usb3.c
>  delete mode 100644 drivers/staging/hikey9xx/phy-hi3670-usb3.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
