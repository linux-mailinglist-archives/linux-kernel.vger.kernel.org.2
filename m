Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FFB423F20
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 15:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbhJFN3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 09:29:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231690AbhJFN3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 09:29:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3CFF610A8;
        Wed,  6 Oct 2021 13:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633526851;
        bh=tCrOPXDPFM6eq1CqRmq09A35LYUJQAclm0PN/6KnclU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X538M987gwaUNdE2XqqRmAsl+RJhXQeVdlbqcqhQZqzfauW0coofiDvJN0Ti5vdYU
         f5oSEja+rqYyo8+7Tl+nYDbi/etUvNBlZZzOw1DwlnZ7nRj95eHClHRufWG+mvg/ik
         NRqAH8kUkM2/y0Jm8g9EoDsMQejOWG8jZSqS6qxE=
Date:   Wed, 6 Oct 2021 15:27:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>, Gioh Kim <gi-oh.kim@ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Can Guo <cang@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        Carlos Bilbao <bilbao@vt.edu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] docs: typo fixes in Documentation/ABI/
Message-ID: <YV2kQT1glItmPS2y@kroah.com>
References: <20211006132104.105288-1-sohaib.amhmd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006132104.105288-1-sohaib.amhmd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 03:20:56PM +0200, Sohaib Mohamed wrote:
> All these changes are about to remove repeated words from severals place in the Documentation/ABI/ directory:

Please properly line-wrap your changelog text.

> - In file stable/sysfs-module:41: "the the source"
> 
> - In file testing/sysfs-bus-rapidio:98: "that that owns"
> 
> - In file testing/sysfs-class-cxl:106: "the the lowest"
> 
> - In file testing/sysfs-class-cxl:107: "this this kernel"
> 
> - In file testing/sysfs-class-rnbd-client:131: "as as the"
> 
> - In file testing/sysfs-class-rtrs-client:81: "the the name"
> 
> - In file testing/sysfs-class-rtrs-server:27: "the the name"
> 
> - In file testing/sysfs-devices-platform-ACPI-TAD:77: "the the status"
> 
> - In file testing/sysfs-devices-power:306: "the the children"
> 
> - In file testing/sysfs-driver-ufs:986: "the The amount"
> 
> - In file testing/sysfs-firmware-acpi:115: "send send a Notify"

Doesn't this look like you need to send a lot of individual patches
instead?

thanks,

greg k-h
