Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1FA423DCA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 14:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbhJFMiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 08:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231277AbhJFMiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:38:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06EDC61139;
        Wed,  6 Oct 2021 12:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633523770;
        bh=j3+A2Qlyg5D4UfN7RyIXmxav9UVc764TxGgamnb+Tgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PCTkgjrS6zmdAMIphuyQznjQUc1Fc5rawZj8vr9BXl5RbAfnkWrgj1dPvKLRNTyma
         3PzbdHGqyiKZuVNVQ5Pq+TIelMzTDg3Kmv3wjnRMrz4rInRl23r9/poTRlsIIiHnQX
         9o81jymzJHAlaFy0sMRMI/PHwiWELHBBU5zLF8yI=
Date:   Wed, 6 Oct 2021 14:36:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jens Axboe <axboe@kernel.dk>, Gioh Kim <gi-oh.kim@ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Bean Huo <beanhuo@micron.com>, Can Guo <cang@codeaurora.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] docs: typo fixes in Documentation/ABI/
Message-ID: <YV2YOJuNKU/J3SEN@kroah.com>
References: <20211006121333.75799-1-sohaib.amhmd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006121333.75799-1-sohaib.amhmd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 02:13:25PM +0200, Sohaib Mohamed wrote:
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>

I can not take patches without any changelog text, sorry.

thanks,

greg k-h
