Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E5034E775
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 14:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhC3MXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:23:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231946AbhC3MXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:23:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09313619B4;
        Tue, 30 Mar 2021 12:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617106989;
        bh=yxo5rnWB+u+L34D4axkwi6is/nDXRLXgw1WNc2SqjAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jremJgB5GbpLL6qR5c/hJw1/S4Aom1a/TGynXipXbKQdyRy1zpm7pAWmc3/uemB6e
         Ucb5l+X4RWP9mX7HlmJBpAxELRmfrk8N3Z0WawXXdVBT3/FyL7HJQuSSGeV4ehC8h3
         TIPEYHqTdVbWbbJco87fhAsDs/vTA2Pl5NgNzes8=
Date:   Tue, 30 Mar 2021 14:23:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     tanghui20 <tanghui20@huawei.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, xuzaibo@huawei.com,
        wangzhou1@hisilicon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon - check if debugfs opened
Message-ID: <YGMYKquXSaju9H+A@kroah.com>
References: <1616833980-11006-1-git-send-email-tanghui20@huawei.com>
 <YGCcQnFHXEMW9Jz/@kroah.com>
 <17d627e8-b89a-bbb8-f5d7-11210b859ac7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17d627e8-b89a-bbb8-f5d7-11210b859ac7@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 08:09:46PM +0800, tanghui20 wrote:
> 
> 
> On 2021/3/28 23:09, Greg KH wrote:
> > On Sat, Mar 27, 2021 at 04:33:00PM +0800, Hui Tang wrote:
> > > 'xx_debugfs_init' check if debugfs opened.
> > > 
> > > Signed-off-by: Hui Tang <tanghui20@huawei.com>
> > > ---
> > >  drivers/crypto/hisilicon/hpre/hpre_main.c | 5 ++++-
> > >  drivers/crypto/hisilicon/qm.c             | 3 +++
> > >  drivers/crypto/hisilicon/sec2/sec_main.c  | 5 ++++-
> > >  drivers/crypto/hisilicon/zip/zip_main.c   | 3 +++
> > >  4 files changed, 14 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
> > > index c7ab06d..f2605c4 100644
> > > --- a/drivers/crypto/hisilicon/hpre/hpre_main.c
> > > +++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
> > > @@ -779,6 +779,9 @@ static int hpre_debugfs_init(struct hisi_qm *qm)
> > >  	struct device *dev = &qm->pdev->dev;
> > >  	int ret;
> > > 
> > > +	if (!debugfs_initialized())
> > > +		return -ENOENT;
> > 
> > Why?  What does this help with?  Why does the code care if debugfs is
> > running or not?
> > 
> When !CONFIG_DEBUG_FS, there is no problem if debugfs is not checked,
> but if checking debugfs, a series of stub functions of debugfs can be
> skipped and 'xx_debugfs_init' will be return immediately.

And have you measured an actual speed difference for that?  I would be
amazed if you could...

thanks,

greg k-h
