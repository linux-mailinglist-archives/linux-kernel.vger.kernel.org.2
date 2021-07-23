Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54913D3648
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 10:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhGWHeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 03:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234328AbhGWHeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 03:34:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 201FA60F02;
        Fri, 23 Jul 2021 08:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627028086;
        bh=qV/N85haIZMB2b46Q5FY5TnkGO80Wbe1Cp7G2j5TkOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4lh+x/ZHeToABLWlXlqhEeVnkFMNUvzw/95mCyGD5ai58Ev377B0bxgAQ8nx14yN
         EdRzIjZnlB/ZApQk/IGxsnunlKxkkxog/trbph8UWDUx+2f+iVFqZNZUPANY0Kxwaf
         qXGPWDsZ5EF/V3hZBSAE607qrYyRB8hTJpeWA/v8=
Date:   Fri, 23 Jul 2021 10:14:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v15 0/3] Move HiSilicon 6421v600 SPMI and USB drivers out
 of staging
Message-ID: <YPp6dNuhPiLdgVKf@kroah.com>
References: <cover.1627025657.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1627025657.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 09:40:05AM +0200, Mauro Carvalho Chehab wrote:
> Hi Greg,
> 
> Those are the remaining patches needed for USB3 to start working on HiKey 970.
> 
> I would prefer to have those merged during this cycle, as the PCIe patchset
> currently under review depends on patch 1 and 2 of this series.
> 
> So, I dropped the cleanup patch from this series, due to a merge conflict with
> the regulator's tree. I'll re-submit it against the mfd tree after the merge window. 
> 
> Mauro Carvalho Chehab (3):
>   mfd: hi6421-spmi-pmic: move driver from staging
>   dts: hisilicon: add support for the PMIC found on Hikey 970
>   dts: hisilicon: add support for USB3 on Hikey 970

I've applied patch 1 here.

The other two I need acks from the DT maintainers before I can do
anything with them.

thanks,

greg k-h
