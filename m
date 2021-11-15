Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBA145027B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbhKOK2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:28:35 -0500
Received: from todd.t-8ch.de ([159.69.126.157]:54377 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231159AbhKOK21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:28:27 -0500
Date:   Mon, 15 Nov 2021 11:25:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1636971925;
        bh=0/bxF+0Ja80KzNIjVBJ20sa/tzr9xnaAs4Q/VbC/BZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UN0gAAvgaQI1b1wSSFpd3xfR2Q8k8FZCdgDo1sUOprnBgHcFDizn1lOs+dsviAqA6
         i74Z81po7P2w3MltQ9lJYqsazIw7CdcBsmS7BWicf5jvABgylnvaQYKs05q+czWtdT
         tJCcX/CFYbJPseikFZ57Nlzl1pmHrp7lVPNhrNdE=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Jan Beulich <jbeulich@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen/privcmd: make option visible in Kconfig
Message-ID: <28809eae-ea8f-4f6b-b41a-a0895aec6e8c@t-8ch.de>
References: <20211113083821.71060-1-linux@weissschuh.net>
 <889cfabe-6262-d105-c806-105ee9377fef@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <889cfabe-6262-d105-c806-105ee9377fef@suse.com>
Jabber-ID: thomas@t-8ch.de
X-Accept: text/plain, text/html;q=0.2, text/*;q=0.1
X-Accept-Language: en-us, en;q=0.8, de-de;q=0.7, de;q=0.6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-15 11:02+0100, Jan Beulich wrote:
> On 13.11.2021 09:38, Thomas Weißschuh wrote:
> > This configuration option provides a misc device as an API to userspace.
> > Make this API usable without having to select the module as a transitive
> > dependency.
> > 
> > This also fixes an issue where localyesconfig would select
> > CONFIG_XEN_PRIVCMD=m because it was not visible and defaulted to
> > building as module.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > 
> > ---
> > 
> > Note: If CONFIG_XEN_PRIVCMD really is only meant to be selected by
> > XENFS, then the issue can be fixed by removing its "default m"
> > definition.
> > ---
> >  drivers/xen/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> > index a1b11c62da9e..c14d8631b8f6 100644
> > --- a/drivers/xen/Kconfig
> > +++ b/drivers/xen/Kconfig
> > @@ -259,7 +259,7 @@ config XEN_SCSI_BACKEND
> >  	  if guests need generic access to SCSI devices.
> >  
> >  config XEN_PRIVCMD
> > -	tristate
> > +	tristate "Xen privileged domain-0 commands"
> >  	depends on XEN
> >  	default m
> 
> While I agree with adding a prompt here, I'm not sure why you've added
> "domain-0" to its wording. Aiui this interface is equally available in
> DomU-s, just that they would be able to only (successfully) use a more
> restricted set of hypercalls. Otherwise the XEN dependency would need
> to be changed to XEN_DOM0 at the same time as adding a prompt, or the
> prompt's visibility be restricted to XEN_DOM0.

I got it from comment at the top of privcmd.c.

To be honest I have no knowledge about Xen and only submitted this patch to get
rid of the spurious module in my localyesconfig.

I can try to find a better wording and submit a v2 but would also be happy if
somebody more knowledgeable about this module wrote a patch, which would
probably be easiest for everybody.

Thanks,
Thomas
