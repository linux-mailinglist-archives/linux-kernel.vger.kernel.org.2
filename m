Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E704840E942
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356990AbhIPRvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:51:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355811AbhIPRmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:42:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 507A763273;
        Thu, 16 Sep 2021 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631811263;
        bh=bF0wIcTJ91ImgJF0Qm7WlA+Rccqg9DNB53j+Xh5Pnrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xSNKa9W6loaUShNUlfbYhP7BtiP8ciVX64eG1vYaJCP6cCyUk9ZBuMedIasqw3Gr1
         1V32pypgkddBCB8Cj/Oj2q8rGWp3gSWEdSox9dQWSr1J09+EymvvLIR/VSmYCln9kI
         nlR3RYjN4zAdS+xo0We1MuBGS0X+eiMNlVequcGY=
Date:   Thu, 16 Sep 2021 18:06:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/30] ABI: sysfs-class-tpm: use wildcards for pcr-*
 nodes
Message-ID: <YUNrez8qiAUZ2oOO@kroah.com>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
 <4ab3fce91ea2bd7c36a07e6c646bf7bd6f4f8634.1631782432.git.mchehab+huawei@kernel.org>
 <26ba3d661d0c8a9e4a44be908dfc7cd2d89a2d43.camel@kernel.org>
 <82ae04ed8546e301553d9985367c771a23d4623e.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82ae04ed8546e301553d9985367c771a23d4623e.camel@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 07:00:51PM +0300, Jarkko Sakkinen wrote:
> On Thu, 2021-09-16 at 18:59 +0300, Jarkko Sakkinen wrote:
> > On Thu, 2021-09-16 at 10:59 +0200, Mauro Carvalho Chehab wrote:
> > > Change how this expression is defined:
> > > 
> > > 	/sys/class/tpm/tpmX/pcr-H/N
> > > 
> > > in order to allow get_abi.pl to convert it into this regex:
> > > 
> > > 	/sys/class/tpm/tpmX/pcr-.*/.*
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  Documentation/ABI/stable/sysfs-class-tpm | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/ABI/stable/sysfs-class-tpm b/Documentation/ABI/stable/sysfs-class-tpm
> > > index d897ecb9615f..411d5895bed4 100644
> > > --- a/Documentation/ABI/stable/sysfs-class-tpm
> > > +++ b/Documentation/ABI/stable/sysfs-class-tpm
> > > @@ -195,7 +195,7 @@ Description:	The "tpm_version_major" property shows the TCG spec major version
> > >  
> > >  		  2
> > >  
> > > -What:		/sys/class/tpm/tpmX/pcr-H/N
> > > +What:		/sys/class/tpm/tpmX/pcr-<H>/<N>
> > >  Date:		March 2021
> > >  KernelVersion:	5.12
> > >  Contact:	linux-integrity@vger.kernel.org
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> I guess I don't have to pick this tho? Just checking.
> 
> Presuming that the whole series is applied by someone...

I'll be taking these, thanks!

greg k-h
