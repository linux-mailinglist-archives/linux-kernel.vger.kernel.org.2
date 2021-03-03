Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF13232BFC8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579210AbhCCSam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381594AbhCCQ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:28:12 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5B8C061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 08:27:29 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id j12so16590105pfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 08:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HXJOYxNuUiToQLVOAt83XI+0FbAC7xtNJfYatTxfIx8=;
        b=tYx6013cgswLASlsXfl1WXn/vkTv5YngKbb02znr0EjByfy+uBLKzAiwm39QudcFXJ
         TzdxMPrmcN4ZGuXB5tl8G8znDH5UMPT7kozJuUCap0RIX+W8amvu9f2St+qgjxsK/0mR
         KVNMY9uHqAB7UXyhD4g1efL5eKEPgoUiEPBbRjAw4hq6dqv31Pnt1PmGb89tghbGxfou
         5TZo0NotobKS3ippvDFQlzbwTCF1z+s3bKwF2dR4OUtpB0zTRD1tzRcSmkqpvfJ0/W+q
         W6B6THK5onadlTG8ikAntJkudUEcg76uE69n6KEHhxPoo22tCoTRkSCDXYwJnrhrT4+L
         vi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HXJOYxNuUiToQLVOAt83XI+0FbAC7xtNJfYatTxfIx8=;
        b=NR69MRBgCm5BzHQ1kfNdaasv47L2nC9qgD/1k8nx/MPFBMygxDsHdO2WFEQAnNhwM5
         fHEL08XeALCHP8xx/h95ZS5N8H6ROgYgS6AewTd4DZAYC4i8Q+6IgCmeyXq75vI2ZzTC
         anMNZrFA9M3IcRpemAyNrNtOBMxv/BdCoOMARSkJ5MjrzrscH5J3UW11xyxLJWCenuDh
         rScbt1y9D2uGp0DG7Il/PjMP/WKLCkiSGaVQ0dRdYvMj1gSZjvIqOLEC5sE0S44bEQY0
         /o7Dk+rsndwayejlWyK+vbxfh3IVxpQzdV3mY/XAtafPr91OolnNS7nmjdBl19xwlXGF
         fXQg==
X-Gm-Message-State: AOAM533R4pkJVUvHgP4V0j/msZ1eoupNKibE92+Uy5yctO5E0NIGyGo2
        75pp2iXEPLBdXOArfDkmJCDr
X-Google-Smtp-Source: ABdhPJyKmdTEy2NDPer/+WSFKgJGmlvOiJb4vEqhDy6RS+58uFBJENaNVGEpmm7m8x0W5iS62gMf9w==
X-Received: by 2002:a63:5d18:: with SMTP id r24mr8837208pgb.307.1614788849224;
        Wed, 03 Mar 2021 08:27:29 -0800 (PST)
Received: from thinkpad ([2409:4072:1d:4075:f412:a448:6d6c:cb4d])
        by smtp.gmail.com with ESMTPSA id z12sm7194440pjz.16.2021.03.03.08.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 08:27:28 -0800 (PST)
Date:   Wed, 3 Mar 2021 21:57:22 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/mtd/parsers/qcomsmempart.c:109 parse_qcomsmem_part()
 warn: passing zero to 'PTR_ERR'
Message-ID: <20210303162722.GB4319@thinkpad>
References: <20210303054918.GX2087@kadam>
 <20210303094840.0e30392c@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210303094840.0e30392c@xps13>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 09:48:40AM +0100, Miquel Raynal wrote:
> Hello,
> 

[...]

> > PTR_ERR(NULL) is success.  But let's just fix the IS_ERR_OR_NULL() check
> > to IS_ERR() so we don't have to wonder if returning success is
> > intentional.
> 
> Thanks for the report, I've just sent the fix.
> 

Thanks for that!

> @Manni, I thought you would be added in Cc automatically as you're the
> author of the fixed commit, but I was wrong, sorry for the mistake.
> 

np.

Thanks,
Mani

> Thanks,
> Miquèl
