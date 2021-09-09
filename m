Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58B94058B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350102AbhIIONK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353158AbhIIONE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:13:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68FCD60F4A;
        Thu,  9 Sep 2021 14:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631196715;
        bh=9GAPZFughZtDi4mO7LFmxjxpQTfjksC84/RSsLxBH30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eRP/zNnZBHLvB2IbEgDWA+QZx+DblgU1NH2YIDVpbvUipzZc5B5iY95fbwYYNEcsW
         g2wXCOrlW/cm7pWvievujzJhxy+SvMUQgGRItbfvCacw76wo0R2wNz1U1hvNOFDwCh
         99nmX/SSOfNAnIAGVmRD9cM7578V4qPYzWRU4Q9T0K6nSoANKgkht4/NKaaG7AVr+d
         5q/XiwGw+Wl4C9XhvCWHKvr1my0/sgSkohl06WTURjLPfpJ7izXgIRGi417CSIDekv
         UAiyh4YWmWO0l5kb1rkQVq+QLuEXsSXFEb3KOVrr6bIIo/p5xj2rejdeQC4iHJdsOd
         nmWDllpTzvK7w==
Date:   Thu, 9 Sep 2021 16:11:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Raphael Gianotti <raphgi@linux.microsoft.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        THOBY Simon <Simon.THOBY@viveris.fr>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] ABI: security: fix location for evm and ima_policy
Message-ID: <20210909161111.3826ab05@coco.lan>
In-Reply-To: <3d781672e8b195ee56a6b04f5133684fcbd6a0a8.camel@linux.ibm.com>
References: <cover.1631112725.git.mchehab+huawei@kernel.org>
        <27f568bf8973afb9c7aa023e96dcd4f50b07a188.1631112725.git.mchehab+huawei@kernel.org>
        <3d781672e8b195ee56a6b04f5133684fcbd6a0a8.camel@linux.ibm.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 09 Sep 2021 09:48:11 -0400
Mimi Zohar <zohar@linux.ibm.com> escreveu:

> Hi Mauro,
> 
> On Wed, 2021-09-08 at 16:58 +0200, Mauro Carvalho Chehab wrote:
> > The What: definitions there are wrong, pointing to different
> > locations than what's expected.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> What is the purpose for the asterisks in the file path?

That's a standard filesystem wildcard. On ABI documents, there are
some other ways to specify it. The most used ones are:

	/sys/kernel/security/*/evm
	/sys/kernel/security/.../evm
	/sys/kernel/security/<something>/evm

(currently, there's no preferences between them)

If you check patches 1-3, the goal here is to have something
that will be replaced by this regex by scripts/get_abi.pl,
e.g. it will turn into:

	/sys/kernel/security/.*/evm

So, this what:

	What:		/sys/kernel/security/evm /sys/kernel/security/*/evm

Matches all three occurrences of evm on my system:

	/sys/kernel/security/evm
	/sys/kernel/security/integrity/evm
	/sys/kernel/security/integrity/evm/evm

Regards,
Mauro


> 
> thanks,
> 
> Mimi
> 
> > ---
> >  Documentation/ABI/testing/evm        | 4 ++--
> >  Documentation/ABI/testing/ima_policy | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/evm b/Documentation/ABI/testing/evm
> > index 553fd8a33e56..4b76a19b7bb4 100644
> > --- a/Documentation/ABI/testing/evm
> > +++ b/Documentation/ABI/testing/evm
> > @@ -1,4 +1,4 @@
> > -What:		security/evm
> > +What:		/sys/kernel/security/evm /sys/kernel/security/*/evm
> >  Date:		March 2011
> >  Contact:	Mimi Zohar <zohar@us.ibm.com>
> >  Description:
> > @@ -93,7 +93,7 @@ Description:
> >  		core/ima-setup) have support for loading keys at boot
> >  		time.
> >  
> > -What:		security/integrity/evm/evm_xattrs
> > +What:		/sys/kernel/security/*/evm/evm_xattrs
> >  Date:		April 2018
> >  Contact:	Matthew Garrett <mjg59@google.com>
> >  Description:
> > diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> > index 5c2798534950..2d84063d196f 100644
> > --- a/Documentation/ABI/testing/ima_policy
> > +++ b/Documentation/ABI/testing/ima_policy
> > @@ -1,4 +1,4 @@
> > -What:		security/ima/policy
> > +What:		/sys/kernel/security/*/ima/policy
> >  Date:		May 2008
> >  Contact:	Mimi Zohar <zohar@us.ibm.com>
> >  Description:  
> 
> 
