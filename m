Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3EE40DEDF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 18:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240462AbhIPQCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 12:02:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240186AbhIPQCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 12:02:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5102A61246;
        Thu, 16 Sep 2021 16:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631808053;
        bh=3YlK9v7ycjR90uHSfMjv0g1Y4dYG4CL5TdkIfOW5iOs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WCiJlU8A1PO2EatS6A6GBJ6WM68fBvSHCYwS+zT3zmBi8ONpO60VXHIEaJdbiUlNk
         NilKRxTAw3UuUVplnWEDWzWx+4sG/+j8P+L3ahTK/l1IbVh7mlpTMkE4F8f/y7jz57
         lB7VBoSWkXczdxRNjyazfz7lQ8682DnmSoMck88ogWUzqeKG96cySgyL3CMsonjhgA
         lpem8dvl0zOStO/PIYTWSuEyBFuw5VWEZvYqX6HfeKRdD4ZOjnUEJsNlaYppx1L3j/
         Xidj8RP+mdErkPlnlphZHLFVDkOntbHFdSFErarWtHVZV4J0/WmdMeHdQpoC3g+JGj
         R+TtOkTBvXSHg==
Message-ID: <82ae04ed8546e301553d9985367c771a23d4623e.camel@kernel.org>
Subject: Re: [PATCH v3 05/30] ABI: sysfs-class-tpm: use wildcards for pcr-*
 nodes
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org
Date:   Thu, 16 Sep 2021 19:00:51 +0300
In-Reply-To: <26ba3d661d0c8a9e4a44be908dfc7cd2d89a2d43.camel@kernel.org>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
         <4ab3fce91ea2bd7c36a07e6c646bf7bd6f4f8634.1631782432.git.mchehab+huawei@kernel.org>
         <26ba3d661d0c8a9e4a44be908dfc7cd2d89a2d43.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-09-16 at 18:59 +0300, Jarkko Sakkinen wrote:
> On Thu, 2021-09-16 at 10:59 +0200, Mauro Carvalho Chehab wrote:
> > Change how this expression is defined:
> >=20
> > 	/sys/class/tpm/tpmX/pcr-H/N
> >=20
> > in order to allow get_abi.pl to convert it into this regex:
> >=20
> > 	/sys/class/tpm/tpmX/pcr-.*/.*
> >=20
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/ABI/stable/sysfs-class-tpm | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/ABI/stable/sysfs-class-tpm b/Documentation/A=
BI/stable/sysfs-class-tpm
> > index d897ecb9615f..411d5895bed4 100644
> > --- a/Documentation/ABI/stable/sysfs-class-tpm
> > +++ b/Documentation/ABI/stable/sysfs-class-tpm
> > @@ -195,7 +195,7 @@ Description:	The "tpm_version_major" property shows=
 the TCG spec major version
> > =20
> >  		  2
> > =20
> > -What:		/sys/class/tpm/tpmX/pcr-H/N
> > +What:		/sys/class/tpm/tpmX/pcr-<H>/<N>
> >  Date:		March 2021
> >  KernelVersion:	5.12
> >  Contact:	linux-integrity@vger.kernel.org
>=20
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I guess I don't have to pick this tho? Just checking.

Presuming that the whole series is applied by someone...

/Jarkko
