Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50BF3FFFB3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 14:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349271AbhICMZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 08:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245400AbhICMZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 08:25:21 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35959C061760
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 05:24:21 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 4so3013348qvp.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 05:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AjVVv2ndb2u5Bt4uUF9TlcBGvkr2yBKHs0BYvFEiwhM=;
        b=gGIslmjuvjmkuQE+MEw2D09EW4vDOuMlNxsSM/ktZ1WBAGN0rCOgOC0WBF8Pk+FMaE
         7i1joaB5gBAmJUqpqz9IMmHXWUaSQ+HttFLCkX4i/TTtxUI1WCJ+bIIbMTZoKG1P1PVP
         rRp5XhWoUPlhKABNFH+Z1T5wARWdSGlN0tqqXO84rUiWuaMeUFfgB8WQxzx0Lng+HFEw
         +hy0WhoOTknyTagvlH2TBDMgG5qEz2hTr3ob4IxVCA951tzGMvUJjg+muXTKr/02rEIS
         1Ydj6mmRRXAbe5t23lTGLiPPIzkKfPXKKTl94e4F7ZES4BTQdhObBaI+dHC5c2Vz/ysO
         15LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AjVVv2ndb2u5Bt4uUF9TlcBGvkr2yBKHs0BYvFEiwhM=;
        b=ujTkB6oMpKLRwTB2rW3aCrrGuUBcXT1eoYnDkxBQRDAtUipdAf/HWRoH9mGej/ZBD4
         6D8Q/uiQkLuKLqGUEBzWsxiu/TEBoznn6g+ckWcTwj1e4nUDIlWS8WT3xVzVtGRCLIbO
         /WrEs+bTuEEAE/OfbwxJ5REmboWbGqjMHY2aZ6Nx8Cl5HkWeqiSgEmP19btkDyDvppSd
         pi9L20BVMjPxMIdDkGi/6o0vMbGSKjtJggW4W8SW7U10fqzc7g1PlmmRAMqYfn4O+jtM
         M7qghjRHRo+KHGl2L3jA5sSLUXEnEI9eo9Uwv/Dg5gH0WcPpBP3MjxWx1e3tAL3AaTti
         84Dw==
X-Gm-Message-State: AOAM530hqULnMJrXUENy2m530uOd0R3g1CzeyJSVX3Zh4Yz5Ce0E8LrO
        DpDKTPYXQf43AOaxHptvgP4DEQ==
X-Google-Smtp-Source: ABdhPJx0ZRB4N7U15Yq2f7MIxv4JxXW05wcJNeaYCXXvbjwj/xN2sCap7XlcXbOyT6yjd1yWliCKqA==
X-Received: by 2002:a05:6214:21cc:: with SMTP id d12mr3132616qvh.22.1630671860349;
        Fri, 03 Sep 2021 05:24:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id c15sm3703514qka.46.2021.09.03.05.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 05:24:19 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mM8F0-00Agea-T2; Fri, 03 Sep 2021 09:24:18 -0300
Date:   Fri, 3 Sep 2021 09:24:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] vfio/pci: add missing identifier name in argument
 of function prototype
Message-ID: <20210903122418.GU1200268@ziepe.ca>
References: <20210902212631.54260-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902212631.54260-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 10:26:31PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The function prototype is missing an identifier name. Add one.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It seems fine, but is there a reason to just pick this one case and
not clean the whole subsystem?

Eg i see a couple more cases in the headers

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
