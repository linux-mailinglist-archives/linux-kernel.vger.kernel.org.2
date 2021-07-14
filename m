Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B67B3C9406
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbhGNWxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:53:23 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:33359 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhGNWxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:53:22 -0400
Received: by mail-io1-f45.google.com with SMTP id z11so4207227iow.0;
        Wed, 14 Jul 2021 15:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y7GzKANsh/DPNvw566Umdxvo9sBO4/Tr3ROvGehG+6M=;
        b=JyuEeBh+SlqIfIjiZOjaOc+zzQEjz0j97BPSIP44ImswsSrm+6Z9QySurBGq5pzkwa
         jLffwdzwpX42aUgaIhoWQh+Q1bmQD3qiAoLBsOXvR8udObQa20VRbzhO9uccaz7z8SzZ
         pdyuYlpwCNBVOIDpVKkhTtEHaTnYDTgVYWCyQNrgOLSOoeuGMgOEPQABP9JzoK4XFiGR
         nxPS0jmPzlhU1EZ81IUL2r/GJfHv5liJWdBjC0XRg20o9PgfI9ZYDEjtpWYarPkHzHkB
         ocCy8phbnc2i/CWB6zcF09WIrdgI8obuuWxD2VaqABUl7IC/4mLkrxIW8MaIxPmKICmn
         Hw0A==
X-Gm-Message-State: AOAM531DALScYUsuHGuQOuqh7A21c/Ye18HZyzlwbAMqDCFNTzImFzjM
        dRqi28SpX0Shb7VEmZvYm/lPB+c1vxBC
X-Google-Smtp-Source: ABdhPJwMmCr6I4NlGrIe7T7IrahrCyQmyNO654sx6BKRj6lJvP4hbd9DcCc7o3tStRhD95Euo1xrNg==
X-Received: by 2002:a02:a98d:: with SMTP id q13mr489412jam.124.1626303029235;
        Wed, 14 Jul 2021 15:50:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a18sm2027589ilc.31.2021.07.14.15.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:50:28 -0700 (PDT)
Received: (nullmailer pid 3683599 invoked by uid 1000);
        Wed, 14 Jul 2021 22:50:26 -0000
Date:   Wed, 14 Jul 2021 16:50:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
Cc:     "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "ohkwon1043@gmail.com" <ohkwon1043@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
Subject: Re: [PATCH] of: fdt: remove unnecessary codes
Message-ID: <20210714225026.GA3683016@robh.at.kernel.org>
References: <CGME20210701140328epcms1p85149318b6c18fa18b3c7c8e966c14db0@epcms1p2>
 <20210701140457epcms1p2cc43a7c62150f012619feab913f017af@epcms1p2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210701140457epcms1p2cc43a7c62150f012619feab913f017af@epcms1p2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jul 2021 23:04:57 +0900, 권오훈 wrote:
> While unflattening the device tree, we try to populate dt nodes and
> properties into tree-shaped data structure.
> 
> In populate_properties function, pprev is initially set to
> &np->properties, and then updated to &pp->next.
> 
> In both scenarios *pprev is NULL, since the memory area that we are
> allocating from is initially zeroed.
> 
> I tested the code as below, and it showed that BUG was never called.
> 
> -       if (!dryrun)
> +       if (!dryrun) {
> +               if (*pprev)
> +                       BUG();
>                 *pprev = NULL;
> +       }
> 
> Let's remove unnecessary code.
> 
> Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
> ---
>  drivers/of/fdt.c | 3 ---
>  1 file changed, 3 deletions(-)
> 

Applied, thanks!
